Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C026E6DCDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDJXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDJXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3DB213A;
        Mon, 10 Apr 2023 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168302; x=1712704302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8tkH3Bjh5/XGpnX2lOKu5HgHTZmmicSiTnYUuWTuPqQ=;
  b=lHRqCK6LzO9G+NbONBgNxIYSUHxoX+l5wwvnH3BnfAMBxI1NUpjJ2FrB
   hISoghDU/y8gYWu7PvuVPaa4ulA+GQqzE6dF3UPKqzBug72jqTRQKxwMx
   DVNaneJyQcxTeZHMZi96Frl8wCph7sEyKZOburBQtIFpqo2FaFVEQ2E6S
   jXV+ZryAoKhQHPyQGyUM12VWU3KlHHjut5dQlAfpBArb19JFg2uZvtD+L
   URYD+/d6TvwG7qzc9kzR6TbsYtht0pXtjqHtJbo45+7WMnf3XFMtKqd1j
   /8pkSe1vxiYLt8W1SCqkO8jtkR2AuZI4PFf1uIcv13qtfMLa7IaX9tMCs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962554"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962554"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757608008"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757608008"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 16:11:40 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping key at boot-time
Date:   Mon, 10 Apr 2023 15:59:31 -0700
Message-Id: <20230410225936.8940-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410225936.8940-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Internal Wrapping Key (IWKey) is an entity of Key Locker to encode a
clear text key into a key handle. This key is a pivot in protecting user
keys. So the value has to be randomized before being loaded in the
software-invisible CPU state.

IWKey needs to be established before the first user. Given that the only
proposed Linux use case for Key Locker is dm-crypt, the feature could be
lazily enabled when the first dm-crypt user arrives, but there is no
precedent for late enabling of CPU features and it adds maintenance burden
without demonstrative benefit outside of minimizing the visibility of
Key Locker to userspace.

The kernel generates random bytes and load them at boot time. These bytes
are flushed out immediately.

Setting the CR4.KL bit does not always enable the feature so ensure the
dynamic CPU bit (CPUID.AESKLE) is set before loading the key.

Given that the Linux Key Locker support is only intended for bare metal
dm-crypt consumption, and that switching IWKey per VM is untenable,
explicitly skip Key Locker setup in the X86_FEATURE_HYPERVISOR case.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
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
index e85dfb6c1524..820ac29c06d9 100644
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
+#define setup_keylocker(c) do { } while (0)
+#define destroy_keylocker_data() do { } while (0)
+#endif
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b366641703e3..20babbaf8c0c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
+obj-$(CONFIG_X86_KEYLOCKER)		+= keylocker.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ea06b0b4570..a1edd5997e0a 100644
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
@@ -1874,10 +1876,11 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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
index 000000000000..2519102f72f1
--- /dev/null
+++ b/arch/x86/kernel/keylocker.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Setup Key Locker feature and support internal wrapping key
+ * management.
+ */
+
+#include <linux/random.h>
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
+	memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
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
index 851477f7d728..880ed9cc8c53 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -84,6 +84,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 #include <asm/sev.h>
+#include <asm/keylocker.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1500,6 +1501,7 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 	nmi_selftest();
 	impress_friends();
 	cache_aps_init();
+	destroy_keylocker_data();
 }
 
 static int __initdata setup_possible_cpus = -1;
-- 
2.17.1

