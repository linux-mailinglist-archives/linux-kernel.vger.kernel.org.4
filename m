Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4536C327D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCUNV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCUNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:21:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C581026843
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679404880; x=1710940880;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1+UQ8hqBGyONf4wA8zSNDO16EIWAiU0GdZRuoJdZK/k=;
  b=WDh0FVTeLRdZysBiThwrMfI2K2wHvjmtbVUr4P0eUhDZCIjr7cyui7n3
   pgStyWmGpLNEvK0FEimsUDIqudG5pgpxb1JXUsHL+4sAxRh194UuzGF7m
   i+3x3dt7tXEwGj+u29gDakuSiETylmngduxk3tg/0Dkedrrd5FsibBU1A
   DlC1UKTJ7C8pnwAs3qeBTzJdTj1zJ84YhDqTuNfP1uhl6biIIMYsFjtFW
   rCkQAxmtgNbygUfF12+rLzL2DFILdcdbeO5s0pTjMewqxbOF2ODkvWXBc
   SpgETm1YmM97BFPJ8nyCV9kkTTot1LhV2LePXByfIZ1JUyUaK1me0SWD3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341297888"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="341297888"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="674834179"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="674834179"
Received: from jluqueti-mobl.ger.corp.intel.com ([10.252.63.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:21:14 -0700
Date:   Tue, 21 Mar 2023 15:21:12 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     James Morse <james.morse@arm.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: Re: [PATCH v3 08/19] x86/resctrl: Add cpumask_any_housekeeping()
 for limbo/overflow
In-Reply-To: <20230320172620.18254-9-james.morse@arm.com>
Message-ID: <816992e-a153-db6e-d3d7-84de1c1e1d59@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-9-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, James Morse wrote:

> The limbo and overflow code picks a CPU to use from the domain's list
> of online CPUs. Work is then scheduled on these CPUs to maintain
> the limbo list and any counters that may overflow.
> 
> cpumask_any() may pick a CPU that is marked nohz_full, which will
> either penalise the work that CPU was dedicated to, or delay the
> processing of limbo list or counters that may overflow. Perhaps
> indefinitely. Delaying the overflow handling will skew the bandwidth
> values calculated by mba_sc, which expects to be called once a second.
> 
> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
> that prefers housekeeping CPUs. This helper will still return
> a nohz_full CPU if that is the only option. The CPU to use is
> re-evaluated each time the limbo/overflow work runs. This ensures
> the work will move off a nohz_full CPU once a houskeeping CPU is
> available.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 17 ++++++++++++-----
>  include/linux/tick.h                   |  3 ++-
>  3 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 87545e4beb70..0b5fd5a0cda2 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <linux/tick.h>
>  #include <asm/resctrl.h>
>  
>  #define L3_QOS_CDP_ENABLE		0x01ULL
> @@ -55,6 +56,28 @@
>  /* Max event bits supported */
>  #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>  
> +/**
> + * cpumask_any_housekeeping() - Chose any cpu in @mask, preferring those that

Choose

> + *			        aren't marked nohz_full
> + * @mask:	The mask to pick a CPU from.
> + *
> + * Returns a CPU in @mask. If there are houskeeping CPUs that don't use

housekeeping

> + * nohz_full, these are preferred.
> + */
> +static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> +{
> +	int cpu, hk_cpu;
> +
> +	cpu = cpumask_any(mask);
> +	if (tick_nohz_full_cpu(cpu)) {
> +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> +		if (hk_cpu < nr_cpu_ids)
> +			cpu = hk_cpu;
> +	}
> +
> +	return cpu;
> +}
> +
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index a2ae4be4b2ba..3bec5c59ca0e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -745,9 +745,9 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
>  void cqm_handle_limbo(struct work_struct *work)
>  {
>  	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
> -	int cpu = smp_processor_id();
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> +	int cpu;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> @@ -756,8 +756,10 @@ void cqm_handle_limbo(struct work_struct *work)
>  
>  	__check_limbo(d, false);
>  
> -	if (has_busy_rmid(r, d))
> +	if (has_busy_rmid(r, d)) {
> +		cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
> +	}
>  
>  	mutex_unlock(&rdtgroup_mutex);
>  }
> @@ -767,7 +769,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->cqm_work_cpu = cpu;
>  
>  	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
> @@ -777,10 +779,10 @@ void mbm_handle_overflow(struct work_struct *work)
>  {
>  	unsigned long delay = msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
>  	struct rdtgroup *prgrp, *crgrp;
> -	int cpu = smp_processor_id();
>  	struct list_head *head;
>  	struct rdt_resource *r;
>  	struct rdt_domain *d;
> +	int cpu;
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> @@ -801,6 +803,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  			update_mba_bw(prgrp, d);
>  	}
>  
> +	/*
> +	 * Re-check for housekeeping CPUs. This allows the overflow handler to
> +	 * move off a nohz_full CPU quickly.
> +	 */
> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>  	schedule_delayed_work_on(cpu, &d->mbm_over, delay);
>  
>  out_unlock:
> @@ -814,7 +821,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  	if (!static_branch_likely(&rdt_mon_enable_key))
>  		return;
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->mbm_work_cpu = cpu;
>  	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index bfd571f18cfd..ae2e9019fc18 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -174,9 +174,10 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>  static inline void tick_nohz_idle_stop_tick_protected(void) { }
>  #endif /* !CONFIG_NO_HZ_COMMON */
>  
> +extern cpumask_var_t tick_nohz_full_mask;
> +
>  #ifdef CONFIG_NO_HZ_FULL
>  extern bool tick_nohz_full_running;
> -extern cpumask_var_t tick_nohz_full_mask;

Its definition seems to also be inside #ifdef:

kernel/time/tick-sched.c-#ifdef CONFIG_NO_HZ_FULL
kernel/time/tick-sched.c:cpumask_var_t tick_nohz_full_mask;
kernel/time/tick-sched.c:EXPORT_SYMBOL_GPL(tick_nohz_full_mask);


-- 
 i.

