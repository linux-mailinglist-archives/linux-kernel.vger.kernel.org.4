Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B87625D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiKKOeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiKKOd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:33:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED512AE2;
        Fri, 11 Nov 2022 06:33:56 -0800 (PST)
Received: from zn.tnic (p200300ea9733e727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45F481EC050B;
        Fri, 11 Nov 2022 15:33:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668177234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cQTEfK48CU7hwLXurFkwvK2hFOt+kE4y/de+J2w7zj0=;
        b=brO2wTAgLaaDhTjk1xKFdJAgl439qcxxNEg9FeFkVArYIO3vRu0h2Ynm9+026DTT1KV9Ob
        y+naYQrphuyKbreh3vMlIul2TmvMXntACq2jByfYiFPCJlUqxlPBgDfcbcVqnc03TY0w1F
        JRf/tjYEE6SIHJo/iFNYL3WoWgPxL84=
Date:   Fri, 11 Nov 2022 15:33:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
Subject: Re: [PATCH v2 06/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Message-ID: <Y25dTPMQ5uwBDa9I@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-7-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107225323.2733518-7-jithu.joseph@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:53:15PM -0800, Jithu Joseph wrote:
> IFS test image carries the same microcode header as regular Intel
> microcode blobs. Microcode blobs  use header version of 1,
> whereas IFS test images will use header version of 2.
> 
> microcode_sanity_check() can be used by IFS driver to perform
> sanity check of the IFS test images too.
> 
> Refactor header version as a parameter, move it to cpu/intel.c
> and expose this function. Qualify the function name with intel.

Same comments as before.

> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  arch/x86/include/asm/cpu.h             |   1 +
>  arch/x86/include/asm/microcode_intel.h |   1 +
>  arch/x86/kernel/cpu/intel.c            | 100 ++++++++++++++++++++++++
>  arch/x86/kernel/cpu/microcode/intel.c  | 102 +------------------------
>  4 files changed, 104 insertions(+), 100 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index e853440b5c65..4aff5f263973 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -96,5 +96,6 @@ static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
>  
>  extern u64 x86_read_arch_cap_msr(void);
>  int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
> +int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_ver);
>  
>  #endif /* _ASM_X86_CPU_H */
> diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
> index 4c92cea7e4b5..6626744c577b 100644
> --- a/arch/x86/include/asm/microcode_intel.h
> +++ b/arch/x86/include/asm/microcode_intel.h
> @@ -41,6 +41,7 @@ struct extended_sigtable {
>  #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
>  #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
>  #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))
> +#define MICROCODE_HEADER_VER_UCODE	1

"MICROCODE" ... "UCODE" - too much.

And "header version" sounds wrong when all you wanna say is, this header
is of this or that *type*. So you simply do:

#define MC_HEADER_TYPE_MICROCODE	1
#define MC_HEADER_TYPE_IFS		2

and that's it.

>  #define get_totalsize(mc) \
>  	(((struct microcode_intel *)mc)->hdr.datasize ? \
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index b6f9210fb31a..f8a5a25ab502 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -245,6 +245,106 @@ int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
>  }
>  EXPORT_SYMBOL_GPL(intel_find_matching_signature);
>  
> +int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_ver)

This is not how this is done:

1st patch: *only* mechanical code move, no semantic or functional changes
whatsoever.

2nd patch: Add semantical/functional changes.

Also, in the second patch, pls put a kernel-doc comment over the
function to explain what hdr_type - not hdr_ver - means here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
