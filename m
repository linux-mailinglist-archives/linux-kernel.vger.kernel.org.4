Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D76A5E00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjB1ROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjB1ROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:14:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED7BA1E5C5;
        Tue, 28 Feb 2023 09:14:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9159C14;
        Tue, 28 Feb 2023 09:14:44 -0800 (PST)
Received: from [10.1.196.177] (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE2693F881;
        Tue, 28 Feb 2023 09:13:59 -0800 (PST)
Message-ID: <3c3b99b8-5f8f-4671-944d-fd615d209456@arm.com>
Date:   Tue, 28 Feb 2023 17:13:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/7] x86/resctrl: Add code to setup monitoring at L3 or
 NODE scope.
Content-Language: en-GB
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-5-tony.luck@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20230126184157.27626-5-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 26/01/2023 18:41, Tony Luck wrote:
> When Sub-NUMA cluster is enabled (snc_ways > 1) use the RDT_RESOURCE_NODE
> instead of RDT_RESOURCE_L3 for all monitoring operations.
> 
> The mon_scale and num_rmid values from CPUID(0xf,0x1),(EBX,ECX) must be
> scaled down by the number of Sub-NUMA Clusters.
> 
> A subsequent change will detect sub-NUMA cluster mode and set
> "snc_ways". For now set to one (meaning each L3 cache spans one
> node).

(I'm looking at decoupling "monitoring is always on RDT_RESOURCE_L3" as a separate thing
 to enabling SNC ... just in case my comments seem strange!)


> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19be6fe42ef3..53b2ab37af2f 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -786,7 +791,13 @@ static __init bool get_rdt_alloc_resources(void)
>  
>  static __init bool get_rdt_mon_resources(void)
>  {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_resource *r;
> +
> +	/* When SNC enabled, monitor functions at node instead of L3 cache scope */
> +	if (snc_ways > 1)
> +		r = &rdt_resources_all[RDT_RESOURCE_NODE].r_resctrl;
> +	else
> +		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;

Could this be hidden in a helper with some name like resctrl_arch_get_mbm_resource()?
You have the same pattern again in rdt_get_tree(). If this gets more complex in the
future, it means its outside the filesystem code, and all in one place.


Thanks,

James


>  	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
>  		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index a6ba3080e5db..a0dc64a70d01 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2238,7 +2238,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  		static_branch_enable_cpuslocked(&rdt_enable_key);
>  
>  	if (is_mbm_enabled()) {
> -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +		if (snc_ways > 1)
> +			r = &rdt_resources_all[RDT_RESOURCE_NODE].r_resctrl;
> +		else
> +			r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  		list_for_each_entry(dom, &r->domains, list)
>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
>  	}

