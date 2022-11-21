Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6258E632CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiKUTI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKUTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:08:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC5FD28AA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:08:23 -0800 (PST)
Received: from zn.tnic (p200300ea9733e725329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e725:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C30691EC03EA;
        Mon, 21 Nov 2022 20:08:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669057701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PW/HmTfWd3KD7F9AeG0CHyci/txJYNIbKWWtUh/bG0A=;
        b=KY/hVSo/pMHtM24iKKP8OWuqQqgIXSOiCgSokHrbPb09ujtI5tpWNpwdkF2vfLeYOGDu+q
        MIh/+eWlfr3v792+e+VBh1CWiad8a8H7XnceWO27O7Pi+LUuJqiPOGRc4WTm8DtuycmzSC
        IeofWwBGS3FS4JHqpbJFflIaGoppcmk=
Date:   Mon, 21 Nov 2022 20:08:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/boot: skip realmode init code when running as Xen PV
 guest
Message-ID: <Y3vMpbsHA35VoasD@zn.tnic>
References: <20221121162433.28070-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121162433.28070-1-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 05:24:33PM +0100, Juergen Gross wrote:
> When running as a Xen PV guest there is no need for setting up the
> realmode trampoline, as realmode isn't supported in this environment.
> 
> Trying to setup the trampoline has been proven to be problematic in
> some cases, especially when trying to debug early boot problems with
> Xen requiring to keep the EFI boot-services memory mapped (some
> firmware variants seem to claim basically all memory below 1M for boot
> services).
> 
> Skip the trampoline setup code for Xen PV guests.
> 
> Fixes: 084ee1c641a0 ("x86, realmode: Relocator for realmode code")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/include/asm/realmode.h | 4 ++--
>  arch/x86/realmode/init.c        | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
 
> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> index fd6f6e5b755a..5bfce58f1bab 100644
> --- a/arch/x86/include/asm/realmode.h
> +++ b/arch/x86/include/asm/realmode.h
> @@ -78,8 +78,8 @@ extern unsigned char secondary_startup_64_no_verify[];
>  
>  static inline size_t real_mode_size_needed(void)
>  {
> -	if (real_mode_header)
> -		return 0;	/* already allocated. */
> +	if (real_mode_header || cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return 0;	/* already allocated or not needed. */
>  
>  	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
>  }
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 41d7669a97ad..1826700b156e 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -202,6 +202,9 @@ static void __init set_real_mode_permissions(void)
>  
>  static int __init init_real_mode(void)
>  {
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))a

This reminds me of the notorious if (xen) sprinkling from years ago.
Please don't do that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
