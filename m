Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8D36BEF81
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCQRU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCQRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:20:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD55AE1FC1;
        Fri, 17 Mar 2023 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679073651; x=1710609651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kpWJA5rZ2wraX+R6Au2wYAFUWO6WUqm6HQUcIiigFY=;
  b=g2gJOzMcI49ihFZExIvNIvz6QlsgWShf7pJHNFZxkX0tSVmwJorUyH0e
   q6U6bmsboUpVc/2LWe2IFEC/OAlqdXAIIGUFqmawvchGtqJ6pk/TZ71Hm
   n/WTVn4BTFn5WcTYqr4cL+pGI4hh4RQMbe3uut6+GXROyzJDpbvEb3+Di
   Faw7B5fqwTWMzI4Mlds6NdFWZZJZf200PBBd/rWs+Mysj7djc5ksYk0kE
   gAEIoG0xQ7JtoxZem2fNQZE4RtxhepG9VLq1Jp+qf5jDSHhE31Rfvo9TE
   HeIqWuM5FjS3R5J9qXKcBhgPYEQckgiwdCR0Jane7t3H7y6JnQ5jTP1Dr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="339858224"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="339858224"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="804166603"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="804166603"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:20:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 2/5] x86/mce: Add per-bank CMCI storm mitigation
Date:   Fri, 17 Mar 2023 10:20:39 -0700
Message-Id: <20230317172042.117201-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317172042.117201-1-tony.luck@intel.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hook into machine_check_poll() to keep track of per-CPU, per-bank
corrected error logs.

Maintain a bitmap history for each bank showing whether the bank
logged an corrected error or not each time it is polled.

In normal operation the interval between polls of this banks
determines how far to shift the history. The 64 bit width corresponds
to about one second.

When a storm is observed the Rate of interrupts is reduced by setting
a large threshold value for this bank in IA32_MCi_CTL2. This bank is
added to the bitmap of banks for this CPU to poll. The polling rate
is increased to once per second.
During a storm each bit in the history indicates the status of the
bank each time it is polled. Thus the history covers just over a minute.

Declare a storm for that bank if the number of corrected interrupts
seen in that history is above some threshold (5 in this RFC code for
ease of testing, likely move to 15 for compatibility with previous
storm detection).

A storm on a bank ends if enough consecutive polls of the bank show
no corrected errors (currently 30, may also change). That resets the
threshold in IA32_MCi_CTL2 back to 1, removes the bank from the bitmap
for polling, and changes the polling rate back to the default.

If a CPU with banks in storm mode is taken offline, the new CPU
that inherits ownership of those banks takes over management of
storm(s) in the inherited bank(s).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/internal.h |   4 +-
 arch/x86/kernel/cpu/mce/core.c     |  26 ++++--
 arch/x86/kernel/cpu/mce/intel.c    | 139 ++++++++++++++++++++++++++++-
 3 files changed, 158 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 07fef4d74525..72fbec8f6c3c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -40,6 +40,8 @@ struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
 
+void track_cmci_storm(int bank, u64 status);
+
 #ifdef CONFIG_X86_MCE_INTEL
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
@@ -54,7 +56,7 @@ static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
-void mce_timer_kick(unsigned long interval);
+void mce_timer_kick(bool storm);
 
 #ifdef CONFIG_ACPI_APEI
 int apei_write_mce(struct mce *m);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 92c2dee4bf43..776d4724b1e0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -694,6 +694,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		barrier();
 		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
+		track_cmci_storm(i, m.status);
+
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
@@ -1597,6 +1599,7 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
 
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
 static DEFINE_PER_CPU(struct timer_list, mce_timer);
+static DEFINE_PER_CPU(bool, storm_poll_mode);
 
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
@@ -1632,22 +1635,29 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-	__this_cpu_write(mce_next_interval, iv);
-	__start_timer(t, iv);
+	if (__this_cpu_read(storm_poll_mode)) {
+		__start_timer(t, HZ);
+	} else {
+		__this_cpu_write(mce_next_interval, iv);
+		__start_timer(t, iv);
+	}
 }
 
 /*
- * Ensure that the timer is firing in @interval from now.
+ * When a storm starts on any bank on this CPU, switch to polling
+ * once per second. When the storm ends, revert to the default
+ * polling interval.
  */
-void mce_timer_kick(unsigned long interval)
+void mce_timer_kick(bool storm)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	unsigned long iv = __this_cpu_read(mce_next_interval);
 
-	__start_timer(t, interval);
+	__this_cpu_write(storm_poll_mode, storm);
 
-	if (interval < iv)
-		__this_cpu_write(mce_next_interval, interval);
+	if (storm)
+		__start_timer(t, HZ);
+	else
+		__this_cpu_write(mce_next_interval, check_interval * HZ);
 }
 
 /* Must not be called in IRQ context where del_timer_sync() can deadlock */
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 052bf2708391..4106877de028 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -47,8 +47,40 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
  */
 static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 
+/*
+ * CMCI storm tracking state
+ *	stormy_bank_count: per-cpu count of MC banks in storm state
+ *	bank_history: bitmask tracking of corrected errors seen in each bank
+ *	bank_time_stamp: last time (in jiffies) that each bank was polled
+ *	cmci_threshold: MCi_CTL2 threshold for each bank when there is no storm
+ */
+static DEFINE_PER_CPU(int, stormy_bank_count);
+static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
+static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
+static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
+static int cmci_threshold[MAX_NR_BANKS];
+
+/* Linux non-storm CMCI threshold (may be overridden by BIOS */
 #define CMCI_THRESHOLD		1
 
+/*
+ * High threshold to limit CMCI rate during storms. Max supported is
+ * 0x7FFF. Use this slightly smaller value so it has a distinctive
+ * signature when some asks "Why am I not seeing all corrected errors?"
+ */
+#define CMCI_STORM_THRESHOLD	32749
+
+/*
+ * How many errors within the history buffer mark the start of a storm
+ */
+#define STORM_BEGIN_THRESHOLD	5
+
+/*
+ * How many polls of machine check bank without an error before declaring
+ * the storm is over
+ */
+#define STORM_END_POLL_THRESHOLD	30
+
 static int cmci_supported(int *banks)
 {
 	u64 cap;
@@ -103,6 +135,93 @@ static bool lmce_supported(void)
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
+static void cmci_storm_begin(int bank)
+{
+	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
+	this_cpu_write(bank_storm[bank], true);
+
+	/*
+	 * If this is the first bank on this CPU to enter storm mode
+	 * start polling
+	 */
+	if (this_cpu_inc_return(stormy_bank_count) == 1)
+		mce_timer_kick(true);
+}
+
+static void cmci_storm_end(int bank)
+{
+	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	this_cpu_write(bank_history[bank], 0ull);
+	this_cpu_write(bank_storm[bank], false);
+
+	/* If no banks left in storm mode, stop polling */
+	if (!this_cpu_dec_return(stormy_bank_count))
+		mce_timer_kick(false);
+}
+
+void track_cmci_storm(int bank, u64 status)
+{
+	unsigned long now = jiffies, delta;
+	unsigned int shift = 1;
+	u64 history;
+
+	/*
+	 * When a bank is in storm mode it is polled once per second and
+	 * the history mask will record about the last minute of poll results.
+	 * If it is not in storm mode, then the bank is only checked when
+	 * there is a CMCI interrupt. Check how long it has been since
+	 * this bank was last checked, and adjust the amount of "shift"
+	 * to apply to history.
+	 */
+	if (!this_cpu_read(bank_storm[bank])) {
+		delta = now - this_cpu_read(bank_time_stamp[bank]);
+		shift = (delta + HZ) / HZ;
+	}
+
+	/* If has been a long time since the last poll, clear history */
+	if (shift >= 64)
+		history = 0;
+	else
+		history = this_cpu_read(bank_history[bank]) << shift;
+	this_cpu_write(bank_time_stamp[bank], now);
+
+	/* History keeps track of corrected errors. VAL=1 && UC=0 */
+	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
+		history |= 1;
+	this_cpu_write(bank_history[bank], history);
+
+	if (this_cpu_read(bank_storm[bank])) {
+		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
+		cmci_set_threshold(bank, cmci_threshold[bank]);
+		cmci_storm_end(bank);
+	} else {
+		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
+			return;
+		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
+		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
+		cmci_storm_begin(bank);
+	}
+}
+
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
@@ -147,6 +266,9 @@ static void cmci_discover(int banks)
 			continue;
 		}
 
+		if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+			goto storm;
+
 		if (!mca_cfg.bios_cmci_threshold) {
 			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
 			val |= CMCI_THRESHOLD;
@@ -159,7 +281,7 @@ static void cmci_discover(int banks)
 			bios_zero_thresh = 1;
 			val |= CMCI_THRESHOLD;
 		}
-
+storm:
 		val |= MCI_CTL2_CMCI_EN;
 		wrmsrl(MSR_IA32_MCx_CTL2(i), val);
 		rdmsrl(MSR_IA32_MCx_CTL2(i), val);
@@ -167,7 +289,14 @@ static void cmci_discover(int banks)
 		/* Did the enable bit stick? -- the bank supports CMCI */
 		if (val & MCI_CTL2_CMCI_EN) {
 			set_bit(i, owned);
-			__clear_bit(i, this_cpu_ptr(mce_poll_banks));
+			if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD) {
+				pr_notice("CPU%d BANK%d CMCI inherited storm\n", smp_processor_id(), i);
+				this_cpu_write(bank_history[i], ~0ull);
+				this_cpu_write(bank_time_stamp[i], jiffies);
+				cmci_storm_begin(i);
+			} else {
+				__clear_bit(i, this_cpu_ptr(mce_poll_banks));
+			}
 			/*
 			 * We are able to set thresholds for some banks that
 			 * had a threshold of 0. This means the BIOS has not
@@ -177,6 +306,10 @@ static void cmci_discover(int banks)
 			if (mca_cfg.bios_cmci_threshold && bios_zero_thresh &&
 					(val & MCI_CTL2_CMCI_THRESHOLD_MASK))
 				bios_wrong_thresh = 1;
+
+			/* Save default threshold for each bank */
+			if (cmci_threshold[i] == 0)
+				cmci_threshold[i] = val & MCI_CTL2_CMCI_THRESHOLD_MASK;
 		} else {
 			WARN_ON(!test_bit(i, this_cpu_ptr(mce_poll_banks)));
 		}
@@ -218,6 +351,8 @@ static void __cmci_disable_bank(int bank)
 	val &= ~MCI_CTL2_CMCI_EN;
 	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
 	__clear_bit(bank, this_cpu_ptr(mce_banks_owned));
+	if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
+		cmci_storm_end(bank);
 }
 
 /*
-- 
2.39.2

