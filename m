Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED15E7CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiIWO0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiIWO0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:26:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02D49B48;
        Fri, 23 Sep 2022 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663943143; x=1695479143;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ct2kO+CGe+zYzDDTqLfuktZbjFCN48YuFfj1OY8tK3k=;
  b=EijzywEUhCcHM8JBTzQx8p4UuXYV8rd52umSg4vGSh9J0hteFfNaXb/Q
   6WKKLDP7rwU5mxPuY8vyR+JTxF7wgjhN6VVgdvudc3FvG6pWzqMVAZVOK
   q5ehxb3qNugITjYCzi8XCNAOtVST+ETygf+Z1TCFP5YBxHDiPO7Uzkzzj
   7NeD3Grr3NjEow5JwqRg8POj8emSXSukv4yIwumZ0/i+suc2Q9dPd7cB5
   DrAH/+7NrCZ9jXKoSm5pjpMy1LOTD9+svtj2CgjjsrF+NHrJVfTa1vWwS
   +N35BCX3gq6oV9QXAdwVPf50jlnrVoegbWaYnzLSYxbiCHpZI35RGPvH2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="301485311"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="301485311"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:25:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="724143736"
Received: from weiyeeta-mobl.gar.corp.intel.com ([10.213.40.75])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 07:25:40 -0700
Message-ID: <fd95a14221c25ae57278ef037a94266c7da12d3b.camel@intel.com>
Subject: Re: [PATCH v4 05/30] thermal/core/governors: Use
 thermal_zone_get_trip() instead of ops functions
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Date:   Fri, 23 Sep 2022 22:25:36 +0800
In-Reply-To: <20220921094244.606948-6-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
         <20220921094244.606948-6-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-21 at 11:42 +0200, Daniel Lezcano wrote:
> The governors are using the ops->get_trip_* functions, Replace these
> calls with thermal_zone_get_trip().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/gov_bang_bang.c       | 23 +++++-------
>  drivers/thermal/gov_fair_share.c      | 18 ++++------
>  drivers/thermal/gov_power_allocator.c | 51 ++++++++++++-------------
> --
>  drivers/thermal/gov_step_wise.c       | 22 ++++++------
>  4 files changed, 47 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/thermal/gov_bang_bang.c
> b/drivers/thermal/gov_bang_bang.c
> index a08bbe33be96..09234f3d2fb9 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -13,26 +13,19 @@
>  
>  #include "thermal_core.h"
>  
> -static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> int trip)
> +static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> int trip_id)
>  {
> -	int trip_temp, trip_hyst;
> +	struct thermal_trip trip;
>  	struct thermal_instance *instance;
>  
> -	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> -
> -	if (!tz->ops->get_trip_hyst) {
> -		pr_warn_once("Undefined get_trip_hyst for thermal zone
> %s - "
> -				"running with default hysteresis
> zero\n", tz->type);
> -		trip_hyst = 0;
> -	} else
> -		tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
> +	thermal_zone_get_trip(tz, trip_id, &trip);
> 
We lose the warning messages, but I don't know how important this
warning message is.

Other than that,
Reviewed-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

>  
>  	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
> -				trip, trip_temp, tz->temperature,
> -				trip_hyst);
> +				trip_id, trip.temperature, tz-
> >temperature,
> +				trip.hysteresis);
>  
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> {
> -		if (instance->trip != trip)
> +		if (instance->trip != trip_id)
>  			continue;
>  
>  		/* in case fan is in initial state, switch the fan off
> */
> @@ -50,10 +43,10 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  		 * enable fan when temperature exceeds trip_temp and
> disable
>  		 * the fan in case it falls below trip_temp minus
> hysteresis
>  		 */
> -		if (instance->target == 0 && tz->temperature >=
> trip_temp)
> +		if (instance->target == 0 && tz->temperature >=
> trip.temperature)
>  			instance->target = 1;
>  		else if (instance->target == 1 &&
> -				tz->temperature <= trip_temp -
> trip_hyst)
> +			 tz->temperature <= trip.temperature -
> trip.hysteresis)
>  			instance->target = 0;
>  
>  		dev_dbg(&instance->cdev->device, "target=%d\n",
> diff --git a/drivers/thermal/gov_fair_share.c
> b/drivers/thermal/gov_fair_share.c
> index a4ee4661e9cc..c515e7a52294 100644
> --- a/drivers/thermal/gov_fair_share.c
> +++ b/drivers/thermal/gov_fair_share.c
> @@ -21,16 +21,12 @@
>   */
>  static int get_trip_level(struct thermal_zone_device *tz)
>  {
> -	int count = 0;
> -	int trip_temp;
> -	enum thermal_trip_type trip_type;
> -
> -	if (tz->num_trips == 0 || !tz->ops->get_trip_temp)
> -		return 0;
> +	struct thermal_trip trip;
> +	int count;
>  
>  	for (count = 0; count < tz->num_trips; count++) {
> -		tz->ops->get_trip_temp(tz, count, &trip_temp);
> -		if (tz->temperature < trip_temp)
> +		thermal_zone_get_trip(tz, count, &trip);
> +		if (tz->temperature < trip.temperature)
>  			break;
>  	}
>  
> @@ -38,10 +34,8 @@ static int get_trip_level(struct
> thermal_zone_device *tz)
>  	 * count > 0 only if temperature is greater than first trip
>  	 * point, in which case, trip_point = count - 1
>  	 */
> -	if (count > 0) {
> -		tz->ops->get_trip_type(tz, count - 1, &trip_type);
> -		trace_thermal_zone_trip(tz, count - 1, trip_type);
> -	}
> +	if (count > 0)
> +		trace_thermal_zone_trip(tz, count - 1, trip.type);
>  
>  	return count;
>  }
> diff --git a/drivers/thermal/gov_power_allocator.c
> b/drivers/thermal/gov_power_allocator.c
> index 2d1aeaba38a8..2ef86ced4c7c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -125,16 +125,15 @@ static void estimate_pid_constants(struct
> thermal_zone_device *tz,
>  				   u32 sustainable_power, int
> trip_switch_on,
>  				   int control_temp)
>  {
> +	struct thermal_trip trip;
> +	u32 temperature_threshold = control_temp;
>  	int ret;
> -	int switch_on_temp;
> -	u32 temperature_threshold;
>  	s32 k_i;
>  
> -	ret = tz->ops->get_trip_temp(tz, trip_switch_on,
> &switch_on_temp);
> -	if (ret)
> -		switch_on_temp = 0;
> +	ret = thermal_zone_get_trip(tz, trip_switch_on, &trip);
> +	if (!ret)
> +		temperature_threshold -= trip.temperature;
>  
> -	temperature_threshold = control_temp - switch_on_temp;
>  	/*
>  	 * estimate_pid_constants() tries to find appropriate default
>  	 * values for thermal zones that don't provide them. If a
> @@ -520,10 +519,10 @@ static void get_governor_trips(struct
> thermal_zone_device *tz,
>  	last_passive = INVALID_TRIP;
>  
>  	for (i = 0; i < tz->num_trips; i++) {
> -		enum thermal_trip_type type;
> +		struct thermal_trip trip;
>  		int ret;
>  
> -		ret = tz->ops->get_trip_type(tz, i, &type);
> +		ret = thermal_zone_get_trip(tz, i, &trip);
>  		if (ret) {
>  			dev_warn(&tz->device,
>  				 "Failed to get trip point %d type:
> %d\n", i,
> @@ -531,14 +530,14 @@ static void get_governor_trips(struct
> thermal_zone_device *tz,
>  			continue;
>  		}
>  
> -		if (type == THERMAL_TRIP_PASSIVE) {
> +		if (trip.type == THERMAL_TRIP_PASSIVE) {
>  			if (!found_first_passive) {
>  				params->trip_switch_on = i;
>  				found_first_passive = true;
>  			} else  {
>  				last_passive = i;
>  			}
> -		} else if (type == THERMAL_TRIP_ACTIVE) {
> +		} else if (trip.type == THERMAL_TRIP_ACTIVE) {
>  			last_active = i;
>  		} else {
>  			break;
> @@ -633,7 +632,7 @@ static int power_allocator_bind(struct
> thermal_zone_device *tz)
>  {
>  	int ret;
>  	struct power_allocator_params *params;
> -	int control_temp;
> +	struct thermal_trip trip;
>  
>  	ret = check_power_actors(tz);
>  	if (ret)
> @@ -659,13 +658,12 @@ static int power_allocator_bind(struct
> thermal_zone_device *tz)
>  	get_governor_trips(tz, params);
>  
>  	if (tz->num_trips > 0) {
> -		ret = tz->ops->get_trip_temp(tz,
> -					params-
> >trip_max_desired_temperature,
> -					&control_temp);
> +		ret = thermal_zone_get_trip(tz, params-
> >trip_max_desired_temperature,
> +					    &trip);
>  		if (!ret)
>  			estimate_pid_constants(tz, tz->tzp-
> >sustainable_power,
>  					       params->trip_switch_on,
> -					       control_temp);
> +					       trip.temperature);
>  	}
>  
>  	reset_pid_controller(params);
> @@ -695,11 +693,11 @@ static void power_allocator_unbind(struct
> thermal_zone_device *tz)
>  	tz->governor_data = NULL;
>  }
>  
> -static int power_allocator_throttle(struct thermal_zone_device *tz,
> int trip)
> +static int power_allocator_throttle(struct thermal_zone_device *tz,
> int trip_id)
>  {
> -	int ret;
> -	int switch_on_temp, control_temp;
>  	struct power_allocator_params *params = tz->governor_data;
> +	struct thermal_trip trip;
> +	int ret;
>  	bool update;
>  
>  	lockdep_assert_held(&tz->lock);
> @@ -708,13 +706,12 @@ static int power_allocator_throttle(struct
> thermal_zone_device *tz, int trip)
>  	 * We get called for every trip point but we only need to do
>  	 * our calculations once
>  	 */
> -	if (trip != params->trip_max_desired_temperature)
> +	if (trip_id != params->trip_max_desired_temperature)
>  		return 0;
>  
> -	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
> -				     &switch_on_temp);
> -	if (!ret && (tz->temperature < switch_on_temp)) {
> -		update = (tz->last_temperature >= switch_on_temp);
> +	ret = thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> +	if (!ret && (tz->temperature < trip.temperature)) {
> +		update = (tz->last_temperature >= trip.temperature);
>  		tz->passive = 0;
>  		reset_pid_controller(params);
>  		allow_maximum_power(tz, update);
> @@ -723,16 +720,14 @@ static int power_allocator_throttle(struct
> thermal_zone_device *tz, int trip)
>  
>  	tz->passive = 1;
>  
> -	ret = tz->ops->get_trip_temp(tz, params-
> >trip_max_desired_temperature,
> -				&control_temp);
> +	ret = thermal_zone_get_trip(tz, params-
> >trip_max_desired_temperature, &trip);
>  	if (ret) {
> -		dev_warn(&tz->device,
> -			 "Failed to get the maximum desired
> temperature: %d\n",
> +		dev_warn(&tz->device, "Failed to get the maximum
> desired temperature: %d\n",
>  			 ret);
>  		return ret;
>  	}
>  
> -	return allocate_power(tz, control_temp);
> +	return allocate_power(tz, trip.temperature);
>  }
>  
>  static struct thermal_governor thermal_gov_power_allocator = {
> diff --git a/drivers/thermal/gov_step_wise.c
> b/drivers/thermal/gov_step_wise.c
> index cdd3354bc27f..3cb16d7e65d1 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -95,30 +95,28 @@ static void update_passive_instance(struct
> thermal_zone_device *tz,
>  		tz->passive += value;
>  }
>  
> -static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> int trip)
> +static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> int trip_id)
>  {
> -	int trip_temp;
> -	enum thermal_trip_type trip_type;
>  	enum thermal_trend trend;
>  	struct thermal_instance *instance;
> +	struct thermal_trip trip;
>  	bool throttle = false;
>  	int old_target;
>  
> -	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> -	tz->ops->get_trip_type(tz, trip, &trip_type);
> +	thermal_zone_get_trip(tz, trip_id, &trip);
>  
> -	trend = get_tz_trend(tz, trip);
> +	trend = get_tz_trend(tz, trip_id);
>  
> -	if (tz->temperature >= trip_temp) {
> +	if (tz->temperature >= trip.temperature) {
>  		throttle = true;
> -		trace_thermal_zone_trip(tz, trip, trip_type);
> +		trace_thermal_zone_trip(tz, trip_id, trip.type);
>  	}
>  
>  	dev_dbg(&tz->device,
> "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
> -				trip, trip_type, trip_temp, trend,
> throttle);
> +				trip_id, trip.type, trip.temperature,
> trend, throttle);
>  
>  	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
> {
> -		if (instance->trip != trip)
> +		if (instance->trip != trip_id)
>  			continue;
>  
>  		old_target = instance->target;
> @@ -132,11 +130,11 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
>  		/* Activate a passive thermal instance */
>  		if (old_target == THERMAL_NO_TARGET &&
>  			instance->target != THERMAL_NO_TARGET)
> -			update_passive_instance(tz, trip_type, 1);
> +			update_passive_instance(tz, trip.type, 1);
>  		/* Deactivate a passive thermal instance */
>  		else if (old_target != THERMAL_NO_TARGET &&
>  			instance->target == THERMAL_NO_TARGET)
> -			update_passive_instance(tz, trip_type, -1);
> +			update_passive_instance(tz, trip.type, -1);
>  
>  		instance->initialized = true;
>  		mutex_lock(&instance->cdev->lock);

