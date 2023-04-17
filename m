Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780AD6E45B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjDQKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjDQKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FE7D8C;
        Mon, 17 Apr 2023 03:50:00 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocUW9GOElvL8AYWsHoDMzMItwN417znLpFX8N+bV3DE=;
        b=uXeFCd08pjlQs7JNty6HsruviAcNU9rbvoGmzIJ1sxUF7OzmoGhtDWNz45aBocqypFC5/B
        /7fqJvPXtCKIDzc5Eeq8BA78+RykigOKfdNgmHjzRB/VfBR+2dN0S90WoaP+UgKt79pwvp
        dMO/mOFQ3TPyHlky3U6VXogLdrUbBuahE+2YA7dZWIFy3am2vA61PvhlJmFc1JYhsqwqAO
        5GimNWnx7a7dhHtN57vk1OUCbkdNc+QDQmnZiX52foko/LF616qQNMqNL5E/QHvpP1ud0G
        69rpB+5OOfy6+tOz/bMx458fY9tr+54oJqkcFLej1HzVCEgJOJHEG8pKs7gLBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocUW9GOElvL8AYWsHoDMzMItwN417znLpFX8N+bV3DE=;
        b=0doHOdMPYju8+8LqoHAzRWTVBY4EAPb9i7esTGnCb35cs1nZ/Ssl6D6i7qmxbW0eZkpFeX
        S/uIbB+hS4t/EAAQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] cpu: Mark panic_smp_self_stop() __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <92d76ab5c8bf660f04fdcd3da1084519212de248.1681342859.git.jpoimboe@kernel.org>
References: <92d76ab5c8bf660f04fdcd3da1084519212de248.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840703.404.1762919033768263988.tip-bot2@tip-bot2>
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

Commit-ID:     7412a60decec2a6744cf773280ff17a0f89e8395
Gitweb:        https://git.kernel.org/tip/7412a60decec2a6744cf773280ff17a0f89e8395
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:25 +02:00

cpu: Mark panic_smp_self_stop() __noreturn

In preparation for improving objtool's handling of weak noreturn
functions, mark panic_smp_self_stop() __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/92d76ab5c8bf660f04fdcd3da1084519212de248.1681342859.git.jpoimboe@kernel.org
---
 arch/arm/kernel/smp.c          | 2 +-
 arch/arm64/include/asm/smp.h   | 1 -
 arch/arm64/kernel/smp.c        | 2 +-
 arch/powerpc/kernel/setup_64.c | 2 +-
 include/linux/smp.h            | 2 +-
 kernel/panic.c                 | 2 +-
 tools/objtool/check.c          | 1 +
 7 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d6be450..f4a4ac0 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -779,7 +779,7 @@ void smp_send_stop(void)
  * kdump fails. So split out the panic_smp_self_stop() and add
  * set_cpu_online(smp_processor_id(), false).
  */
-void panic_smp_self_stop(void)
+void __noreturn panic_smp_self_stop(void)
 {
 	pr_debug("CPU %u will stop doing anything useful since another CPU has paniced\n",
 	         smp_processor_id());
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 07f4ea1..f2d2623 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -143,7 +143,6 @@ bool cpus_are_stuck_in_kernel(void);
 
 extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
-extern void panic_smp_self_stop(void);
 
 #endif /* ifndef __ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 07d156f..05fe797 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -830,7 +830,7 @@ static void __noreturn local_cpu_stop(void)
  * that cpu_online_mask gets correctly updated and smp_send_stop() can skip
  * CPUs that have already stopped themselves.
  */
-void panic_smp_self_stop(void)
+void __noreturn panic_smp_self_stop(void)
 {
 	local_cpu_stop();
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b2e0d3c..246201d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -480,7 +480,7 @@ void early_setup_secondary(void)
 
 #endif /* CONFIG_SMP */
 
-void panic_smp_self_stop(void)
+void __noreturn panic_smp_self_stop(void)
 {
 	hard_irq_disable();
 	spin_begin();
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a80ab58..2a737b3 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -59,7 +59,7 @@ int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
  * Cpus stopping functions in panic. All have default weak definitions.
  * Architecture-dependent code may override them.
  */
-void panic_smp_self_stop(void);
+void __noreturn panic_smp_self_stop(void);
 void nmi_panic_self_stop(struct pt_regs *regs);
 void crash_smp_send_stop(void);
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 5cfea83..5e4982d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -141,7 +141,7 @@ EXPORT_SYMBOL(panic_blink);
 /*
  * Stop ourself in panic -- architecture code may override this
  */
-void __weak panic_smp_self_stop(void)
+void __weak __noreturn panic_smp_self_stop(void)
 {
 	while (1)
 		cpu_relax();
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a436bc1..4b52ed6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -218,6 +218,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"machine_real_restart",
 		"make_task_dead",
 		"panic",
+		"panic_smp_self_stop",
 		"rest_init",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
