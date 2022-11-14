Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC56286D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiKNRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiKNRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:18:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C0FF7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VHNRiFwLD0T8xlIzSdUGCUiQwRiGBIjAq2J/I0NP6Es=; b=iJAsxGebVqg5F0ryulGlz19f1x
        AscGkDKEeCi5Lpbr/e/pA/pFuFkGfpXqardUjV8/OMj6lNtSNfo/XIaGf55DZ2+8fZvY51SZBAV9J
        xXBuhJQzGvDFlwi7ddxEi70rWyM6gqCKCDMQR110Vth6gEF2/GvvpKxa4hDqBnMn78XBNRRcM3f1B
        HMJwMSz0LSw4b0ygAonLQ0DJgXn3CcF+o7dkN+fJgpBRaySku9EYpfQi3cfObcfwe748rMENkuNe0
        SjfSbDQqRlR79JNOuFpXCCMUHxpNESxADEshDT7MZFBAnwcKVmhDELn5Urzay6Hev6PrVHYUwNH3+
        fcsJbUtg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oud6N-00FaHg-OL; Mon, 14 Nov 2022 17:18:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3EE93021D4;
        Mon, 14 Nov 2022 17:02:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAF9D2B891F5A; Mon, 14 Nov 2022 17:02:46 +0100 (CET)
Date:   Mon, 14 Nov 2022 17:02:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 14/46] x86/sev, lto: Mark cpuid_table_copy as
 __visible_on_lto
Message-ID: <Y3Jmpjwl0aJpwq/4@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-15-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114114344.18650-15-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:43:12PM +0100, Jiri Slaby (SUSE) wrote:
> From: Martin Liska <mliska@suse.cz>
> 
> Symbols referenced from assembler (either directly or e.f. from
> DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> they could end up in a different object file than the assembler. This
> can lead to linker errors without this patch.
> 
> So mark cpuid_table_copy as __visible_on_lto.
> 
> [js] use __visible_on_lto
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Martin Liska <mliska@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  arch/x86/kernel/sev-shared.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 3a5b0c9c4fcc..554da8aabfc7 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -64,7 +64,7 @@ struct snp_cpuid_table {
>  static u16 ghcb_version __ro_after_init;
>  
>  /* Copy of the SNP firmware's CPUID page. */
> -static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
> +__visible_on_lto struct snp_cpuid_table cpuid_table_copy __ro_after_init;

Same again, address is taken (and passed into inline asm). Must not be
eliminated.
