Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5F667827
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbjALOxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbjALOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:52:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E22565AE8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eW1eJS20PBPNIc/x7hkOEbhV5Z70C96GEP7VlPQr3GE=; b=aPU7lwsfmN0exgD06ro+v230ma
        inYN+4H37Om7tBqtVLzUL9CUNUKlfPza2KgcF/4PIvMJRSjjj182vbfZKCbWGWcbCIG45AgQgTeW2
        fJfibscpsY63h5bZRqGsUf4OhsblkoP/Zw/BZA9PTJDZ2yDWPiuYKZy08myhK7w4NQ6zGvyAXLf0r
        M3tKHRiVoMc/WSOdEc6z2X8grpK42f1voLXiB5Pdc8Sqe2lHCgDtzs7he1s2s4NuaMwjujHi3zrRS
        ZFm27VOnMo7aZariMxE7kPw4B2ygcq5oEm7hLZK/tnd6ofcrPVD/UdjX1MVog7QR+UD+cBkfTdQE7
        QKSVn4uQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFyjo-0057ze-0K; Thu, 12 Jan 2023 14:39:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E5F5E300BE3;
        Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BD2812CC8C6A4; Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Message-ID: <20230112143825.762830112@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 15:31:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com
Subject: [RFC][PATCH 4/6] x86/power: Sprinkle some noinstr
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

Ensure no compiler instrumentation sneaks in while restoring the CPU
state. Specifically we can't handle CALL/RET until GS is restored.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/power/cpu.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -192,7 +192,7 @@ static void fix_processor_context(void)
  * The asm code that gets us here will have restored a usable GDT, although
  * it will be pointing to the wrong alias.
  */
-static void notrace __restore_processor_state(struct saved_context *ctxt)
+static __always_inline void __restore_processor_state(struct saved_context *ctxt)
 {
 	struct cpuinfo_x86 *c;
 
@@ -235,6 +235,13 @@ static void notrace __restore_processor_
 	loadsegment(fs, __KERNEL_PERCPU);
 #endif
 
+	/*
+	 * Definitely wrong, but at this point we should have at least enough
+	 * to do CALL/RET (consider SKL callthunks) and this avoids having
+	 * to deal with the noinstr explosion for now :/
+	 */
+	instrumentation_begin();
+
 	/* Restore the TSS, RO GDT, LDT, and usermode-relevant MSRs. */
 	fix_processor_context();
 
@@ -276,10 +283,12 @@ static void notrace __restore_processor_
 	 * because some of the MSRs are "emulated" in microcode.
 	 */
 	msr_restore_context(ctxt);
+
+	instrumentation_end();
 }
 
 /* Needed by apm.c */
-void notrace restore_processor_state(void)
+void noinstr restore_processor_state(void)
 {
 	__restore_processor_state(&saved_context);
 }


