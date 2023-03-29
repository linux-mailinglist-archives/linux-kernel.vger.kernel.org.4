Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E16CDA31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC2NM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjC2NMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:12:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7FDB3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680095573; x=1711631573;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=5Vwh/Volhh+/NA65sq/MLtc+CLNnTXIdhlhu6gU25OA=;
  b=Vsy83n9FIotsmb/6o9vzmNWK8MqSapmkNkPq8uNUMSFgce1JD09Qtmc5
   3VxxU06EVsafODYH5qELTJmHjWOlcQwkLXlzGuaiA16/m0cJOljZB/teN
   b0plDMe54j8IyialmhuUnBkEzVMsCkLLloiRW0LmexPZBC7/7FFP+TcRq
   EDuaQEIBvx7SvRUMkaCctx/53+BkElGUIugot8j7snwdcP1oUv+SYDs1z
   vclFuCf2QzZovEIZ+WVmwKq4h2pUXYnpx5iFeBX+UTdqFbdduZqdKtl3u
   55oPjme3i8tixLkumEiUKT7H89eeAVch+jISbbVVhj5pEU1To7ZzvjOTv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340889788"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="340889788"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827887700"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="827887700"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2023 06:12:53 -0700
Received: from [10.212.202.192] (kliang2-mobl1.ccr.corp.intel.com [10.212.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 55EE2580CD3;
        Wed, 29 Mar 2023 06:12:52 -0700 (PDT)
Message-ID: <0b0e6fd6-b775-cdd0-c3c0-dc20056e07d2@linux.intel.com>
Date:   Wed, 29 Mar 2023 09:12:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2] iommu/vt-d: Fix a IOMMU perfmon warning when CPU
 hotplug
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230328182028.1366416-1-kan.liang@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230328182028.1366416-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-28 2:20 p.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A warning can be triggered when hotplug CPU 0.
> $ echo 0 > /sys/devices/system/cpu/cpu0/online
> 
> [11958.737635] ------------[ cut here ]------------
> [11958.742882] Voluntary context switch within RCU read-side critical
> section!
> [11958.742891] WARNING: CPU: 0 PID: 19 at kernel/rcu/tree_plugin.h:318
> rcu_note_context_switch+0x4f4/0x580
> [11958.860095] RIP: 0010:rcu_note_context_switch+0x4f4/0x580
> [11958.960360] Call Trace:
> [11958.963161]  <TASK>
> [11958.965565]  ? perf_event_update_userpage+0x104/0x150
> [11958.971293]  __schedule+0x8d/0x960
> [11958.975165]  ? perf_event_set_state.part.82+0x11/0x50
> [11958.980891]  schedule+0x44/0xb0
> [11958.984464]  schedule_timeout+0x226/0x310
> [11958.989017]  ? __perf_event_disable+0x64/0x1a0
> [11958.994054]  ? _raw_spin_unlock+0x14/0x30
> [11958.998605]  wait_for_completion+0x94/0x130
> [11959.003352]  __wait_rcu_gp+0x108/0x130
> [11959.007616]  synchronize_rcu+0x67/0x70
> [11959.011876]  ? invoke_rcu_core+0xb0/0xb0
> [11959.016333]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
> [11959.022147]  perf_pmu_migrate_context+0x121/0x370
> [11959.027478]  iommu_pmu_cpu_offline+0x6a/0xa0
> [11959.032325]  ? iommu_pmu_del+0x1e0/0x1e0
> [11959.036782]  cpuhp_invoke_callback+0x129/0x510
> [11959.041825]  cpuhp_thread_fun+0x94/0x150
> [11959.046283]  smpboot_thread_fn+0x183/0x220
> [11959.050933]  ? sort_range+0x20/0x20
> [11959.054902]  kthread+0xe6/0x110
> [11959.058479]  ? kthread_complete_and_exit+0x20/0x20
> [11959.063911]  ret_from_fork+0x1f/0x30
> [11959.067982]  </TASK>
> [11959.070489] ---[ end trace 0000000000000000 ]---
> 
> The synchronize_rcu() will be invoked in the perf_pmu_migrate_context(),
> when migrating a PMU to a new CPU. However, the current for_each_iommu()
> is within RCU read-side critical section.
> 
> Two methods were considered to fix the issue.
> - Use the dmar_global_lock to replace the RCU read lock when going
>   through the drhd list. But it triggers a lockdep warning.
> - Use the cpuhp_setup_state_multi() to set up a dedicated state for each
>   IOMMU PMU. The lock can be avoided.
> 
> The latter method is implemented in this patch. Since each IOMMU PMU has
> a dedicated state, add cpuhp_node and cpu in struct iommu_pmu to track
> the state. The state can be dynamically allocated now. Remove the
> CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE.
> 
> Fixes: 46284c6ceb5e ("iommu/vt-d: Support cpumask for IOMMU perfmon")

Forgot to add a tag. If the patch looks good, please add the below tag
when you pull the patch.

Reported-by: Ammy Yi <ammy.yi@intel.com>

Thanks,
Kan

> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h   |  2 ++
>  drivers/iommu/intel/perfmon.c | 68 ++++++++++++++++++++++-------------
>  include/linux/cpuhotplug.h    |  1 -
>  3 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index d6df3b865812..694ab9b7d3e9 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -641,6 +641,8 @@ struct iommu_pmu {
>  	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
>  	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
>  	unsigned char		irq_name[16];
> +	struct hlist_node	cpuhp_node;
> +	int			cpu;
>  };
>  
>  #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
> diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
> index e17d9743a0d8..e27bc954e866 100644
> --- a/drivers/iommu/intel/perfmon.c
> +++ b/drivers/iommu/intel/perfmon.c
> @@ -773,19 +773,34 @@ static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
>  	iommu->perf_irq = 0;
>  }
>  
> -static int iommu_pmu_cpu_online(unsigned int cpu)
> +static int iommu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>  {
> +	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
> +
>  	if (cpumask_empty(&iommu_pmu_cpu_mask))
>  		cpumask_set_cpu(cpu, &iommu_pmu_cpu_mask);
>  
> +	if (cpumask_test_cpu(cpu, &iommu_pmu_cpu_mask))
> +		iommu_pmu->cpu = cpu;
> +
>  	return 0;
>  }
>  
> -static int iommu_pmu_cpu_offline(unsigned int cpu)
> +static int iommu_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
>  {
> -	struct dmar_drhd_unit *drhd;
> -	struct intel_iommu *iommu;
> -	int target;
> +	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
> +	int target = cpumask_first(&iommu_pmu_cpu_mask);
> +
> +	/*
> +	 * The iommu_pmu_cpu_mask has been updated when offline the CPU
> +	 * for the first iommu_pmu. Migrate the other iommu_pmu to the
> +	 * new target.
> +	 */
> +	if ((target < nr_cpu_ids) && (target != iommu_pmu->cpu)) {
> +		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
> +		iommu_pmu->cpu = target;
> +		return 0;
> +	}
>  
>  	if (!cpumask_test_and_clear_cpu(cpu, &iommu_pmu_cpu_mask))
>  		return 0;
> @@ -795,45 +810,50 @@ static int iommu_pmu_cpu_offline(unsigned int cpu)
>  	if (target < nr_cpu_ids)
>  		cpumask_set_cpu(target, &iommu_pmu_cpu_mask);
>  	else
> -		target = -1;
> +		return 0;
>  
> -	rcu_read_lock();
> -
> -	for_each_iommu(iommu, drhd) {
> -		if (!iommu->pmu)
> -			continue;
> -		perf_pmu_migrate_context(&iommu->pmu->pmu, cpu, target);
> -	}
> -	rcu_read_unlock();
> +	perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
> +	iommu_pmu->cpu = target;
>  
>  	return 0;
>  }
>  
>  static int nr_iommu_pmu;
> +static enum cpuhp_state iommu_cpuhp_slot;
>  
>  static int iommu_pmu_cpuhp_setup(struct iommu_pmu *iommu_pmu)
>  {
>  	int ret;
>  
> -	if (nr_iommu_pmu++)
> -		return 0;
> +	if (!nr_iommu_pmu) {
> +		ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +					      "driver/iommu/intel/perfmon:online",
> +					      iommu_pmu_cpu_online,
> +					      iommu_pmu_cpu_offline);
> +		if (ret < 0)
> +			return ret;
> +		iommu_cpuhp_slot = ret;
> +	}
>  
> -	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
> -				"driver/iommu/intel/perfmon:online",
> -				iommu_pmu_cpu_online,
> -				iommu_pmu_cpu_offline);
> -	if (ret)
> -		nr_iommu_pmu = 0;
> +	ret = cpuhp_state_add_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
> +	if (ret) {
> +		if (!nr_iommu_pmu)
> +			cpuhp_remove_multi_state(iommu_cpuhp_slot);
> +		return ret;
> +	}
> +	nr_iommu_pmu++;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void iommu_pmu_cpuhp_free(struct iommu_pmu *iommu_pmu)
>  {
> +	cpuhp_state_remove_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
> +
>  	if (--nr_iommu_pmu)
>  		return;
>  
> -	cpuhp_remove_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE);
> +	cpuhp_remove_multi_state(iommu_cpuhp_slot);
>  }
>  
>  void iommu_pmu_register(struct intel_iommu *iommu)
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index c6fab004104a..5b2f8147d1ae 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -218,7 +218,6 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_X86_CQM_ONLINE,
>  	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
>  	CPUHP_AP_PERF_X86_IDXD_ONLINE,
> -	CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
>  	CPUHP_AP_PERF_S390_CF_ONLINE,
>  	CPUHP_AP_PERF_S390_SF_ONLINE,
>  	CPUHP_AP_PERF_ARM_CCI_ONLINE,
