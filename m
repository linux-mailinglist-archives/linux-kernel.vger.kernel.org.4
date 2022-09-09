Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5535B3D84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIIRBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiIIRBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:01:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3A4CAF486;
        Fri,  9 Sep 2022 10:00:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5091165C;
        Fri,  9 Sep 2022 10:01:05 -0700 (PDT)
Received: from [10.1.197.78] (eglon.cambridge.arm.com [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A60D23F73D;
        Fri,  9 Sep 2022 10:00:55 -0700 (PDT)
Message-ID: <a60be378-dce6-08fb-02b8-1efc660ee3cb@arm.com>
Date:   Fri, 9 Sep 2022 18:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
Content-Language: en-GB
To:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 07/09/2022 18:59, Babu Moger wrote:
> AMD systems support zero CBM (capacity bit mask) for L3 allocation.
> That is reflected in rdt_init_res_defs_amd() by:
> 
> 	r->cache.arch_has_empty_bitmaps = true;
> 
> However given the unified code in cbm_validate(), checking for:
> 	val == 0 && !arch_has_empty_bitmaps
> 
> is not enough because of another check in cbm_validate():
> 
> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)

Right, the Intel version had this, but the AMD didn't. I evidently only thought about this
the !arch_has_empty_bitmaps way round! Sorry about that.


> The default value of r->cache.min_cbm_bits = 1.
> 
> Leading to:
> 
> 	$ cd /sys/fs/resctrl
> 	$ mkdir foo
> 	$ cd foo
> 	$ echo L3:0=0 > schemata
>           -bash: echo: write error: Invalid argument
> 	$ cat /sys/fs/resctrl/info/last_cmd_status
> 	  Need at least 1 bits in the mask
> 
> Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also,
> remove the default setting of min_cbm_bits and initialize it separately.
> 
> After the fix
> 	$ cd /sys/fs/resctrl
> 	$ mkdir foo
> 	$ cd foo
> 	$ echo L3:0=0 > schemata
> 	$ cat /sys/fs/resctrl/info/last_cmd_status
> 	  ok
> 
> Link: https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/
> Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, empty}_bitmaps")

> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Er, who is the author if this patch? If you are reposting Stephane's patch then there
needs to be a 'From: ' at the top of the email so that git preserves the ownership. You
may need some incantation of "git commit --amend --author=" to fix this in your tree.

As its a fix, have you posted this separately? Mixing fixes and new-code makes it hard for
the maintainer to spot what needs to be taken for the next -rc.


> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index bb1c3f5f60c8..a5c51a14fbce 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
>  			.cache_level		= 3,
> -			.cache = {
> -				.min_cbm_bits	= 1,
> -			},
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
>  			.cache_level		= 2,
> -			.cache = {
> -				.min_cbm_bits	= 1,
> -			},
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)
>  			r->cache.arch_has_sparse_bitmaps = false;
>  			r->cache.arch_has_empty_bitmaps = false;
>  			r->cache.arch_has_per_cpu_cfg = false;
> +			r->cache.min_cbm_bits = 1;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_THRTL_BASE;
>  			hw_res->msr_update = mba_wrmsr_intel;
> @@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
>  			r->cache.arch_has_sparse_bitmaps = true;
>  			r->cache.arch_has_empty_bitmaps = true;
>  			r->cache.arch_has_per_cpu_cfg = true;
> +			r->cache.min_cbm_bits = 0;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>  			hw_res->msr_update = mba_wrmsr_amd;
> 
> 


Reviewed-by: James Morse <james.morse@arm.com>

Thanks,

James
