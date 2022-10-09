Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4AE5F8B33
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJIM2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJIM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:28:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26E2CC85
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NgAqYrZYqyV6fTVG0gpB572W+SdYs1uSeMEMFpJCuYY=; b=HqMktaDbRarPLJOHIPV0Dno0wN
        UaFRe9Yi0bwuLjL63zkn14gynuR7wna9qsYjWac5OkXaK9EXQVCyU6bHt+VNKS7dx42O0vULWAFFr
        YsoDgixPUUZtvQrh0REnc57B+3/pGfbY2yrRgR0W4vL3pBrgnuKmJ23+su/S8fT4jRNKeCmjepiVC
        tQb1xDQoknc/lVK5nGJi3eeI1udPHwoBvZIaZCUjCUFkvn/JuRFmHyjkeKOCkcz5VyX8ntH9Tnd9F
        9oPPNSeoiLU1VyICkFKvmNfgKG2TvnlDaIKF2jD+guApE5wuT+UHJmLDj2xFt+XWbhqv9owqOxSkb
        1psA6iQQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohVPr-003PR3-MF; Sun, 09 Oct 2022 12:28:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1CFE300023;
        Sun,  9 Oct 2022 14:28:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA06A2C189412; Sun,  9 Oct 2022 14:28:17 +0200 (CEST)
Date:   Sun, 9 Oct 2022 14:28:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternative: fix undefined reference to
 __ibt_endbr_seal[_end]
Message-ID: <Y0K+YbcwyLJg9Iwr@hirez.programming.kicks-ass.net>
References: <20221009154532.1100121-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009154532.1100121-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 11:45:32PM +0800, Miaohe Lin wrote:
> When I compile the kernel bzImage, there are several compile errors:
> 
> ld: arch/x86/kernel/alternative.o: in function
> `alternative_instructions':
> alternative.c:(.init.text+0x15d): undefined reference to
> `__ibt_endbr_seal_end'
> ld: alternative.c:(.init.text+0x164): undefined reference to
> `__ibt_endbr_seal'
> 
> It's because __ibt_endbr_seal and __ibt_endbr_seal_end are not optimized
> away when CONFIG_X86_KERNEL_IBT isn't enabled. Remove noinline attribute
> to help gcc optimize them away.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kernel/alternative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 5cadcea035e0..beaf9fc44e2f 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -624,7 +624,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
>  
>  #else
>  
> -void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
> +void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
>  
>  #endif /* CONFIG_X86_KERNEL_IBT */
>  

None of this makes any sense...
