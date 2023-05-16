Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7CF7048A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjEPJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjEPJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355A49F5;
        Tue, 16 May 2023 02:10:01 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KX8Ot/wYO1ZvdLJGOBq0J38CTuRduAdt+c2T/8576OE=;
        b=kLo6DZ4bCROyzmjRa2awRgSnnSHSu/UP+Ci8BOWPfgpsGJcchxP3wnDyI+jtrd1J8p80kS
        yHuNlFXBLU6ksLgloeAbWXO4MaIrVPkqdCYZzsNaAJ5RdUgAiAeZ/1dHxoYhVyu9uW/aTi
        8LurvBeJu0/749D+f2YfZpNZR3G0m3S1CU+ZUJgcZRHjOQd/5oWqZqd2YjA77GdChsaLjW
        DDyYSTQo282VFKjfPg+U1TwY3U9yjC6oX365JGTJT9Ge+a4SmMAsirg9aAasjUx0XqZZgc
        MIhZ59dRXqECocKYjQCuFmt/BeFgIler3AO1YxW7yO+SdybSPT2yJC+4PNg+HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KX8Ot/wYO1ZvdLJGOBq0J38CTuRduAdt+c2T/8576OE=;
        b=0UPuvfTtbRuJY6s5ZLVIV2d8rv9m2qkyd7H3TfAR/4o6pgLE2CmODzKXhOHNC5vl5wnr3k
        DtGKg4W/wTefflBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] csky/smp: Switch to hotplug core state synchronization
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.747254502@linutronix.de>
References: <20230512205256.747254502@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819707.404.11869298820913365779.tip-bot2@tip-bot2>
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

Commit-ID:     7202e979645715318f2f21a324cb8a506e12fa76
Gitweb:        https://git.kernel.org/tip/7202e979645715318f2f21a324cb8a506e12fa76
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:58 +02:00

csky/smp: Switch to hotplug core state synchronization

Switch to the CPU hotplug core state tracking and synchronization
mechanim. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.747254502@linutronix.de
---
 arch/csky/Kconfig           | 1 +
 arch/csky/include/asm/smp.h | 2 +-
 arch/csky/kernel/smp.c      | 8 ++------
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 4df1f8c..95f1e9b 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -96,6 +96,7 @@ config CSKY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
index 668b79c..d3db334 100644
--- a/arch/csky/include/asm/smp.h
+++ b/arch/csky/include/asm/smp.h
@@ -23,7 +23,7 @@ void __init set_send_ipi(void (*func)(const struct cpumask *mask), int irq);
 
 int __cpu_disable(void);
 
-void __cpu_die(unsigned int cpu);
+static inline void __cpu_die(unsigned int cpu) { }
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b12e2c3..8e42352 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -291,12 +291,8 @@ int __cpu_disable(void)
 	return 0;
 }
 
-void __cpu_die(unsigned int cpu)
+void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 {
-	if (!cpu_wait_death(cpu, 5)) {
-		pr_crit("CPU%u: shutdown failed\n", cpu);
-		return;
-	}
 	pr_notice("CPU%u: shutdown\n", cpu);
 }
 
@@ -304,7 +300,7 @@ void __noreturn arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
 
-	cpu_report_death();
+	cpuhp_ap_report_dead();
 
 	while (!secondary_stack)
 		arch_cpu_idle();
