Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D3D6ED429
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjDXSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjDXSNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1CA6EAC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:13:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682360010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yPopGSGIvjVTqV5otbjNJCXhWeHJlpzmAsrgnKvj3lY=;
        b=VQP1e7M5rZkurFyo7oK2zlh6ubkG+v0gLLbzetUa5daYixb6YrvCNzHf85AB2vvCUuRhiM
        jai2heCh2WwMNCbXjY+rmS6XDMNdC2kaTTe/rahy4pjw2Kbs7goECQybtpkQqx327d2qWR
        kikVPHaduEka+8Xvav5SycB64k07mp4V0JBNuwE6jPsH6mL+JevnO7THOvurTBhC2x4ZHC
        RXL6Yj0BUlHmOhV/b8nqwszLFeFiDw93u7WM/ih23qzeoE5VLxravlXdETT0Dstmn/yq/B
        qkvqH0NUD5n4Vtkx2W7sE6xyNP2u8s8XgAsh0pKGPJwGF7Peh6eOS+mWoq681A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682360010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yPopGSGIvjVTqV5otbjNJCXhWeHJlpzmAsrgnKvj3lY=;
        b=AgzxV5RpVNGEU1DmiWfyJ1to1Zxz1WmOLEyiMd/RTyeNpL06+C9QvQ4em7xgY6Y+LPgf7G
        KxWBiHXKYBl5idBg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for 6.4-rc1
References: <168235968801.840202.17752066425816055574.tglx@xen13>
Message-ID: <168235969391.840202.8176231027101593470.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 24 Apr 2023 20:13:29 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2023-04=
-24

up to:  5af507bef93c: x86/ioapic: Don't return 0 from arch_dynirq_lower_bound=
()


x86 APIC updates:

 - Fix the incorrect handling of atomic offset updates in
   reserve_eilvt_offset()

   The check for the return value of atomic_cmpxchg() is not compared
   against the old value, it is compared against the new value, which
   makes it two round on success.

   Convert it to atomic_try_cmpxchg() which does the right thing.


 - Handle IO/APIC less systems correctly

   When IO/APIC is not advertised by ACPI then the computation of the lower
   bound for dynamically allocated interrupts like MSI goes wrong.

   This lower bound is used to exclude the IO/APIC legacy GSI space as that
   must stay reserved for the legacy interrupts.

   In case that the system, e.g. VM, does not advertise an IO/APIC the
   lower bound stays at 0.

   0 is an invalid interrupt number except for the legacy timer interrupt
   on x86. The return value is unchecked in the core code, so it ends up
   to allocate interrupt number 0 which is subsequently considered to be
   invalid by the caller, e.g. the MSI allocation code.

   A similar problem was already cured for device tree based systems years
   ago, but that missed - or did not envision - the zero IO/APIC case.

   Consolidate the zero check and return the provided "from" argument to the
   core code call site, which is guaranteed to be greater than 0.


 - Simplify the X2APIC cluster CPU mask logic for CPU hotplug

   Per cluster CPU masks are required for X2APIC in cluster mode to
   determine the correct cluster for a target CPU when calculating the
   destination for IPIs

   These masks are established when CPUs are borught up. The first CPU in a
   cluster must allocate a new cluster CPU mask. As this happens during the
   early startup of a CPU, where memory allocations cannot be done, the
   mask has to be allocated by the control CPU.

   The current implementation allocates a clustermask just in case and if
   the to be brought up CPU is the first in a cluster the CPU takes over
   this allocation from a global pointer.

   This works nicely in the fully serialized CPU bringup scenario which is
   used today, but would fail completely for parallel bringup of CPUs.

   The cluster association of a CPU can be computed from the APIC ID which
   is enumerated by ACPI/MADT.

   So the cluster CPU masks can be preallocated and associated upfront and
   the upcoming CPUs just need to set their corresponding bit.

   Aside of preparing for parallel bringup this is a valuable
   simplification on its own.


 - Remove global variables which control the early startup of secondary
   CPUs on 64-bit

   The only information which is needed by a starting CPU is the Linux CPU
   number. The CPU number allows it to retrieve the rest of the required
   data from already existing per CPU storage.

   So instead of initial_stack, early_gdt_desciptor and initial_gs provide
   a new variable smpboot_control which contains the Linux CPU number for
   now. The starting CPU can retrieve and compute all required information
   for startup from there.

   Aside of being a cleanup, this is also preparing for parallel CPU
   bringup, where starting CPUs will look up their Linux CPU number via the
   APIC ID, when smpboot_control has the corresponding control bit set.


 - Make cc_vendor globally accesible

   Subsequent parallel bringup changes require access to cc_vendor because
   confidental computing platforms need special treatment in the early
   startup phase vs. CPUID and APCI ID readouts.

   The change makes cc_vendor global and provides stub accessors in case
   that CONFIG_ARCH_HAS_CC_PLATFORM is not set.

   This was merged from the x86/cc branch in anticipation of further
   parallel bringup commits which require access to cc_vendor. Due to late
   discoveries of fundamental issue with those patches these commits never
   happened.

   The merge commit is unfortunately in the middle of the APIC commits so
   unraveling it would have required a rebase or revert. As the parallel
   bringup seems to be well on its way for 6.5 this would be just pointless
   churn. As the commit does not contain any functional change it's not a
   risk to keep it.

Thanks,

	tglx

------------------>
Borislav Petkov (AMD) (1):
      x86/coco: Export cc_vendor

Brian Gerst (3):
      x86/smpboot: Remove initial_stack on 64-bit
      x86/smpboot: Remove early_gdt_descr on 64-bit
      x86/smpboot: Remove initial_gs

David Woodhouse (2):
      x86/apic/x2apic: Allow CPU cluster_mask to be populated in parallel
      x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()

Saurabh Sengar (1):
      x86/ioapic: Don't return 0 from arch_dynirq_lower_bound()

Uros Bizjak (1):
      x86/apic: Fix atomic update of offset in reserve_eilvt_offset()


 arch/x86/coco/core.c                  |  13 ++--
 arch/x86/include/asm/coco.h           |  23 ++++++-
 arch/x86/include/asm/processor.h      |   6 +-
 arch/x86/include/asm/realmode.h       |   1 -
 arch/x86/include/asm/smp.h            |   5 +-
 arch/x86/kernel/acpi/sleep.c          |  23 +++++--
 arch/x86/kernel/apic/apic.c           |   5 +-
 arch/x86/kernel/apic/io_apic.c        |  14 ++--
 arch/x86/kernel/apic/x2apic_cluster.c | 126 ++++++++++++++++++++++----------=
--
 arch/x86/kernel/asm-offsets.c         |   1 +
 arch/x86/kernel/head_64.S             |  72 ++++++++++---------
 arch/x86/kernel/smpboot.c             |  30 +++++---
 arch/x86/xen/xen-head.S               |   2 +-
 13 files changed, 205 insertions(+), 116 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f881484..684f0a910475 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
=20
-static enum cc_vendor vendor __ro_after_init;
+enum cc_vendor cc_vendor __ro_after_init;
 static u64 cc_mask __ro_after_init;
=20
 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -83,7 +83,7 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
=20
 bool cc_platform_has(enum cc_attr attr)
 {
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
 	case CC_VENDOR_INTEL:
@@ -105,7 +105,7 @@ u64 cc_mkenc(u64 val)
 	 * - for AMD, bit *set* means the page is encrypted
 	 * - for Intel *clear* means encrypted.
 	 */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val | cc_mask;
 	case CC_VENDOR_INTEL:
@@ -118,7 +118,7 @@ u64 cc_mkenc(u64 val)
 u64 cc_mkdec(u64 val)
 {
 	/* See comment in cc_mkenc() */
-	switch (vendor) {
+	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val & ~cc_mask;
 	case CC_VENDOR_INTEL:
@@ -129,11 +129,6 @@ u64 cc_mkdec(u64 val)
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
=20
-__init void cc_set_vendor(enum cc_vendor v)
-{
-	vendor =3D v;
-}
-
 __init void cc_set_mask(u64 mask)
 {
 	cc_mask =3D mask;
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..91b9448ffe76 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -11,13 +11,30 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
=20
-void cc_set_vendor(enum cc_vendor v);
-void cc_set_mask(u64 mask);
-
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern enum cc_vendor cc_vendor;
+
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return cc_vendor;
+}
+
+static inline void cc_set_vendor(enum cc_vendor vendor)
+{
+	cc_vendor =3D vendor;
+}
+
+void cc_set_mask(u64 mask);
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
+static inline enum cc_vendor cc_get_vendor(void)
+{
+	return CC_VENDOR_NONE;
+}
+
+static inline void cc_set_vendor(enum cc_vendor vendor) { }
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 8d73004e4cac..a1e4fa58b357 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -647,7 +647,11 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
=20
 #else
-#define INIT_THREAD { }
+extern unsigned long __end_init_task[];
+
+#define INIT_THREAD {							    \
+	.sp	=3D (unsigned long)&__end_init_task - sizeof(struct pt_regs), \
+}
=20
 extern unsigned long KSTK_ESP(struct task_struct *task);
=20
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index a336feef0af1..f6a1737c77be 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -59,7 +59,6 @@ extern struct real_mode_header *real_mode_header;
 extern unsigned char real_mode_blob_end[];
=20
 extern unsigned long initial_code;
-extern unsigned long initial_gs;
 extern unsigned long initial_stack;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern unsigned long initial_vc_handler;
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4dbb20dab1a..bf2c51df9e0b 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -199,5 +199,8 @@ extern void nmi_selftest(void);
 #define nmi_selftest() do { } while (0)
 #endif
=20
-#endif /* __ASSEMBLY__ */
+extern unsigned int smpboot_control;
+
+#endif /* !__ASSEMBLY__ */
+
 #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 3b7f4cdbf2e0..1328c221af30 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -111,13 +111,26 @@ int x86_acpi_suspend_lowlevel(void)
 	saved_magic =3D 0x12345678;
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
-	initial_stack =3D (unsigned long)temp_stack + sizeof(temp_stack);
-	early_gdt_descr.address =3D
-			(unsigned long)get_cpu_gdt_rw(smp_processor_id());
-	initial_gs =3D per_cpu_offset(smp_processor_id());
+	/*
+	 * As each CPU starts up, it will find its own stack pointer
+	 * from its current_task->thread.sp. Typically that will be
+	 * the idle thread for a newly-started AP, or even the boot
+	 * CPU which will find it set to &init_task in the static
+	 * per-cpu data.
+	 *
+	 * Make the resuming CPU use the temporary stack at startup
+	 * by setting current->thread.sp to point to that. The true
+	 * %rsp will be restored with the rest of the CPU context,
+	 * by do_suspend_lowlevel(). And unwinders don't care about
+	 * the abuse of ->thread.sp because it's a dead variable
+	 * while the thread is running on the CPU anyway; the true
+	 * value is in the actual %rsp register.
+	 */
+	current->thread.sp =3D (unsigned long)temp_stack + sizeof(temp_stack);
+	smpboot_control =3D smp_processor_id();
 #endif
 	initial_code =3D (unsigned long)wakeup_long64;
-       saved_magic =3D 0x123456789abcdef0L;
+	saved_magic =3D 0x123456789abcdef0L;
 #endif /* CONFIG_64BIT */
=20
 	/*
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 20d9a604da7c..770557110051 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -422,10 +422,9 @@ static unsigned int reserve_eilvt_offset(int offset, uns=
igned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd =3D atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd !=3D new);
+	} while (!atomic_try_cmpxchg(&eilvt_offsets[offset], &rsvd, new));
=20
-	rsvd &=3D ~APIC_EILVT_MASKED;
+	rsvd =3D new & ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd !=3D vector)
 		pr_info("LVT offset %d assigned for vector 0x%02x\n",
 			offset, rsvd);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1f83b052bb74..f980b38b0227 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2477,17 +2477,21 @@ static int io_apic_get_redir_entries(int ioapic)
=20
 unsigned int arch_dynirq_lower_bound(unsigned int from)
 {
+	unsigned int ret;
+
 	/*
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	if (!ioapic_initialized)
-		return gsi_top;
+	ret =3D ioapic_dynirq_base ? : gsi_top;
+
 	/*
-	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
-	 * updated. So simply return @from if ioapic_dynirq_base =3D=3D 0.
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
+	 * always 0. gsi_top can be 0 if there is no IO/APIC registered.
+	 * 0 is an invalid interrupt number for dynamic allocations. Return
+	 * @from instead.
 	 */
-	return ioapic_dynirq_base ? : from;
+	return ret ? : from;
 }
=20
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2a=
pic_cluster.c
index e696e22d0531..b2b2b7f3e03f 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -9,11 +9,7 @@
=20
 #include "local.h"
=20
-struct cluster_mask {
-	unsigned int	clusterid;
-	int		node;
-	struct cpumask	mask;
-};
+#define apic_cluster(apicid) ((apicid) >> 4)
=20
 /*
  * __x2apic_send_IPI_mask() possibly needs to read
@@ -23,8 +19,7 @@ struct cluster_mask {
 static u32 *x86_cpu_to_logical_apicid __read_mostly;
=20
 static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
-static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
-static struct cluster_mask *cluster_hotplug_mask;
+static DEFINE_PER_CPU_READ_MOSTLY(struct cpumask *, cluster_masks);
=20
 static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
@@ -60,10 +55,10 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int ve=
ctor, int apic_dest)
=20
 	/* Collapse cpus in a cluster so a single IPI per cluster is sent */
 	for_each_cpu(cpu, tmpmsk) {
-		struct cluster_mask *cmsk =3D per_cpu(cluster_masks, cpu);
+		struct cpumask *cmsk =3D per_cpu(cluster_masks, cpu);
=20
 		dest =3D 0;
-		for_each_cpu_and(clustercpu, tmpmsk, &cmsk->mask)
+		for_each_cpu_and(clustercpu, tmpmsk, cmsk)
 			dest |=3D x86_cpu_to_logical_apicid[clustercpu];
=20
 		if (!dest)
@@ -71,7 +66,7 @@ __x2apic_send_IPI_mask(const struct cpumask *mask, int vect=
or, int apic_dest)
=20
 		__x2apic_send_IPI_dest(dest, vector, APIC_DEST_LOGICAL);
 		/* Remove cluster CPUs from tmpmask */
-		cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
+		cpumask_andnot(tmpmsk, tmpmsk, cmsk);
 	}
=20
 	local_irq_restore(flags);
@@ -105,55 +100,98 @@ static u32 x2apic_calc_apicid(unsigned int cpu)
=20
 static void init_x2apic_ldr(void)
 {
-	struct cluster_mask *cmsk =3D this_cpu_read(cluster_masks);
-	u32 cluster, apicid =3D apic_read(APIC_LDR);
-	unsigned int cpu;
+	struct cpumask *cmsk =3D this_cpu_read(cluster_masks);
=20
-	x86_cpu_to_logical_apicid[smp_processor_id()] =3D apicid;
+	BUG_ON(!cmsk);
=20
-	if (cmsk)
-		goto update;
-
-	cluster =3D apicid >> 16;
-	for_each_online_cpu(cpu) {
-		cmsk =3D per_cpu(cluster_masks, cpu);
-		/* Matching cluster found. Link and update it. */
-		if (cmsk && cmsk->clusterid =3D=3D cluster)
-			goto update;
+	cpumask_set_cpu(smp_processor_id(), cmsk);
+}
+
+/*
+ * As an optimisation during boot, set the cluster_mask for all present
+ * CPUs at once, to prevent each of them having to iterate over the others
+ * to find the existing cluster_mask.
+ */
+static void prefill_clustermask(struct cpumask *cmsk, unsigned int cpu, u32 =
cluster)
+{
+	int cpu_i;
+
+	for_each_present_cpu(cpu_i) {
+		struct cpumask **cpu_cmsk =3D &per_cpu(cluster_masks, cpu_i);
+		u32 apicid =3D apic->cpu_present_to_apicid(cpu_i);
+
+		if (apicid =3D=3D BAD_APICID || cpu_i =3D=3D cpu || apic_cluster(apicid) !=
=3D cluster)
+			continue;
+
+		if (WARN_ON_ONCE(*cpu_cmsk =3D=3D cmsk))
+			continue;
+
+		BUG_ON(*cpu_cmsk);
+		*cpu_cmsk =3D cmsk;
 	}
-	cmsk =3D cluster_hotplug_mask;
-	cmsk->clusterid =3D cluster;
-	cluster_hotplug_mask =3D NULL;
-update:
-	this_cpu_write(cluster_masks, cmsk);
-	cpumask_set_cpu(smp_processor_id(), &cmsk->mask);
 }
=20
-static int alloc_clustermask(unsigned int cpu, int node)
+static int alloc_clustermask(unsigned int cpu, u32 cluster, int node)
 {
+	struct cpumask *cmsk =3D NULL;
+	unsigned int cpu_i;
+
+	/*
+	 * At boot time, the CPU present mask is stable. The cluster mask is
+	 * allocated for the first CPU in the cluster and propagated to all
+	 * present siblings in the cluster. If the cluster mask is already set
+	 * on entry to this function for a given CPU, there is nothing to do.
+	 */
 	if (per_cpu(cluster_masks, cpu))
 		return 0;
+
+	if (system_state < SYSTEM_RUNNING)
+		goto alloc;
+
 	/*
-	 * If a hotplug spare mask exists, check whether it's on the right
-	 * node. If not, free it and allocate a new one.
+	 * On post boot hotplug for a CPU which was not present at boot time,
+	 * iterate over all possible CPUs (even those which are not present
+	 * any more) to find any existing cluster mask.
 	 */
-	if (cluster_hotplug_mask) {
-		if (cluster_hotplug_mask->node =3D=3D node)
-			return 0;
-		kfree(cluster_hotplug_mask);
+	for_each_possible_cpu(cpu_i) {
+		u32 apicid =3D apic->cpu_present_to_apicid(cpu_i);
+
+		if (apicid !=3D BAD_APICID && apic_cluster(apicid) =3D=3D cluster) {
+			cmsk =3D per_cpu(cluster_masks, cpu_i);
+			/*
+			 * If the cluster is already initialized, just store
+			 * the mask and return. There's no need to propagate.
+			 */
+			if (cmsk) {
+				per_cpu(cluster_masks, cpu) =3D cmsk;
+				return 0;
+			}
+		}
 	}
-
-	cluster_hotplug_mask =3D kzalloc_node(sizeof(*cluster_hotplug_mask),
-					    GFP_KERNEL, node);
-	if (!cluster_hotplug_mask)
+	/*
+	 * No CPU in the cluster has ever been initialized, so fall through to
+	 * the boot time code which will also populate the cluster mask for any
+	 * other CPU in the cluster which is (now) present.
+	 */
+alloc:
+	cmsk =3D kzalloc_node(sizeof(*cmsk), GFP_KERNEL, node);
+	if (!cmsk)
 		return -ENOMEM;
-	cluster_hotplug_mask->node =3D node;
+	per_cpu(cluster_masks, cpu) =3D cmsk;
+	prefill_clustermask(cmsk, cpu, cluster);
+
 	return 0;
 }
=20
 static int x2apic_prepare_cpu(unsigned int cpu)
 {
-	if (alloc_clustermask(cpu, cpu_to_node(cpu)) < 0)
+	u32 phys_apicid =3D apic->cpu_present_to_apicid(cpu);
+	u32 cluster =3D apic_cluster(phys_apicid);
+	u32 logical_apicid =3D (cluster << 16) | (1 << (phys_apicid & 0xf));
+
+	x86_cpu_to_logical_apicid[cpu] =3D logical_apicid;
+
+	if (alloc_clustermask(cpu, cluster, cpu_to_node(cpu)) < 0)
 		return -ENOMEM;
 	if (!zalloc_cpumask_var(&per_cpu(ipi_mask, cpu), GFP_KERNEL))
 		return -ENOMEM;
@@ -162,10 +200,10 @@ static int x2apic_prepare_cpu(unsigned int cpu)
=20
 static int x2apic_dead_cpu(unsigned int dead_cpu)
 {
-	struct cluster_mask *cmsk =3D per_cpu(cluster_masks, dead_cpu);
+	struct cpumask *cmsk =3D per_cpu(cluster_masks, dead_cpu);
=20
 	if (cmsk)
-		cpumask_clear_cpu(dead_cpu, &cmsk->mask);
+		cpumask_clear_cpu(dead_cpu, cmsk);
 	free_cpumask_var(per_cpu(ipi_mask, dead_cpu));
 	return 0;
 }
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 283dcd2f62c8..dc3576303f1a 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -115,6 +115,7 @@ static void __used common(void)
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
+	OFFSET(X86_current_task, pcpu_hot, current_task);
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 	OFFSET(X86_call_depth, pcpu_hot, call_depth);
 #endif
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 222efd4a09bc..6a8238702eab 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -61,23 +61,15 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * tables and then reload them.
 	 */
=20
-	/* Set up the stack for verify_cpu(), similar to initial_stack below */
-	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
+	/* Set up the stack for verify_cpu() */
+	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
=20
 	leaq	_text(%rip), %rdi
=20
-	/*
-	 * initial_gs points to initial fixed_percpu_data struct with storage for
-	 * the stack protector canary. Global pointer fixups are needed at this
-	 * stage, so apply them as is done in fixup_pointer(), and initialize %gs
-	 * such that the canary can be accessed at %gs:40 for subsequent C calls.
-	 */
+	/* Setup GSBASE to allow stack canary access for C code */
 	movl	$MSR_GS_BASE, %ecx
-	movq	initial_gs(%rip), %rax
-	movq	$_text, %rdx
-	subq	%rdx, %rax
-	addq	%rdi, %rax
-	movq	%rax, %rdx
+	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	movl	%edx, %eax
 	shrq	$32,  %rdx
 	wrmsr
=20
@@ -241,13 +233,36 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_G=
LOBAL)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // above
=20
+#ifdef CONFIG_SMP
+	movl	smpboot_control(%rip), %ecx
+
+	/* Get the per cpu offset for the given CPU# which is in ECX */
+	movq	__per_cpu_offset(,%rcx,8), %rdx
+#else
+	xorl	%edx, %edx /* zero-extended to clear all of RDX */
+#endif /* CONFIG_SMP */
+
+	/*
+	 * Setup a boot time stack - Any secondary CPU will have lost its stack
+	 * by now because the cr3-switch above unmaps the real-mode stack.
+	 *
+	 * RDX contains the per-cpu offset
+	 */
+	movq	pcpu_hot + X86_current_task(%rdx), %rax
+	movq	TASK_threadsp(%rax), %rsp
+
 	/*
 	 * We must switch to a new descriptor in kernel space for the GDT
 	 * because soon the kernel won't have access anymore to the userspace
 	 * addresses where we're currently running on. We have to do that here
 	 * because in 32bit we couldn't load a 64bit linear address.
 	 */
-	lgdt	early_gdt_descr(%rip)
+	subq	$16, %rsp
+	movw	$(GDT_SIZE-1), (%rsp)
+	leaq	gdt_page(%rdx), %rax
+	movq	%rax, 2(%rsp)
+	lgdt	(%rsp)
+	addq	$16, %rsp
=20
 	/* set up data segments */
 	xorl %eax,%eax
@@ -271,16 +286,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_G=
LOBAL)
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movl	initial_gs(%rip),%eax
-	movl	initial_gs+4(%rip),%edx
+#ifndef CONFIG_SMP
+	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+#endif
+	movl	%edx, %eax
+	shrq	$32, %rdx
 	wrmsr
=20
-	/*
-	 * Setup a boot time stack - Any secondary CPU will have lost its stack
-	 * by now because the cr3-switch above unmaps the real-mode stack
-	 */
-	movq initial_stack(%rip), %rsp
-
 	/* Setup and Load IDT */
 	pushq	%rsi
 	call	early_setup_idt
@@ -372,7 +384,11 @@ SYM_CODE_END(secondary_startup_64)
 SYM_CODE_START(start_cpu0)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_EMPTY
-	movq	initial_stack(%rip), %rsp
+
+	/* Find the idle task stack */
+	movq	PER_CPU_VAR(pcpu_hot) + X86_current_task, %rcx
+	movq	TASK_threadsp(%rcx), %rsp
+
 	jmp	.Ljump_to_C_code
 SYM_CODE_END(start_cpu0)
 #endif
@@ -416,16 +432,9 @@ SYM_CODE_END(vc_boot_ghcb)
 	__REFDATA
 	.balign	8
 SYM_DATA(initial_code,	.quad x86_64_start_kernel)
-SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
-
-/*
- * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
- * reliably detect the end of the stack.
- */
-SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
 	__FINITDATA
=20
 	__INIT
@@ -657,8 +666,7 @@ SYM_DATA_END(level1_fixmap_pgt)
 	.data
 	.align 16
=20
-SYM_DATA(early_gdt_descr,		.word GDT_ENTRIES*8-1)
-SYM_DATA_LOCAL(early_gdt_descr_base,	.quad INIT_PER_CPU_VAR(gdt_page))
+SYM_DATA(smpboot_control,		.long 0)
=20
 	.align 16
 /* This must match the first entry in level2_kernel_pgt */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9013bb28255a..851477f7d728 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -121,17 +121,20 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
=20
+
+static unsigned int smpboot_warm_reset_vector_count;
+
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
=20
 	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0xa, 0xf);
+	if (!smpboot_warm_reset_vector_count++) {
+		CMOS_WRITE(0xa, 0xf);
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =3D start=
_eip >> 4;
+		*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =3D start_=
eip & 0xf;
+	}
 	spin_unlock_irqrestore(&rtc_lock, flags);
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =3D
-							start_eip >> 4;
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =3D
-							start_eip & 0xf;
 }
=20
 static inline void smpboot_restore_warm_reset_vector(void)
@@ -143,10 +146,12 @@ static inline void smpboot_restore_warm_reset_vector(vo=
id)
 	 * to default values.
 	 */
 	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0, 0xf);
+	if (!--smpboot_warm_reset_vector_count) {
+		CMOS_WRITE(0, 0xf);
+		*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =3D 0;
+	}
 	spin_unlock_irqrestore(&rtc_lock, flags);
=20
-	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =3D 0;
 }
=20
 /*
@@ -1059,8 +1064,6 @@ int common_cpu_up(unsigned int cpu, struct task_struct =
*idle)
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
 	per_cpu(pcpu_hot.top_of_stack, cpu) =3D task_top_of_stack(idle);
-#else
-	initial_gs =3D per_cpu_offset(cpu);
 #endif
 	return 0;
 }
@@ -1086,9 +1089,14 @@ static int do_boot_cpu(int apicid, int cpu, struct tas=
k_struct *idle,
 		start_ip =3D real_mode_header->trampoline_start64;
 #endif
 	idle->thread.sp =3D (unsigned long)task_pt_regs(idle);
-	early_gdt_descr.address =3D (unsigned long)get_cpu_gdt_rw(cpu);
 	initial_code =3D (unsigned long)start_secondary;
-	initial_stack  =3D idle->thread.sp;
+
+	if (IS_ENABLED(CONFIG_X86_32)) {
+		early_gdt_descr.address =3D (unsigned long)get_cpu_gdt_rw(cpu);
+		initial_stack  =3D idle->thread.sp;
+	} else {
+		smpboot_control =3D cpu;
+	}
=20
 	/* Enable the espfix hack for this CPU */
 	init_espfix_ap(cpu);
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index e36ea4268bd2..91f7a53519a7 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
=20
-	mov initial_stack(%rip), %rsp
+	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
=20
 	/* Set up %gs.
 	 *

