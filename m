Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6334D5E7CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiIWOVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiIWOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:21:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7813F73E;
        Fri, 23 Sep 2022 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663942892; x=1695478892;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNGZ0160eaVRIXmVcK+VYIKfu9NQriiHVbxWECDSa2w=;
  b=lxPXbjOOwfv/r+S2o2/CseULzaSVVrX2qDUJvaDd7cKCraJjOHn9o2YR
   nqIKc04bA0M+yV1EeIFD2xVnY4pMfBTAhNIUCQ3g5kzz6RxWbq2Hfjyss
   vQ9XB7sDxQzUvea4+WQOhG15nAN6v6Gjnf2CB6U6x34BHYa+k5dFNHEBE
   BElZaHBbTP65wuw2HhE0Bff+wZibwBiKntCk7GTsHOyMJOJX1NvDG4YmJ
   SE9jKY0RnvjX5uLEFlHL0cs2o/kXHHPEMLriWu2CyMmE5YPFDYlr5ZVBI
   LKnBvJlNZcLNN21QNkEHB1lDgROoSqXx3GVh/0mQy0bnbXobeIE+2RMwt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="283700363"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="283700363"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:21:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="709312444"
Received: from weiyeeta-mobl.gar.corp.intel.com ([10.213.40.75])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:21:29 -0700
Message-ID: <9a17dcd684fa32b445857d07d193c5cd6625fe12.camel@intel.com>
Subject: Re: [PATCH v4 03/30] thermal/core: Add a generic
 thermal_zone_set_trip() function
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Date:   Fri, 23 Sep 2022 22:21:26 +0800
In-Reply-To: <20220921094244.606948-4-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
         <20220921094244.606948-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-21 at 11:42 +0200, Daniel Lezcano wrote:
> The thermal zone ops defines a set_trip callback where we can invoke
> the backend driver to set an interrupt for the next trip point
> temperature being crossed the way up or down, or setting the low
> level
> with the hysteresis.
> 
> The ops is only called from the thermal sysfs code where the
> userspace
> has the ability to modify a trip point characteristic.
> 
> With the effort of encapsulating the thermal framework core code,
> let's create a thermal_zone_set_trip() which is the writable side of
> the thermal_zone_get_trip() and put there all the ops encapsulation.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> ---
>  drivers/thermal/thermal_core.c  | 44 ++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c | 48 +++++++++++------------------
> ----
>  include/linux/thermal.h         |  3 +++
>  3 files changed, 63 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 381d85ec74a0..fa0f89a24b68 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1183,6 +1183,50 @@ int thermal_zone_get_trip(struct
> thermal_zone_device *tz, int trip_id,
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
>  
> +int thermal_zone_set_trip(struct thermal_zone_device *tz, int
> trip_id,
> +			  const struct thermal_trip *trip)
> +{
> +	struct thermal_trip t;
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&tz->lock);
> +
> +	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz-
> >trips)
> +		goto out;
> +
> +	ret = __thermal_zone_get_trip(tz, trip_id, &t);
> +	if (ret)
> +		goto out;
> +
> +	if ((t.temperature != trip->temperature) && tz->ops-
> >set_trip_temp) {
> +
> +		ret = tz->ops->set_trip_temp(tz, trip_id, trip-
> >temperature);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if ((t.hysteresis != trip->hysteresis) && tz->ops-
> >set_trip_hyst) {
> +
> +		ret = tz->ops->set_trip_hyst(tz, trip_id, trip-
> >hysteresis);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (((t.temperature != trip->temperature) ||
> +	     (t.hysteresis != trip->hysteresis)) && tz->trips)
> +		tz->trips[trip_id] = *trip;
> +
> +out:
> +	mutex_unlock(&tz->lock);
> +
> +	if (!ret) {
> +		thermal_notify_tz_trip_change(tz->id, trip_id, trip-
> >type,
> +					      trip->temperature, trip-
> >hysteresis);
> +		thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +	}
> +	
> +	return ret;
> +}
>  
>  /**
>   * thermal_zone_device_register_with_trips() - register a new
> thermal zone device
> diff --git a/drivers/thermal/thermal_sysfs.c
> b/drivers/thermal/thermal_sysfs.c
> index 18cdd7cd0008..8d7b25ab67c2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -115,31 +115,20 @@ trip_point_temp_store(struct device *dev,
> struct device_attribute *attr,
>  	struct thermal_trip trip;
>  	int trip_id, ret;
>  
> -	if (!tz->ops->set_trip_temp && !tz->trips)
> -		return -EPERM;
> -
>  	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) !=
> 1)
>  		return -EINVAL;
>  
> -	if (kstrtoint(buf, 10, &trip.temperature))
> -		return -EINVAL;
> -
> -	ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
> +	ret = thermal_zone_get_trip(tz, trip_id, &trip);
>  	if (ret)
>  		return ret;
>  
> -	if (tz->trips)
> -		tz->trips[trip_id].temperature = trip.temperature;
> +	if (kstrtoint(buf, 10, &trip.temperature))
> +		return -EINVAL;
>  
> -	ret = thermal_zone_get_trip(tz, trip_id, &trip);
> +	ret = thermal_zone_set_trip(tz, trip_id, &trip);
>  	if (ret)
>  		return ret;
>  
> -	thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
> -				      trip.temperature,
> trip.hysteresis);
> -
> -	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> -
>  	return count;
>  }
>  
> @@ -166,29 +155,24 @@ trip_point_hyst_store(struct device *dev,
> struct device_attribute *attr,
>  		      const char *buf, size_t count)
>  {
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	int trip, ret;
> -	int temperature;
> -
> -	if (!tz->ops->set_trip_hyst)
> -		return -EPERM;
> +	struct thermal_trip trip;
> +	int trip_id, ret;
>  
> -	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
> +	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) !=
> 1)
>  		return -EINVAL;
>  
> -	if (kstrtoint(buf, 10, &temperature))
> -		return -EINVAL;
> +	ret = thermal_zone_get_trip(tz, trip_id, &trip);
> +	if (ret)
> +		return ret;
>  
> -	/*
> -	 * We are not doing any check on the 'temperature' value
> -	 * here. The driver implementing 'set_trip_hyst' has to
> -	 * take care of this.
> -	 */
> -	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
> +	if (kstrtoint(buf, 10, &trip.hysteresis))
> +		return -EINVAL;
>  
> -	if (!ret)
> -		thermal_zone_set_trips(tz);
> +	ret = thermal_zone_set_trip(tz, trip_id, &trip);
> +	if (ret)
> +		return ret;
>  
> -	return ret ? ret : count;
> +	return count;
>  }
>  
>  static ssize_t
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 09dc09228717..5350a437f245 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -338,6 +338,9 @@ static inline void
> devm_thermal_of_zone_unregister(struct device *dev,
>  int thermal_zone_get_trip(struct thermal_zone_device *tz, int
> trip_id,
>  			  struct thermal_trip *trip);
>  
> +int thermal_zone_set_trip(struct thermal_zone_device *tz, int
> trip_id,
> +			  const struct thermal_trip *trip);
> +
>  int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>  
>  #ifdef CONFIG_THERMAL

