Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EBD699789
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBPOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBPOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:35:34 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D54D602
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:35:20 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 3A23526F7A7; Thu, 16 Feb 2023 15:35:19 +0100 (CET)
Date:   Thu, 16 Feb 2023 15:35:19 +0100
From:   Janne Grunau <j@jannau.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        ecurtin@redhat.com, lina@asahilina.net,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ravi.bangoria@amd.com, will@kernel.org
Subject: Re: [PATCH 1/2] arm_pmu: fix event CPU filtering
Message-ID: <20230216143519.GI17933@jannau.net>
References: <20230216141240.3833272-1-mark.rutland@arm.com>
 <20230216141240.3833272-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216141240.3833272-2-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16 14:12:38 +0000, Mark Rutland wrote:
> Janne reports that perf has been broken on Apple M1 as of commit:
> 
>   bd27568117664b8b ("perf: Rewrite core context handling")
> 
> That commit replaced the pmu::filter_match() callback with
> pmu::filter(), whose return value has the opposite polarity, with true
> implying events should be ignored rather than scheduled. While an
> attempt was made to update the logic in armv8pmu_filter() and
> armpmu_filter() accordingly, the return value remains inverted in a
> couple of cases:
> 
> * If the arm_pmu does not have an arm_pmu::filter() callback,
>   armpmu_filter() will always return whether the CPU is supported rather
>   than whether the CPU is not supported.
> 
>   As a result, the perf core will not schedule events on supported CPUs,
>   resulting in a loss of events. Additionally, the perf core will
>   attempt to schedule events on unsupported CPUs, but this will be
>   rejected by armpmu_add(), which may result in a loss of events from
>   other PMUs on those unsupported CPUs.
> 
> * If the arm_pmu does have an arm_pmu::filter() callback, and
>   armpmu_filter() is called on a CPU which is not supported by the
>   arm_pmu, armpmu_filter() will return false rather than true.
> 
>   As a result, the perf core will attempt to schedule events on
>   unsupported CPUs, but this will be rejected by armpmu_add(), which may
>   result in a loss of events from other PMUs on those unsupported CPUs.
> 
> This means a loss of events can be seen with any arm_pmu driver, but
> with the ARMv8 PMUv3 driver (which is the only arm_pmu driver with an
> arm_pmu::filter() callback) the event loss will be more limited and may
> go unnoticed, which is how this issue evaded testing so far.
> 
> Fix the CPU filtering by performing this consistently in
> armpmu_filter(), and remove the redundant arm_pmu::filter() callback and
> armv8pmu_filter() implementation.
> 
> Commit bd2756811766 also silently removed the CHAIN event filtering from
> armv8pmu_filter(), which will be addressed by a separate patch without
> using the filter callback.
> 
> Fixes: bd27568117664b8b ("perf: Rewrite core context handling")
> Reported-by: Janne Grunau <j@jannau.net>
> Link: https://lore.kernel.org/asahi/20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net/
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Asahi Lina <lina@asahilina.net>
> Cc: Eric Curtin <ecurtin@redhat.com>
> ---
>  arch/arm64/kernel/perf_event.c | 7 -------
>  drivers/perf/arm_pmu.c         | 8 +-------
>  include/linux/perf/arm_pmu.h   | 1 -
>  3 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index a5193f2146a6..3e43538f6b72 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1023,12 +1023,6 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  	return 0;
>  }
>  
> -static bool armv8pmu_filter(struct pmu *pmu, int cpu)
> -{
> -	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> -	return !cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus);
> -}
> -
>  static void armv8pmu_reset(void *info)
>  {
>  	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
> @@ -1258,7 +1252,6 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>  	cpu_pmu->stop			= armv8pmu_stop;
>  	cpu_pmu->reset			= armv8pmu_reset;
>  	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
> -	cpu_pmu->filter			= armv8pmu_filter;
>  
>  	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
>  
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 9b593f985805..40f70f83daba 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -550,13 +550,7 @@ static void armpmu_disable(struct pmu *pmu)
>  static bool armpmu_filter(struct pmu *pmu, int cpu)
>  {
>  	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> -	bool ret;
> -
> -	ret = cpumask_test_cpu(cpu, &armpmu->supported_cpus);
> -	if (ret && armpmu->filter)
> -		return armpmu->filter(pmu, cpu);
> -
> -	return ret;
> +	return !cpumask_test_cpu(cpu, &armpmu->supported_cpus);
>  }
>  
>  static ssize_t cpus_show(struct device *dev,
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index ef914a600087..525b5d64e394 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -100,7 +100,6 @@ struct arm_pmu {
>  	void		(*stop)(struct arm_pmu *);
>  	void		(*reset)(void *);
>  	int		(*map_event)(struct perf_event *event);
> -	bool		(*filter)(struct pmu *pmu, int cpu);
>  	int		num_events;
>  	bool		secure_access; /* 32-bit ARM only */
>  #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40

This works as well. I limited the patch to the minimal fix this                                                   
this late in the cycle.

Tested-by: Janne Grunau <j@jannau.net>

thanks,
Janne
