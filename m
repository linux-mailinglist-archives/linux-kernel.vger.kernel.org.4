Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A70601234
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiJQO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiJQO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80156B168;
        Mon, 17 Oct 2022 07:56:03 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXoAAQQ7PXxcDd0SeRPf5Rlo3hZbRsnZX6YYQQxynd8=;
        b=fJn+/FbNCujxKENYC4oXvn4YNkM6AKLDA+sWfX6ZmHNPN10BJwAdSyv96nZHdr8rvTQhBc
        CSOqOMGMxrM6pil+GfGJ5sObCme8lRHHKEc0noj39KrK7GcOisTBfAZpT8mI0oGFUcAiWw
        RgaQt4ou+cSnt96JPyFTBoN5DsDBOEu29ABWEGebMXaboEbTpkfLiK2yH2UGeNee1zOF4b
        LpcZHOty8QKfZhFOqe4ZHscYWeGMUCFA0WcVc8O4cnjgckq+dfTI/XeyhFbwVoSFEjaPEB
        tOdZpYopgzSnJ9p5HP0MecCmSL+PnY1rU6RtDZ/nekJwC2Sn6s6+c+lpnzzXQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXoAAQQ7PXxcDd0SeRPf5Rlo3hZbRsnZX6YYQQxynd8=;
        b=uvagcZMQPLE6DkNt6V49C+uAOIeEB548Jrk235pAqO+w+slJlQLANZpWtq5pnN+yhWfGvq
        WkDS8zcswVMNYzBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Remove segment load from switch_to_new_gdt()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111143.097052006@infradead.org>
References: <20220915111143.097052006@infradead.org>
MIME-Version: 1.0
Message-ID: <166601847113.401.13616810593513367893.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b5636d45aae42aa345b4c7918bdef245ed63da68
Gitweb:        https://git.kernel.org/tip/b5636d45aae42aa345b4c7918bdef245ed63da68
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:10:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:40:56 +02:00

x86/cpu: Remove segment load from switch_to_new_gdt()

On 32bit FS and on 64bit GS segments are already set up correctly, but
load_percpu_segment() still sets [FG]S after switching from the early GDT
to the direct GDT.

For 32bit the segment load has no side effects, but on 64bit it causes
GSBASE to become 0, which means that any per CPU access before GSBASE is
set to the new value is going to fault. That's the reason why the whole
file containing this code has stackprotector removed.

But that's a pointless exercise for both 32 and 64 bit as the relevant
segment selector is already correct. Loading the new GDT does not change
that.

Remove the segment loads and add comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.097052006@infradead.org
---
 arch/x86/include/asm/processor.h |  1 +-
 arch/x86/kernel/cpu/common.c     | 47 ++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73..e21ec97 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -670,7 +670,6 @@ extern struct desc_ptr		early_gdt_descr;
 extern void switch_to_new_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
-extern void load_percpu_segment(int);
 extern void cpu_init(void);
 extern void cpu_init_secondary(void);
 extern void cpu_init_exception_handling(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f2..c09abee 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -701,16 +701,6 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
 __u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 __u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
-void load_percpu_segment(int cpu)
-{
-#ifdef CONFIG_X86_32
-	loadsegment(fs, __KERNEL_PERCPU);
-#else
-	__loadsegment_simple(gs, 0);
-	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
-#endif
-}
-
 #ifdef CONFIG_X86_32
 /* The 32-bit entry code needs to find cpu_entry_area. */
 DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
@@ -738,16 +728,41 @@ void load_fixmap_gdt(int cpu)
 }
 EXPORT_SYMBOL_GPL(load_fixmap_gdt);
 
-/*
- * Current gdt points %fs at the "master" per-cpu area: after this,
- * it's on the real one.
+/**
+ * switch_to_new_gdt - Switch form early GDT to the direct one
+ * @cpu:	The CPU number for which this is invoked
+ *
+ * Invoked during early boot to switch from early GDT and early per CPU
+ * (%fs on 32bit, GS_BASE on 64bit) to the direct GDT and the runtime per
+ * CPU area.
  */
 void switch_to_new_gdt(int cpu)
 {
-	/* Load the original GDT */
 	load_direct_gdt(cpu);
-	/* Reload the per-cpu base */
-	load_percpu_segment(cpu);
+
+#ifdef CONFIG_X86_64
+	/*
+	 * No need to load %gs. It is already correct.
+	 *
+	 * Writing %gs on 64bit would zero GSBASE which would make any per
+	 * CPU operation up to the point of the wrmsrl() fault.
+	 *
+	 * Set GSBASE to the new offset. Until the wrmsrl() happens the
+	 * early mapping is still valid. That means the GSBASE update will
+	 * lose any prior per CPU data which was not copied over in
+	 * setup_per_cpu_areas().
+	 */
+	wrmsrl(MSR_GS_BASE, cpu_kernelmode_gs_base(cpu));
+#else
+	/*
+	 * %fs is already set to __KERNEL_PERCPU, but after switching GDT
+	 * it is required to load FS again so that the 'hidden' part is
+	 * updated from the new GDT. Up to this point the early per CPU
+	 * translation is active. Any content of the early per CPU data
+	 * which was not copied over in setup_per_cpu_areas() is lost.
+	 */
+	loadsegment(fs, __KERNEL_PERCPU);
+#endif
 }
 
 static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] = {};
