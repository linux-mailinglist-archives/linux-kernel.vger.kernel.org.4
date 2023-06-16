Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9D732C80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbjFPJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjFPJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:53:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72A26297E;
        Fri, 16 Jun 2023 02:53:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4E41FB;
        Fri, 16 Jun 2023 02:54:07 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1817B3F5A1;
        Fri, 16 Jun 2023 02:53:19 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:53:11 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, sudeep.holla@arm.com,
        ionela.voinescu@arm.com, yang@os.amperecomputing.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZIwxB5ao96pVPaCc@e120325.cambridge.arm.com>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <8e755438-4b1f-b3d6-b2b8-a5efcca813bc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e755438-4b1f-b3d6-b2b8-a5efcca813bc@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:29:57AM +0530, Sumit Gupta wrote:
> 
> 
> On 06/06/23 21:27, Beata Michalska wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > With the Frequency Invariance Engine (FIE) being already wired up with
> > sched tick and making use of relevant (core counter and constant
> > counter) AMU counters, getting the current frequency for a given CPU
> > on supported platforms, can be achieved by utilizing the frequency scale
> > factor which reflects an average CPU frequency for the last tick period
> > length.
> > 
> > With that at hand, arch_freq_get_on_cpu dedicated implementation
> > gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
> > which is expected to represent the current frequency of a given CPU,
> > as obtained by the hardware. This is exactly the type of feedback that
> > cycle counters provide.
> > 
> > In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
> > attribute handler for platforms that do provide cpuinfo_cur_freq, and
> > yet keeping things intact for those platform that do not, its use gets
> > conditioned on the presence of cpufreq_driver (*get) callback (which also
> > seems to be the case for creating cpuinfo_cur_freq attribute).
> > 
> 
> Tested the change with frequency switch stress test but was getting big
> delta between set and get freq.
Would you mind sharing some more data re your testing ?
The arch_freq_get_on_cpu will provided an average freq for last tick period,
with an updated occurring on each sched tick so the differences between set
and get might show up. With your stress testing, if the frequency change comes
at the end of current tick period, it might not be reflected until next one
elapses.
In case of idle states - if the CPU for which the current frequency is being
requested is in idle mode, the frequency returned will be the last one before
entering idle, which seems reasonable (?).
I guess the question here would be what is your tolerance level for those
differences.
> After passing "nohz=off" and commenting "wfi" in "cpu_do_idle()", the
> delta is less. This confirms that more delta is due to AMU counters
> stopping at "WFI".
> 
>   +++ b/arch/arm64/kernel/idle.c
>   @@ -27,7 +27,7 @@ void noinstr cpu_do_idle(void)
>           arm_cpuidle_save_irq_context(&context);
> 
>           dsb(sy);
>   -       wfi();
>   +//     wfi();
> 
> I am not sure if the expected behavior here is right.
Both CPU_CYCLES and CNT_CYCLES are not incremented in WFI.
> In our tests, we compare the last set frequency against the re-generated
> value from counters to confirm that the CPU is actually running at the
> requested frequency and the counters are working correct. But that won't
> happen with this change.
> 
> In [1] and later in the updated patch within [2], we are busy looping
> on the target CPU and avoid WFI to get the actual frequency.
> 
> Please share what you think is the right expected behavior.
> 
> [1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com/T/#mb898a75fd0c72d166b26b04da3ad162afe068a82
