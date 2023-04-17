Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B196E45B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjDQKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjDQKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6397EEA;
        Mon, 17 Apr 2023 03:50:02 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O8BJw/Yhksc1Eki6Km1qZYtTIfmg2/ZCRikV992cJE=;
        b=nREe89yQy3fFb62VQiYriNUHhlg6kPzBl8vaJouidZOKD/SAFJPxp7JWpGEaWcTw8GD5je
        b7mvuvY4R3mtPBGipunMB461J1Fqfxul9zTI05qkl7sv3ARKKGdKaSSnUeDgZIwVZvDRAz
        /3fpzGYfCiR+9KMSN9pQALy6kSAEYx7JlrpQvsiQG2viSQ18zLx4Dd4uh8XrG+PziI/Ro8
        gJmnKLzKXVbJfOn/r5c/YS7SGmkm0zKRGeoCvL7uQw2L8cSkUKMENyetSqARIz9MeKiY7z
        mvLIemV+KIdQ9Hd5mJ9ZK/bOl7Wjh2FekmnFfnLPlnj+Pu5vUn8v3RWgMaTsBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O8BJw/Yhksc1Eki6Km1qZYtTIfmg2/ZCRikV992cJE=;
        b=T+YCib5CmUyCXuUfBnsevg8MPmb0zvy9siCKnp6NO6XOzGS37cMmwmc4hlJB4LiO4dLutl
        lu30HqJX59avWeDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] cpu: Mark nmi_panic_self_stop() __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <316fc6dfab5a8c4e024c7185484a1ee5fb0afb79.1681342859.git.jpoimboe@kernel.org>
References: <316fc6dfab5a8c4e024c7185484a1ee5fb0afb79.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840678.404.9161137494457038103.tip-bot2@tip-bot2>
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

Commit-ID:     27dea14c7f05106f39850a9239874cd38703b405
Gitweb:        https://git.kernel.org/tip/27dea14c7f05106f39850a9239874cd38703b405
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:26 +02:00

cpu: Mark nmi_panic_self_stop() __noreturn

In preparation for improving objtool's handling of weak noreturn
functions, mark nmi_panic_self_stop() __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/316fc6dfab5a8c4e024c7185484a1ee5fb0afb79.1681342859.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/reboot.h | 1 -
 arch/x86/kernel/reboot.c      | 2 +-
 include/linux/smp.h           | 2 +-
 kernel/panic.c                | 2 +-
 tools/objtool/check.c         | 1 +
 5 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index bc5b4d7..9177b43 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -28,7 +28,6 @@ void __noreturn machine_real_restart(unsigned int type);
 void cpu_emergency_disable_virtualization(void);
 
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
-void nmi_panic_self_stop(struct pt_regs *regs);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
 void run_crash_ipi_callback(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index d03c551..3adbe97 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -920,7 +920,7 @@ void run_crash_ipi_callback(struct pt_regs *regs)
 }
 
 /* Override the weak function in kernel/panic.c */
-void nmi_panic_self_stop(struct pt_regs *regs)
+void __noreturn nmi_panic_self_stop(struct pt_regs *regs)
 {
 	while (1) {
 		/* If no CPU is preparing crash dump, we simply loop here. */
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 2a737b3..7b93504 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -60,7 +60,7 @@ int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
  * Architecture-dependent code may override them.
  */
 void __noreturn panic_smp_self_stop(void);
-void nmi_panic_self_stop(struct pt_regs *regs);
+void __noreturn nmi_panic_self_stop(struct pt_regs *regs);
 void crash_smp_send_stop(void);
 
 /*
diff --git a/kernel/panic.c b/kernel/panic.c
index 5e4982d..886d2eb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -151,7 +151,7 @@ void __weak __noreturn panic_smp_self_stop(void)
  * Stop ourselves in NMI context if another CPU has already panicked. Arch code
  * may override this to prepare for crash dumping, e.g. save regs info.
  */
-void __weak nmi_panic_self_stop(struct pt_regs *regs)
+void __weak __noreturn nmi_panic_self_stop(struct pt_regs *regs)
 {
 	panic_smp_self_stop();
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b52ed6..8d073bf 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -217,6 +217,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"machine_real_restart",
 		"make_task_dead",
+		"nmi_panic_self_stop",
 		"panic",
 		"panic_smp_self_stop",
 		"rest_init",
