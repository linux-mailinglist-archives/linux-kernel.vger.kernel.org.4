Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26412704894
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjEPJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjEPJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84D4227;
        Tue, 16 May 2023 02:09:59 -0700 (PDT)
Date:   Tue, 16 May 2023 09:09:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ae9SElgMhiy5kA+2p0t34L/wUZDdVE3Qxr6yI4gN/w0=;
        b=E2azaAp56ed92RUc5+1syAOMVJhtLVSGabBCADIUrxqZXnfQwOp0fvOlzNxYKfKqlw5DQf
        MQg5P0+d0XH7LHIIK8KeZ09ccsoakFJ543SX1Cd5KGLWP+cfPt7bhcNJsntlnz759poc/j
        EsC9XL3fHLk84G+fAxGZe96Qgm7StaeAuNaKP6N3EFQBFE/a5hM5OaH/45SwyJRbOKFPKY
        kb7OqnuP8iWgW8DXmQz2nQSYq0Jjk97/vncIUESee6t8mPe//ugiCM4UQAqbUJMQGN2ru6
        //YMUR6qF9U2hXr2S1jyZkgI08y/nvmTe1p//AQX9MSF2UDtcrLmksAwefD5mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ae9SElgMhiy5kA+2p0t34L/wUZDdVE3Qxr6yI4gN/w0=;
        b=hS94bUE0KpTEkW24kmeSF9OtvjptSI9/3OOjaTJ9R79lAML0lNbIywPxydJ5MWRTfsFRLE
        KTG3Vk40mDbORNCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/apic: Provide cpu_primary_thread mask
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205257.186599880@linutronix.de>
References: <20230512205257.186599880@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422819500.404.16598527509892623147.tip-bot2@tip-bot2>
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

Commit-ID:     f54d4434c281f38b975d58de47adeca671beff4f
Gitweb:        https://git.kernel.org/tip/f54d4434c281f38b975d58de47adeca671beff4f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:45:02 +02:00

x86/apic: Provide cpu_primary_thread mask

Make the primary thread tracking CPU mask based in preparation for simpler
handling of parallel bootup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205257.186599880@linutronix.de
---
 arch/x86/include/asm/apic.h     |  2 --
 arch/x86/include/asm/topology.h | 19 +++++++++++++++----
 arch/x86/kernel/apic/apic.c     | 20 +++++++++-----------
 arch/x86/kernel/smpboot.c       | 12 +++---------
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index dc50ed7..030f5fb 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -506,10 +506,8 @@ extern int default_check_phys_apicid_present(int phys_apicid);
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_SMP
-bool apic_id_is_primary_thread(unsigned int id);
 void apic_smt_update(void);
 #else
-static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
 static inline void apic_smt_update(void) { }
 #endif
 
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2ba5758..caf41c4 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -31,9 +31,9 @@
  * CONFIG_NUMA.
  */
 #include <linux/numa.h>
+#include <linux/cpumask.h>
 
 #ifdef CONFIG_NUMA
-#include <linux/cpumask.h>
 
 #include <asm/mpspec.h>
 #include <asm/percpu.h>
@@ -139,9 +139,20 @@ static inline int topology_max_smt_threads(void)
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
-bool topology_is_primary_thread(unsigned int cpu);
 bool topology_smt_supported(void);
-#else
+
+extern struct cpumask __cpu_primary_thread_mask;
+#define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thread_mask)
+
+/**
+ * topology_is_primary_thread - Check whether CPU is the primary SMT thread
+ * @cpu:	CPU to check
+ */
+static inline bool topology_is_primary_thread(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
+}
+#else /* CONFIG_SMP */
 #define topology_max_packages()			(1)
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
@@ -152,7 +163,7 @@ static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline bool topology_smt_supported(void) { return false; }
-#endif
+#endif /* !CONFIG_SMP */
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
 {
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 7705571..e17600d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2386,20 +2386,16 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 }
 
 #ifdef CONFIG_SMP
-/**
- * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary thread
- * @apicid: APIC ID to check
- */
-bool apic_id_is_primary_thread(unsigned int apicid)
+static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	u32 mask;
-
-	if (smp_num_siblings == 1)
-		return true;
 	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
-	return !(apicid & mask);
+	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
+
+	if (smp_num_siblings == 1 || !(apicid & mask))
+		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
+#else
+static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
 /*
@@ -2544,6 +2540,8 @@ int generic_processor_info(int apicid, int version)
 	set_cpu_present(cpu, true);
 	num_processors++;
 
+	cpu_mark_primary_thread(cpu, apicid);
+
 	return cpu;
 }
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a27941a..51122f0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -102,6 +102,9 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+/* CPUs which are the primary SMT threads */
+struct cpumask __cpu_primary_thread_mask __read_mostly;
+
 /* Representing CPUs for which sibling maps can be computed */
 static cpumask_var_t cpu_sibling_setup_mask;
 
@@ -277,15 +280,6 @@ static void notrace start_secondary(void *unused)
 }
 
 /**
- * topology_is_primary_thread - Check whether CPU is the primary SMT thread
- * @cpu:	CPU to check
- */
-bool topology_is_primary_thread(unsigned int cpu)
-{
-	return apic_id_is_primary_thread(per_cpu(x86_cpu_to_apicid, cpu));
-}
-
-/**
  * topology_smt_supported - Check whether SMT is supported by the CPUs
  */
 bool topology_smt_supported(void)
