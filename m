Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB396CC626
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjC1PYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjC1PYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DADEFA2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4046182C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CD0C4339C;
        Tue, 28 Mar 2023 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680016902;
        bh=i3OkFYn+CvmNVhVlFuKMt5831golXkFfwanYc2N5usY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTRUTtheg3ul7TFIUZ2bUACT6mMO4m2jNNA8dJNsFdEOYw3guRTO9SMsVWYvsAY3h
         EhoYVun4Z7KOwxgYLpVZ2guqVBHuO3HOmujEehnh8rNAT0npfoh0Sav0Vr5z+tyr/M
         39mQciKni4eiIwKhS7OUB9A/BrRmRmGU73J7eYMkWPSDFMwDWNNHzDKaFglqo9rVkH
         mgl9O65iX1QyJ8ivozahD4YKlnfUmQrz8A7NELtC9nJtteF0T/Qa1oLTI3SebGQhoa
         q3wGgKqG4koRsPL++lYpA19H7Jzd+4rApL2oihpzZoPXsXTumvaFg6MCI2LWW7mAOr
         15AVt+voYRK5w==
Date:   Tue, 28 Mar 2023 16:21:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Zaid Al-Bassam <zalbassam@google.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mach-virt: fix PMUv3 dependendency
Message-ID: <20230328152136.GA1844@willie-the-truck>
References: <20230328144405.1527555-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328144405.1527555-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Mar 28, 2023 at 04:43:44PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting a ARM_PMUV3 from a platform option breaks the build
> when CONFIG_ARM_PMU is not already set:
> 
> WARNING: unmet direct dependencies detected for ARM_PMUV3
>   Depends on [n]: PERF_EVENTS [=y] && HW_PERF_EVENTS [=n] && (ARM [=y] && CPU_V7 [=y] || ARM64)
>   Selected by [y]:
>   - ARCH_VIRT [=y] && ARCH_MULTI_V7 [=y] && PERF_EVENTS [=y]
> 
> drivers/perf/arm_pmuv3.c:48:9: error: 'PERF_MAP_ALL_UNSUPPORTED' undeclared here (not in a function)
>    48 |         PERF_MAP_ALL_UNSUPPORTED,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/perf/arm_pmuv3.c:63:9: error: 'PERF_CACHE_MAP_ALL_UNSUPPORTED' undeclared here (not in a function)
>    63 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/perf/arm_pmuv3.c:65:10: error: implicit declaration of function 'C' [-Werror=implicit-function-declaration]
>    65 |         [C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]  = ARMV8_PMUV3_PERFCTR_L1D_CACHE,
> 
> Fixes: 3b16f6268e66 ("ARM: mach-virt: Select PMUv3 driver by default")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8ccacb3653b..700458c7cace 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -397,7 +397,7 @@ config ARCH_VIRT
>  	select ARM_GIC_V3
>  	select ARM_GIC_V3_ITS if PCI
>  	select ARM_PSCI
> -	select ARM_PMUV3 if PERF_EVENTS
> +	select ARM_PMUV3 if PERF_EVENTS && ARM_PMU
>  	select HAVE_ARM_ARCH_TIMER

We're discussing this one over at:

https://lore.kernel.org/r/202303281539.zzI4vpw1-lkp@intel.com

I'm leaning towards dropping the 'select' altogether.

Will
