Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5C6DFF69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDLUKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDLUJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:09:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28565B8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:09:56 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0121D1EC053F;
        Wed, 12 Apr 2023 22:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681330195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=huWboU1Yi3NkXP9KSNXtGd4bxkYqu44nKppsfg4n+qs=;
        b=GUmvjBZYIXf1oCxdYqdDWriacQ8eP15Mq85UYVTap6LY7CNHhaP/Qj3xnyOS6gyNTtR74d
        RVwiE9lw8nQtx5L7AGooKEHA1GMXTHK5TdlYbcQ1/0EiUXlguI0wXGKM0uOv4S0oXiwFIo
        B1ouMv7KJkPNL9yPkIbmNEXLLRJxaDA=
Date:   Wed, 12 Apr 2023 22:09:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 08/15] x86/mtrr: have only one set_mtrr() variant
Message-ID: <20230412200950.GCZDcQDj3f6TTv2qvL@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-9-jgross@suse.com>
 <20230412123044.GJZDakdLatRW26J+1k@fat_crate.local>
 <a8523ee6-6c1b-07f3-41ce-b6f28eeeeee4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8523ee6-6c1b-07f3-41ce-b6f28eeeeee4@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:56:33PM +0200, Juergen Gross wrote:
> I'm not sure the comment is accurate ("has no MTRR" is a bad way
> to say that X86_FEATURE_MTRR is 0, BTW).

Yeah, this comment is from see below.

The commit message is, as expected, useless. And that comment part
reads, at least to me, like, "maybe we should do this but I don't know,
perhaps, no hw to try this on".

I.e., this is for all those MTRR implementations which are different
from Intel's MTRR spec and are so old that they couldn't possibly have
had SMP. I.e., those are ooold single core machines.

The second part of the comment is not sure whether those machines could
even handle suspend/resume...

And I'm willing to bet good money, this code won't ever run on real hw
anymore because all that real hw is long dead and buried.

> The main point is that mtrr_restore() is called with interrupts off
> and before any other potential CPUs are started again.

Yes. I am only making sure that you mean what I think you mean and
trying to get you to be more verbose in your commit messages.

:-)

Thx.

---

commit 3b520b238e018ef0e9d11c9115d5e7d9419c4ef9
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Thu Jul 7 17:56:38 2005 -0700

    [PATCH] MTRR suspend/resume cleanup
    
    There has been some discuss about solving the SMP MTRR suspend/resume
    breakage, but I didn't find a patch for it.  This is an intent for it.  The
    basic idea is moving mtrr initializing into cpu_identify for all APs (so it
    works for cpu hotplug).  For BP, restore_processor_state is responsible for
    restoring MTRR.
    
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Acked-by: Andi Kleen <ak@muc.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
index 2203a9d20212..4553ffd94b1f 100644
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -435,6 +435,11 @@ void __devinit identify_cpu(struct cpuinfo_x86 *c)
 	if (c == &boot_cpu_data)
 		sysenter_setup();
 	enable_sep_cpu();
+
+	if (c == &boot_cpu_data)
+		mtrr_bp_init();
+	else
+		mtrr_ap_init();
 }
 
 #ifdef CONFIG_X86_HT
diff --git a/arch/i386/kernel/cpu/mtrr/generic.c b/arch/i386/kernel/cpu/mtrr/generic.c
index 64d91f73a0a4..169ac8e0db68 100644
--- a/arch/i386/kernel/cpu/mtrr/generic.c
+++ b/arch/i386/kernel/cpu/mtrr/generic.c
@@ -67,13 +67,6 @@ void __init get_mtrr_state(void)
 	mtrr_state.enabled = (lo & 0xc00) >> 10;
 }
 
-/*  Free resources associated with a struct mtrr_state  */
-void __init finalize_mtrr_state(void)
-{
-	kfree(mtrr_state.var_ranges);
-	mtrr_state.var_ranges = NULL;
-}
-
 /*  Some BIOS's are fucked and don't set all MTRRs the same!  */
 void __init mtrr_state_warn(void)
 {
@@ -334,6 +327,9 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 */
 {
 	unsigned long flags;
+	struct mtrr_var_range *vr;
+
+	vr = &mtrr_state.var_ranges[reg];
 
 	local_irq_save(flags);
 	prepare_set();
@@ -342,11 +338,15 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 		/* The invalid bit is kept in the mask, so we simply clear the
 		   relevant mask register to disable a range. */
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), 0, 0);
+		memset(vr, 0, sizeof(struct mtrr_var_range));
 	} else {
-		mtrr_wrmsr(MTRRphysBase_MSR(reg), base << PAGE_SHIFT | type,
-		      (base & size_and_mask) >> (32 - PAGE_SHIFT));
-		mtrr_wrmsr(MTRRphysMask_MSR(reg), -size << PAGE_SHIFT | 0x800,
-		      (-size & size_and_mask) >> (32 - PAGE_SHIFT));
+		vr->base_lo = base << PAGE_SHIFT | type;
+		vr->base_hi = (base & size_and_mask) >> (32 - PAGE_SHIFT);
+		vr->mask_lo = -size << PAGE_SHIFT | 0x800;
+		vr->mask_hi = (-size & size_and_mask) >> (32 - PAGE_SHIFT);
+
+		mtrr_wrmsr(MTRRphysBase_MSR(reg), vr->base_lo, vr->base_hi);
+		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
 	}
 
 	post_set();
diff --git a/arch/i386/kernel/cpu/mtrr/main.c b/arch/i386/kernel/cpu/mtrr/main.c
index d66b09e0c820..764cac64e211 100644
--- a/arch/i386/kernel/cpu/mtrr/main.c
+++ b/arch/i386/kernel/cpu/mtrr/main.c
@@ -332,6 +332,8 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 
 	error = -EINVAL;
 
+	/* No CPU hotplug when we change MTRR entries */
+	lock_cpu_hotplug();
 	/*  Search for existing MTRR  */
 	down(&main_lock);
 	for (i = 0; i < num_var_ranges; ++i) {
@@ -372,6 +374,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	error = i;
  out:
 	up(&main_lock);
+	unlock_cpu_hotplug();
 	return error;
 }
 
@@ -461,6 +464,8 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 		return -ENXIO;
 
 	max = num_var_ranges;
+	/* No CPU hotplug when we change MTRR entries */
+	lock_cpu_hotplug();
 	down(&main_lock);
 	if (reg < 0) {
 		/*  Search for existing MTRR  */
@@ -501,6 +506,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 	error = reg;
  out:
 	up(&main_lock);
+	unlock_cpu_hotplug();
 	return error;
 }
 /**
@@ -544,21 +550,9 @@ static void __init init_ifs(void)
 	centaur_init_mtrr();
 }
 
-static void __init init_other_cpus(void)
-{
-	if (use_intel())
-		get_mtrr_state();
-
-	/* bring up the other processors */
-	set_mtrr(~0U,0,0,0);
-
-	if (use_intel()) {
-		finalize_mtrr_state();
-		mtrr_state_warn();
-	}
-}
-
-
+/* The suspend/resume methods are only for CPU without MTRR. CPU using generic
+ * MTRR driver doesn't require this
+ */
 struct mtrr_value {
 	mtrr_type	ltype;
 	unsigned long	lbase;
@@ -611,13 +605,13 @@ static struct sysdev_driver mtrr_sysdev_driver = {
 
 
 /**
- * mtrr_init - initialize mtrrs on the boot CPU
+ * mtrr_bp_init - initialize mtrrs on the boot CPU
  *
  * This needs to be called early; before any of the other CPUs are 
  * initialized (i.e. before smp_init()).
  * 
  */
-static int __init mtrr_init(void)
+void __init mtrr_bp_init(void)
 {
 	init_ifs();
 
@@ -674,12 +668,48 @@ static int __init mtrr_init(void)
 	if (mtrr_if) {
 		set_num_var_ranges();
 		init_table();
-		init_other_cpus();
-
-		return sysdev_driver_register(&cpu_sysdev_class,
-					      &mtrr_sysdev_driver);
+		if (use_intel())
+			get_mtrr_state();
 	}
-	return -ENXIO;
 }
 
-subsys_initcall(mtrr_init);
+void mtrr_ap_init(void)
+{
+	unsigned long flags;
+
+	if (!mtrr_if || !use_intel())
+		return;
+	/*
+	 * Ideally we should hold main_lock here to avoid mtrr entries changed,
+	 * but this routine will be called in cpu boot time, holding the lock
+	 * breaks it. This routine is called in two cases: 1.very earily time
+	 * of software resume, when there absolutely isn't mtrr entry changes;
+	 * 2.cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug lock to
+	 * prevent mtrr entry changes
+	 */
+	local_irq_save(flags);
+
+	mtrr_if->set_all();
+
+	local_irq_restore(flags);
+}
+
+static int __init mtrr_init_finialize(void)
+{
+	if (!mtrr_if)
+		return 0;
+	if (use_intel())
+		mtrr_state_warn();
+	else {
+		/* The CPUs haven't MTRR and seemes not support SMP. They have
+		 * specific drivers, we use a tricky method to support
+		 * suspend/resume for them.
+		 * TBD: is there any system with such CPU which supports
+		 * suspend/resume?  if no, we should remove the code.
+		 */
+		sysdev_driver_register(&cpu_sysdev_class,
+			&mtrr_sysdev_driver);
+	}
+	return 0;
+}
+subsys_initcall(mtrr_init_finialize);
diff --git a/arch/i386/kernel/cpu/mtrr/mtrr.h b/arch/i386/kernel/cpu/mtrr/mtrr.h
index de1351245599..99c9f2682041 100644
--- a/arch/i386/kernel/cpu/mtrr/mtrr.h
+++ b/arch/i386/kernel/cpu/mtrr/mtrr.h
@@ -91,7 +91,6 @@ extern struct mtrr_ops * mtrr_if;
 
 extern unsigned int num_var_ranges;
 
-void finalize_mtrr_state(void);
 void mtrr_state_warn(void);
 char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
diff --git a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c
index 0e6b45b61251..c547c1af6fa1 100644
--- a/arch/i386/power/cpu.c
+++ b/arch/i386/power/cpu.c
@@ -137,6 +137,7 @@ void __restore_processor_state(struct saved_context *ctxt)
 
 	fix_processor_context();
 	do_fpu_end();
+	mtrr_ap_init();
 }
 
 void restore_processor_state(void)
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index b02d921da4f7..5fd03225058a 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -1076,6 +1076,10 @@ void __cpuinit identify_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_MCE
 	mcheck_init(c);
 #endif
+	if (c == &boot_cpu_data)
+		mtrr_bp_init();
+	else
+		mtrr_ap_init();
 #ifdef CONFIG_NUMA
 	if (c != &boot_cpu_data)
 		numa_add_cpu(c - cpu_data);
diff --git a/arch/x86_64/kernel/suspend.c b/arch/x86_64/kernel/suspend.c
index 6c0f402e3a88..0612640d91b1 100644
--- a/arch/x86_64/kernel/suspend.c
+++ b/arch/x86_64/kernel/suspend.c
@@ -119,6 +119,7 @@ void __restore_processor_state(struct saved_context *ctxt)
 	fix_processor_context();
 
 	do_fpu_end();
+	mtrr_ap_init();
 }
 
 void restore_processor_state(void)
diff --git a/include/asm-i386/processor.h b/include/asm-i386/processor.h
index 6f0f93d0d417..5d06e6bd6ba0 100644
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -694,4 +694,12 @@ extern unsigned long boot_option_idle_override;
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
+#ifdef CONFIG_MTRR
+extern void mtrr_ap_init(void);
+extern void mtrr_bp_init(void);
+#else
+#define mtrr_ap_init() do {} while (0)
+#define mtrr_bp_init() do {} while (0)
+#endif
+
 #endif /* __ASM_I386_PROCESSOR_H */
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index f2f073642d62..6c813eb521f3 100644
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -15,6 +15,13 @@ extern void pda_init(int);
 extern void early_idt_handler(void);
 
 extern void mcheck_init(struct cpuinfo_x86 *c);
+#ifdef CONFIG_MTRR
+extern void mtrr_ap_init(void);
+extern void mtrr_bp_init(void);
+#else
+#define mtrr_ap_init() do {} while (0)
+#define mtrr_bp_init() do {} while (0)
+#endif
 extern void init_memory_mapping(unsigned long start, unsigned long end);
 
 extern void system_call(void); 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
