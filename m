Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9114E70BF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjEVNMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjEVNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:12:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2811011F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:12:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C838A21C6D;
        Mon, 22 May 2023 13:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684761126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/b4jyt+mKKOEyG+XA4wBw25yWm36AKKIFRNbqWnek58=;
        b=NbXipsck+2suySbWtdwDQpL1QvujcttjUrREiH9Ntb+b37wW/PwC4k3LUwL3318cLXn3jk
        V2kxGuTFWLAi8CeoIxs2DtsPNPzx40PAeyL0JbaXQ8Mve3AfeVZdqIxBQbHP0CAaqUilxi
        jWPjowsC/VwVLr27Mfz5pjuqXzFC6Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684761126;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/b4jyt+mKKOEyG+XA4wBw25yWm36AKKIFRNbqWnek58=;
        b=P8GlxAt6Gth5hmeiSaHUqsv1LCPdisz684BgFtW9WMWUhb4JkqoHvYniXvbJVfyzT+aMWe
        d0wH0ojpTnwNjiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AC1113776;
        Mon, 22 May 2023 13:12:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FoeGHCZqa2Q8cgAAMHmgww
        (envelope-from <jroedel@suse.de>); Mon, 22 May 2023 13:12:06 +0000
Date:   Mon, 22 May 2023 15:12:05 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH] x86/head/64: Switch to KERNEL_CS as soon as new GDT is
 installed
Message-ID: <ZGtqJU_pIc7kI6sO@suse.de>
References: <6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:26:41AM -0500, Tom Lendacky wrote:
> The call to startup_64_setup_env() will install a new GDT but does not
> actually switch to using the KERNEL_CS entry until returning from the
> function call.
> 
> Commit bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in
> boot") moved the call to sme_enable() earlier in the boot process and in
> between the call to startup_64_setup_env() and the switch to KERNEL_CS.
> An SEV-ES or an SEV-SNP guest will trigger #VC exceptions during the call
> to sme_enable() and if the CS pushed on the stack as part of the exception
> and used by IRETQ is not mapped by the new GDT, then problems occur.
> Today, the current CS when entering startup_64 is the kernel CS value
> because it was set up by the decompressor code, so no issue is seen.
> 
> However, a recent patchset that looked to avoid using the legacy
> decompressor during an EFI boot exposed this bug. At entry to startup_64,
> the CS value is that of EFI and is not mapped in the new kernel GDT. So
> when a #VC exception occurs, the CS value used by IRETQ is not valid and
> the guest boot crashes.
> 
> Fix this issue by moving the block that switches to the KERNEL_CS value to
> be done immediately after returning from startup_64_setup_env().
> 
> Fixes: bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in boot")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/head_64.S | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Makes sense, thanks for the fix.

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 9cd77d319555..c5b9289837dc 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -79,6 +79,15 @@ SYM_CODE_START_NOALIGN(startup_64)
>  	call	startup_64_setup_env
>  	popq	%rsi
>  
> +	/* Now switch to __KERNEL_CS so IRET works reliably */
> +	pushq	$__KERNEL_CS
> +	leaq	.Lon_kernel_cs(%rip), %rax
> +	pushq	%rax
> +	lretq
> +
> +.Lon_kernel_cs:
> +	UNWIND_HINT_END_OF_STACK
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  	/*
>  	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
> @@ -92,15 +101,6 @@ SYM_CODE_START_NOALIGN(startup_64)
>  	popq	%rsi
>  #endif
>  
> -	/* Now switch to __KERNEL_CS so IRET works reliably */
> -	pushq	$__KERNEL_CS
> -	leaq	.Lon_kernel_cs(%rip), %rax
> -	pushq	%rax
> -	lretq
> -
> -.Lon_kernel_cs:
> -	UNWIND_HINT_END_OF_STACK
> -
>  	/* Sanitize CPU configuration */
>  	call verify_cpu
>  
> -- 
> 2.40.0
> 

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

