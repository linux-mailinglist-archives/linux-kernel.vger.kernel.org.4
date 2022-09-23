Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216DE5E7CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiIWOW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIWOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:22:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E7713B023;
        Fri, 23 Sep 2022 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663942944; x=1695478944;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SahJxuJ4ZBEAUbR87wl3K3W9aF0nvWRA2WTTBb1LnMQ=;
  b=K0G1ekx7d8EofM0GdboYtiIELpXGVEj6860tkG+WXikSCmi7UwZPv7qd
   tpqWbxySLV+nEfOpJLKkx1LSa0H7vZZZ9dGVbRRffpIlu8uDy1qloS6Qy
   vS9bVkxI3g19ySOTFzEmA3rIf4cY0vJq9X8AkKajq/EHMVMlqYu/HHYej
   fLnNqgB7DA/FOsE+FJhKtJ9Rj2Y8YWxLRQsdcRIS8gBs9Jw6TACT4wMKI
   C09gC3/5cV2WuCZfzDSu2PUmi1AGAiCMLG8zF8y5ioOMw82dkDse5C9R9
   /eaS8CaUvgoXfvFV25L4mt7vugqMMM6qPklQaEyYKU0kCS+zr3Pf1bOzl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="283700590"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="283700590"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:22:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="688728566"
Received: from weiyeeta-mobl.gar.corp.intel.com ([10.213.40.75])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:22:21 -0700
Message-ID: <949edf3c0afea01006468a28fe444b4ee86042a7.camel@intel.com>
Subject: Re: [PATCH v4 04/30] thermal/core: Add a generic
 thermal_zone_get_crit_temp() function
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Date:   Fri, 23 Sep 2022 22:22:17 +0800
In-Reply-To: <20220921094244.606948-5-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
         <20220921094244.606948-5-daniel.lezcano@linaro.org>
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
> The thermal zone ops defines a callback to retrieve the critical
> temperature. As the trip handling is being reworked, all the trip
> points will be the same whatever the driver and consequently finding
> the critical trip temperature will be just a loop to search for a
> critical trip point type.
> 
> Provide such a generic function, so we encapsulate the ops
> get_crit_temp() which can be removed when all the backend drivers are
> using the generic trip points handling.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

> ---
>  drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
>  include/linux/thermal.h        |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index fa0f89a24b68..2495c174a226 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1144,6 +1144,33 @@ int thermal_zone_get_num_trips(struct
> thermal_zone_device *tz)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
>  
> +int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int
> *temp)
> +{
> +	int i, ret = 0;
> +
> +	if (tz->ops->get_crit_temp)
> +		return tz->ops->get_crit_temp(tz, temp);
> +	
> +	if (!tz->trips)
> +		return -EINVAL;
> +
> +	mutex_lock(&tz->lock);
> +
> +	for (i = 0; i < tz->num_trips; i++) {
> +		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
> +			*temp = tz->trips[i].temperature;
> +			goto out;
> +		}
> +	}
> +
> +	ret = -EINVAL;
> +out:
> +	mutex_unlock(&tz->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
> +
>  static int __thermal_zone_get_trip(struct thermal_zone_device *tz,
> int trip_id,
>  				   struct thermal_trip *trip)
>  {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5350a437f245..66373f872237 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -343,6 +343,8 @@ int thermal_zone_set_trip(struct
> thermal_zone_device *tz, int trip_id,
>  
>  int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>  
> +int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int
> *temp);
> +
>  #ifdef CONFIG_THERMAL
>  struct thermal_zone_device *thermal_zone_device_register(const char
> *, int, int,
>  		void *, struct thermal_zone_device_ops *,

