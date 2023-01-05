Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71D65EE88
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjAEONb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjAEOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:12:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E94EE59319;
        Thu,  5 Jan 2023 06:12:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73CE315BF;
        Thu,  5 Jan 2023 06:13:04 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78B243F71A;
        Thu,  5 Jan 2023 06:12:21 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:12:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yogesh Lal <quic_ylal@quicinc.com>
Cc:     maz@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: ERRATUM_858921 is broken on 5.15 kernel
Message-ID: <Y7bar/zQ4khMDyiv@FVFF77S0Q05N>
References: <ca4679a0-7f29-65f4-54b9-c575248192f1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca4679a0-7f29-65f4-54b9-c575248192f1@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 07:03:48PM +0530, Yogesh Lal wrote:
> Hi,
> 
> We are observing issue on A73 core where ERRATUM_858921 is broken.

Do you *only* see this issue on v5.15.y, or is mainline (e.g. v6.2-rc2) also
broken?

I don't see any fix that fits your exact description below, but I do see that
we've made a bunch of changes in this area since.

> 
> On 5.15 kernel arch_timer_enable_workaround is set by reading
> arm64_858921_read_cntpct_el0 and arm64_858921_read_cntvct_el0 during timer
> register using following path.
> 
> arch_timer_enable_workaround->atomic_set(&timer_unstable_counter_workaround_in_use,
> 1);
> 
> [code snap]
> 564 static
> 565 void arch_timer_enable_workaround(const struct
> arch_timer_erratum_workaround *wa,
> 566                               bool local)
> 567 {
> 568     int i;
> 569
> 570     if (local) {
> 571 __this_cpu_write(timer_unstable_counter_workaround, wa);
> 572     } else {
> 573             for_each_possible_cpu(i)
> 574                     per_cpu(timer_unstable_counter_workaround, i) = wa;
> 575     }
> 576
> 577     if (wa->read_cntvct_el0 || wa->read_cntpct_el0)
> 578 atomic_set(&timer_unstable_counter_workaround_in_use, 1);
> 
> 
> and based on above workaround enablement , appropriate function to get
> counter is used.
> 
> 1008 static void __init arch_counter_register(unsigned type)
> 1009 {
> 1010     u64 start_count;
> 1011
> 1012     /* Register the CP15 based counter if we have one */
> 1013     if (type & ARCH_TIMER_TYPE_CP15) {
> 1014         u64 (*rd)(void);
> 1015
> 1016         if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
> 1017             arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
> 1018             if (arch_timer_counter_has_wa())
> 1019                 rd = arch_counter_get_cntvct_stable;
> 1020             else
> 1021                 rd = arch_counter_get_cntvct;
> 1022         } else {
> 1023             if (arch_timer_counter_has_wa())
> 1024                 rd = arch_counter_get_cntpct_stable;
> 1025             else
> 1026                 rd = arch_counter_get_cntpct;
> 1027         }
> [snap]
> 1043     /* 56 bits minimum, so we assume worst case rollover */
> 1044     sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> 
> 
> As our boot cores are not impacted by errata sched_clock_register() will
> register !arch_timer_counter_has_wa() callback.

It would be helpful to mention this fact (that the system is big.LITTLE, and
the boot cores are not Cortex-A73) earlier in the report.

> Now when errata impacted core boots up and sched_clock_register already
> register will !arch_timer_counter_has_wa() path.
> As sched_clock_register is not per_cpu bases so arch_timer_read_counter will
> always point to !arch_timer_counter_has_wa() function calls.

Hmm... yes, AFAICT this cannot work unless the affected CPUs are up before we
probe, and it doesn't make much sense for arch_counter_register() to look at
arch_timer_counter_has_wa() since it can be called before all CPUs are up.

> Looks like this bug is side effect of following patch:
> 
> commit 0ea415390cd345b7d09e8c9ebd4b68adfe873043
> Author: Marc Zyngier <marc.zyngier@arm.com>
> Date:   Mon Apr 8 16:49:07 2019 +0100
> 
>     clocksource/arm_arch_timer: Use arch_timer_read_counter to access stable
> counters
> 
>     Instead of always going via arch_counter_get_cntvct_stable to access the
>     counter workaround, let's have arch_timer_read_counter point to the
>     right method.
> 
>     For that, we need to track whether any CPU in the system has a
>     workaround for the counter. This is done by having an atomic variable
>     tracking this.
> 
>     Acked-by: Mark Rutland <mark.rutland@arm.com>
>     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>     Signed-off-by: Will Deacon <will.deacon@arm.com>
> 

Yeah, that does look to be broken, but I think there are futher issues anyway
(e.g. late onlining).

AFAICT we need to detect this *stupidly early* in the CPU bringup path in order
to handle this safely, which is quite painful.

What a great.

Thanks,
Mark.
