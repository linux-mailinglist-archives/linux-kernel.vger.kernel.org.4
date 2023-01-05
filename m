Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA865E265
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjAEBQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjAEBPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:15:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8936B2F7AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:15:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 109B8618B9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C615C433EF;
        Thu,  5 Jan 2023 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672881339;
        bh=1uzbuAMG2pci7jybSzcRNNiDYgNHTs84/fzs0RTC4+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6CZ+sZAPFTVmaCTLY/cy6zT8j4jCctIiSw5OH/OWDI5HxdfKKyyOUZ/W16qVdW+0
         sT1CbayMvsltyNph1run8SrUCLiULYxrgvi4Mg1/WvDD+TLdl2s/6U3DQ41gywXOCH
         33We+cWa9hcc4qaMN0tsY7AgETig1zlhZzTvZgSG2Nx+NMe1xLbhXCnkWrBpold3ZD
         aH0mx9YY9iPg0n1IAWJHFFFI2JIEuZs0yaHfkrCWpdR+Gs1bcvt8v2b635cefMxB9R
         nJKa19A8nQQPQxi8T1UZa42+8lKFR5F1da1qmkCBfS3MFGQs2vqv9aEMO/hxGDb1X8
         yHO9pZt60P4IQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 193445C0558; Wed,  4 Jan 2023 17:15:39 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH x86/nmi 2/2] x86/nmi: Print reasons why backtrace NMIs are ignored
Date:   Wed,  4 Jan 2023 17:15:37 -0800
Message-Id: <20230105011537.1774941-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105011537.1774941-1-paulmck@kernel.org>
References: <20230105011537.1774941-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instrument nmi_trigger_cpumask_backtrace() to dump out diagnostics based
on evidence accumulated by exc_nmi().  These diagnostics are dumped for
CPUs that ignored an NMI backtrace request for more than 10 seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/nmi.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/nmi.h   |  8 +++++
 lib/nmi_backtrace.c   |  2 ++
 3 files changed, 83 insertions(+)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4f1651dc65b3a..4a58ea6a806e1 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -566,6 +566,79 @@ DEFINE_IDTENTRY_RAW(exc_nmi_noist)
 EXPORT_SYMBOL_GPL(asm_exc_nmi_noist);
 #endif
 
+#ifdef CONFIG_NMI_CHECK_CPU
+
+static char *nmi_check_stall_msg[] = {
+/*									*/
+/* +--------- nsp->idt_seq_snap & 0x1: CPU is in NMI handler.		*/
+/* | +------ cpu_is_offline(cpu)					*/
+/* | | +--- nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls):	*/
+/* | | |	NMI handler has been invoked.				*/
+/* | | |								*/
+/* V V V								*/
+/* 0 0 0 */ "NMIs are not reaching exc_nmi handler",
+/* 0 0 1 */ "exc_nmi handler is ignoring NMIs",
+/* 0 1 0 */ "CPU is offline and NMIs are not reaching exc_nmi handler",
+/* 0 1 1 */ "CPU is offline and exc_nmi handler is legitimately ignoring NMIs",
+/* 1 0 0 */ "CPU is in exc_nmi handler and no further NMIs are reaching handler",
+/* 1 0 1 */ "CPU is in exc_nmi handler which is legitimately ignoring NMIs",
+/* 1 1 0 */ "CPU is offline in exc_nmi handler and no further NMIs are reaching exc_nmi handler",
+/* 1 1 1 */ "CPU is offline in exc_nmi handler which is legitimately ignoring NMIs",
+};
+
+void nmi_backtrace_stall_snap(const struct cpumask *btp)
+{
+	int cpu;
+	struct nmi_stats *nsp;
+
+	for_each_cpu(cpu, btp) {
+		nsp = per_cpu_ptr(&nmi_stats, cpu);
+		nsp->idt_seq_snap = READ_ONCE(nsp->idt_seq);
+		nsp->idt_nmi_seq_snap = READ_ONCE(nsp->idt_nmi_seq);
+		nsp->idt_ignored_snap = READ_ONCE(nsp->idt_ignored);
+		nsp->idt_calls_snap = atomic_long_read(&nsp->idt_calls);
+	}
+}
+
+void nmi_backtrace_stall_check(const struct cpumask *btp)
+{
+	int cpu;
+	int idx;
+	unsigned long nmi_seq;
+	unsigned long j = jiffies;
+	char *modp;
+	char *msgp;
+	char *msghp;
+	struct nmi_stats *nsp;
+
+	for_each_cpu(cpu, btp) {
+		nsp = per_cpu_ptr(&nmi_stats, cpu);
+		modp = "";
+		msghp = "";
+		nmi_seq = READ_ONCE(nsp->idt_nmi_seq);
+		if (nsp->idt_nmi_seq_snap + 1 == nmi_seq && (nmi_seq & 0x1)) {
+			msgp = "CPU entered NMI handler function, but has not exited";
+		} else if ((nsp->idt_nmi_seq_snap & 0x1) != (nmi_seq & 0x1)) {
+			msgp = "CPU is handling NMIs";
+		} else {
+			idx = ((nsp->idt_seq_snap & 0x1) << 2) |
+			      (cpu_is_offline(cpu) << 1) |
+			      (nsp->idt_calls_snap != atomic_long_read(&nsp->idt_calls));
+			msgp = nmi_check_stall_msg[idx];
+			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
+				modp = ", but OK because ignore_nmis was set";
+			if (nmi_seq & ~0x1)
+				msghp = " (CPU currently in NMI handler function)";
+			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
+				msghp = " (CPU exited one NMI handler function)";
+		}
+		pr_alert("%s: CPU %d: %s%s%s, last activity: %lu jiffies ago.\n",
+			 __func__, cpu, msgp, modp, msghp, j - READ_ONCE(nsp->recv_jiffies));
+	}
+}
+
+#endif
+
 void stop_nmi(void)
 {
 	ignore_nmis++;
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index f700ff2df074e..048c0b9aa623d 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -214,4 +214,12 @@ int proc_watchdog_cpumask(struct ctl_table *, int, void *, size_t *, loff_t *);
 #include <asm/nmi.h>
 #endif
 
+#ifdef CONFIG_NMI_CHECK_CPU
+void nmi_backtrace_stall_snap(const struct cpumask *btp);
+void nmi_backtrace_stall_check(const struct cpumask *btp);
+#else
+static inline void nmi_backtrace_stall_snap(const struct cpumask *btp) {}
+static inline void nmi_backtrace_stall_check(const struct cpumask *btp) {}
+#endif
+
 #endif
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index d01aec6ae15c8..5274bbb026d79 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -64,6 +64,7 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
 		pr_info("Sending NMI from CPU %d to CPUs %*pbl:\n",
 			this_cpu, nr_cpumask_bits, to_cpumask(backtrace_mask));
+		nmi_backtrace_stall_snap(to_cpumask(backtrace_mask));
 		raise(to_cpumask(backtrace_mask));
 	}
 
@@ -74,6 +75,7 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 		mdelay(1);
 		touch_softlockup_watchdog();
 	}
+	nmi_backtrace_stall_check(to_cpumask(backtrace_mask));
 
 	/*
 	 * Force flush any remote buffers that might be stuck in IRQ context
-- 
2.31.1.189.g2e36527f23

