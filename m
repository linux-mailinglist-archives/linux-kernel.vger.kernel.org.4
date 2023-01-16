Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAB66C2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjAPOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjAPOwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:52:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D72BF1B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dtG3CCLzMA0i0qOsNCGAACCWIWjzH+RX76nYJr/7nUg=; b=mNSQfQeUAAjFw9ESss496f+Z7Q
        u0TgyafjRhE1gQwftI2iBVWQ3NaSLG34VdbAWazXouiYsRdKyzqy1wML0X2573JOCsV/N0PK5k2F2
        TPov7/LEGoLwGuZcybAwU9tHaa3wffyOD9zxSarAfZ29Q4WErfXs+qrs4jgpQMpEdyO9/ORvp95nX
        EjaMEymmS+cwIurns0c3wEq3uE17tL2K8Hwq/Ex3y3gpAT4bxe9pp5k86FtmXoW5UtC3/6pfTmVtZ
        8qPTNYgKrdqtoTo1pP63NdYMrqwT3UhPTSsaXrAPfezN6rdi70FJ8sxMqiPPuMxRvDSFpPFtdzk0Q
        gXratnhg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHQcT-008oZ6-SE; Mon, 16 Jan 2023 14:37:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E016530073F;
        Mon, 16 Jan 2023 15:37:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B816220B75F29; Mon, 16 Jan 2023 15:37:38 +0100 (CET)
Message-ID: <20230116143645.768035056@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 15:25:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 4/7] x86/power: Inline write_cr[04]()
References: <20230116142533.905102512@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we can't do CALL/RET until GS is restored and CR[04] pinning is
of dubious value in this code path, simply write the stored values.

Fixes: e81dc127ef69 ("x86/callthunks: Add call patching for call depth tracking")
Reported-by: Joan Bruguera <joanbrugueram@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/power/cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -208,11 +208,11 @@ static void notrace __restore_processor_
 #else
 /* CONFIG X86_64 */
 	native_wrmsrl(MSR_EFER, ctxt->efer);
-	native_write_cr4(ctxt->cr4);
+	asm volatile("mov %0,%%cr4": "+r" (ctxt->cr4) : : "memory");
 #endif
 	native_write_cr3(ctxt->cr3);
 	native_write_cr2(ctxt->cr2);
-	native_write_cr0(ctxt->cr0);
+	asm volatile("mov %0,%%cr0": "+r" (ctxt->cr0) : : "memory");
 
 	/* Restore the IDT. */
 	native_load_idt(&ctxt->idt);


