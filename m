Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F8660E788
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiJZSjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiJZSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:38:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF11EA9C1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:38:58 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E5731EC06A7;
        Wed, 26 Oct 2022 20:38:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666809536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gBQphS1nNInT9b5FidH50wFA5Vf1pdI/cx35jR9Ij8=;
        b=dLvWpmWyzcgm2I6HSu6lf4m+rZPfSHxW13q8XfPsOvEiX8oLyLab15WUR3PCleEEGrtTwG
        q0JxdrphENK7xb7LGCV6EkO9NA1j3Ci6bydIi1b8vlYy7vDEIqgtlYbUGwuP8JdvOqdq+n
        obseAeMNFk1bncJ7g8ChfPxD6moAO8s=
Date:   Wed, 26 Oct 2022 20:38:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 01/10] x86/Kconfig: enable X86_X2APIC by default and
 improve help text
Message-ID: <Y1l+v3uG7tSUZfd0@zn.tnic>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
 <20220911084711.13694-2-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220911084711.13694-2-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 10:47:02AM +0200, Mateusz Jończyk wrote:
> As many current platforms (most modern Intel CPUs and QEMU) have x2APIC
> present, enable CONFIG_X86_X2APIC by default as it gives performance
> and functionality benefits.

Can we do that without any detriment to older systems which don't have
x2APIC?

It looks so from a quick look...

> Additionally, if the BIOS has already
> switched APIC to x2APIC mode, but CONFIG_X86_X2APIC is disabled, the
> kernel will panic in arch/x86/kernel/apic/apic.c .
> 
> Also improve the help text, which was confusing and really did not
> describe what the feature is about.
> 
> Help text references and discussion:

So I'm not sure this discussion should be part of the commit message.

You can put it under the "---" line of the patch though.

> 
> Both Intel [1] and AMD [3] spell the name as "x2APIC", not "x2apic".
> 
> "It allows faster access to the local APIC"
>         [2], chapter 2.1, page 15:
>         "More efficient MSR interface to access APIC registers."
> 
> "x2APIC was introduced in Intel CPUs around 2008":
>         I was unable to find specific information which Intel CPUs
>         support x2APIC. Wikipedia claims it was "introduced with the
>         Nehalem microarchitecture in November 2008", but I was not able
>         to confirm this independently. At least some Nehalem CPUs do not
>         support x2APIC [1].
> 
>         The documentation [2] is dated June 2008. Linux kernel also
>         introduced x2APIC support in 2008, so the year seems to be
>         right.
> 
> "and in AMD EPYC CPUs in 2019":
>         [3], page 15:
>         "AMD introduced an x2APIC in our EPYC 7002 Series processors for
>         the first time."
> 
> "It is also frequently emulated in virtual machines, even when the host
> CPU does not support it."
>         [1]
> 
> "If this configuration option is disabled, the kernel will not boot on
> some platforms that have x2APIC enabled."
>         According to some BIOS documentation [4], the x2APIC may be
>         "disabled", "enabled", or "force enabled" on this system.
>         I think that "enabled" means "made available to the operating
>         system, but not already turned on" and "force enabled" means
>         "already switched to x2APIC mode when the OS boots". Only in the
>         latter mode a kernel without CONFIG_X86_X2APIC will panic in
>         validate_x2apic() in arch/x86/kernel/apic/apic.c .
> 
> 	QEMU 4.2.1 and my Intel HP laptop (bought in 2019) use the
> 	"enabled" mode and the kernel does not panic.
> 
> [1] "Re: [Qemu-devel] [Question] why x2apic's set by default without host sup"
>         https://lists.gnu.org/archive/html/qemu-devel/2013-07/msg03527.html
> 
> [2] Intel® 64 Architecture x2APIC Specification,
>         ( https://www.naic.edu/~phil/software/intel/318148.pdf )
> 
> [3] Workload Tuning Guide for AMD EPYC ™ 7002 Series Processor Based
>         Servers Application Note,
>         https://developer.amd.com/wp-content/resources/56745_0.80.pdf
> 
> [4] UEFI System Utilities and Shell Command Mobile Help for HPE ProLiant
>         Gen10, ProLiant Gen10 Plus Servers and HPE Synergy:
>         Enabling or disabling Processor x2APIC Support
>         https://techlibrary.hpe.com/docs/iss/proliant-gen10-uefi/s_enable_disable_x2APIC_support.html
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> 
> ---
> v2: language fixes by Mr Randy Dunlap, change option name
> ---
>  arch/x86/Kconfig | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..28133b5d3f12 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -440,15 +440,27 @@ config X86_FEATURE_NAMES
>  	  If in doubt, say Y.
>  
>  config X86_X2APIC
> -	bool "Support x2apic"
> +	bool "x2APIC interrupt controller architecture support"

s/architecture //g

and below too. Keep it simple pls.

>  	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
> +	default y
>  	help
> -	  This enables x2apic support on CPUs that have this feature.
> +	  x2APIC is an interrupt controller architecture, a component of which
> +	  (the local APIC) is present in the CPU. It allows faster access to
> +	  the local APIC and supports a larger number of CPUs in the system
> +	  than the predecessors.
>  
> -	  This allows 32-bit apic IDs (so it can support very large systems),
> -	  and accesses the local apic via MSRs not via mmio.
> +	  x2APIC was introduced in Intel CPUs around 2008 and in AMD EPYC CPUs
> +	  in 2019, but it can be disabled by the BIOS. It is also frequently
> +	  emulated in virtual machines, even when the host CPU does not support
> +	  it. Support in the CPU can be checked by executing
> +		cat /proc/cpuinfo | grep x2apic

or simply

$ grep x2apic /proc/cpuinfo

>  
> -	  If you don't know what to do here, say N.
> +	  If this configuration option is disabled, the kernel will not boot on
> +	  some platforms that have x2APIC enabled.
> +
> +	  Say N if you know that your platform does not have x2APIC.

Does it matter?

If the platform doesn't support it, it'll fallback to APIC anyway.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
