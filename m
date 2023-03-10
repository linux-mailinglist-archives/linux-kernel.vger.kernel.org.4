Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3826B4A92
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbjCJPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjCJPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:24:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 705CC1165C3;
        Fri, 10 Mar 2023 07:13:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F371FB;
        Fri, 10 Mar 2023 07:13:57 -0800 (PST)
Received: from [10.57.18.185] (unknown [10.57.18.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53E073F71A;
        Fri, 10 Mar 2023 07:13:12 -0800 (PST)
Message-ID: <db539c1e-22d5-2261-1248-07883dac12ee@arm.com>
Date:   Fri, 10 Mar 2023 15:13:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] thermal/core/power_allocator: avoid cdev->state can not
 be reset
Content-Language: en-US
To:     Di Shen <di.shen@unisoc.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com
References: <20230309135515.1232-1-di.shen@unisoc.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230309135515.1232-1-di.shen@unisoc.com>
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

Hi Di,

On 3/9/23 13:55, Di Shen wrote:
> Commit 0952177f2a1f (thermal/core/power_allocator: Update once cooling devices when temp is low)
> add a update flag to update cooling device only once when temp is low.
> But when the switch_on_temp is set to be a higher value, the cooling device state
> may not be reset to max, because the last_temp is smaller than the switch_on_temp.
> 
> For example:
> First:
> swicth_on_temp=70 control_temp=85;
> 
> Then userspace change the trip_temp:
> swicth_on_temp=45 control_temp=55 cur_temp=54
> 
> Then userspace reset the trip_temp:
> swicth_on_temp=70 control_temp=85 cur_temp=57 last_temp=54
> 
> At this time, the cooling device state should be reset to be max.
> However, because cur_temp(57) < switch_on_temp(70)
> last_temp(54) < swicth_on_temp(70) --> update = false
> When update is false, the cooling device state can not be reset.

That's a tricky use case. How is that now possible,
> 
> So delete the update condition, so that the cooling device state
> could be reset.

IMO this is not the desired solution. Daniel reported the issue that
IPA triggers the event sent to user-space even when there is no need.
That's the motivation for the 0952177f2a1f change.

To address your scenario properly, we need an interface which allows
to respond properly for such situation when someone from user-space
writes a new value to something fundamental as trip point.

You also have a kernel config enabled:
CONFIG_THERMAL_WRITABLE_TRIPS
which IMO is only for debug kernels for system integrator (according
to the Kconfig description).

When you disable this config in your deploy/product kernel
than this issue would disappear.

> 
> Fixes: 0952177f2a1f (thermal/core/power_allocator: Update once cooling devices when temp is low)
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 

That's why IMO this is not the solution.

Regards,
Lukasz
