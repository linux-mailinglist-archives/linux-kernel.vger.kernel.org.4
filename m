Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3E5667829
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbjALOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbjALOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:52:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF396146F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LNbZyqdS6MCOXN5DhvrakKEz6kKRrs7/+Ia2/9U4HAc=; b=G5AA9h/yH9+nJcJaV99Ad2Ey8F
        k5XWYtZamnH9v88AQNk//cUWHI313YsUcDWkBRHwsEnZ3YwO8uX31UVbbHNGiSckhXek4//+Wnz8l
        sFL6gBapz0F4s5kPWpNrhL2lnWrU7jUGCNGjtvEK9GN2wjN3Qp6ppjE4WmTl7v9s6AsO4FwK2CMiy
        BksgEqIsTHg+IvsVuWE/RCyauvJNvXu9ihIdqTkl7iNXaBSeD4jwxobQPOMLpk/dWsh0TlC086R3I
        6S5sM/g0/l5h+kcMN6smqUUGVPcaJ0N69KsfH2p+TSKM/cDaDIhyRd6fHrKzfHFtn9N3WXaseHucg
        0YtdygGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFyjo-0057zn-9C; Thu, 12 Jan 2023 14:39:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E776300AFB;
        Thu, 12 Jan 2023 15:39:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB2472CC949B7; Thu, 12 Jan 2023 15:39:12 +0100 (CET)
Message-ID: <20230112143825.881829388@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 12 Jan 2023 15:31:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jan Beulich <jbeulich@suse.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Kees Cook <keescook@chromium.org>, mark.rutland@arm.com
Subject: [RFC][PATCH 6/6] x86/power: Seal restore_processor_state()
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

Disallow indirect branches to restore_processor_state().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/suspend_64.h |    4 ++++
 arch/x86/power/cpu.c              |    2 +-
 arch/x86/power/hibernate_asm_64.S |    4 ++++
 include/linux/suspend.h           |    4 ++++
 4 files changed, 13 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -9,6 +9,7 @@
 
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
+#include <asm/ibt.h>
 
 /*
  * Image of the saved processor state, used by the low level ACPI suspend to
@@ -61,4 +62,7 @@ struct saved_context {
 extern char core_restore_code[];
 extern char restore_registers[];
 
+#define restore_processor_state restore_processor_state
+extern __noendbr void restore_processor_state(void);
+
 #endif /* _ASM_X86_SUSPEND_64_H */
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -288,7 +288,7 @@ static __always_inline void __restore_pr
 }
 
 /* Needed by apm.c */
-void noinstr restore_processor_state(void)
+void __noendbr noinstr restore_processor_state(void)
 {
 	__restore_processor_state(&saved_context);
 }
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -23,6 +23,10 @@
 #include <asm/frame.h>
 #include <asm/nospec-branch.h>
 
+.pushsection .discard.noendbr
+.quad	restore_processor_state
+.popsection
+
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
 SYM_FUNC_START(restore_registers)
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/freezer.h>
 #include <asm/errno.h>
+#include <asm/suspend.h>
 
 #ifdef CONFIG_VT
 extern void pm_set_vt_switch(int);
@@ -483,7 +484,10 @@ extern struct mutex system_transition_mu
 
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);
+
+#ifndef restore_processor_state
 void restore_processor_state(void);
+#endif
 
 /* kernel/power/main.c */
 extern int register_pm_notifier(struct notifier_block *nb);


