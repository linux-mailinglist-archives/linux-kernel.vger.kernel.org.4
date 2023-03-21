Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871886C306B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCULaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCULaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:30:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7291F4EEA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679398197; x=1710934197;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Su0mgso3qzTUPnrqbdAvVrElMC8Pma5v9atr/AX7Tig=;
  b=aD/uApM0A0YKhuOEPS0jT3AqDCBv/0nM5afUxwFycMME1L+DQ1qSxn6G
   4BXp6/7VcA6iu5SmgNYTYfkqw7qAnd5k1yImvXQBQ1GgqkHCmIw80I8kv
   pInthgTCP26GVCxYjjIVURv9l+DLZQVawTKgh8PH/mGZyUy3SCgANpgxn
   iEbOQR2th9k6VkcajJeVq2qJb3c6/ZrB1SO1QOAn+DYf2mZU7FzKZ/XHI
   ixY5cUrkD0iBqrdI7vgvAtufd0HPpktrWArfUIWH6PXf+dzMe6sqJJaU7
   aR7LD9k74TlYTHo3gdNgcGkUnc8OKj9mFmqB3ZSvavgCGbJxZOl07BjLH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="401483183"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="401483183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="711771715"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="711771715"
Received: from jluqueti-mobl.ger.corp.intel.com ([10.252.63.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 04:29:51 -0700
Date:   Tue, 21 Mar 2023 13:29:48 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     James Morse <james.morse@arm.com>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v3 05/19] x86/resctrl: Allow RMID allocation to be scoped
 by CLOSID
In-Reply-To: <20230320172620.18254-6-james.morse@arm.com>
Message-ID: <bd22cfed-7d3b-413d-840-95bf2f498b48@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-6-james.morse@arm.com>
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

> MPAMs RMID values are not unique unless the CLOSID is considered as well.
> 
> alloc_rmid() expects the RMID to be an independent number.
> 
> Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
> allocating. If the CLOSID is not relevant to the index, this ends up
> comparing the free RMID with itself, and the first free entry will be
> used. With MPAM the CLOSID is included in the index, so this becomes a
> walk of the free RMID entries, until one that matches the supplied
> CLOSID is found.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2;
>  * Rephrased comment in resctrl_find_free_rmid() to describe this in terms of
>    list_entry_first()
>  * Rephrased comment above alloc_rmid()
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 54 +++++++++++++++++------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>  4 files changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 47506e2afd59..e11d9ce943d3 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -535,7 +535,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
>  struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
>  int closids_supported(void);
>  void closid_free(int closid);
> -int alloc_rmid(void);
> +int alloc_rmid(u32 closid);
>  void free_rmid(u32 closid, u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
>  bool __init rdt_cpu_has(int flag);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 03a7d13dd653..ca58a433c668 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -337,25 +337,51 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
>  	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
>  }
>  
> -/*
> - * As of now the RMIDs allocation is global.
> - * However we keep track of which packages the RMIDs
> - * are used to optimize the limbo list management.
> - */
> -int alloc_rmid(void)
> +static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>  {
> -	struct rmid_entry *entry;
> -
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	struct rmid_entry *itr;
> +	u32 itr_idx, cmp_idx;
>  
>  	if (list_empty(&rmid_free_lru))
> -		return rmid_limbo_count ? -EBUSY : -ENOSPC;
> +		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
>  
> -	entry = list_first_entry(&rmid_free_lru,
> -				 struct rmid_entry, list);
> -	list_del(&entry->list);
> +	list_for_each_entry(itr, &rmid_free_lru, list) {
> +		/*
> +		 * get the index of this free RMID, and the index it would need
> +		 * to be if it were used with this CLOSID.
> +		 * If the CLOSID is irrelevant on this architecture, these will
> +		 * always be the same meaning the compiler can reduce this loop
> +		 * to a single list_entry_first() call.
> +		 */
> +		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
> +		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
>  
> -	return entry->rmid;
> +		if (itr_idx == cmp_idx)
> +			return itr;
> +	}
> +
> +	return ERR_PTR(-ENOSPC);
> +}
> +
> +/*
> + * For MPAM the RMID value is not unique, and has to be considered with
> + * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> + * allows all domains to be managed by a single limbo list.
> + * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
> + */
> +int alloc_rmid(u32 closid)
> +{
> +	struct rmid_entry *entry;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	entry = resctrl_find_free_rmid(closid);
> +	if (!IS_ERR(entry)) {
> +		list_del(&entry->list);
> +		return entry->rmid;
> +	}
> +
> +	return PTR_ERR(entry);

Reverse the if condition to make this follow the normal error handling 
pattern.


-- 
 i.

