Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125B86FE2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjEJQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjEJQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:43:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2B601BB;
        Wed, 10 May 2023 09:43:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED6FD12FC;
        Wed, 10 May 2023 09:44:10 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BF0F3F67D;
        Wed, 10 May 2023 09:43:23 -0700 (PDT)
Date:   Wed, 10 May 2023 17:43:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/10] arm64: idle: Tag the arm64 idle functions as
 __cpuidle
Message-ID: <ZFvJqIYo00vfqRiB@FVFF77S0Q05N.cambridge.arm.com>
References: <20230419225604.21204-1-dianders@chromium.org>
 <20230419155341.v8.6.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419155341.v8.6.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 03:56:00PM -0700, Douglas Anderson wrote:
> As per the (somewhat recent) comment before the definition of
> `__cpuidle`, the tag is like `noinstr` but also marks a function so it
> can be identified by cpu_in_idle(). Let'a add this.
> 
> After doing this then when we dump stack traces of all processors
> using nmi_cpu_backtrace() then instead of getting useless backtraces
> we get things like:
> 
>   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98

As a heads-up, this is only going to work in the trivial case where a CPU is
within the default cpu_do_idle(), and not for anything using PSCI
cpu_suspend() (which I'd *really* hope is the common case).

That doesn't get inlined, and the invocation is shared with other SMCCC users,
so we probably need more work there if culling idle backtraces is important.

I'm not averse to this change itself.

Mark.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v8:
> - "Tag the arm64 idle functions as __cpuidle" new for v8
> 
>  arch/arm64/kernel/idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
> index c1125753fe9b..05cfb347ec26 100644
> --- a/arch/arm64/kernel/idle.c
> +++ b/arch/arm64/kernel/idle.c
> @@ -20,7 +20,7 @@
>   *	ensure that interrupts are not masked at the PMR (because the core will
>   *	not wake up if we block the wake up signal in the interrupt controller).
>   */
> -void noinstr cpu_do_idle(void)
> +void __cpuidle cpu_do_idle(void)
>  {
>  	struct arm_cpuidle_irq_context context;
>  
> @@ -35,7 +35,7 @@ void noinstr cpu_do_idle(void)
>  /*
>   * This is our default idle handler.
>   */
> -void noinstr arch_cpu_idle(void)
> +void __cpuidle arch_cpu_idle(void)
>  {
>  	/*
>  	 * This should do all the clock switching and wait for interrupt
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 
