Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447CC736974
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjFTKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:38:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D03DE3;
        Tue, 20 Jun 2023 03:38:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9B31063;
        Tue, 20 Jun 2023 03:38:52 -0700 (PDT)
Received: from [10.57.26.18] (unknown [10.57.26.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 697463F64C;
        Tue, 20 Jun 2023 03:38:06 -0700 (PDT)
Message-ID: <1a921c36-1959-65e0-aaf7-da2683cdb8c4@arm.com>
Date:   Tue, 20 Jun 2023 11:38:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
Content-Language: en-US
To:     Di Shen <di.shen@unisoc.com>
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com, rafael@kernel.org
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230619063534.12831-1-di.shen@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Di,

I have missed your v4 because it landed below your v3 thread.

On 6/19/23 07:35, Di Shen wrote:
> When the thermal trip point is changed, the governor should
> be reset so that the policy algorithm be updated to adapt to the
> new trip point.
> 
> This patch adds an ops for thermal the governor structure to reset

s/ops/callback

> the governor. The ops is called when the trip point is changed.
> For power allocator, the parameters of pid controller and the states
> of power cooling devices can be reset when the passive trip point
> is changed.
> 
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> 
> ---
> V4:
> - Compared to V3, handle it in thermal core instead of in governor.
> 
> - Add an ops to the governor structure, and call it when a trip
>    point is changed.
> 
> - Define reset ops for power allocator.
> 
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
>   drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
>   drivers/thermal/thermal_trip.c        |  6 ++++++
>   include/linux/thermal.h               |  1 +
>   3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 8642f1096b91..41d155adc616 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -729,10 +729,31 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>   	return allocate_power(tz, trip.temperature);
>   }
>   
> +static int power_allocator_reset(struct thermal_zone_device *tz, int trip_id)
> +{
> +	int ret = 0;
> +	struct thermal_trip trip;
> +	struct power_allocator_params *params = tz->governor_data;
> +
> +	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> +	if (ret)
> +		return ret;
> +
> +	/* Only need reset for passive trips */
> +	if (trip.type != THERMAL_TRIP_PASSIVE)
> +		return -EINVAL;
> +
> +	reset_pid_controller(params);
> +	allow_maximum_power(tz, true);
> +
> +	return ret;
> +}
> +
>   static struct thermal_governor thermal_gov_power_allocator = {
>   	.name		= "power_allocator",
>   	.bind_to_tz	= power_allocator_bind,
>   	.unbind_from_tz	= power_allocator_unbind,
>   	.throttle	= power_allocator_throttle,
> +	.reset		= power_allocator_reset,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index 907f3a4d7bc8..52eb768fada8 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>   	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
>   		tz->trips[trip_id] = *trip;
>   
> +	if (t.temperature != trip->temperature && tz->governor && tz->governor->reset) {
> +		ret = tz->governor->reset(tz, trip_id);
> +		if (ret)
> +			pr_warn_once("Failed to reset thermal governor\n");
> +	}

I agree with Rafael. Maybe change that to debug print, so that can be
checked during the product testing. We cannot do much if that happens.

> +
>   	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
>   				      trip->temperature, trip->hysteresis);
>   
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 87837094d549..155ce2291fa5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -204,6 +204,7 @@ struct thermal_governor {
>   	int (*bind_to_tz)(struct thermal_zone_device *tz);
>   	void (*unbind_from_tz)(struct thermal_zone_device *tz);
>   	int (*throttle)(struct thermal_zone_device *tz, int trip);
> +	int (*reset)(struct thermal_zone_device *tz, int trip);
>   	struct list_head	governor_list;
>   };
>   

That thermal_governor::reset() callback is what I had im mind while
giving you the feedback for the v1. Now it's much cleaner what is going
on and why.

Apart from some small bits, LGTM. Please adjust the comment in the patch
header and this debug print and you can add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Please send the next version as separate new thread.

Regards,
Lukasz
