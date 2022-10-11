Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02245FADD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJKHwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJKHvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:51:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C1A8997C;
        Tue, 11 Oct 2022 00:51:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE40B106F;
        Tue, 11 Oct 2022 00:51:52 -0700 (PDT)
Received: from [10.57.1.254] (unknown [10.57.1.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356923F766;
        Tue, 11 Oct 2022 00:51:45 -0700 (PDT)
Message-ID: <32ee5e63-5b0c-3869-c196-265444d008e9@arm.com>
Date:   Tue, 11 Oct 2022 08:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/governors: Fix cooling device setting cooling
 state failure
Content-Language: en-US
To:     Qibo Huang <huangqibo.tech@gmail.com>
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, rafael@kernel.org
References: <20221010144341.16738-1-huangqibo.tech@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221010144341.16738-1-huangqibo.tech@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qibo,

Thank you for using IPA and sending a patch. Unfortunately,
this code cannot be added into the governor.

On 10/10/22 15:43, Qibo Huang wrote:
> Because the __thermal_cdev_update function traverses the
> cooling_device->thermal_instances list to obtain the maximum
> target state, and then the cooling device sets the maximum
> cooling state. However, the power_actor_set_power function
> only updates the target value of thermal_zone->thermal_instances
> to the target state, and does not update the target value of
> cooling_device->thermal_instances, resulting in the target
> being 0 all the time.
> 
> Signed-off-by: Qibo Huang <huangqibo.tech@gmail.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 2d1aeaba38a8..8a6a08906dd4 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -293,6 +293,7 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
>   		      struct thermal_instance *instance, u32 power)
>   {
>   	unsigned long state;
> +	struct thermal_instance *cdev_instance;
>   	int ret;
>   
>   	ret = cdev->ops->power2state(cdev, power, &state);
> @@ -300,6 +301,10 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
>   		return ret;
>   
>   	instance->target = clamp_val(state, instance->lower, instance->upper);

For our 'instance', which IPA was given be the framework, we set the new
'target' value above.

> +	list_for_each_entry(cdev_instance, &cdev->thermal_instances, cdev_node) {
> +		if (cdev_instance->tz->id == instance->tz->id)
> +			cdev_instance->target = state;

This is not the approach for the governor of a single thermal zone.
Please check the implementation of the function below
__thermal_cdev_update()
You will see there the 'voting' code. This belongs to the framework
code.

> +	}
>   	mutex_lock(&cdev->lock);
>   	__thermal_cdev_update(cdev);

This is the place where the right 'targe't is picked for cooling device
from different thermal zones (and maybe governors). When a new target
value is higher than other target values, the framework would throttle
the device. Then other thermal framework are kicked to make this change
propagated correctly.

Also important, please see that this work is done under the
cdev->lock. Not every code is safe to run, because e.g. this
list cdev->thermal_instances might change in the meantime.

>   	mutex_unlock(&cdev->lock);

Regards,
Lukasz
