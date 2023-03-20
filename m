Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127356C11D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCTMYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCTMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:24:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 165F2976F;
        Mon, 20 Mar 2023 05:24:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A63B2FEC;
        Mon, 20 Mar 2023 05:24:54 -0700 (PDT)
Received: from [10.57.18.164] (unknown [10.57.18.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E69E33F67D;
        Mon, 20 Mar 2023 05:24:08 -0700 (PDT)
Message-ID: <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
Date:   Mon, 20 Mar 2023 12:24:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
To:     Di Shen <di.shen@unisoc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org
References: <20230320095620.7480-1-di.shen@unisoc.com>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230320095620.7480-1-di.shen@unisoc.com>
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



On 3/20/23 09:56, Di Shen wrote:
> Commit <0952177f2a1f>(thermal/core/power_allocator: Update once
> cooling devices when temp is low) adds a update flag to avoid
> the thermal event is triggered when there is no need, and
> thermal cdev would be update once when temperature is low.
> 
> But when the trips are writable, and switch_on_temp is set
> to be a higher value, the cooling device state may not be
> reset to 0, because last_temperature is smaller than the
> switch_on_temp.
> 
> For example:
> First:
> switch_on_temp=70 control_temp=85;
> Then userspace change the trip_temp:
> switch_on_temp=45 control_temp=55 cur_temp=54
> 
> Then userspace reset the trip_temp:
> switch_on_temp=70 control_temp=85 cur_temp=57 last_temp=54
> 
> At this time, the cooling device state should be reset to 0.
> However, because cur_temp(57) < switch_on_temp(70)
> last_temp(54) < switch_on_temp(70)  ---->  update = false,
> update is false, the cooling device state can not be reset.
> 
> This patch adds a function thermal_cdev_needs_update() to
> renew the update flag value only when the trips are writable,
> so that thermal cdev->state can be reset after switch_on_temp
> changed from low to high.
> 
> Fixes: <0952177f2a1f> (thermal/core/power_allocator: Update once cooling devices when temp is low)
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> 
> ---
> V3:
> - Add fix tag.
> 
> V2:
> - Compared to v1, do not revert.
> 
> - Add a variable(last_switch_on_temp) in power_allocator_params
>    to record the last switch_on_temp value.
> 
> - Adds a function to renew the update flag and update the
>    last_switch_on_temp when thermal trips are writable.
> 
> V1:
> - Revert commit 0952177f2a1f.
> ---
> ---
>   drivers/thermal/gov_power_allocator.c | 39 ++++++++++++++++++++++-----
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 0eaf1527d3e3..c9e1f3b15f15 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -59,6 +59,8 @@ static inline s64 div_frac(s64 x, s64 y)
>    *			governor switches on when this trip point is crossed.
>    *			If the thermal zone only has one passive trip point,
>    *			@trip_switch_on should be INVALID_TRIP.
> + * @last_switch_on_temp:Record the last switch_on_temp only when trips
> +			are writable.
>    * @trip_max_desired_temperature:	last passive trip point of the thermal
>    *					zone.  The temperature we are
>    *					controlling for.
> @@ -70,6 +72,9 @@ struct power_allocator_params {
>   	s64 err_integral;
>   	s32 prev_err;
>   	int trip_switch_on;
> +#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
> +	int last_switch_on_temp;
> +#endif
>   	int trip_max_desired_temperature;
>   	u32 sustainable_power;
>   };
> @@ -554,6 +559,25 @@ static void get_governor_trips(struct thermal_zone_device *tz,
>   	}
>   }
>   
> +#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
> +static bool thermal_cdev_needs_update(struct thermal_zone_device *tz, int switch_on_temp)
> +{
> +	bool update;
> +	struct power_allocator_params *params = tz->governor_data;
> +	int last_switch_on_temp = params->last_switch_on_temp;
> +
> +	update = (tz->last_temperature >= last_switch_on_temp);
> +	params->last_switch_on_temp = switch_on_temp;
> +
> +	return update;
> +}
> +#else
> +static inline bool thermal_cdev_needs_update(struct thermal_zone_device *tz, int switch_on_temp)
> +{
> +	return false;
> +}
> +#endif
> +
>   static void reset_pid_controller(struct power_allocator_params *params)
>   {
>   	params->err_integral = 0;
> @@ -709,12 +733,15 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>   		return 0;
>   
>   	ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> -	if (!ret && (tz->temperature < trip.temperature)) {
> -		update = (tz->last_temperature >= trip.temperature);
> -		tz->passive = 0;
> -		reset_pid_controller(params);
> -		allow_maximum_power(tz, update);
> -		return 0;
> +	if (!ret) {
> +		update = thermal_cdev_needs_update(tz, trip.temperature);
> +		if (tz->temperature < trip.temperature) {
> +			update |= (tz->last_temperature >= trip.temperature);
> +			tz->passive = 0;
> +			reset_pid_controller(params);
> +			allow_maximum_power(tz, update);
> +			return 0;
> +		}
>   	}
>   
>   	tz->passive = 1;


Thanks for the patch. The code looks good. The initial value of
'last_switch_on_temp' would be set to 0. It won't harm us because it
will get the proper value later.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
