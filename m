Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B573381E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbjFPS2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbjFPS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:27:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8963A89;
        Fri, 16 Jun 2023 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686940074; x=1718476074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zEVnmX99I2MJ6rQrCRB0AQ3FXUujATL09To6bcMprnE=;
  b=KPRWe+s1M2plJGfan4TfB+8NKiCGPZsQs7DcZNaF34asM+vmlgzRxi1d
   mPf3iPoaJM9LTV1Hd2O0NZI+jGmdCbNqztjX7ESKOLHMCC+kMxTJMFK0A
   aW89UdiXJQJ4l2L/4RCx45bR+hJlHSMaaxCVIKV8VImekD5+ZzOeTK9Dx
   parPL1H68yFlMVin9NvVBXrQe8CmWTqI+eHlvaCgYkQGImP+lvz8mEtY+
   eiPzjXWfe2r9+PEDzNARtmIEA/YQSI42dqj3YBEdBD4t3H3xCJpJBCKob
   v3Wm2YxBFJf5RqkhruIXdToa8QRzWvj07J5FoYWZKM78fYz6huo9ijFvn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="361815203"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="361815203"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="783018178"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="783018178"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:27:51 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 4/4] x86/mce: Handle Intel threshold interrupt storms
Date:   Fri, 16 Jun 2023 11:27:44 -0700
Message-Id: <20230616182744.17632-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616182744.17632-1-tony.luck@intel.com>
References: <20230411173841.70491-1-tony.luck@intel.com>
 <20230616182744.17632-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Intel specific hook into machine_check_poll() to keep track
of per-CPU, per-bank corrected error logs (with a stub for the
CONFIG_MCE_INTEL=n case).

When a storm is observed the Rate of interrupts is reduced by setting
a large threshold value for this bank in IA32_MCi_CTL2. This bank is
added to the bitmap of banks for this CPU to poll. The polling rate
is increased to once per second.

When a storm ends reset the
threshold in IA32_MCi_CTL2 back to 1, removes the bank from the bitmap
for polling, and changes the polling rate back to the default.

If a CPU with banks in storm mode is taken offline, the new CPU
that inherits ownership of those banks takes over management of
storm(s) in the inherited bank(s).

The cmci_discover() function was already very large. These changes
pushed it well over the top. Refactor with three helper functions
to braing it back under control.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/internal.h |   2 +
 arch/x86/kernel/cpu/mce/core.c     |   3 +
 arch/x86/kernel/cpu/mce/intel.c    | 202 +++++++++++++++++++++--------
 3 files changed, 156 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 22899d28138f..1cd112f94028 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -43,12 +43,14 @@ extern mce_banks_t mce_banks_ce_disabled;
 void track_cmci_storm(int bank, u64 status);
 
 #ifdef CONFIG_X86_MCE_INTEL
+void mce_intel_handle_storm(int bank, bool on);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 #else
+static inline void mce_intel_handle_storm(int bank, bool on) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d4c9dc194d56..bc5137c0c47b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2055,6 +2055,9 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
 void mce_handle_storm(int bank, bool on)
 {
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_INTEL:
+		mce_intel_handle_storm(bank, on);
+		break;
 	case X86_VENDOR_AMD:
 		mce_amd_handle_storm(bank, on);
 		break;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 052bf2708391..83bb800e408d 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -47,8 +47,27 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
  */
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
+/* Linux non-storm CMCI threshold (may be overridden by BIOS) */
 #define CMCI_THRESHOLD		1
 
+/*
+ * MCi_CTL2 threshold for each bank when there is no storm.
+ * Default value for each bank may have been set by BIOS.
+ */
+static int cmci_threshold[MAX_NR_BANKS];
+
+/*
+ * High threshold to limit CMCI rate during storms. Max supported is
+ * 0x7FFF. Use this slightly smaller value so it has a distinctive
+ * signature when some asks "Why am I not seeing all corrected errors?"
+ * A high threshold is used instead of just disabling CMCI for a
+ * bank because both corrected and uncorrected errors may be logged
+ * in the same bank and signalled with CMCI. The threshold only applies
+ * to corrected errors, so keeping CMCI enabled means that uncorrected
+ * errors will still be processed in a timely fashion.
+ */
+#define CMCI_STORM_THRESHOLD	32749
+
 static int cmci_supported(int *banks)
 {
 	u64 cap;
@@ -103,6 +122,31 @@ static bool lmce_supported(void)
 	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
+/*
+ * Set a new CMCI threshold value. Preserve the state of the
+ * MCI_CTL2_CMCI_EN bit in case this happens during a
+ * cmci_rediscover() operation.
+ */
+static void cmci_set_threshold(int bank, int thresh)
+{
+	unsigned long flags;
+	u64 val;
+
+	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
+	wrmsrl(MSR_IA32_MCx_CTL2(bank), val | thresh);
+	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
+}
+
+void mce_intel_handle_storm(int bank, bool on)
+{
+	if (on)
+		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+	else
+		cmci_set_threshold(bank, cmci_threshold[bank]);
+}
+
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
@@ -114,72 +158,126 @@ static void intel_threshold_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_banks_owned));
 }
 
+/*
+ * Check all the reasons why current CPU cannot claim
+ * ownership of a bank.
+ * 1: CPU already owns this bank
+ * 2: BIOS owns this bank
+ * 3: Some other CPU owns this bank
+ */
+static bool cmci_skip_bank(int bank, u64 *val)
+{
+	unsigned long *owned = (void *)this_cpu_ptr(&mce_banks_owned);
+
+	if (test_bit(bank, owned))
+		return true;
+
+	/* Skip banks in firmware first mode */
+	if (test_bit(bank, mce_banks_ce_disabled))
+		return true;
+
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), *val);
+
+	/* Already owned by someone else? */
+	if (*val & MCI_CTL2_CMCI_EN) {
+		clear_bit(bank, owned);
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Decide which CMCI interrupt threshold to use:
+ * 1: If this bank is in storm mode from whichever CPU was
+ *    the previous owner, stay in storm mode.
+ * 2: If ignoring any threshold set by BIOS, set Linux default
+ * 3: Try to honor BIOS threshold (unless buggy BIOS set it at zero).
+ */
+static u64 cmci_pick_threshold(u64 val, int *bios_zero_thresh)
+{
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+		return val;
+
+	if (!mca_cfg.bios_cmci_threshold) {
+		val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
+		val |= CMCI_THRESHOLD;
+	} else if (!(val & MCI_CTL2_CMCI_THRESHOLD_MASK)) {
+		/*
+		 * If bios_cmci_threshold boot option was specified
+		 * but the threshold is zero, we'll try to initialize
+		 * it to 1.
+		 */
+		*bios_zero_thresh = 1;
+		val |= CMCI_THRESHOLD;
+	}
+
+	return val;
+}
+
+/*
+ * Try to claim ownership of a bank.
+ */
+static void cmci_claim_bank(int bank, u64 val, int bios_zero_thresh, int *bios_wrong_thresh)
+{
+	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
+
+	val |= MCI_CTL2_CMCI_EN;
+	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
+	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
+
+	/* Did the enable bit stick? -- the bank supports CMCI */
+	if (val & MCI_CTL2_CMCI_EN) {
+		set_bit(bank, (void *)this_cpu_ptr(&mce_banks_owned));
+		if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {
+			pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), bank);
+			storm->bank_history[bank] = ~0ull;
+			storm->bank_time_stamp[bank] = jiffies;
+			cmci_storm_begin(bank);
+		} else {
+			__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+		}
+		/*
+		 * We are able to set thresholds for some banks that
+		 * had a threshold of 0. This means the BIOS has not
+		 * set the thresholds properly or does not work with
+		 * this boot option. Note down now and report later.
+		 */
+		if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
+		    (val & MCI_CTL2_CMCI_THRESHOLD_MASK))
+			*bios_wrong_thresh = 1;
+
+		/* Save default threshold for each bank */
+		if (cmci_threshold[bank] == 0)
+			cmci_threshold[bank] = val & MCI_CTL2_CMCI_THRESHOLD_MASK;
+	} else {
+		WARN_ON(!test_bit(bank, this_cpu_ptr(mce_poll_banks)));
+	}
+}
+
 /*
  * Enable CMCI (Corrected Machine Check Interrupt) for available MCE banks
  * on this CPU. Use the algorithm recommended in the SDM to discover shared
- * banks.
+ * banks. Called during initial bootstrap, and also for hotplug CPU operations
+ * to rediscover/reassign machine check banks.
  */
 static void cmci_discover(int banks)
 {
-	unsigned long *owned = (void *)this_cpu_ptr(&mce_banks_owned);
-	unsigned long flags;
-	int i;
 	int bios_wrong_thresh = 0;
+	unsigned long flags;
+	int i;
 
 	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
 	for (i = 0; i < banks; i++) {
 		u64 val;
 		int bios_zero_thresh = 0;
 
-		if (test_bit(i, owned))
+		if (cmci_skip_bank(i, &val))
 			continue;
 
-		/* Skip banks in firmware first mode */
-		if (test_bit(i, mce_banks_ce_disabled))
-			continue;
-
-		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
-
-		/* Already owned by someone else? */
-		if (val & MCI_CTL2_CMCI_EN) {
-			clear_bit(i, owned);
-			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
-			continue;
-		}
-
-		if (!mca_cfg.bios_cmci_threshold) {
-			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
-			val |= CMCI_THRESHOLD;
-		} else if (!(val & MCI_CTL2_CMCI_THRESHOLD_MASK)) {
-			/*
-			 * If bios_cmci_threshold boot option was specified
-			 * but the threshold is zero, we'll try to initialize
-			 * it to 1.
-			 */
-			bios_zero_thresh = 1;
-			val |= CMCI_THRESHOLD;
-		}
-
-		val |= MCI_CTL2_CMCI_EN;
-		wrmsrl(MSR_IA32_MCx_CTL2(i), val);
-		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
-
-		/* Did the enable bit stick? -- the bank supports CMCI */
-		if (val & MCI_CTL2_CMCI_EN) {
-			set_bit(i, owned);
-			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
-			/*
-			 * We are able to set thresholds for some banks that
-			 * had a threshold of 0. This means the BIOS has not
-			 * set the thresholds properly or does not work with
-			 * this boot option. Note down now and report later.
-			 */
-			if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
-					(val & MCI_CTL2_CMCI_THRESHOLD_MASK))
-				bios_wrong_thresh = 1;
-		} else {
-			WARN_ON(!test_bit(i, this_cpu_ptr(mce_poll_banks)));
-		}
+		val = cmci_pick_threshold(val, &bios_zero_thresh);
+		cmci_claim_bank(i, val, bios_zero_thresh, &bios_wrong_thresh);
 	}
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 	if (mca_cfg.bios_cmci_threshold && bios_wrong_thresh) {
@@ -218,6 +316,8 @@ static void __cmci_disable_bank(int bank)
 	val &= ~MCI_CTL2_CMCI_EN;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+		cmci_storm_end(bank);
 }
 
 /*
-- 
2.40.1

