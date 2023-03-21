Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06056C35B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCUPc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCUPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:32:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991462711
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679412775; x=1710948775;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BLmGtZvHGRmtWQIJgM06aKm60El5aTJHv0EDF7NbiFU=;
  b=PKTh5sQNG95vn3f5igyp1w3VX9+/0bFDkFrMvz+kB7aMLhiQSj82sUMa
   ZshBjZClQMJXwRhnmXEC6Br5xMTEsXMpkCio1Le/r2mc1qHUL9lOIBxcq
   0+QvcQbw7FjQW7QFJCqmyyYOIw7xGrcKiZ1Mfd8LD07KZxkB+UYHGl20V
   H5N6QzHV4kA2x6uxPbNDim72JIwf/jwvloFT0w4dJCh2roZf3wZZNZM1P
   33XEEHEj5J2OXBUy2nIponcNZ6tk9OwIFNzEAIr/AuZzPVeCxkqDRVyU0
   Xz9/UyJgWl9WoaMNWrYpY6yUoM/1Gxug0Kn9SUKL27ivJ4fc7IeW9ougN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319363267"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="319363267"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="805419596"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="805419596"
Received: from jluqueti-mobl.ger.corp.intel.com ([10.252.63.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:32:46 -0700
Date:   Tue, 21 Mar 2023 17:32:44 +0200 (EET)
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
Subject: Re: [PATCH v3 18/19] x86/resctrl: Add cpu offline callback for
 resctrl work
In-Reply-To: <20230320172620.18254-19-james.morse@arm.com>
Message-ID: <988232ec-988f-5d12-eacb-8095d8c01eb6@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-19-james.morse@arm.com>
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

> The resctrl architecture specific code may need to free a domain when
> a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
> The resctrl filesystem code needs to move the overflow and limbo work
> to run on a different CPU, and clear this CPU from the cpu_mask of
> control and monitor groups.
> 
> Currently this is all done in core.c and called from
> resctrl_offline_cpu(), making the split between architecture and
> filesystem code unclear.
> 
> Move the filesystem work into a filesystem helper called
> resctrl_offline_cpu(), and rename the one in core.c
> resctrl_arch_offline_cpu().
> 
> The rdtgroup_mutex is unlocked and locked again in the call in
> preparation for changing the locking rules for the architecture
> code.
> 
> resctrl_offline_cpu() is called before any of the resource/domains
> are updated, and makes use of the exclude_cpu feature that was
> previously added.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 41 ++++----------------------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 ++++++++++++++++++++++++
>  include/linux/resctrl.h                |  1 +
>  3 files changed, 45 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index aafe4b74587c..4e5fc89dab6d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -578,22 +578,6 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> -
> -	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> -		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> -			cancel_delayed_work(&d->mbm_over);
> -			/*
> -			 * exclude_cpu=-1 as this CPU has already been removed
> -			 * by cpumask_clear_cpu()d
> -			 */

This was added in 17/19 and now removed (not moved) in 18/19. Please avoid 
such back-and-forth churn.

-- 
 i.


> -			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> -		}
> -		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> -		    has_busy_rmid(r, d)) {
> -			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> -		}
> -	}
>  }
>  
>  static void clear_closid_rmid(int cpu)
> @@ -623,31 +607,15 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
>  	return err;
>  }
>  
> -static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> +static int resctrl_arch_offline_cpu(unsigned int cpu)
>  {
> -	struct rdtgroup *cr;
> -
> -	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
> -		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask)) {
> -			break;
> -		}
> -	}
> -}
> -
> -static int resctrl_offline_cpu(unsigned int cpu)
> -{
> -	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  
>  	mutex_lock(&rdtgroup_mutex);
> +	resctrl_offline_cpu(cpu);
> +
>  	for_each_capable_rdt_resource(r)
>  		domain_remove_cpu(cpu, r);
> -	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> -		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
> -			clear_childcpus(rdtgrp, cpu);
> -			break;
> -		}
> -	}
>  	clear_closid_rmid(cpu);
>  	mutex_unlock(&rdtgroup_mutex);
>  
> @@ -970,7 +938,8 @@ static int __init resctrl_late_init(void)
>  
>  	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				  "x86/resctrl/cat:online:",
> -				  resctrl_arch_online_cpu, resctrl_offline_cpu);
> +				  resctrl_arch_online_cpu,
> +				  resctrl_arch_offline_cpu);
>  	if (state < 0)
>  		return state;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index bf206bdb21ee..c27ec56c6c60 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3710,6 +3710,45 @@ int resctrl_online_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> +static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
> +{
> +	struct rdtgroup *cr;
> +
> +	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
> +		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
> +			break;
> +	}
> +}
> +
> +void resctrl_offline_cpu(unsigned int cpu)
> +{
> +	struct rdt_domain *d;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
> +			clear_childcpus(rdtgrp, cpu);
> +			break;
> +		}
> +	}
> +
> +	d = get_domain_from_cpu(cpu, l3);
> +	if (d) {
> +		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> +			cancel_delayed_work(&d->mbm_over);
> +			mbm_setup_overflow_handler(d, 0, cpu);
> +		}
> +		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> +		    has_busy_rmid(l3, d)) {
> +			cancel_delayed_work(&d->cqm_limbo);
> +			cqm_setup_limbo_handler(d, 0, cpu);
> +		}
> +	}
> +}
> +
>  /*
>   * rdtgroup_init - rdtgroup initialization
>   *
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 3ea7d618f33f..f053527aaa5b 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -226,6 +226,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>  void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>  int resctrl_online_cpu(unsigned int cpu);
> +void resctrl_offline_cpu(unsigned int cpu);
>  
>  /**
>   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
> 

