Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4F7210EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjFCPf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFCPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:35:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D8418D;
        Sat,  3 Jun 2023 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685806508; x=1717342508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=46ODicMEHTm3WSA9Zthp4yjDFP1jOE55xd09xeCbdG8=;
  b=K56conYw8KH4AhcXPf/iSuv9kXq6MLFOMug7n9qdou/f8ZmcGhpoJJ/n
   Cql18qTb/Q5RxSlrUl3A3CoCfwV6JzBBGlxoU6gtzLX+zvv608bmr2zwo
   A4tDgr6hi2F9fN6iMOOs1bZuOWwzb0fVgSS9xgWazCYUFUPwy2oqFikXO
   xU+Cr92/ABSx8FRJCzl49Eo1pz8LArRu+4hD+vp65SGymytv5APDxFv0s
   yLXCYj2L27G8+1r8lVJZRk3JzJw0+ixSLRap0eAAvPukHYX0u1JjZDqZe
   lsjH8TRVIGw/2/PHOaMuWMRggt4+yEANUn4+rOv2vRYj446cU4AxgWZ01
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="356097479"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="356097479"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 08:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="702274269"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="702274269"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2023 08:35:07 -0700
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
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v8 08/12] x86/PM/keylocker: Restore the wrapping key on the resume from ACPI S3/4
Date:   Sat,  3 Jun 2023 08:22:23 -0700
Message-Id: <20230603152227.12335-9-chang.seok.bae@intel.com>
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

The primary use case for the feature is bare metal dm-crypt. The key
needs to be restored properly on wakeup, as dm-crypt does not prompt
for the key on resume from suspend. Even if the prompt performs for
unlocking the volume, where the hibernation image is stored, it still
expects to reuse the key handles within the hibernation image once it
is loaded.

== Wrapping-key Restore ==

So it is motivated to meet dm-crypt's expectation that the key handles
in the suspend-image remain valid after resume from an S-state. But,
when the system enters the ACPI S3 or S4 sleep states, the wrapping
key is discarded.

Key Locker provides a mechanism to back up the wrapping key in
non-volatile storage. So, request a backup right after the key is
loaded at boot time, and copy it back to each CPU upon wakeup. Then,
the entirety of Key Locker has to be disabled if the backup mechanism
is not available unless CONFIG_SUSPEND=n.

== Restore Failure ==

In the event of a key restore failure, the kernel proceeds with an
initialized wrapping key state. This has the effect of invalidating
any key handles that might be present in a suspend-image. When this
happens, dm-crypt will see I/O errors resulting from error returns
from crypto_skcipher_encrypt()/decrypt().

While this will disrupt operations in the current boot, data is not at
risk and access is restored with new handles created by the new
wrapping key at the next boot. Also, manage a feature-specific flag to
communicate with the crypto implementation. This ensures to stop using
the AES instructions upon the key restore failure while not turning
off the feature.

== Off-states ==

While the backup may be maintained in non-volatile media across S5 and
G3 "off" states, it is neither architecturally guaranteed nor it is
expected by dm-crypt as prompting for the key whenever the volume is
started. Then, a reboot can cover this case with a new wrapping key.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
Changes from v6:
* Limit the symbol export only when needed.
* Improve the coding style -- reduce an indent after
  'if() { ... return; }'. (Eric Biggers)
* Fix the coding style -- reduce an indent after if() {...return;}.
  (Eric Biggers) Tweak the comment along with that.
* Improve the function prototype, instead of using a macro. (Eric
  Biggers and Dave Hansen)
* Update the documentation:
  - Massage the changelog to clarify the problem-and-solution by
    sections
  - Clarify the comment about the key restore failure.

Changes from v5:
* Fix the 'valid_kl' flag not to be set when the feature is disabled.
  (Reported by Marvin Hsu marvin.hsu@intel.com) Add the function
  comment about this.
* Improve the error handling in setup_keylocker(). All the error cases
  fall through the end that disables the feature. Otherwise, all the
  successful cases return immediately.

Changes from v4:
* Update the changelog and title. (Rafael Wysocki)

Changes from v3:
* Fix the build issue with !X86_KEYLOCKER. (Eric Biggers)

Changes from RFC v2:
* Change the backup key failure handling. (Dan Williams)

Changes from RFC v1:
* Folded the warning message into the if condition check. (Rafael
  Wysocki)
* Rebased on the changes of the previous patches.
* Added error code for key restoration failures.
* Moved the restore helper.
* Added function descriptions.
---
 arch/x86/include/asm/keylocker.h |   4 +
 arch/x86/kernel/keylocker.c      | 136 ++++++++++++++++++++++++++++++-
 arch/x86/power/cpu.c             |   2 +
 3 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 9040e10ab648..8621234c5897 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -32,9 +32,13 @@ struct iwkey {
 #ifdef CONFIG_X86_KEYLOCKER
 void setup_keylocker(struct cpuinfo_x86 *c);
 void destroy_keylocker_data(void);
+void restore_keylocker(void);
+extern bool valid_keylocker(void);
 #else
 static inline void setup_keylocker(struct cpuinfo_x86 *c) { }
 static inline void destroy_keylocker_data(void) { }
+static inline void restore_keylocker(void) { }
+static inline bool valid_keylocker(void) { return false; }
 #endif
 
 #endif /*__ASSEMBLY__ */
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 038e5268e6b8..8f3acc34b6da 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -11,20 +11,48 @@
 #include <asm/fpu/api.h>
 #include <asm/keylocker.h>
 #include <asm/tlbflush.h>
+#include <asm/msr.h>
 
 static __initdata struct keylocker_setup_data {
+	bool initialized;
 	struct iwkey key;
 } kl_setup;
 
+/*
+ * This flag is set with wrapping key load. When the key restore
+ * fails, it is reset. This restore state is exported to the crypto
+ * library, then Key Locker will not be used there. So, the feature is
+ * soft-disabled with this flag.
+ */
+static bool valid_kl;
+
+bool valid_keylocker(void)
+{
+	return valid_kl;
+}
+#if IS_MODULE(CONFIG_CRYPTO_AES_KL)
+EXPORT_SYMBOL_GPL(valid_keylocker);
+#endif
+
 static void __init generate_keylocker_data(void)
 {
 	get_random_bytes(&kl_setup.key.integrity_key,  sizeof(kl_setup.key.integrity_key));
 	get_random_bytes(&kl_setup.key.encryption_key, sizeof(kl_setup.key.encryption_key));
 }
 
+/*
+ * This is invoked when the boot-up is finished, which means wrapping
+ * key is loaded. Then, the 'valid_kl' flag is set here as the feature
+ * is enabled.
+ */
 void __init destroy_keylocker_data(void)
 {
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
+		return;
+
 	memzero_explicit(&kl_setup.key, sizeof(kl_setup.key));
+	kl_setup.initialized = true;
+	valid_kl = true;
 }
 
 static void __init load_keylocker(void)
@@ -34,6 +62,27 @@ static void __init load_keylocker(void)
 	kernel_fpu_end();
 }
 
+/**
+ * copy_keylocker - Copy the wrapping key from the backup.
+ *
+ * Request hardware to copy the key in non-volatile storage to the CPU
+ * state.
+ *
+ * Returns:	-EBUSY if the copy fails, 0 if successful.
+ */
+static int copy_keylocker(void)
+{
+	u64 status;
+
+	wrmsrl(MSR_IA32_COPY_IWKEY_TO_LOCAL, 1);
+
+	rdmsrl(MSR_IA32_IWKEY_COPY_STATUS, status);
+	if (status & BIT(0))
+		return 0;
+	else
+		return -EBUSY;
+}
+
 /**
  * setup_keylocker - Enable the feature.
  * @c:		A pointer to struct cpuinfo_x86
@@ -52,6 +101,7 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 
 	if (c == &boot_cpu_data) {
 		u32 eax, ebx, ecx, edx;
+		bool backup_available;
 
 		cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
 		/*
@@ -65,13 +115,53 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 			goto disable;
 		}
 
+		backup_available = !!(ebx & KEYLOCKER_CPUID_EBX_BACKUP);
+		/*
+		 * The wrapping key in CPU state is volatile in S3/4
+		 * states. So ensure the backup capability along with
+		 * S-states.
+		 */
+		if (!backup_available && IS_ENABLED(CONFIG_SUSPEND)) {
+			pr_debug("x86/keylocker: No key backup support with possible S3/4.\n");
+			goto disable;
+		}
+
 		generate_keylocker_data();
+		load_keylocker();
+
+		/* Backup a wrapping key in non-volatile media. */
+		if (backup_available)
+			wrmsrl(MSR_IA32_BACKUP_IWKEY_TO_PLATFORM, 1);
+
+		pr_info("x86/keylocker: Enabled.\n");
+		return;
 	}
 
-	load_keylocker();
+	/*
+	 * At boot time, the key is loaded directly from the memory.
+	 * Otherwise, this path performs the key recovery on each CPU
+	 * wake-up. Then, the backup in the platform-scoped state is
+	 * copied to the CPU state.
+	 */
+	if (!kl_setup.initialized) {
+		load_keylocker();
+		return;
+	} else if (valid_kl) {
+		int rc;
 
-	pr_info_once("x86/keylocker: Enabled.\n");
-	return;
+		rc = copy_keylocker();
+		if (!rc)
+			return;
+
+		/*
+		 * The key copy failed here. The subsequent feature
+		 * use will have inconsistent keys and failures. So,
+		 * invalidate the feature via the flag like with the
+		 * backup failure.
+		 */
+		valid_kl = false;
+		pr_err_once("x86/keylocker: Invalid copy status (rc: %d).\n", rc);
+	}
 
 disable:
 	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
@@ -80,3 +170,43 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 	/* Make sure the feature disabled for kexec-reboot. */
 	cr4_clear_bits(X86_CR4_KEYLOCKER);
 }
+
+/**
+ * restore_keylocker - Restore the wrapping key.
+ *
+ * The boot CPU executes this while other CPUs restore it through the
+ * setup function.
+ */
+void restore_keylocker(void)
+{
+	u64 backup_status;
+	int rc;
+
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER) || !valid_kl)
+		return;
+
+	/*
+	 * The IA32_IWKEYBACKUP_STATUS MSR contains a bitmap that
+	 * indicates an invalid backup if bit 0 is set and a read (or
+	 * write) error if bit 2 is set.
+	 */
+	rdmsrl(MSR_IA32_IWKEY_BACKUP_STATUS, backup_status);
+	if (backup_status & BIT(0)) {
+		rc = copy_keylocker();
+		if (rc)
+			pr_err("x86/keylocker: Invalid copy state (rc: %d).\n", rc);
+		else
+			return;
+	} else {
+		pr_err("x86/keylocker: The key backup access failed with %s.\n",
+		       (backup_status & BIT(2)) ? "read error" : "invalid status");
+	}
+
+	/*
+	 * Now the backup key is not available. Invalidate the feature
+	 * via the flag to avoid any subsequent use. But keep the
+	 * feature with zeroed wrapping key instead of disabling it.
+	 */
+	pr_err("x86/keylocker: Failed to restore wrapping key.\n");
+	valid_kl = false;
+}
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 63230ff8cf4f..e99be45354cd 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
+#include <asm/keylocker.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -264,6 +265,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	x86_platform.restore_sched_clock_state();
 	cache_bp_restore();
 	perf_restore_debug_store();
+	restore_keylocker();
 
 	c = &cpu_data(smp_processor_id());
 	if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
-- 
2.17.1

