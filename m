Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF95E7D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiIWOtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiIWOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:49:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E67C7220E3;
        Fri, 23 Sep 2022 07:49:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE9A6113E;
        Fri, 23 Sep 2022 07:49:44 -0700 (PDT)
Received: from [10.57.3.23] (unknown [10.57.3.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CBAE3F73B;
        Fri, 23 Sep 2022 07:49:37 -0700 (PDT)
Message-ID: <564e6fc6-4734-a60e-d578-a15247a32c5f@arm.com>
Date:   Fri, 23 Sep 2022 15:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 05/30] thermal/core/governors: Use
 thermal_zone_get_trip() instead of ops functions
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        rafael@kernel.org
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
 <20220921094244.606948-6-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220921094244.606948-6-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


On 9/21/22 10:42, Daniel Lezcano wrote:
> The governors are using the ops->get_trip_* functions, Replace these
> calls with thermal_zone_get_trip().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/gov_bang_bang.c       | 23 +++++-------
>   drivers/thermal/gov_fair_share.c      | 18 ++++------
>   drivers/thermal/gov_power_allocator.c | 51 ++++++++++++---------------
>   drivers/thermal/gov_step_wise.c       | 22 ++++++------
>   4 files changed, 47 insertions(+), 67 deletions(-)
> 

[snip]

> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 2d1aeaba38a8..2ef86ced4c7c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -125,16 +125,15 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
>   				   u32 sustainable_power, int trip_switch_on,
>   				   int control_temp)
>   {
> +	struct thermal_trip trip;
> +	u32 temperature_threshold = control_temp;
>   	int ret;
> -	int switch_on_temp;
> -	u32 temperature_threshold;
>   	s32 k_i;
>   
> -	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
> -	if (ret)
> -		switch_on_temp = 0;
> +	ret = thermal_zone_get_trip(tz, trip_switch_on, &trip);
> +	if (!ret)
> +		temperature_threshold -= trip.temperature;
>   
> -	temperature_threshold = control_temp - switch_on_temp;
>   	/*
>   	 * estimate_pid_constants() tries to find appropriate default
>   	 * values for thermal zones that don't provide them. If a
> @@ -520,10 +519,10 @@ static void get_governor_trips(struct thermal_zone_device *tz,
>   	last_passive = INVALID_TRIP;
>   
>   	for (i = 0; i < tz->num_trips; i++) {
> -		enum thermal_trip_type type;
> +		struct thermal_trip trip;
>   		int ret;
>   
> -		ret = tz->ops->get_trip_type(tz, i, &type);
> +		ret = thermal_zone_get_trip(tz, i, &trip);
>   		if (ret) {
>   			dev_warn(&tz->device,
>   				 "Failed to get trip point %d type: %d\n", i,
> @@ -531,14 +530,14 @@ static void get_governor_trips(struct thermal_zone_device *tz,
>   			continue;
>   		}
>   
> -		if (type == THERMAL_TRIP_PASSIVE) {
> +		if (trip.type == THERMAL_TRIP_PASSIVE) {
>   			if (!found_first_passive) {
>   				params->trip_switch_on = i;
>   				found_first_passive = true;
>   			} else  {
>   				last_passive = i;
>   			}
> -		} else if (type == THERMAL_TRIP_ACTIVE) {
> +		} else if (trip.type == THERMAL_TRIP_ACTIVE) {
>   			last_active = i;
>   		} else {
>   			break;
> @@ -633,7 +632,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   {
>   	int ret;
>   	struct power_allocator_params *params;
> -	int control_temp;
> +	struct thermal_trip trip;
>   
>   	ret = check_power_actors(tz);
>   	if (ret)
> @@ -659,13 +658,12 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   	get_governor_trips(tz, params);
>   
>   	if (tz->num_trips > 0) {
> -		ret = tz->ops->get_trip_temp(tz,
> -					params->trip_max_desired_temperature,
> -					&control_temp);
> +		ret = thermal_zone_get_trip(tz, params->trip_max_desired_temperature,
> +					    &trip);
>   		if (!ret)
>   			estimate_pid_constants(tz, tz->tzp->sustainable_power,
>   					       params->trip_switch_on,
> -					       control_temp);
> +					       trip.temperature);
>   	}
>   
>   	reset_pid_controller(params);
> @@ -695,11 +693,11 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
>   	tz->governor_data = NULL;
>   }
>   
> -static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
> +static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>   {
> -	int ret;
> -	int switch_on_temp, control_temp;
>   	struct power_allocator_params *params = tz->governor_data;
> +	struct thermal_trip trip;
> +	int ret;
>   	bool update;
>   
>   	lockdep_assert_held(&tz->lock);
> @@ -708,13 +706,12 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
>   	 * We get called for every trip point but we only need to do
>   	 * our calculations once
>   	 */
> -	if (trip != params->trip_max_desired_temperature)
> +	if (trip_id != params->trip_max_desired_temperature)
>   		return 0;
>   
> -	ret = tz->ops->get_trip_temp(tz, params->trip_switch_on,
> -				     &switch_on_temp);
> -	if (!ret && (tz->temperature < switch_on_temp)) {
> -		update = (tz->last_temperature >= switch_on_temp);
> +	ret = thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> +	if (!ret && (tz->temperature < trip.temperature)) {
> +		update = (tz->last_temperature >= trip.temperature);
>   		tz->passive = 0;
>   		reset_pid_controller(params);
>   		allow_maximum_power(tz, update);
> @@ -723,16 +720,14 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip)
>   
>   	tz->passive = 1;
>   
> -	ret = tz->ops->get_trip_temp(tz, params->trip_max_desired_temperature,
> -				&control_temp);
> +	ret = thermal_zone_get_trip(tz, params->trip_max_desired_temperature, &trip);
>   	if (ret) {
> -		dev_warn(&tz->device,
> -			 "Failed to get the maximum desired temperature: %d\n",
> +		dev_warn(&tz->device, "Failed to get the maximum desired temperature: %d\n",
>   			 ret);
>   		return ret;
>   	}
>   
> -	return allocate_power(tz, control_temp);
> +	return allocate_power(tz, trip.temperature);
>   }
>   
>   static struct thermal_governor thermal_gov_power_allocator = {

this part of IPA LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
