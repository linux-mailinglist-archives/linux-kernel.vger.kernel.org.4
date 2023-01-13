Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD1669757
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjAMMfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbjAMMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D8551D7;
        Fri, 13 Jan 2023 04:31:12 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0ubaXfDfhpMCgnJFD4tqKhLDwUq1u6iRG5Kjrq1zIA=;
        b=21qUFe+V+/+ol7Lsbmkmct+AcRh6rz/bqjHG+FQimWI/NQUJyDROg3j4v6f26vmop2TYuQ
        EUjMEh+IdSJMpspkebHFjRGa8b0MxxY8IE8EASA2cx+WLzayMrDhvbvhEqiE3yLJHvu5IB
        DOCW/X5vqjmfoUUwSCaABmgHxHRjrRWM2fteFwFwK4wHErflN00BgVgjdKtBHhMNARwdW4
        GgyhLf0yS1dC0gU+c16FebXi8uRCo2O6y/hOrJdcfa68vivo/r2tvGu3cQXOA66g/Al9/l
        NHs/TCzCJ+kiCkm8Whu+SA8O4LhmrL8Vwjv3OVHZuelpGgwEMRCQYKlaPZY31A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0ubaXfDfhpMCgnJFD4tqKhLDwUq1u6iRG5Kjrq1zIA=;
        b=NreBUqAuXTWJcfFzTGFrEVYCVVDmdgkaoWo4ZzxTJnHGT/VhJla4GKMZxDspod8DQvO+z7
        VdNVt1N1jr6uKeDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, mwait: Make the mwait code noinstr clean
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.050542952@infradead.org>
References: <20230112195541.050542952@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306942.4906.10598168030102825603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ec8efe64e6dfcaa50906ae4b0b5a0a7e1a54d50
Gitweb:        https://git.kernel.org/tip/2ec8efe64e6dfcaa50906ae4b0b5a0a7e1a54d50
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:16 +01:00

cpuidle, mwait: Make the mwait code noinstr clean

objtool found a few cases where this code called out into instrumented
code:

  vmlinux.o: warning: objtool: intel_idle_s2idle+0x6e: call to __monitor.constprop.0() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_irq+0x8c: call to __monitor.constprop.0() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle+0x73: call to __monitor.constprop.0() leaves .noinstr.text section

  vmlinux.o: warning: objtool: mwait_idle+0x88: call to clflush() leaves .noinstr.text section

Fix it by marking the affected methods as __always_inline.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.050542952@infradead.org
---
 arch/x86/include/asm/mwait.h         | 12 ++++++------
 arch/x86/include/asm/special_insns.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index f224216..778df05 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -26,7 +26,7 @@
 #define TPAUSE_C01_STATE		1
 #define TPAUSE_C02_STATE		0
 
-static inline void __monitor(const void *eax, unsigned long ecx,
+static __always_inline void __monitor(const void *eax, unsigned long ecx,
 			     unsigned long edx)
 {
 	/* "monitor %eax, %ecx, %edx;" */
@@ -34,7 +34,7 @@ static inline void __monitor(const void *eax, unsigned long ecx,
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static inline void __monitorx(const void *eax, unsigned long ecx,
+static __always_inline void __monitorx(const void *eax, unsigned long ecx,
 			      unsigned long edx)
 {
 	/* "monitorx %eax, %ecx, %edx;" */
@@ -42,7 +42,7 @@ static inline void __monitorx(const void *eax, unsigned long ecx,
 		     :: "a" (eax), "c" (ecx), "d"(edx));
 }
 
-static inline void __mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
 
@@ -77,8 +77,8 @@ static inline void __mwait(unsigned long eax, unsigned long ecx)
  * EAX                     (logical) address to monitor
  * ECX                     #GP if not zero
  */
-static inline void __mwaitx(unsigned long eax, unsigned long ebx,
-			    unsigned long ecx)
+static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
+				     unsigned long ecx)
 {
 	/* No MDS buffer clear as this is AMD/HYGON only */
 
@@ -87,7 +87,7 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 		     :: "a" (eax), "b" (ebx), "c" (ecx));
 }
 
-static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
+static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
 	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index c2e3221..54621e7 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -196,7 +196,7 @@ static inline void load_gs_index(unsigned int selector)
 
 #endif /* CONFIG_PARAVIRT_XXL */
 
-static inline void clflush(volatile void *__p)
+static __always_inline void clflush(volatile void *__p)
 {
 	asm volatile("clflush %0" : "+m" (*(volatile char __force *)__p));
 }
