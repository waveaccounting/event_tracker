class EventTracker::Amplitude
  def initialize(key)
    @key = key
  end

  def init
    s = <<-EOD
      (function(e,t){var n=e.amplitude||{_q:[]};var r=t.createElement("script");r.type="text/javascript";
      r.async=true;r.src="https://d24n15hnbwhuhn.cloudfront.net/libs/amplitude-2.9.1-min.gz.js";
      r.onload=function(){e.amplitude.runQueuedFunctions()};var i=t.getElementsByTagName("script")[0];
      i.parentNode.insertBefore(r,i);var s=function(){this._q=[];return this};function o(e){
      s.prototype[e]=function(){this._q.push([e].concat(Array.prototype.slice.call(arguments,0)));
      return this}}var a=["add","append","clearAll","prepend","set","setOnce","unset"];for(var c=0;c<a.length;c++){
      o(a[c])}n.Identify=s;var u=["init","logEvent","logRevenue","setUserId","setUserProperties","setOptOut","setVersionName","setDomain","setDeviceId","setGlobalUserProperties","identify","clearUserProperties"];
      function p(e){function t(t){e[t]=function(){e._q.push([t].concat(Array.prototype.slice.call(arguments,0)));
      }}for(var n=0;n<u.length;n++){t(u[n])}}p(n);e.amplitude=n})(window,document);
      amplitude.init("#{@key}");
    EOD
  end

  def track(event_name, properties)
    p = properties.empty? ? "" : ", #{properties.to_json}"
    %Q{amplitude.logEvent("#{event_name}"#{p});}
  end

  def identify(distinct_id)
    %Q{amplitude.setUserId("#{distinct_id}");}
  end

  def set_user_properties(properties)
    %Q{amplitude.setUserProperties(#{properties.to_json});}
  end
end
