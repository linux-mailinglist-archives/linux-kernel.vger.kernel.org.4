Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92B270FC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjEXRLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbjEXRKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB718C;
        Wed, 24 May 2023 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948224; x=1716484224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=46ODicMEHTm3WSA9Zthp4yjDFP1jOE55xd09xeCbdG8=;
  b=a40fkCs8WDErTtd0sOmUDvdZI6OJ4s4DHSB9VF4O+d76FlSDFcAX3bmw
   Uea8T0iIX96X2VrOPUsDAdB8NevMZ4+MciiTakqiWmhO2xY7Y3acqx387
   w3bkyY9qa2aSXNr25h7qQSL4SvVDEojFfXXwNqEqT06vA15OomKCdsXZx
   3JCTg7sX58LU2BhoXmI4YMYtIGd66czgMcBK3NBx5vBBE8rH2L60eb/hS
   61Y2O1c7T4iVZ0XXFFKjigOnk1p7OyQ0OdriFYl3hY4uTaNmdabRdmXog
   j8PwaJKWbSkyBnyquQUewyGHfdM5BJkt9+l7vvKI8fOgtzEHlwbXqqghD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338206755"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338206755"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704427361"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704427361"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 10:09:54 -0700
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
Subject: [PATCH v7 08/12] x86/PM/keylocker: Restore the wrapping key on the resume from ACPI S3/4
Date:   Wed, 24 May 2023 09:57:13 -0700
Message-Id: <20230524165717.14062-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230524165717.14062-1-chang.seok.bae@intel.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

