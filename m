Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA07210EF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbjFCPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjFCPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:35:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC8B132;
        Sat,  3 Jun 2023 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685806507; x=1717342507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IpuMeJ7w9RTam7d1xIGHVCj5KBh4GD8Z4Cp8NyF1HVg=;
  b=WfKXeYjvzoLVsXAK7OoV8OkAYLJ+Z80DITWEuaOAeFmRjF8uKpVQpydZ
   UDDTK8dQajMCQtvoc4GCu8icPqOdZQz6QcLsMYxpJCezgNhYarrWkV15Z
   KqtBspCQ3tcCpdo3v2QXsLSc6tlj75Ld3URZYTfN55NStv5L/z2f1x4Ti
   5AADwet51vvujRB17PqqmNL7vZnrEVoTxi1Vngw7yFSMM0nopCIgf0ecM
   xAv5a6xwHiCl348lLIxs6ZImE2cOCXwJ5CasXtmbxP1hEuGTMjsFC1b58
   YCYQfVQFMBlnTp8WjxymQA68eM0sY+up8o6SilS/c4rTJ9PlTdPvPqAXk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="356097465"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="356097465"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 08:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="702274266"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="702274266"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2023 08:35:06 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        chang.seok.bae@intel.com, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v8 07/12] x86/cpu/keylocker: Load a wrapping key at boot-time
Date:   Sat,  3 Jun 2023 08:22:22 -0700
Message-Id: <20230603152227.12335-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230603152227.12335-1-chang.seok.bae@intel.com>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrapping key is an entity to encode a clear text key into a key
handle. This key is a pivot in protecting user keys. So the value has
to be randomized before being loaded in the software-invisible CPU
state.

The wrapping key needs to be established before the first user. Given
that the only proposed Linux use case for Key Locker is dm-crypt, the
feature could be lazily enabled when the first dm-crypt user arrives.

But there is no precedent for late enabling of CPU features and it
adds maintenance burden without demonstrative benefit outside of
minimizing the visibility of Key Locker to userspace.

Therefore, generate random bytes and load them at boot time. Ensure
the dynamic CPU bit (CPUID.AESKLE) is set before the load and flush
out these bytes after that.

Given that the Linux Key Locker support is only intended for bare
metal dm-crypt consumption, and that switching wrapping key per VM is
untenable, explicitly skip this setup in the X86_FEATURE_HYPERVISOR
case.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
* Switch to use 'static inline' for the empty functions, instead of
  macro that disallows type checks. (Eric Biggers and Dave Hansen)
* Use memzero_explicit() to wipe out the key data instead of writing
  the poison value over there. (Robert Elliott)
* Massage the changelog for the better readability.

Changes from v5:
* Call out the disabling when the feature is available on a virtual
  machine. Then, it will turn off the feature flag

Changes from RFC v2:
* Make bare metal only.
* Clean up the code (e.g. dynamically allocate the key cache).
  (Dan Williams)
* Massage the changelog.
* Move out the LOADIWKEY wrapper and the Key Locker CPUID defines.

Note, Dan wonders that given that the only proposed Linux use case for
Key Locker is dm-crypt, the feature could be lazily enabled when the
first dm-crypt user arrives, but as Dave notes there is no precedent
for late enabling of CPU features and it adds maintenance burden
without demonstrative benefit outside of minimizing the visibility of
Key Locker to userspace.
---
 arch/x86/include/asm/keylocker.h |  9 ++++
 arch/x86/kernel/Makefile         |  1 +
 arch/x86/kernel/cpu/common.c     |  5 +-
 arch/x86/kernel/keylocker.c      | 82 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c        |  2 +
 5 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/keylocker.c

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 1717e0866254..9040e10ab648 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -5,6 +5,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/processor.h>
 #include <linux/bits.h>
 #include <asm/fpu/types.h>
 
@@ -28,5 +29,13 @@ struct iwkey {
 #define KEYLOCKER_CPUID_EBX_WIDE	BIT(2)
 #define KEYLOCKER_CPUID_EBX_BACKUP	BIT(4)
 
+#ifdef CONFIG_X86_KEYLOCKER
+void setup_keylocker(struct cpuinfo_x86 *c);
+void destroy_keylocker_data(void);
+#else
+static inline void setup_keylocker(struct cpuinfo_x86 *c) { }
+static inline void destroy_keylocker_data(void) { }
+#endif
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4070a01c11b7..9e2647320dc6 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -134,6 +134,7 @@ obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
+obj-$(CONFIG_X86_KEYLOCKER)		+= keylocker.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f284e185aea..5882ff6e3c6b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -58,6 +58,8 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/keylocker.h>
+
 #include <asm/uv/uv.h>
 #include <asm/sigframe.h>
 #include <asm/traps.h>
@@ -1834,10 +1836,11 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
+	/* Setup various Intel-specific CPU security features */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_keylocker(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
new file mode 100644
index 000000000000..038e5268e6b8
--- /dev/null
+++ b/arch/x86/kernel/keylocker.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Setup Key Locker feature and support the wrapping key management.
+ */
+
+#include <linux/random.h>
+#include <linux/string.h>
+#include <linux/poison.h>
+
+#include <asm/fpu/api.h>
+#include <asm/keylocker.h>
+#include <asm/tlbflush.h>
+
+static __initdata struct keylocker_setup_data {
+	struct iwkey key;
+} kl_setup;
+
+static void __init generate_keylocker_data(void)
+{
+	get_random_bytes(&kl_setup.key.integrity_key,  sizeof(kl_setup.key.integrity_key));
+	get_random_bytes(&kl_setup.key.encryption_key, sizeof(kl_setup.key.encryption_key));
+}
+
+void __init destroy_keylocker_data(void)
+{
+	memzero_explicit(&kl_setup.key, sizeof(kl_setup.key));
+}
+
+static void __init load_keylocker(void)
+{
+	kernel_fpu_begin();
+	load_xmm_iwkey(&kl_setup.key);
+	kernel_fpu_end();
+}
+
+/**
+ * setup_keylocker - Enable the feature.
+ * @c:		A pointer to struct cpuinfo_x86
+ */
+void __ref setup_keylocker(struct cpuinfo_x86 *c)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
+		goto out;
+
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+		pr_debug("x86/keylocker: Not compatible with a hypervisor.\n");
+		goto disable;
+	}
+
+	cr4_set_bits(X86_CR4_KEYLOCKER);
+
+	if (c == &boot_cpu_data) {
+		u32 eax, ebx, ecx, edx;
+
+		cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
+		/*
+		 * Check the feature readiness via CPUID. Note that the
+		 * CPUID AESKLE bit is conditionally set only when CR4.KL
+		 * is set.
+		 */
+		if (!(ebx & KEYLOCKER_CPUID_EBX_AESKLE) ||
+		    !(eax & KEYLOCKER_CPUID_EAX_SUPERVISOR)) {
+			pr_debug("x86/keylocker: Not fully supported.\n");
+			goto disable;
+		}
+
+		generate_keylocker_data();
+	}
+
+	load_keylocker();
+
+	pr_info_once("x86/keylocker: Enabled.\n");
+	return;
+
+disable:
+	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
+	pr_info_once("x86/keylocker: Disabled.\n");
+out:
+	/* Make sure the feature disabled for kexec-reboot. */
+	cr4_clear_bits(X86_CR4_KEYLOCKER);
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ea4f4c1c74cd..13ebdb5fb6c4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -86,6 +86,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 #include <asm/sev.h>
+#include <asm/keylocker.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1371,6 +1372,7 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 	nmi_selftest();
 	impress_friends();
 	cache_aps_init();
+	destroy_keylocker_data();
 }
 
 static int __initdata setup_possible_cpus = -1;
-- 
2.17.1

