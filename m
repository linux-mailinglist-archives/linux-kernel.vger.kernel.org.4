Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198976DCDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDJXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDJXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A352694;
        Mon, 10 Apr 2023 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168303; x=1712704303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OVcWEfHIwxJSYOH3PtUNQyn0mkISh7WF54jUMQ9NGf0=;
  b=hR9QD36cyQELP1j2wAI4/EAVDcDcUF++1lSJuzaeYWKpHwmdAkPfNi+5
   IFuBCPCt806EbcfhH0dG8jB0LcTP6n5010A7fxAr0JxdcmJmBPN+FLuBq
   85SwBX025khVGcX2dLgTMPAyfCw3/v+EY2BJMyAH+6nvrZj8EO56LptbN
   WJeVr3DX07zf9Nb0I62xIfBhGurcmddyReuxQgZNahVywgHeC129vy2bY
   qiy/6a5PultrulO+0pMTmvgrw28b9lO0TePxaKmjlNSlAG/fyTLHyhSJ0
   AUPOXur3fJA2ONsL+d5PCKmENVB3p0AMjdePxrxane6bMN12HnzP+I50S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962566"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962566"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757608012"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757608012"
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
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v6 08/12] x86/PM/keylocker: Restore internal wrapping key on resume from ACPI S3/4
Date:   Mon, 10 Apr 2023 15:59:32 -0700
Message-Id: <20230410225936.8940-9-chang.seok.bae@intel.com>
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

When the system enters the ACPI S3 or S4 sleep states, the internal
wrapping key is discarded.

The primary use case for the feature is bare metal dm-crypt. The key needs
to be restored properly on wakeup, as dm-crypt does not prompt for the key
on resume from suspend. Even the prompt it does perform for unlocking
the volume where the hibernation image is stored, it still expects to reuse
the key handles within the hibernation image once it is loaded. So it is
motivated to meet dm-crypt's expectation that the key handles in the
suspend-image remain valid after resume from an S-state.

Key Locker provides a mechanism to back up the internal wrapping key in
non-volatile storage. The kernel requests a backup right after the key is
loaded at boot time. It is copied back to each CPU upon wakeup.

While the backup may be maintained in NVM across S5 and G3 "off"
states it is not architecturally guaranteed, nor is it expected by dm-crypt
which expects to prompt for the key each time the volume is started.

The entirety of Key Locker needs to be disabled if the backup mechanism is
not available unless CONFIG_SUSPEND=n, otherwise dm-crypt requires the
backup to be available.

In the event of a key restore failure the kernel proceeds with an
initialized IWKey state. This has the effect of invalidating any key
handles that might be present in a suspend-image. When this happens
dm-crypt will see I/O errors resulting from error returns from
crypto_skcipher_{en,de}crypt(). While this will disrupt operations in the
current boot, data is not at risk and access is restored at the next reboot
to create new handles relative to the current IWKey.

Manage a feature-specific flag to communicate with the crypto
implementation. This ensures to stop using the AES instructions upon the
key restore failure while not turning off the feature.

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
 arch/x86/kernel/keylocker.c      | 138 ++++++++++++++++++++++++++++++-
 arch/x86/power/cpu.c             |   2 +
 3 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 820ac29c06d9..c1d27fb5a1c3 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -32,9 +32,13 @@ struct iwkey {
 #ifdef CONFIG_X86_KEYLOCKER
 void setup_keylocker(struct cpuinfo_x86 *c);
 void destroy_keylocker_data(void);
+void restore_keylocker(void);
+extern bool valid_keylocker(void);
 #else
 #define setup_keylocker(c) do { } while (0)
 #define destroy_keylocker_data() do { } while (0)
+#define restore_keylocker() do { } while (0)
+static inline bool valid_keylocker(void) { return false; }
 #endif
 
 #endif /*__ASSEMBLY__ */
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
index 2519102f72f1..72d075499067 100644
--- a/arch/x86/kernel/keylocker.c
+++ b/arch/x86/kernel/keylocker.c
@@ -11,20 +11,45 @@
 #include <asm/fpu/api.h>
 #include <asm/keylocker.h>
 #include <asm/tlbflush.h>
+#include <asm/msr.h>
 
 static __initdata struct keylocker_setup_data {
+	bool initialized;
 	struct iwkey key;
 } kl_setup;
 
+/*
+ * This flag is set with IWKey load. When the key restore fails, it is
+ * reset. This restore state is exported to the crypto library, then AES-KL
+ * will not be used there. So, the feature is soft-disabled with this flag.
+ */
+static bool valid_kl;
+
+bool valid_keylocker(void)
+{
+	return valid_kl;
+}
+EXPORT_SYMBOL_GPL(valid_keylocker);
+
 static void __init generate_keylocker_data(void)
 {
 	get_random_bytes(&kl_setup.key.integrity_key,  sizeof(kl_setup.key.integrity_key));
 	get_random_bytes(&kl_setup.key.encryption_key, sizeof(kl_setup.key.encryption_key));
 }
 
+/*
+ * This is invoked when the bootup is finished, which means IWKey is
+ * loaded. Then, the 'valid_kl' flag is set here when the feature is
+ * enabled.
+ */
 void __init destroy_keylocker_data(void)
 {
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
+		return;
+
 	memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
+	kl_setup.initialized = true;
+	valid_kl = true;
 }
 
 static void __init load_keylocker(void)
@@ -34,6 +59,27 @@ static void __init load_keylocker(void)
 	kernel_fpu_end();
 }
 
+/**
+ * copy_keylocker - Copy the internal wrapping key from the backup.
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
@@ -52,6 +98,7 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 
 	if (c == &boot_cpu_data) {
 		u32 eax, ebx, ecx, edx;
+		bool backup_available;
 
 		cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
 		/*
@@ -65,13 +112,54 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 			goto disable;
 		}
 
+		backup_available = !!(ebx & KEYLOCKER_CPUID_EBX_BACKUP);
+		/*
+		 * The internal wrapping key in CPU state is volatile in
+		 * S3/4 states. So ensure the backup capability along with
+		 * S-states.
+		 */
+		if (!backup_available && IS_ENABLED(CONFIG_SUSPEND)) {
+			pr_debug("x86/keylocker: No key backup support with possible S3/4.\n");
+			goto disable;
+		}
+
 		generate_keylocker_data();
-	}
+		load_keylocker();
 
-	load_keylocker();
+		/* Backup an internal wrapping key in non-volatile media. */
+		if (backup_available)
+			wrmsrl(MSR_IA32_BACKUP_IWKEY_TO_PLATFORM, 1);
 
-	pr_info_once("x86/keylocker: Enabled.\n");
-	return;
+		pr_info("x86/keylocker: Enabled.\n");
+		return;
+	} else {
+		int rc;
+
+		/*
+		 * Load the internal wrapping key directly when available
+		 * in memory, which is only possible at boot-time.
+		 *
+		 * NB: When system wakes up, this path also recovers the
+		 * internal wrapping key.
+		 */
+		if (!kl_setup.initialized) {
+			load_keylocker();
+			return;
+		} else if (valid_kl) {
+			rc = copy_keylocker();
+			if (!rc)
+				return;
+
+			/*
+			 * The boot CPU was successful but the key copy
+			 * fails here. Then, the subsequent feature use
+			 * will have inconsistent keys and failures. So,
+			 * invalidate the feature via the flag.
+			 */
+			valid_kl = false;
+			pr_err_once("x86/keylocker: Invalid copy status (rc: %d).\n", rc);
+		}
+	}
 
 disable:
 	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
@@ -80,3 +168,45 @@ void __ref setup_keylocker(struct cpuinfo_x86 *c)
 	/* Make sure the feature disabled for kexec-reboot. */
 	cr4_clear_bits(X86_CR4_KEYLOCKER);
 }
+
+/**
+ * restore_keylocker - Restore the internal wrapping key.
+ *
+ * The boot CPU executes this while other CPUs restore it through the setup
+ * function.
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
+	 * The IA32_IWKEYBACKUP_STATUS MSR contains a bitmap that indicates
+	 * an invalid backup if bit 0 is set and a read (or write) error if
+	 * bit 2 is set.
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
+	 * Now the backup key is not available. Invalidate the feature via
+	 * the flag to avoid any subsequent use. But keep the feature with
+	 * zero IWKeys instead of disabling it. The current users will see
+	 * key handle integrity failure but that's because of the internal
+	 * key change.
+	 */
+	pr_err("x86/keylocker: Failed to restore internal wrapping key.\n");
+	valid_kl = false;
+}
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 236447ee9beb..34d2cf946b13 100644
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

