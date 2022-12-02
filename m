Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB76D640E35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiLBTJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiLBTJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:09:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771799D2FF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:09:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670008171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1A5G4mMMuodVfthbtguBB0Gc4KqVgkuBM1fkq+zo4I=;
        b=uL3p48VNpj/49nNS75ipa8NkKAm4Rb39nng7NnG4fyQxyyaz0EGDzlNRotmsgqMdY8W6V8
        EJMcA7fHY+EW8j645Wdm8HLNwSRuieq+nld6GpNIxh5QKnN65AB01TiHnaPiLoPNsGsovg
        UGTB7lhgiynYoG4Bc5jal2gjPErKiVfMlGTzEReBkueEyJIduBJqbVjOQwlgZuz1Me6l8X
        6a24Dcg+gYCPzH5jGYO+nq4teV9J2Fa/FAM5QOVQCbg++ka83OLhVdOm8SV0p/tACdclZI
        vNia1Lximtdoik/PzLZv6w+WKR2iJvHEKharESzEAgBicSdlxUHn1ztIQnk27w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670008171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1A5G4mMMuodVfthbtguBB0Gc4KqVgkuBM1fkq+zo4I=;
        b=HSni7Uv3+BHxsZpAFOyPZLC5Dkz5GsvGTjjxVMRRMnsegoKPW9haH6p/Y/SYbLerIAdHys
        9srrDs1Ao5/FdhBg==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 4/7] x86/microcode/core: Take a snapshot before and
 after applying microcode
In-Reply-To: <20221129210832.107850-5-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-5-ashok.raj@intel.com>
Date:   Fri, 02 Dec 2022 20:09:30 +0100
Message-ID: <874judpqqd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:

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
> Ignore the capabilities recorded at boot. Take a new snapshot before the
> update and compare with a snapshot after the update to eliminate the false
> warning.

Makes sense.

> +static void copy_cpu_caps(struct cpuinfo_x86 *info)
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
> -static void microcode_check(void)
> +static void microcode_check(struct cpuinfo_x86 *orig)
>  {
>  	struct cpuinfo_x86 info;
>  
> @@ -446,15 +462,13 @@ static void microcode_check(void)
>  	info.cpuid_level = cpuid_eax(0);
>  
>  	/*
> -	 * Copy all capability leafs to pick up the synthetic ones so that
> -	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
> -	 * get overwritten in get_cpu_cap().
> -	 */
> -	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
> +	* Copy all capability leafs to pick up the synthetic ones so that
> +	* memcmp() below doesn't fail on that. The ones coming from CPUID will
> +	* get overwritten in get_cpu_cap().
> +	*/
> +	copy_cpu_caps(&info);
>  
> -	get_cpu_cap(&info);
> -
> -	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability,
> +	if (!memcmp(&info.x86_capability, &orig->x86_capability,
>  		    sizeof(info.x86_capability)))
>  		return;
>  
> @@ -469,6 +483,7 @@ static void microcode_check(void)
>  static int microcode_reload_late(void)
>  {
>  	int old = boot_cpu_data.microcode, ret;
> +	struct cpuinfo_x86 info;
>  
>  	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
>  	pr_err("You should switch to early loading, if possible.\n");
> @@ -476,9 +491,10 @@ static int microcode_reload_late(void)
>  	atomic_set(&late_cpus_in,  0);
>  	atomic_set(&late_cpus_out, 0);
>  
> +	copy_cpu_caps(&info);
>  	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);

You clearly ran out of newlines and comments here.

>  	if (ret == 0)
> -		microcode_check();
> +		microcode_check(&info);
>  
>  	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
>  		old, boot_cpu_data.microcode);

Unrelated to that patch, but it just caught my attention. Why are we
printing this is case of failure?

Thanks,

        tglx
