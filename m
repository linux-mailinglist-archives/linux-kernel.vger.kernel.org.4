Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B6F6E4598
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDQKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDQKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:49:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E8ED;
        Mon, 17 Apr 2023 03:48:12 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EygwRbB8JyZnkTtOgv8diB/DIMVBm1/6K4FuPOI9bXM=;
        b=tuIQyVEw8pRS8KPuqNfCmSr+gP6U/gQ8phJzhksfq379Z2dKY8Vfiy4UFyw4Xmi65VM3ls
        A3EvHolwJWpq+om49n8p1DIM5Vog16IBXMu++UVU4kwAa6d1l0tzVFBQ5mitZ5fTrbWLOK
        xvbRhKapeXp7qmA7NCYqjCDGMuaHTaluIk5UINBCngsWZIvQSNWzcvqQrxHwuTug+Zk30C
        yWz7z9S9e4wyZVNiw2xW6nLD7tgvyT6zMgtGjGYs92t/mVSo7cBVCibHrKi3jo5EFrRcCv
        eO3yuFdVzrRSni+njxErBojpGIr0FhTz7mbzGKEfaK8WFGQ/QONXjug2SBcaNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EygwRbB8JyZnkTtOgv8diB/DIMVBm1/6K4FuPOI9bXM=;
        b=aezQTuIGs1lQVIWSLljq6polu1aPIiEFkZRDZUjd961NT5pFZfqRH0ky11tS+5MajtFmfp
        RBAUK5O7yl77N+CA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/cpu: Mark {hlt,resume}_play_dead() __noreturn
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ce1407c4bf88b1334fe40413126343792a77ca50.1681342859.git.jpoimboe@kernel.org>
References: <ce1407c4bf88b1334fe40413126343792a77ca50.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840596.404.15545078409070467274.tip-bot2@tip-bot2>
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

Commit-ID:     52668badd34b4b346f32c33a9bcba069a06c3caa
Gitweb:        https://git.kernel.org/tip/52668badd34b4b346f32c33a9bcba069a06c3caa
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:27 +02:00

x86/cpu: Mark {hlt,resume}_play_dead() __noreturn

Fixes the following warning:

  vmlinux.o: warning: objtool: resume_play_dead+0x21: unreachable instruction

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/ce1407c4bf88b1334fe40413126343792a77ca50.1681342859.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/smp.h | 2 +-
 arch/x86/kernel/smpboot.c  | 2 +-
 arch/x86/power/cpu.c       | 2 +-
 tools/objtool/check.c      | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e6d1d28..47ce4c7 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -125,7 +125,7 @@ int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_disable(void);
 int common_cpu_die(unsigned int cpu);
 void native_cpu_die(unsigned int cpu);
-void hlt_play_dead(void);
+void __noreturn hlt_play_dead(void);
 void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9013bb2..a6da3f9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1816,7 +1816,7 @@ static inline void mwait_play_dead(void)
 	}
 }
 
-void hlt_play_dead(void)
+void __noreturn hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)
 		wbinvd();
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 236447e..7a4d5e9 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -288,7 +288,7 @@ EXPORT_SYMBOL(restore_processor_state);
 #endif
 
 #if defined(CONFIG_HIBERNATION) && defined(CONFIG_HOTPLUG_CPU)
-static void resume_play_dead(void)
+static void __noreturn resume_play_dead(void)
 {
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ceb9848..724a63b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -212,6 +212,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"do_task_dead",
 		"ex_handler_msr_mce",
 		"fortify_panic",
+		"hlt_play_dead",
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
@@ -222,6 +223,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"panic",
 		"panic_smp_self_stop",
 		"rest_init",
+		"resume_play_dead",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
