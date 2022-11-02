Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93A61614D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKBK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiKBK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:56:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70F3711443;
        Wed,  2 Nov 2022 03:56:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82F111FB;
        Wed,  2 Nov 2022 03:56:59 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008E23F5A1;
        Wed,  2 Nov 2022 03:56:51 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:56:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/30] clocksource/drivers/arm_arch_timer: Use
 kstrtobool() instead of strtobool()
Message-ID: <Y2JM7mOJwa5ilU4R@FVFF77S0Q05N>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <f430bb12e12eb225ab1206db0be64b755ddafbdc.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f430bb12e12eb225ab1206db0be64b755ddafbdc.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:13:58PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
> 
> The last patch of the serie removes the definition of strtobool().
> 
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/clocksource/arm_arch_timer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index a7ff77550e17..1af045b231fd 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -18,6 +18,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/clocksource_ids.h>
>  #include <linux/interrupt.h>
> +#include <linux/kstrtox.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  #include <linux/io.h>
> @@ -97,7 +98,7 @@ static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EV
>  
>  static int __init early_evtstrm_cfg(char *buf)
>  {
> -	return strtobool(buf, &evtstrm_enable);
> +	return kstrtobool(buf, &evtstrm_enable);
>  }
>  early_param("clocksource.arm_arch_timer.evtstrm", early_evtstrm_cfg);
>  
> -- 
> 2.34.1
> 
