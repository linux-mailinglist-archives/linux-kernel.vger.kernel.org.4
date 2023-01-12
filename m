Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE89667833
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbjALOxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjALOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:52:57 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A041B4B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sHDPsq2uABjtfq0P5gTU9bTPKMFTr0x7rU8OwfasSIg=; b=LI9y8vBQdis0SSWa52KOS2vrQI
        DwEgo+snsApY9aPqeiehYRoGQAQPCfcXdVF/jnQvKmoDaZgOMjKpFPoGTQGrbyME7YpvvPqVAN8Au
        xhJ4YL/E4PAO+PAZBX22U4wBu1/QoMzS7R97C0oTdBAOCx8hnEzZ/GJ8x43Z2EedpvXr/NLaJ1WcW
        Xn4115CcVMUdvp59cZr83pNUcEW6riGQbkak/hhi3nIgdfg9mi2Jm6QWhhq8mm98rpvZdtPfTsVha
        Tn3o9kjumy/5q3a/JwjaPtKaLtr7A4nKrKiZq5C++dGVHnqAjuh5olHmuMnpLddjUizxu999OLs+z
        VmxWPwnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pFyjS-0040tF-12;
        Thu, 12 Jan 2023 14:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5EEE30084B;
        Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B487C2CC8C6A5; Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Message-ID: <20230112143825.584639584@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 15:31:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com
Subject: [RFC][PATCH 1/6] x86/power: De-paravirt restore_processor_state()
References: <20230112143141.645645775@infradead.org>
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

Since Xen PV doesn't use restore_processor_state(), and we're going to
have to avoid CALL/RET until at least GS is restored, de-paravirt the
easy bits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/power/cpu.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -197,25 +197,25 @@ static void notrace __restore_processor_
 	struct cpuinfo_x86 *c;
 
 	if (ctxt->misc_enable_saved)
-		wrmsrl(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
+		native_wrmsrl(MSR_IA32_MISC_ENABLE, ctxt->misc_enable);
 	/*
 	 * control registers
 	 */
 	/* cr4 was introduced in the Pentium CPU */
 #ifdef CONFIG_X86_32
 	if (ctxt->cr4)
-		__write_cr4(ctxt->cr4);
+		native_write_cr4(ctxt->cr4);
 #else
 /* CONFIG X86_64 */
-	wrmsrl(MSR_EFER, ctxt->efer);
-	__write_cr4(ctxt->cr4);
+	native_wrmsrl(MSR_EFER, ctxt->efer);
+	native_write_cr4(ctxt->cr4);
 #endif
-	write_cr3(ctxt->cr3);
-	write_cr2(ctxt->cr2);
-	write_cr0(ctxt->cr0);
+	native_write_cr3(ctxt->cr3);
+	native_write_cr2(ctxt->cr2);
+	native_write_cr0(ctxt->cr0);
 
 	/* Restore the IDT. */
-	load_idt(&ctxt->idt);
+	native_load_idt(&ctxt->idt);
 
 	/*
 	 * Just in case the asm code got us here with the SS, DS, or ES
@@ -230,7 +230,7 @@ static void notrace __restore_processor_
 	 * handlers or in complicated helpers like load_gs_index().
 	 */
 #ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
+	native_wrmsrl(MSR_GS_BASE, ctxt->kernelmode_gs_base);
 #else
 	loadsegment(fs, __KERNEL_PERCPU);
 #endif
@@ -246,15 +246,15 @@ static void notrace __restore_processor_
 	loadsegment(ds, ctxt->es);
 	loadsegment(es, ctxt->es);
 	loadsegment(fs, ctxt->fs);
-	load_gs_index(ctxt->gs);
+	native_load_gs_index(ctxt->gs);
 
 	/*
 	 * Restore FSBASE and GSBASE after restoring the selectors, since
 	 * restoring the selectors clobbers the bases.  Keep in mind
 	 * that MSR_KERNEL_GS_BASE is horribly misnamed.
 	 */
-	wrmsrl(MSR_FS_BASE, ctxt->fs_base);
-	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
+	native_wrmsrl(MSR_FS_BASE, ctxt->fs_base);
+	native_wrmsrl(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
 #else
 	loadsegment(gs, ctxt->gs);
 #endif


