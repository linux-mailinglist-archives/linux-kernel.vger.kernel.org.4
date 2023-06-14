Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712C372F79E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbjFNISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjFNISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:18:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B88D1984;
        Wed, 14 Jun 2023 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FIzRwjiKM7SvRFy1N4h9FRGo7xOEwNJymcZ/CXggJvU=; b=jPiJRxzHMAQaXI0SS5WpBBWV/0
        ZMINmS9g0g7iF4YhMVQS5kwtbV2cO2FE8ngADbM9tQ6tOaqrHvCwjDWI3VWwDFz6lh98bey8XF2gl
        Jx3xKCvybrlRPZLid9VukQ9kRDr4eV3IF8E9MdJhN+kiPbYaeprGs7XIr+hy9CbguwdVFOACWUrZG
        D480SOpWqtdyw3GBXptZctR7UCi/N0HfNClqzk6YDlZOc0Ds+C3yq4nb8uiz9uDOHvGWyIb7HrsCn
        Yn97drpKxX0kzcSoIHAU2yxcrLQCrnzltCSeRURawGZMfkCPN1jc8Ebe5D6nT/iXV0qJULf+kKiAV
        5FzEwZtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9LhX-005vmJ-1g; Wed, 14 Jun 2023 08:17:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11C643002A9;
        Wed, 14 Jun 2023 10:17:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF1B427E48343; Wed, 14 Jun 2023 10:17:57 +0200 (CEST)
Date:   Wed, 14 Jun 2023 10:17:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>, yu.c.chen@intel.com
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230614081757.GA1639749@hirez.programming.kicks-ass.net>
References: <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
 <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
 <20230613082536.GI83892@hirez.programming.kicks-ass.net>
 <3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:00:39PM +0530, K Prateek Nayak wrote:

> >> - SIS_NODE_TOPOEXT - tip:sched/core + this patch
> >>                      + new sched domain (Multi-Multi-Core or MMC)
> >> 		     (https://lore.kernel.org/all/20230601153522.GB559993@hirez.programming.kicks-ass.net/)
> >> 		     MMC domain groups 2 nearby CCX.
> > 
> > OK, so you managed to get the NPS4 topology in NPS1 mode?
> 
> Yup! But it is a hack. I'll leave the patch at the end.

Chen Yu, could we do the reverse? Instead of building a bigger LLC
domain, can we split our LLC based on SNC (sub-numa-cluster) topologies?

Because as you know, Intel chips are having the reverse problem of the
LLC being entirely too large, so perhaps we can break it up along the
SNC lines.

Could you see if that works?

> Here you go. It is not pretty and assigning the mmc_id is a hack.
> Below diff should apply cleanly on top of commit e2a1f85bf9f5
> ("sched/psi: Avoid resetting the min update period when it is
> unnecessary") with the SIS_NODE patch.
> 
> ---
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 4e91054c84be..cca5d147d8e1 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -16,8 +16,10 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
>  DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
>  /* cpus sharing the last level cache: */
>  DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
> +DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_mc_shared_map);
>  DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
>  DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
> +DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_mc_id);
>  DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
>  
>  DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
> @@ -166,6 +168,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>  	return per_cpu(cpu_llc_shared_map, cpu);
>  }
>  
> +static inline struct cpumask *cpu_mc_shared_mask(int cpu)
> +{
> +	return per_cpu(cpu_mc_shared_map, cpu);
> +}
> +
>  static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
>  {
>  	return per_cpu(cpu_l2c_shared_map, cpu);
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 458c891a8273..b3519d2d0b56 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -102,6 +102,7 @@ static inline void setup_node_to_cpumask_map(void) { }
>  
>  #include <asm-generic/topology.h>
>  
> +extern const struct cpumask *cpu_mcgroup_mask(int cpu);
>  extern const struct cpumask *cpu_coregroup_mask(int cpu);
>  extern const struct cpumask *cpu_clustergroup_mask(int cpu);
>  
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 4063e8991211..f6e3be6f2512 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -35,6 +35,7 @@
>  
>  /* Shared last level cache maps */
>  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
> +DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_mc_shared_map);
>  
>  /* Shared L2 cache maps */
>  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
> @@ -677,6 +678,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
>  		 * Core complex ID is ApicId[3] for these processors.
>  		 */
>  		per_cpu(cpu_llc_id, cpu) = c->apicid >> 3;
> +		per_cpu(cpu_mc_id, cpu) = c->apicid >> 4;
>  	} else {
>  		/*
>  		 * LLC ID is calculated from the number of threads sharing the
> @@ -693,6 +695,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
>  			int bits = get_count_order(num_sharing_cache);
>  
>  			per_cpu(cpu_llc_id, cpu) = c->apicid >> bits;
> +			per_cpu(cpu_mc_id, cpu) = (c->apicid >> bits) >> 1;
>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 80710a68ef7d..a320516bf767 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -81,6 +81,7 @@ EXPORT_SYMBOL(smp_num_siblings);
>  
>  /* Last level cache ID of each logical CPU */
>  DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
> +DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_mc_id) = BAD_APICID;
>  
>  u16 get_llc_id(unsigned int cpu)
>  {
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 28fcd292f5fd..dedf86b9e8cb 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -536,6 +536,23 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>  	return topology_sane(c, o, "llc");
>  }
>  
> +static bool match_mc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
> +{
> +	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
> +
> +	/*
> +	 * Do not match if we do not have a valid APICID for cpu.
> +	 * TODO: For non AMD processors, return topology_same_node(c, o)?
> +	 */
> +	if (per_cpu(cpu_mc_id, cpu1) == BAD_APICID)
> +		return false;
> +
> +	/* Do not match if LLC id does not match: */
> +	if (per_cpu(cpu_mc_id, cpu1) != per_cpu(cpu_mc_id, cpu2))
> +		return false;
> +
> +	return topology_sane(c, o, "mmc");
> +}
>  
>  #if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
>  static inline int x86_sched_itmt_flags(void)
> @@ -570,7 +587,7 @@ static int x86_cluster_flags(void)
>   */
>  static bool x86_has_numa_in_package;
>  
> -static struct sched_domain_topology_level x86_topology[6];
> +static struct sched_domain_topology_level x86_topology[7];
>  
>  static void __init build_sched_topology(void)
>  {
> @@ -596,6 +613,16 @@ static void __init build_sched_topology(void)
>  		cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC)
>  	};
>  #endif
> +
> +	/*
> +	 * Multi-Multi-Core Domain Experimentation
> +	 */
> +	if (static_cpu_has(X86_FEATURE_ZEN)) {
> +		x86_topology[i++] = (struct sched_domain_topology_level){
> +			cpu_mcgroup_mask, SD_INIT_NAME(MMC)
> +		};
> +	}
> +
>  	/*
>  	 * When there is NUMA topology inside the package skip the DIE domain
>  	 * since the NUMA domains will auto-magically create the right spanning
> @@ -628,6 +655,7 @@ void set_cpu_sibling_map(int cpu)
>  	if (!has_mp) {
>  		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
>  		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
> +		cpumask_set_cpu(cpu, cpu_mc_shared_mask(cpu));
>  		cpumask_set_cpu(cpu, cpu_l2c_shared_mask(cpu));
>  		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
>  		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
> @@ -647,6 +675,9 @@ void set_cpu_sibling_map(int cpu)
>  		if ((i == cpu) || (has_mp && match_llc(c, o)))
>  			link_mask(cpu_llc_shared_mask, cpu, i);
>  
> +		if ((i == cpu) || (has_mp && match_mc(c, o)))
> +			link_mask(cpu_mc_shared_mask, cpu, i);
> +
>  		if ((i == cpu) || (has_mp && match_l2c(c, o)))
>  			link_mask(cpu_l2c_shared_mask, cpu, i);
>  
> @@ -700,6 +731,12 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>  	return cpu_llc_shared_mask(cpu);
>  }
>  
> +/* maps the cpu to the sched domain representing multi-multi-core */
> +const struct cpumask *cpu_mcgroup_mask(int cpu)
> +{
> +	return cpu_mc_shared_mask(cpu);
> +}
> +
>  const struct cpumask *cpu_clustergroup_mask(int cpu)
>  {
>  	return cpu_l2c_shared_mask(cpu);
> @@ -1393,6 +1430,7 @@ void __init smp_prepare_cpus_common(void)
>  		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
>  		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
>  		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
> +		zalloc_cpumask_var(&per_cpu(cpu_mc_shared_map, i), GFP_KERNEL);
>  		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
>  		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
>  	}
> @@ -1626,9 +1664,12 @@ static void remove_siblinginfo(int cpu)
>  
>  	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
>  		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
> +	for_each_cpu(sibling, cpu_mc_shared_mask(cpu))
> +		cpumask_clear_cpu(cpu, cpu_mc_shared_mask(sibling));
>  	for_each_cpu(sibling, cpu_l2c_shared_mask(cpu))
>  		cpumask_clear_cpu(cpu, cpu_l2c_shared_mask(sibling));
>  	cpumask_clear(cpu_llc_shared_mask(cpu));
> +	cpumask_clear(cpu_mc_shared_mask(cpu));
>  	cpumask_clear(cpu_l2c_shared_mask(cpu));
>  	cpumask_clear(topology_sibling_cpumask(cpu));
>  	cpumask_clear(topology_core_cpumask(cpu));
> --
> 
> I'll share the data from the reruns of SIS_NODE_LIMIT soon. In the
> meantime, if there is anything you would like more data on, please do let
> me know.
> 
> --
> Thanks and Regards,
> Prateek
