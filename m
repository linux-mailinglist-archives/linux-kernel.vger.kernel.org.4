Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB162ADC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiKOWIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiKOWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:08:22 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43982FC2A;
        Tue, 15 Nov 2022 14:08:18 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 71815100006;
        Tue, 15 Nov 2022 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668550097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8kX9BK+p90uYuJR0Um3Xq35qwoEFzQYYov+5yT+VzM=;
        b=kOVRYVLrb3caTDuD8WOL3RAwKT7yQ4MEchxJu03+5c+w7WT6qTSpqnDFxrFyP59KVywy9T
        8jH7lernSFURn9Z3ZJU7G/TCoAGeurOYHuKINXw/mYkcahn/Gk6kfgKESL7oC6P3UaC0M5
        Bt3KotQpvkLV75LxYfTFV+nsdWkWeSDOpBk2m9BL0khhW5BW6k+nulCCTXT8WBaP83CaiE
        vpfNGfG01otVYP3iA5KJGogSvBww2uwtldlR3OsDAGiv/coX72UolHn8t+/PxuYGCcTTXk
        yluPcusyzoL+au6Hh/FTYMoPHAkNFugZ7ymwyNEWR+XwN1xGgUdu3v1GxIS09A==
Date:   Tue, 15 Nov 2022 23:08:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Arnd Bergmann <arnd@arndb.de>,
        Reinier Kuipers <kuipers.reinier@gmail.com>,
        linux-rtc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] rtc: y2038: remove broken RTC_HCTOSYS workaround
Message-ID: <Y3QNzvAYo9y+yyTf@mail.local>
References: <20220908115337.1604277-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908115337.1604277-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm fine with the patch and I'll probably take it, I a an observation
though:

On 08/09/2022 13:53:20+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The RTC_HCTOSYS is fundamentally flawed for legacy user space, and
> unfortunately there are no good solutions for it.
> 
> As Reinier Kuipers reports, the current code is broken for any 32-bit
> platform that relies on CONFIG_RTC_HCTOSYS when they want to support
> 64-bit time_t. Running with the RTC set to 2038 or later, the system
> clock silently reverts back to 1970, which makes it impossible to actually
> deploy such a system today and expect it to keep working.
> 
> The code that caused this issue was in turn a workaround for a recurring
> problem that happens when RTCs are set to the wrong time accidentally
> or as the result of a depleted battery. If the time is accidentally set
> past INT_MAX, this causes a systemd with 32-bit time_t to hang on boot,
> with no easy recovery.
> 
> As the kernel has no idea about whether the time from the RTC is real
> or fake, or if the user space it will run has 32-bit or 64-bit time_t,
> it is impossible to make CONFIG_RTC_HCTOSYS work in a way that reliably
> avoids both of the above problems.
> 
> Additionally, the current behavior is inconsistent because it works
> differently based on whether the kernel itself is 32-bit or 64-bit,
> regardless of what userspace is actually running. Configurations in
> full compat mode are getting more popular (again) as Arm based SoCs are
> increasingly built using 64-bit CPU cores like Cortex-A35, but memory
> constrained systems still benefit from running 32-bit user space.
> 
> Change the current behavior in two ways:
> 
>  - In an attempt to pick the lesser of two evils, do not actually set
>    the time differently based on the boot-time RTC contents, but
>    instead warn about affected configurations. This effectively reverts
>    b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow
>    time_t") and will make systemd hang again on broken hardware, but
>    at least makes it possible to deploy y2038 ready 32-bit systems.
> 
>  - Change the #ifdef to check for CONFIG_COMPAT_32BIT_TIME instead of
>    BITS_PER_LONG, so we do not catch kernels that only support time64_t
>    userspace, but do catch 64-bit kernels that may run a 32-bit rootfs.
> 
> Other ideas that have been suggested but discarded include:
> 
>  - Using a blacklist or whitelist of RTC drivers to only set
>    the time on reliable hardware, which would effectively break current
>    users of that hardware immediately, rather than in 16 years.
> 
>  - Changing affected RTC drivers to interpret the register contents
>    as belonging within the 32-bit time_t range but still allow changing
>    that window using the "start-year" DT property to make it work
>    past y2038. This work avoid most of the problems but still requires
>    identifying exactly which drivers are affected.
> 
>  - Dropping CONFIG_RTC_HCTOSYS from the kernel. This is still
>    Alexandre's long-term goal, but we cannot wait for that as users
>    are trying to deploy y2038 compatible systems today.
> 
>  - Making CONFIG_RTC_HCTOSYS depend on !CONFIG_COMPAT_32BIT_TIME,
>    which is a trivial way of avoiding both of the bugs, but breaks
>    all general purpose 32-bit userland until they upgrade to
>    a full time64 build or away from RTC_HCTOSYS.
> 
>  - Changing systemd to no longer crash on broken hardware, or
>    ideally just set the system time itself to a value that is within
>    its time_t range. This was previously rejected by the systemd
>    developers, but is probably needed again with the b3a5ac42ab18
>    patch reverted.
> 
> Cc: Reinier Kuipers <kuipers.reinier@gmail.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: linux-rtc@vger.kernel.org
> Cc: Russell King <linux@armlinux.org.uk>
> Link: https://lore.kernel.org/all/CAKYb531CyL8XRVRcRN30cC3xRgsd-1FzXUeS7o2LiZqALJ42qw@mail.gmail.com/
> Link: https://github.com/systemd/systemd/issues/1143
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/class.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index e48223c00c67..572e356821b5 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -73,11 +73,31 @@ static void rtc_hctosys(struct rtc_device *rtc)
>  
>  	tv64.tv_sec = rtc_tm_to_time64(&tm);
>  
> -#if BITS_PER_LONG == 32
> -	if (tv64.tv_sec > INT_MAX) {
> -		err = -ERANGE;
> -		goto err_read;
> -	}
> +#ifdef CONFIG_COMPAT_32BIT_TIME
> +	/*
> +	 * User space with 32-bit time_t behaves in unexpected ways when
> +	 * the time is set past January 19 2038, often leading to
> +	 * unbootable systems. With CONFIG_RTC_HCTOSYS, this can happen
> +	 * either because of broken RTC hardware that sets a random time
> +	 * with a depleted battery, or because it is actually the future.
> +	 *
> +	 * This can affect 32-bit kernels as well as 64-bit kernels when
> +	 * running a 32-bit rootfs or container.
> +	 *
> +	 * Since the kernel has no way of knowing what user space it runs,
> +	 * warn here whenever the kernel is able to run it.
> +	 * When CONFIG_COMPAT_32BIT_TIME is disabled, we know that the
> +	 * system is safe, but unfortunately this this is currently not
> +	 * supported by musl-1.2.x or most glibc based user space.

I was under the impression that musl never had a 32bit time_t nor used
the 32bit time APIs so it would not be affected by the bug.
So I guess the only affected userspace is glibc without _TIME_BITS=64

It doesn't change the fact that the kernel is not aware of any of that.

> +	 *
> +	 * Disabling CONFIG_RTC_HCTOSYS defers the problem to user space,
> +	 * which will work correctly when all of it supports 64-bit
> +	 * time_t, or will alternatively be unable to set a time past
> +	 * y2038 if it still uses 32-bit time_t.
> +	 */
> +	dev_warn(rtc->dev.parent, "Warning: CONFIG_RTC_HCTOSYS is broken for 32-bit time_t userspace\n");
> +	if (tv64.tv_sec > INT_MAX)
> +		dev_warn(rtc->dev.parent, "Time set to past y2038 date\n");
>  #endif
>  
>  	err = do_settimeofday64(&tv64);
> -- 
> 2.29.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
