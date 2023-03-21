Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131D86C2FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjCUK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:57:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD362F78F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679396245; x=1710932245;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/k4j9lIzqcsHGDq/qy2vT0g85evDUM1Ob6+Zh6UlWjo=;
  b=NRv2BjitWL5ZaqVYuf9BGZr4Bez7PqMv0owpO+R4vt71B/2oQ3vw4nTP
   3mqwlsxm3m8mT2UHo+TOWf1gFDPXxM2vSxqujtyfOZnaRI4jrqLPFfWJr
   TdMr/dv2QB7yR83yVa5zHxnPONzh4vB9/HTLifVlXbxzGjKN/3GFEPXvx
   AgJPreFUFAOf8dGhzo390Y3YvNCLjGRLBWRV5s5dDevhSInQwVSZeJqml
   hNy+cdkyMUBpePXqlmkTTUBtLIWOnKvxO2VZqbUrrshYoZqQSCnJQKtOh
   r73osoZ9ahT9OK07ZNIB6wszpMoFWM1qB8/GyJXxCFK9RYhRV+TfDijNG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="327281843"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="327281843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 03:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="658723121"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="658723121"
Received: from jluqueti-mobl.ger.corp.intel.com ([10.252.63.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 03:57:10 -0700
Date:   Tue, 21 Mar 2023 12:57:03 +0200 (EET)
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
Subject: Re: [PATCH v3 02/19] x86/resctrl: Access per-rmid structures by
 index
In-Reply-To: <20230320172620.18254-3-james.morse@arm.com>
Message-ID: <312d454-494-1ab5-6374-353a7fe24162@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, James Morse wrote:

> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
> monitors, RMID values on arm64 are not unique unless the CLOSID is
> also included. Bitmaps like rmid_busy_llc need to be sized by the
> number of unique entries for this resource.
> 
> Add helpers to encode/decode the CLOSID and RMID to an index. The
> domain's rmid_busy__llc and the rmid_ptrs[] array are then sized by
> index, as are the domain mbm_local and mbm_total arrays.
> On x86, the index is always just the RMID, so all these structures
> remain the same size.
> 
> The index gives resctrl a unique value it can use to store monitor
> values, and allows MPAM to decode the closid when reading the hardware
> counters.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
> 
> Changes since v2:
>  * Added RESCTRL_RESERVED_CLOSID
>  * Removed a newline
>  * Repharsed some comments
>  * Renamed a variable 'ignore'd
>  * Moved X86_RESCTRL_BAD_CLOSID to a previous patch
> ---

> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index cbe986d23df6..3ca40be41a0a 100644

> @@ -732,19 +759,20 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  
>  static int dom_data_init(struct rdt_resource *r)
>  {
> +	u32 nr_idx = resctrl_arch_system_num_rmid_idx();

You've used idx_limit elsewhere so this name should be consistent with the 
others.

-- 
 i.

>  	struct rmid_entry *entry = NULL;
> -	int i, nr_rmids;
> +	u32 idx;
> +	int i;
>  
> -	nr_rmids = r->num_rmid;
> -	rmid_ptrs = kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
> +	rmid_ptrs = kcalloc(nr_idx, sizeof(struct rmid_entry), GFP_KERNEL);
>  	if (!rmid_ptrs)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < nr_rmids; i++) {
> +	for (i = 0; i < nr_idx; i++) {
>  		entry = &rmid_ptrs[i];
>  		INIT_LIST_HEAD(&entry->list);
>  
> -		entry->rmid = i;
> +		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  	}
>  
> @@ -753,7 +781,8 @@ static int dom_data_init(struct rdt_resource *r)
>  	 * default_rdtgroup control group, which will be setup later. See
>  	 * rdtgroup_setup_root().
>  	 */
> -	entry = __rmid_entry(0, 0);
> +	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID, 0);
> +	entry = __rmid_entry(idx);
>  	list_del(&entry->list);
>  
>  	return 0;

