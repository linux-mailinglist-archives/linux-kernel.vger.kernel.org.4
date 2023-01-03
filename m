Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6613165C6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbjACSse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbjACSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:47:52 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363814D0A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672771622; x=1704307622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1uaWgsWi4o1Ho2eADPCN9pAUfuK7ViANHJnqxAf/HWM=;
  b=kMS2Rwn0BN+fMt+ZEzcVctFYWSfD5WpJk2qeZrxbvPhnT6f8JvCDRGZp
   +Y5z1NyOeYqDHt42cUsURfMa3riaVD4ArMThe43qrL+pedqne1XRq17Am
   yUbDhYb40gZpOx4XWfHJSMqI+51y5x/eRIeYHwQyKWl5xPR0bCGMDSJtl
   yLSo9UL+R1bUjq8TFU7HLtbRQcS+E/na3smYa68NnnEoQ1ArmWnvcy7h1
   OUdj8EB1nZKix5wE2hnsr8X9IQxB7NNSlqVD8L2/K8xLbtFwDzTD+KBQn
   Vx73w6v1b2sLGBgY09x0d6F1wnPZsG9/phuUxQX9CJ+7fpeT98TdBX3s9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="348949097"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="348949097"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:46:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="685498837"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="685498837"
Received: from aalnoman-mobl.amr.corp.intel.com (HELO [10.212.192.60]) ([10.212.192.60])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:46:56 -0800
Message-ID: <efafb54e-5447-fd5e-8f8b-1fc150087d35@intel.com>
Date:   Tue, 3 Jan 2023 10:46:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/6] x86/microcode/core: Take a snapshot before and
 after applying microcode
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-3-ashok.raj@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230103180212.333496-3-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 10:02, Ashok Raj wrote:
> The kernel caches features about each CPU's features at boot in an
> x86_capability[] structure. The microcode update takes one snapshot and
> compares it with the saved copy at boot.
> 
> However, the capabilities in the boot copy can be turned off as a result of
> certain command line parameters or configuration restrictions. This can
> cause a mismatch when comparing the values before and after the microcode
> update.
> 
> microcode_check() is called after an update to report any previously
> cached CPUID bits might have changed due to the update.
> 
> microcode_store_cpu_caps() basically stores the original CPU reported
> values and not the OS modified values. This will avoid giving a false
> warning even if no capabilities have changed.
> 
> Ignore the capabilities recorded at boot. Take a new snapshot before the
> update and compare with a snapshot after the update to eliminate the false
> warning.
...

It took me a moment to square this "Ignore the capabilities recorded at
boot." statement with the continued existence of:

	memcpy(info->x86_capability, &boot_cpu_data.x86_capability, ...

I think just adding "hardware" might help:

	Ignore all hardware capabilities recorded at boot.

Or even adding one more sentence:

	Only consult the synthetic capabilities recorded at boot so that
	a simple memcmp() can be used for comparisons.

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 387578049de0..ac2e67156b9b 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -697,6 +697,7 @@ bool xen_set_default_idle(void);
>  #endif
>  
>  void __noreturn stop_this_cpu(void *dummy);
> +void microcode_store_cpu_caps(struct cpuinfo_x86 *info);
>  void microcode_check(struct cpuinfo_x86 *info);
>  
>  enum l1tf_mitigations {
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index b9c7529c920e..7c86c6fd07ae 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2297,28 +2297,43 @@ void cpu_init_secondary(void)
>  #endif
>  
>  #ifdef CONFIG_MICROCODE_LATE_LOADING
> +
> +void microcode_store_cpu_caps(struct cpuinfo_x86 *info)
> +{
> +	/* Reload CPUID max function as it might've changed. */
> +	info->cpuid_level = cpuid_eax(0);
> +
> +	/*
> +	 * Copy all capability leafs to pick up the synthetic ones so that
> +	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
> +	 * get overwritten in get_cpu_cap().
> +	 */
> +	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
> +	       sizeof(info->x86_capability));
> +
> +	get_cpu_cap(info);
> +}
> +
>  /*
>   * The microcode loader calls this upon late microcode load to recheck features,
>   * only when microcode has been updated. Caller holds microcode_mutex and CPU
>   * hotplug lock.
>   */
> -void microcode_check(struct cpuinfo_x86 *info)
> +void microcode_check(struct cpuinfo_x86 *orig)
>  {
> -	perf_check_microcode();
> +	struct cpuinfo_x86 info;

'info' is kinda a throwaway name.  would this be better as:

	prev_info / new_info

instead of:

	orig / info

?

> -	/* Reload CPUID max function as it might've changed. */
> -	info->cpuid_level = cpuid_eax(0);
> +	perf_check_microcode();
>  
>  	/*
>  	 * Copy all capability leafs to pick up the synthetic ones so that
>  	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
>  	 * get overwritten in get_cpu_cap().
>  	 */

This comment got copied to microcode_store_cpu_caps().  Does this
instance still need to be here?

> -	memcpy(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability));
> -
> -	get_cpu_cap(info);
> +	microcode_store_cpu_caps(&info);
>  
> -	if (!memcmp(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability)))
> +	if (!memcmp(&info.x86_capability, &orig->x86_capability,
> +		    sizeof(info.x86_capability)))
>  		return;
>  
>  	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index d86a4f910a6b..14d9031ed68a 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -447,6 +447,13 @@ static int microcode_reload_late(void)
>  	atomic_set(&late_cpus_in,  0);
>  	atomic_set(&late_cpus_out, 0);
>  
> +	/*
> +	 * Take a snapshot before the microcode update, so we can compare
> +	 * them after the update is successful to check for any bits
> +	 * changed.
> +	 */
> +	microcode_store_cpu_caps(&info);

A "we" snuck in there.  How about this?

	/*
	 * Take a snapshot before the microcode update.  This enables
	 * a later comparison to see any bits changed after an update.
	 */

I do think some better naming of 'info' here would be nice too.
'old_info' or 'prev_info' seem like good alternatives.

>  	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
>  	if (ret == 0)
>  		microcode_check(&info);

