Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB02065E266
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjAEBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAEBPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:15:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C030560
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:15:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3517B81982
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3FAC433D2;
        Thu,  5 Jan 2023 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672881339;
        bh=jMyAkSLpCMuh5ciUOiwzDqHeUIJ9RghvpXjIS5MdcxI=;
        h=From:To:Cc:Subject:Date:From;
        b=KRP4LJjp7yGLjwwzAMb3jhdzs8TNfv+qQHwKvFoxtVMGYB2IzSqNizdtz7RP1HBCP
         Wy0lVu7n3F7nvA89C99Nch7Z4g3Sindri5hYFKq6ODjC5CwLkmeygu+EfU3gfPyWa7
         /qmh52VU9tPaYlKyf26Dg+TNX3CXZoJoODQS8l9tEAexDE8F2EDJeOozsFo5HdUZ5Y
         wBCmju3kdaRTXdAC+8fgwIRNfA9Zslg4fwk3Vopd3mu1kYOjF3IaKJKv10CFnIW11W
         r9cWbQ17ye8g66WcX7aIgAtCyML90HnwbSzct0i6UxVqx2bvZuFhk9bDswXtgdmUNo
         inHpU6zgZA6KQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 178795C05CA; Wed,  4 Jan 2023 17:15:39 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH x86/nmi 1/2] x86/nmi: Accumulate NMI-progress evidence in exc_nmi()
Date:   Wed,  4 Jan 2023 17:15:36 -0800
Message-Id: <20230105011537.1774941-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
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

CPUs ignoring NMIs is often a sign of those CPUs going bad, but there
are quite a few other reasons why a CPU might ignore NMIs.  Therefore,
accumulate evidence within exc_nmi() as to what might be preventing a
given CPU from responding to an NMI.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/nmi.c | 31 ++++++++++++++++++++++++++++++-
 lib/Kconfig.debug     | 11 +++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index cec0bfa3bc04f..4f1651dc65b3a 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -69,6 +69,15 @@ struct nmi_stats {
 	unsigned int unknown;
 	unsigned int external;
 	unsigned int swallow;
+	unsigned long recv_jiffies;
+	unsigned long idt_seq;
+	unsigned long idt_nmi_seq;
+	unsigned long idt_ignored;
+	atomic_long_t idt_calls;
+	unsigned long idt_seq_snap;
+	unsigned long idt_nmi_seq_snap;
+	unsigned long idt_ignored_snap;
+	long idt_calls_snap;
 };
 
 static DEFINE_PER_CPU(struct nmi_stats, nmi_stats);
@@ -479,12 +488,15 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
 	irqentry_state_t irq_state;
+	struct nmi_stats *nsp = this_cpu_ptr(&nmi_stats);
 
 	/*
 	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
 	 * cause nested NMIs, but those can be handled safely.
 	 */
 	sev_es_nmi_complete();
+	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU))
+		arch_atomic_long_inc(&nsp->idt_calls);
 
 	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
@@ -495,6 +507,11 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	}
 	this_cpu_write(nmi_state, NMI_EXECUTING);
 	this_cpu_write(nmi_cr2, read_cr2());
+	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
+		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
+		WARN_ON_ONCE(!(nsp->idt_seq & 0x1));
+		WRITE_ONCE(nsp->recv_jiffies, jiffies);
+	}
 nmi_restart:
 
 	/*
@@ -509,8 +526,15 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	inc_irq_stat(__nmi_count);
 
-	if (!ignore_nmis)
+	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU) && ignore_nmis) {
+		WRITE_ONCE(nsp->idt_ignored, nsp->idt_ignored + 1);
+	} else if (!ignore_nmis) {
+		WRITE_ONCE(nsp->idt_nmi_seq, nsp->idt_nmi_seq + 1);
+		WARN_ON_ONCE(!(nsp->idt_nmi_seq & 0x1));
 		default_do_nmi(regs);
+		WRITE_ONCE(nsp->idt_nmi_seq, nsp->idt_nmi_seq + 1);
+		WARN_ON_ONCE(nsp->idt_nmi_seq & 0x1);
+	}
 
 	irqentry_nmi_exit(regs, irq_state);
 
@@ -525,6 +549,11 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	if (user_mode(regs))
 		mds_user_clear_cpu_buffers();
+	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU)) {
+		WRITE_ONCE(nsp->idt_seq, nsp->idt_seq + 1);
+		WARN_ON_ONCE(nsp->idt_seq & 0x1);
+		WRITE_ONCE(nsp->recv_jiffies, jiffies);
+	}
 }
 
 #if defined(CONFIG_X86_64) && IS_ENABLED(CONFIG_KVM_INTEL)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a3..dad99197d2695 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1552,6 +1552,17 @@ config TRACE_IRQFLAGS_NMI
 	depends on TRACE_IRQFLAGS
 	depends on TRACE_IRQFLAGS_NMI_SUPPORT
 
+config NMI_CHECK_CPU
+	bool "Debugging for CPUs failing to respond to backtrace requests"
+	depends on DEBUG_KERNEL
+	depends on X86
+	default n
+	help
+	  Enables debug prints when a CPU fails to respond to a given
+	  backtrace NMI.  These prints provide some reasons why a CPU
+	  might legitimately be failing to respond, for example, if it
+	  is offline of if ignore_nmis is set.
+
 config DEBUG_IRQFLAGS
 	bool "Debug IRQ flag manipulation"
 	help
-- 
2.31.1.189.g2e36527f23

