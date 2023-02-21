Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB70869D970
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjBUDpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjBUDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:45:00 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B893CF;
        Mon, 20 Feb 2023 19:44:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 096B13FB17;
        Tue, 21 Feb 2023 03:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1676951095; bh=z+58+QJcVH0GSU4dfnKJG6sV0atAJpJZM0PmOGOrpCQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Da/coslVKVT6AdPdmAYnct7dZRD12T6oYTiHeIULtD51snXB2Mymh71IWg53mC/cc
         GRka1nODAzTUYdyDW/a0HsZODL342C+GIxiL+S4CqlDqLQfIkaI2d+jaAJusjiP48p
         L8eJhtLt5fSDYDIMP4nTCnLBAp52VQ2pseRkCe+b5kaPWjQxBxnlgdLCn4ZXRHOiqV
         KSGyUMqxA26rP0jpT1vdWINbo9+N9xiVc5m7hHp8vVtp206gT1B0P7yOwSryVvJvTz
         M8FGKeRqlaTPn75koHA2HJizkLzZXTd1pB+dGs74ADJsI50oKYVWt3NJZcsyNvSZS5
         CLjwgdqkR1EFA==
Message-ID: <19938ad0-9dde-560c-2e4f-a697b5323051@marcan.st>
Date:   Tue, 21 Feb 2023 12:44:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PM: s2idle: Don't allow s2idle when cpuidle isn't
 supported
Content-Language: en-US
To:     Kazuki Hashimoto <kazukih0205@gmail.com>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <20230214215003.70683-1-kazukih0205@gmail.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230214215003.70683-1-kazukih0205@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2023 06.50, Kazuki Hashimoto wrote:
> s2idle isn't supported on platforms that don't support cpuidle as of
> 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze()
> too"), so update the suspend framework to reflect this in order to avoid
> breakages.
> 
> Link: https://lore.kernel.org/all/20230204152747.drte4uitljzngdt6@kazuki-mac
> Fixes: 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze() too")
> Signed-off-by: Kazuki Hashimoto <kazukih0205@gmail.com>
> ---
>  kernel/power/suspend.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 3f436282547c..27507ae7c9c9 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -556,6 +556,12 @@ static int enter_state(suspend_state_t state)
>  
>  	trace_suspend_resume(TPS("suspend_enter"), state, true);
>  	if (state == PM_SUSPEND_TO_IDLE) {
> +		struct cpuidle_device *dev = cpuidle_get_device();
> +		struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +
> +		if (cpuidle_not_available(drv, dev))
> +			return -EINVAL;
> +
>  #ifdef CONFIG_PM_DEBUG
>  		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
>  			pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");

Well... this turns s2idle from "slighly broken" to "fully broken". I'm
not sure that's a good idea.

If this (or something equivalent) goes in, we'll have to carry a revert
in the Asahi tree until the PSCI-replacement story goes in, because lots
of people are using the current somewhat broken s2idle. It's a lot
better than having no sleep modes at all.

Also, if you intend to disable s2idle on these platforms, you have to
actually stop advertising it. Advertising it and then refusing to enter
s2idle is not acceptable, it means people will get "sleep" buttons and
expect sleep to work and then it won't. But then that could also
introduce race conditions with userspace checking for sleep support
before the cpuidle driver loads. So there is definitely a can of worms here.

- Hector
