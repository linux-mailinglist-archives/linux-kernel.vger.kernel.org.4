Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C605F8B86
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJINLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJINLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:11:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3C818E3A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z69Ux8mPjjeN7GgdN0xPF6QWCJzpogn4HnwfVSwTjvQ=; b=F7sw4xHh98nbM/Fpw3BnOBRo0z
        N8HtRJGTE6bSCfzthpMVV8H0Y9pTjESJ3Wa9c1eOk32S/H+qq76lYAsmDSexYSAGi7FvAnHoLNKMf
        cYoYQqRxEnboPYyjQSlDr2ZmAiyXYspsV+UQOifIUcSRbubHWYZaRl192WgF7AmOp9/XLlrehGJ+x
        t4CJworihQsSVCTo3ePzVaRP8QMj2LwwCabWt9FlXoK5tSep3h6mAEZQcFBbm81Jcbq0ZUGwovtBl
        /uDRPsQXZfeSPci02Ykp2YhG+joRu9iv9atPQPK2bmsRJ/iYbxjRgBbIZ+LDuvUM55ZF+iOoW84eS
        FvUjz6/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohW5P-003Qhs-RZ; Sun, 09 Oct 2022 13:11:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83D50300422;
        Sun,  9 Oct 2022 15:11:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 685AA2C18974D; Sun,  9 Oct 2022 15:11:15 +0200 (CEST)
Date:   Sun, 9 Oct 2022 15:11:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/alternative: fix undefined reference to
 __ibt_endbr_seal[_end]
Message-ID: <Y0LIcwJKRDJVOW7o@hirez.programming.kicks-ass.net>
References: <20221009154532.1100121-1-linmiaohe@huawei.com>
 <Y0K+YbcwyLJg9Iwr@hirez.programming.kicks-ass.net>
 <1ed246ea-2960-4893-f84a-c24b3c3832d7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed246ea-2960-4893-f84a-c24b3c3832d7@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 08:44:26PM +0800, Miaohe Lin wrote:
> On 2022/10/9 20:28, Peter Zijlstra wrote:
> > On Sun, Oct 09, 2022 at 11:45:32PM +0800, Miaohe Lin wrote:
> >> When I compile the kernel bzImage, there are several compile errors:
> >>
> >> ld: arch/x86/kernel/alternative.o: in function
> >> `alternative_instructions':
> >> alternative.c:(.init.text+0x15d): undefined reference to
> >> `__ibt_endbr_seal_end'
> >> ld: alternative.c:(.init.text+0x164): undefined reference to
> >> `__ibt_endbr_seal'
> >>
> >> It's because __ibt_endbr_seal and __ibt_endbr_seal_end are not optimized
> >> away when CONFIG_X86_KERNEL_IBT isn't enabled. Remove noinline attribute
> >> to help gcc optimize them away.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  arch/x86/kernel/alternative.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> >> index 5cadcea035e0..beaf9fc44e2f 100644
> >> --- a/arch/x86/kernel/alternative.c
> >> +++ b/arch/x86/kernel/alternative.c
> >> @@ -624,7 +624,7 @@ void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
> >>  
> >>  #else
> >>  
> >> -void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
> >> +void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
> >>  
> >>  #endif /* CONFIG_X86_KERNEL_IBT */
> >>  
> > 
> > None of this makes any sense...
> 
> This compile error occurs in my env when CONFIG_X86_KERNEL_IBT isn't
> enabled with gcc version 7.3.0 (GCC).

*sigh*... geriatric GCC :/

Anyway; perhaps clarify the changelog to state something like:

Due to the explicit 'noinline' GCC-7.3 is not able to optimize away the
argument setup of:

	apply_ibt_endbr(__ibt_endbr_seal, __ibt_enbr_seal_end);

even when X86_KERNEL_IBT=n and the function is an empty stub -- leading
to link errors due to missing __ibt_endbr_seal* symbols.

