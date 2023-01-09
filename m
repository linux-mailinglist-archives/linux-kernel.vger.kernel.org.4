Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D88663537
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbjAIX1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbjAIX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:27:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2033C140F9;
        Mon,  9 Jan 2023 15:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673306847; x=1704842847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dDKF3W3BplY1ndZeIWEJvFNMLuDzda4H9tPWcbK9sww=;
  b=Fa3rj3XAhj/5kOgec93aYI1x9S6d6ECSYgk+8hCylsdWL+2WOxiThF8P
   LzFNQ8XxU5TIhJ1/x9xRUT8ivbYlN0FB6Q4aqG0LEYbhh/72EhIm0+ygW
   YlywSTPGWLW57fUxVsFIrXmO26CSsdk39kT/tU3GvgzbWCG9dgaWS/Ilg
   rWr0E9S/1PkRgeDHyRLTNZdhS29/xKFB7um22hJsclvzuYPVUW8q/FN4Y
   H5IJc2ZsMpFPEDlrwvqX5EcRW7q6sJ8R97x6thx60PZUEqBY3mGvTDgD6
   ojHcZrGejIsOVmO8f6rOr/sYSREP+Av6u78NWEcr1TYvH2zNetKaKCU/X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350227983"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="350227983"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 15:27:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830780938"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="830780938"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 15:27:26 -0800
Date:   Mon, 9 Jan 2023 23:26:56 +0000
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Message-ID: <Y7yiwOerGiEKAF9i@araj-dh-work>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-2-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109164405.569714-2-babu.moger@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:43:53AM -0600, Babu Moger wrote:
> on_each_cpu_mask() runs the function on each CPU specified by cpumask,
> which may include the local processor.
> 
> Replace smp_call_function_many() with on_each_cpu_mask() to simplify
> the code.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 11 +++------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++----------------
>  2 files changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1df0e3262bca..7eece3d2d0c3 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -310,7 +310,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  	enum resctrl_conf_type t;
>  	cpumask_var_t cpu_mask;
>  	struct rdt_domain *d;
> -	int cpu;
>  	u32 idx;
>  
>  	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
> @@ -341,13 +340,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  
>  	if (cpumask_empty(cpu_mask))
>  		goto done;
> -	cpu = get_cpu();
> -	/* Update resource control msr on this CPU if it's in cpu_mask. */
> -	if (cpumask_test_cpu(cpu, cpu_mask))
> -		rdt_ctrl_update(&msr_param);
> -	/* Update resource control msr on other CPUs. */
> -	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
> -	put_cpu();
> +
> +	/* Update resource control msr on all the CPUs. */
> +	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);

Do you require these updates to done immediately via an IPI? or can they be
done bit lazy via schedule_on_each_cpu()? 

Cheers,
Ashok
