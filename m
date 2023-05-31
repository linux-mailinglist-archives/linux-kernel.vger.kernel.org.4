Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF76718563
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjEaO5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjEaO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:57:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47448C0;
        Wed, 31 May 2023 07:57:13 -0700 (PDT)
Date:   Wed, 31 May 2023 14:57:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685545031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mc/72IgAy/2O0TiRmrTvAV+VaixFt6yGvsNgTMrAUs=;
        b=OUZtwHuzuApJAqCk6uTHUh81FWcPiRbSrSkH8gOMt3Y3wITz8c24HJYXKwf//9gST1XC4E
        x1knZFUpDMk+FJEjlDE/Q4otHTbEiDhuQdCRRnaA5aWuWpkBOk31/YhzWzpTq3+lUdJHjT
        OSLlCG4u0jn0L1zxbb8WrVlbYRr3vcl0/TNybhSj8Yh/vmiU8ag9nMJmEv1cVkilCROfXs
        aztmDMU8FuMslHTfrYkeTQD9K0pOGHoDyj3ggPKUlKXmamSo6z1uuhMbVTQDnskvIaqPKZ
        zEF4kCUjy+Wr3xX1zzwZ7aLCismtoYmIvDbXxcfSwDDL3gmwFQxk6J3EWxWYvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685545031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mc/72IgAy/2O0TiRmrTvAV+VaixFt6yGvsNgTMrAUs=;
        b=mKyhs2FO5PnkjviSP/NWtOxwLTqpRylwtfXKprmva6s4+lgg2nzHTB01FJRPzmkxeMDcZs
        2KlvTXA3BqJH6GAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Fix the parallel bringup decision
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87ilc9gd2d.ffs@tglx>
References: <87ilc9gd2d.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168554503081.404.12282666738168010731.tip-bot2@tip-bot2>
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

Commit-ID:     ff3cfcb0d46adc541283a507560f88b7d7114dbe
Gitweb:        https://git.kernel.org/tip/ff3cfcb0d46adc541283a507560f88b7d7114dbe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 31 May 2023 09:44:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 31 May 2023 16:49:34 +02:00

x86/smpboot: Fix the parallel bringup decision

The decision to allow parallel bringup of secondary CPUs checks
CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
parallel bootup because accessing the local APIC is intercepted and raises
a #VC or #VE, which cannot be handled at that point.

The check works correctly, but only for AMD encrypted guests. TDX does not
set that flag.

As there is no real connection between CC attributes and the inability to
support parallel bringup, replace this with a generic control flag in
x86_cpuinit and let SEV-ES and TDX init code disable it.

Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/87ilc9gd2d.ffs@tglx

---
 arch/x86/coco/tdx/tdx.c         | 11 +++++++++++
 arch/x86/include/asm/x86_init.h |  3 +++
 arch/x86/kernel/smpboot.c       | 19 ++-----------------
 arch/x86/kernel/x86_init.c      |  1 +
 arch/x86/mm/mem_encrypt_amd.c   | 15 +++++++++++++++
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b59..27ce10c 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -871,5 +871,16 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
 
+	/*
+	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
+	 * bringup low level code. That raises #VE which cannot be handled
+	 * there.
+	 *
+	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
+	 * implemented seperately in the low level startup ASM code.
+	 * Until that is in place, disable parallel bringup for TDX.
+	 */
+	x86_cpuinit.parallel_bringup = false;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 88085f3..0bf4d73 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -177,11 +177,14 @@ struct x86_init_ops {
  * struct x86_cpuinit_ops - platform specific cpu hotplug setups
  * @setup_percpu_clockev:	set up the per cpu clock event device
  * @early_percpu_clock_init:	early init of the per cpu clock event device
+ * @fixup_cpu_id:		fixup function for cpuinfo_x86::phys_proc_id
+ * @parallel_bringup:		Parallel bringup control
  */
 struct x86_cpuinit_ops {
 	void (*setup_percpu_clockev)(void);
 	void (*early_percpu_clock_init)(void);
 	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
+	bool parallel_bringup;
 };
 
 struct timespec64;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 660709e..aaa876c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1267,23 +1267,8 @@ void __init smp_prepare_cpus_common(void)
 /* Establish whether parallel bringup can be supported. */
 bool __init arch_cpuhp_init_parallel_bringup(void)
 {
-	/*
-	 * Encrypted guests require special handling. They enforce X2APIC
-	 * mode but the RDMSR to read the APIC ID is intercepted and raises
-	 * #VC or #VE which cannot be handled in the early startup code.
-	 *
-	 * AMD-SEV does not provide a RDMSR GHCB protocol so the early
-	 * startup code cannot directly communicate with the secure
-	 * firmware. The alternative solution to retrieve the APIC ID via
-	 * CPUID(0xb), which is covered by the GHCB protocol, is not viable
-	 * either because there is no enforcement of the CPUID(0xb)
-	 * provided "initial" APIC ID to be the same as the real APIC ID.
-	 *
-	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
-	 * implemented seperately in the low level startup ASM code.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
-		pr_info("Parallel CPU startup disabled due to guest state encryption\n");
+	if (!x86_cpuinit.parallel_bringup) {
+		pr_info("Parallel CPU startup disabled by the platform\n");
 		return false;
 	}
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index d82f4fa..1da4baa 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -126,6 +126,7 @@ struct x86_init_ops x86_init __initdata = {
 struct x86_cpuinit_ops x86_cpuinit = {
 	.early_percpu_clock_init	= x86_init_noop,
 	.setup_percpu_clockev		= setup_secondary_APIC_clock,
+	.parallel_bringup		= true,
 };
 
 static void default_nmi_init(void) { };
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e0b51c0..4855e5f 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -501,6 +501,21 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
+
+	/*
+	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
+	 * parallel bringup low level code. That raises #VC which cannot be
+	 * handled there.
+	 * It does not provide a RDMSR GHCB protocol so the early startup
+	 * code cannot directly communicate with the secure firmware. The
+	 * alternative solution to retrieve the APIC ID via CPUID(0xb),
+	 * which is covered by the GHCB protocol, is not viable either
+	 * because there is no enforcement of the CPUID(0xb) provided
+	 * "initial" APIC ID to be the same as the real APIC ID.
+	 * Disable parallel bootup.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		x86_cpuinit.parallel_bringup = false;
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
