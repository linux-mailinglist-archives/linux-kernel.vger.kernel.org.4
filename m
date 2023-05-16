Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75827048A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjEPJKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEPJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A328249EC;
        Tue, 16 May 2023 02:10:01 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xtsc3QMq8abgtUkGI84p9HLSUWmPJubMFXi/P9/1NSM=;
        b=ovj1DmATjCmMdQ29dXsLG1sF6YCPlYOiB/djY7HMySqF2dtIgAw9/LYOFMZqwN+sQCbk4u
        0LchI/IU6aZUmoGg4qD+Ffy0xvc4NM0Qv82sqBVnogqeZyN75795b8zhzK+994KcuV+Kq+
        QmmObrevb2H7ftX7NdXfxAePPCUca87y9WeYt3/zxvDjrKWcZIbkZtOEpQMbnt9BeHJgHN
        LwxBNckAskkVkRadZlzw1EFPmOGSX7vWdT11YK3OjJQ/YGSdZtAq92MX9q3INGGSrvw6DN
        1oyX4lECYaxBSCPeyz/HMMNxMiHLht/c52umh8RtY2Wvg0iqVHVmowZ9rp0BtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xtsc3QMq8abgtUkGI84p9HLSUWmPJubMFXi/P9/1NSM=;
        b=sYQAPLhLFG/gdHrikvezY2t/zGdf632TgXhG8tIKW/pqINDsa5zy5RwywdQskPDSGs2MdO
        T7UGwjBO87unhhBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] arm64: smp: Switch to hotplug core state synchronization
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.690926018@linutronix.de>
References: <20230512205256.690926018@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819737.404.15725341721545451300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     b3091f172fed63ee59d1746f088bdcc76a79a79c
Gitweb:        https://git.kernel.org/tip/b3091f172fed63ee59d1746f088bdcc76a79a79c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:57 +02:00

arm64: smp: Switch to hotplug core state synchronization

Switch to the CPU hotplug core state tracking and synchronization
mechanim. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.690926018@linutronix.de
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/smp.h |  2 +-
 arch/arm64/kernel/smp.c      | 14 +++++---------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d2..fcb945b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -222,6 +222,7 @@ config ARM64
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index f2d2623..9b31e6d 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -99,7 +99,7 @@ static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 
 extern int __cpu_disable(void);
 
-extern void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
 extern void __noreturn cpu_die(void);
 extern void __noreturn cpu_die_early(void);
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d00d4cb..edd6389 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -332,17 +332,13 @@ static int op_cpu_kill(unsigned int cpu)
 }
 
 /*
- * called on the thread which is asking for a CPU to be shutdown -
- * waits until shutdown has completed, or it is timed out.
+ * Called on the thread which is asking for a CPU to be shutdown after the
+ * shutdown completed.
  */
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
 	int err;
 
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_crit("CPU%u: cpu didn't die\n", cpu);
-		return;
-	}
 	pr_debug("CPU%u: shutdown\n", cpu);
 
 	/*
@@ -369,8 +365,8 @@ void __noreturn cpu_die(void)
 
 	local_daif_mask();
 
-	/* Tell __cpu_die() that this CPU is now safe to dispose of */
-	(void)cpu_report_death();
+	/* Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose of */
+	cpuhp_ap_report_dead();
 
 	/*
 	 * Actually shutdown the CPU. This must never fail. The specific hotplug
