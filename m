Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C126E45AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDQKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjDQKun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD581737;
        Mon, 17 Apr 2023 03:49:59 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMJ+cbokOctSN0U6wHjIbInp6iX43XTC0mQ1d+BTzbg=;
        b=wDEBJ6VcRx9pzel12ZIixHs/KB1eWrkf43cuXt9PWu5MCrr5ghBXbYwOxQCfUJzcuA0j9w
        dKbkr4AP+P/r/i4yMPN9iGpSDQo/6T7T4YMOgq6KAdGMrQ5aD3xNGXU7BmS9Zzcuv3cgu0
        f9MbQ4rgOStO3DKmL5kHQgyDS74XHVTlkm1AqZz3LR9agZc8C0CgitLmVQ/WEvfeFTPuCg
        QEH1/qEZD/yI+4fB8t4uSAWHL3LSPTCkcyxnGhFqaDPv0CbqfUm4I045er6mQqUDUcJrkG
        /8Z8ukx0EjZ990Qs696iYtpM0QP5mTt49QM1vdTsj8NtzMUAsdjoMCXSAQV1YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMJ+cbokOctSN0U6wHjIbInp6iX43XTC0mQ1d+BTzbg=;
        b=k3HrFrko+wBbrv4Q8F85qGSgG/3MzFL4ifc9hj5VvwMqkdlmAc3vbphhS5sM9C8I+VtPE/
        xHLgMa/a+GStpcCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/head: Mark *_start_kernel() __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c2525f96b88be98ee027ee0291d58003036d4120.1681342859.git.jpoimboe@kernel.org>
References: <c2525f96b88be98ee027ee0291d58003036d4120.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840758.404.8391667372410527352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4208d2d79837ef70f260d6170e3ac7fd6fde7788
Gitweb:        https://git.kernel.org/tip/4208d2d79837ef70f260d6170e3ac7fd6fde7788
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:33 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:24 +02:00

x86/head: Mark *_start_kernel() __noreturn

Now that start_kernel() is __noreturn, mark its chain of callers
__noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/c2525f96b88be98ee027ee0291d58003036d4120.1681342859.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/setup.h | 6 +++---
 arch/x86/kernel/head32.c     | 2 +-
 arch/x86/kernel/head64.c     | 4 ++--
 tools/objtool/check.c        | 2 ++
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f37cbff..f349562 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -125,11 +125,11 @@ void clear_bss(void);
 
 #ifdef __i386__
 
-asmlinkage void __init i386_start_kernel(void);
+asmlinkage void __init __noreturn i386_start_kernel(void);
 
 #else
-asmlinkage void __init x86_64_start_kernel(char *real_mode);
-asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
+asmlinkage void __init __noreturn x86_64_start_kernel(char *real_mode);
+asmlinkage void __init __noreturn x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index ec6fefb..10c27b4 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -29,7 +29,7 @@ static void __init i386_default_early_setup(void)
 	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc;
 }
 
-asmlinkage __visible void __init i386_start_kernel(void)
+asmlinkage __visible void __init __noreturn i386_start_kernel(void)
 {
 	/* Make sure IDT is set up before any exception happens */
 	idt_setup_early_handler();
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 387e4b1..49f7629 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -471,7 +471,7 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_unmap_bootdata(real_mode_data);
 }
 
-asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
+asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode_data)
 {
 	/*
 	 * Build-time sanity checks on the kernel image and module
@@ -537,7 +537,7 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	x86_64_start_reservations(real_mode_data);
 }
 
-void __init x86_64_start_reservations(char *real_mode_data)
+void __init __noreturn x86_64_start_reservations(char *real_mode_data)
 {
 	/* version is always not zero if it is copied */
 	if (!boot_params.hdr.version)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9aaad9d..a436bc1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -225,6 +225,8 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"start_kernel",
 		"stop_this_cpu",
 		"usercopy_abort",
+		"x86_64_start_kernel",
+		"x86_64_start_reservations",
 		"xen_cpu_bringup_again",
 		"xen_start_kernel",
 	};
