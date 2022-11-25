Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847F763878A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiKYK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKYK3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:29:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F81FCDF;
        Fri, 25 Nov 2022 02:29:40 -0800 (PST)
Received: from zn.tnic (p200300ea9733e784329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e784:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEEB71EC06C1;
        Fri, 25 Nov 2022 11:29:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669372178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wLUMoW1MAGvGSE9qqBYQ6DlGH4B8mL8lIeXoP8DoMU8=;
        b=T9RewFHIjvKGLcpIg70j98aXoYa9XoaOdr655IlxTzon8L6Oz/qaN1j3g3KJVOBofW6aRp
        TnwdAwrN6q/gA9eGBbOi0VEl6TB+SletOmaJJ0+wSApLJnM/Z9BCN+/ngInUezzfa1jhEm
        yl4SJ4xy59NrltoSLAj55qx3ZdMKxQU=
Date:   Fri, 25 Nov 2022 11:29:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the efi tree with the tip tree
Message-ID: <Y4CZEysC8Ls9qt7R@zn.tnic>
References: <20221125122216.07eae5c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221125122216.07eae5c6@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 12:22:16PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the efi tree got a conflict in:
> 
>   arch/x86/boot/compressed/efi_thunk_64.S
> 
> between commit:
> 
>   cb8bda8ad443 ("x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S")
> 
> from the tip tree and commit:
> 
>   a61962d8e7d3 ("efi: libstub: Permit mixed mode return types other than efi_status_t")
> 
> from the efi tree.
> 
> I fixed it up (I remofved the file and applied the following patch) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 25 Nov 2022 12:15:58 +1100
> Subject: [PATCH] fix up for "efi: libstub: Permit mixed mode return types other than efi_status_t"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/x86/boot/compressed/efi_mixed.S | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
> index 8b02e507d3bb..4ca70bf93dc0 100644
> --- a/arch/x86/boot/compressed/efi_mixed.S
> +++ b/arch/x86/boot/compressed/efi_mixed.S
> @@ -132,12 +132,6 @@ SYM_FUNC_START(__efi64_thunk)
>  	movl	%ebx, %fs
>  	movl	%ebx, %gs
>  
> -	/*
> -	 * Convert 32-bit status code into 64-bit.
> -	 */
> -	roll	$1, %eax
> -	rorq	$1, %rax
> -
>  	pop	%rbx
>  	pop	%rbp
>  	RET
> -- 

LGTM, thanks Stephen.

We'll keep that in mind when sending the pull requests later.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
