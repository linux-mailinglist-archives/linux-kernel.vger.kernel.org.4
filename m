Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251A069B22C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBQSDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBQSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:03:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A827C672
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676657016; x=1708193016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/0I2eNgcELr46mo7GWQjLjQkIT8MaP5vxGbWWNgO7zk=;
  b=joE2OAP2ntD7DdZcMSpYpGX2bPpOOcKpj6PrKysSTPvz5MaCwf0FkTwY
   YrF/VQBKH8VtYx6eaV3UqeYhUbOu9gpiy8Mv5iZUJKyVKLZ2Dw2cpbXiv
   bvBgfM2qFWSgK30FGWiTGAP9sh3YDpYo6mDaVGurbJgnhM4T2moJwplDr
   VtPt+dwUvBdJ3ws5I6uCYeCiWFz9m64Rdd+n5cq3BW8WPcoGxsO1i1VeD
   f9MriC/0HR6VBG6sluIVnylbYYkyvRBOTQYovAZpwtm2Q9wWbJcmTGTl0
   ByYr3jGl3ildZgpz7/j9EuRjY5Ddpag2/IIJVvT4Wq9K80XKdIXdtPahB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="359499978"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="359499978"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 10:03:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="734386639"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="734386639"
Received: from dcasilla-mobl.amr.corp.intel.com (HELO [10.252.132.244]) ([10.252.132.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 10:03:35 -0800
Message-ID: <fcd46e9d-c6d0-4a01-141b-11173602475e@intel.com>
Date:   Fri, 17 Feb 2023 10:03:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] x86/topology: fix erroneous smp_num_siblings on Intel
 Hybrid platform
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com, len.brown@intel.com
References: <20230217163724.581513-1-rui.zhang@intel.com>
 <20230217163724.581513-2-rui.zhang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230217163724.581513-2-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 08:37, Zhang Rui wrote:
> The SMT siblings value returned by CPUID.1F SMT level EBX differs
> among CPUs on Intel Hybrid platforms like AlderLake and MeteorLake.
> It returns 2 for Pcore CPUs which have SMT siblings and returns 1 for
> Ecore CPUs which do not have SMT siblings.
> 
> Today, the CPU boot code sets the global variable smp_num_siblings when
> every CPU thread is brought up. The last thread to boot will overwrite
> it with the number of siblings of *that* thread. That last thread to
> boot will "win". If the thread is a Pcore, smp_num_siblings == 2.  If it
> is an Ecore, smp_num_siblings == 1.
> 
> smp_num_siblings describes if the *system* supports SMT.  It should
> specify the maximum number of SMT threads among all cores.

I was with you until here, but I'm having a hard time parsing this:

> On AlderLake-P/S platforms, it does not cause any functional issues so
> far.
> But on MeteorLake-P platform, when probing an Ecore CPU,
> a). smp_num_siblings varies like AlderLake and it is set to 1 for Ecore.
> b). x86_max_cores is totally broken and it is set to 1 for the boot cpu.
> Altogether, these two issues make the system being treated as an UP
> system in set_cpu_sibling_map() when probing Ecore CPUs, and the Ecore
> CPUs are not updated in any cpu sibling maps erroneously.

Let's try and focus this changelog on the problem at hand which is a
broken smp_num_siblings on MeterorLake.  Right?

> Below shows part of the CPU topology information before and after the
> fix, for both Pcore and Ecore CPU (cpu0 is Pcore, cpu 12 is Ecore).
> ...
> -/sys/devices/system/cpu/cpu0/topology/package_cpus:000fff
> -/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-11
> +/sys/devices/system/cpu/cpu0/topology/package_cpus:3fffff
> +/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-21
> ...
> -/sys/devices/system/cpu/cpu12/topology/package_cpus:001000
> -/sys/devices/system/cpu/cpu12/topology/package_cpus_list:12
> +/sys/devices/system/cpu/cpu12/topology/package_cpus:3fffff
> +/sys/devices/system/cpu/cpu12/topology/package_cpus_list:0-21
> 
> And this also breaks userspace tools like lscpu
> -Core(s) per socket:  1
> -Socket(s):           11
> +Core(s) per socket:  16
> +Socket(s):           1

Heh, yeah, 11 sockets is a tiny bug.

> To fix the first issue, ensure that smp_num_siblings represents the
> system-wide maximum number of siblings by always increasing its value.
> Never allow it to decrease.
> 
> Note that this fix is sufficient to make set_cpu_sibling_map() work
> correctly. And how to fix the bogus cpuinfo_x86.x86_max_cores will be
> addressed separately.

Having this note here is probably OK.  But, I'm not sure even mentioning
x86_max_cores is worth it.  Doesn't it just add confusion?

> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 5e868b62a7c4..0270925fe013 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -79,7 +79,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
>  	 * initial apic id, which also represents 32-bit extended x2apic id.
>  	 */
>  	c->initial_apicid = edx;
> -	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
>  #endif
>  	return 0;
>  }
> @@ -109,7 +109,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
>  	 */
>  	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
>  	c->initial_apicid = edx;
> -	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
>  	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
>  	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
>  	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);

The fix seems simple enough.
