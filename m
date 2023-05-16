Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C547048C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjEPJMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjEPJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A09F49EC;
        Tue, 16 May 2023 02:10:07 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAw3iiNKYMs7YXhTK+oHrE7mTiSbiNakd4j8jRewZtA=;
        b=32LCS+h2JVoJNIHOcky7ZlnkRrwsiTdyswJ/rQMPDnBIzJuhTb3dw6xFCmeUnFkqLS62GB
        lRGHEPGXKbZmehL0eETY20GjJiY3sZVddUlVxHzJZTGAUM1NKeB9LRnzX2dzeLezLNqYq6
        KJNu527IMwx115QD9tN/Pa+4mu7AoMvZcmhMrZEiPZuZiqz9K9QbS5gHCzPw6ntvgG1IQX
        sb0e0H3YGnEj5t0lo4qH0NWK/Q6m2JWo4yJp3Vn5GescngoBwBf1a6xep7V1dId0vdm+Fq
        MoETgxvzwDbxr71dVEInUxQhv0Ct8z+/SRgdd/FxUXzgxFPE8a/I45qiVn5AJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAw3iiNKYMs7YXhTK+oHrE7mTiSbiNakd4j8jRewZtA=;
        b=jDjJae2Es86p8L53Ur6hqTJmlBJkhXDtEm8dDHMonrDZK2UlJhKWul3VcE8UKt9+oCIEam
        W/ys6aly2Cr8bUAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Mark arch_disable_smp_support() and
 bringup_nonboot_cpus() __init
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.551974164@linutronix.de>
References: <20230512205255.551974164@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820351.404.11737048171121591047.tip-bot2@tip-bot2>
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

Commit-ID:     ba831b7b1a517ba7f25d6fa9736a8092d07b0c74
Gitweb:        https://git.kernel.org/tip/ba831b7b1a517ba7f25d6fa9736a8092d07b0c74
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:47 +02:00

cpu/hotplug: Mark arch_disable_smp_support() and bringup_nonboot_cpus() __init

No point in keeping them around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.551974164@linutronix.de
---
 arch/x86/kernel/smpboot.c | 4 ++--
 kernel/cpu.c              | 2 +-
 kernel/smp.c              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index bca9692..8eb7721 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1269,9 +1269,9 @@ unreg_nmi:
 }
 
 /**
- * arch_disable_smp_support() - disables SMP support for x86 at runtime
+ * arch_disable_smp_support() - Disables SMP support for x86 at boottime
  */
-void arch_disable_smp_support(void)
+void __init arch_disable_smp_support(void)
 {
 	disable_ioapic_support();
 }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f4a2c58..c0d859c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1502,7 +1502,7 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 	return 0;
 }
 
-void bringup_nonboot_cpus(unsigned int setup_max_cpus)
+void __init bringup_nonboot_cpus(unsigned int setup_max_cpus)
 {
 	unsigned int cpu;
 
diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5da..71dce74 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -892,7 +892,7 @@ EXPORT_SYMBOL(setup_max_cpus);
  * SMP mode to <NUM>.
  */
 
-void __weak arch_disable_smp_support(void) { }
+void __weak __init arch_disable_smp_support(void) { }
 
 static int __init nosmp(char *str)
 {
