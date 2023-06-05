Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97F72285E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjFEOJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbjFEOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF52B110;
        Mon,  5 Jun 2023 07:08:17 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HCRaetb73GzNhNwYrURm826JSBw+69hNQxs10HaMF4=;
        b=SbqruPps/rOgW1LaJaxH632DIoSZyhZV3gj65ITs8PLd9k2KmRkoQ/AA3t7KjGuVrLzDr2
        kx7Jw7Z9j1WSv+5bpqd9odJ39A+KITZtDW9KP6+hIV0jWodJsYtNtVW94w6fDhIca0h9bY
        dh+jjMo0PMPS7oYHh+swa/niHJG6UgirSMdrJ9zrUC5jBQ10BsN/mhsCEjv4kaoZRXcfnH
        ypwwsNmtYb+77jjxcrXZrmTt2v4e3JbrJvunzya0r7KaM/bOVZlQrTTyI0MhQfKspliDcb
        T0ClLOiE09IVeCgR90h4KSgF0XnDlDFffNK+Q4QIt5lR84dSa4jQ/vmUeEYa2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HCRaetb73GzNhNwYrURm826JSBw+69hNQxs10HaMF4=;
        b=Hv6SZD5rnMm8MUZdqyu+c4cVRGpBHhIGwatQ0myCf52dzvyqcyK0noU55s8WRSS+rt70Uc
        IatWu5jDQsbGuVBw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Construct a memory map with cache modes
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-12-jgross@suse.com>
References: <20230502120931.20719-12-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409473.404.17590630546339021847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     061b984aab5845dc958f248b5b0f9040fe45b5e1
Gitweb:        https://git.kernel.org/tip/061b984aab5845dc958f248b5b0f9040fe45b5e1
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:26 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Construct a memory map with cache modes

After MTRR initialization construct a memory map with cache modes from
MTRR values. This will speed up lookups via mtrr_lookup_type()
especially in case of overlapping MTRRs.

This will be needed when switching the semantics of the "uniform"
parameter of mtrr_lookup_type() from "only covered by one MTRR" to
"memory range has a uniform cache mode", which is the data the callers
really want to know. Today this information is not easily available,
in case MTRRs are not well sorted regarding base address.

The map will be built in __initdata. When memory management is up, the
map will be moved to dynamically allocated memory, in order to avoid
the need of an overly large array. The size of this array is calculated
using the number of variable MTRR registers and the needed size for
fixed entries.

Only add the map creation and expansion for now. The lookup will be
added later.

When writing new MTRR entries in the running system rebuild the map
inside the call from mtrr_rendezvous_handler() in order to avoid nasty
race conditions with concurrent lookups.

  [ bp: Move out rebuild_map() call and rename it. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-12-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 299 ++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  12 +-
 arch/x86/kernel/cpu/mtrr/mtrr.h    |   5 +-
 3 files changed, 314 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index b944271..e0db6fc 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -33,6 +33,38 @@ static struct fixed_range_block fixed_range_blocks[] = {
 	{}
 };
 
+struct cache_map {
+	u64 start;
+	u64 end;
+	u64 flags;
+	u64 type:8;
+	u64 fixed:1;
+};
+
+/*
+ * CACHE_MAP_MAX is the maximum number of memory ranges in cache_map, where
+ * no 2 adjacent ranges have the same cache mode (those would be merged).
+ * The number is based on the worst case:
+ * - no two adjacent fixed MTRRs share the same cache mode
+ * - one variable MTRR is spanning a huge area with mode WB
+ * - 255 variable MTRRs with mode UC all overlap with the WB MTRR, creating 2
+ *   additional ranges each (result like "ababababa...aba" with a = WB, b = UC),
+ *   accounting for MTRR_MAX_VAR_RANGES * 2 - 1 range entries
+ * - a TOP_MEM2 area (even with overlapping an UC MTRR can't add 2 range entries
+ *   to the possible maximum, as it always starts at 4GB, thus it can't be in
+ *   the middle of that MTRR, unless that MTRR starts at 0, which would remove
+ *   the initial "a" from the "abababa" pattern above)
+ * The map won't contain ranges with no matching MTRR (those fall back to the
+ * default cache mode).
+ */
+#define CACHE_MAP_MAX	(MTRR_NUM_FIXED_RANGES + MTRR_MAX_VAR_RANGES * 2)
+
+static struct cache_map init_cache_map[CACHE_MAP_MAX] __initdata;
+static struct cache_map *cache_map __refdata = init_cache_map;
+static unsigned int cache_map_size = CACHE_MAP_MAX;
+static unsigned int cache_map_n;
+static unsigned int cache_map_fixed;
+
 static unsigned long smp_changes_mask;
 static int mtrr_state_set;
 u64 mtrr_tom2;
@@ -80,6 +112,20 @@ static u64 get_mtrr_size(u64 mask)
 	return size;
 }
 
+static u8 get_var_mtrr_state(unsigned int reg, u64 *start, u64 *size)
+{
+	struct mtrr_var_range *mtrr = mtrr_state.var_ranges + reg;
+
+	if (!(mtrr->mask_lo & MTRR_PHYSMASK_V))
+		return MTRR_TYPE_INVALID;
+
+	*start = (((u64)mtrr->base_hi) << 32) + (mtrr->base_lo & PAGE_MASK);
+	*size = get_mtrr_size((((u64)mtrr->mask_hi) << 32) +
+			      (mtrr->mask_lo & PAGE_MASK));
+
+	return mtrr->base_lo & MTRR_PHYSBASE_TYPE;
+}
+
 static u8 get_effective_type(u8 type1, u8 type2)
 {
 	if (type1 == MTRR_TYPE_UNCACHABLE || type2 == MTRR_TYPE_UNCACHABLE)
@@ -243,6 +289,259 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	return mtrr_state.def_type;
 }
 
+static void rm_map_entry_at(int idx)
+{
+	cache_map_n--;
+	if (cache_map_n > idx) {
+		memmove(cache_map + idx, cache_map + idx + 1,
+			sizeof(*cache_map) * (cache_map_n - idx));
+	}
+}
+
+/*
+ * Add an entry into cache_map at a specific index.  Merges adjacent entries if
+ * appropriate.  Return the number of merges for correcting the scan index
+ * (this is needed as merging will reduce the number of entries, which will
+ * result in skipping entries in future iterations if the scan index isn't
+ * corrected).
+ * Note that the corrected index can never go below -1 (resulting in being 0 in
+ * the next scan iteration), as "2" is returned only if the current index is
+ * larger than zero.
+ */
+static int add_map_entry_at(u64 start, u64 end, u8 type, int idx)
+{
+	bool merge_prev = false, merge_next = false;
+
+	if (start >= end)
+		return 0;
+
+	if (idx > 0) {
+		struct cache_map *prev = cache_map + idx - 1;
+
+		if (!prev->fixed && start == prev->end && type == prev->type)
+			merge_prev = true;
+	}
+
+	if (idx < cache_map_n) {
+		struct cache_map *next = cache_map + idx;
+
+		if (!next->fixed && end == next->start && type == next->type)
+			merge_next = true;
+	}
+
+	if (merge_prev && merge_next) {
+		cache_map[idx - 1].end = cache_map[idx].end;
+		rm_map_entry_at(idx);
+		return 2;
+	}
+	if (merge_prev) {
+		cache_map[idx - 1].end = end;
+		return 1;
+	}
+	if (merge_next) {
+		cache_map[idx].start = start;
+		return 1;
+	}
+
+	/* Sanity check: the array should NEVER be too small! */
+	if (cache_map_n == cache_map_size) {
+		WARN(1, "MTRR cache mode memory map exhausted!\n");
+		cache_map_n = cache_map_fixed;
+		return 0;
+	}
+
+	if (cache_map_n > idx) {
+		memmove(cache_map + idx + 1, cache_map + idx,
+			sizeof(*cache_map) * (cache_map_n - idx));
+	}
+
+	cache_map[idx].start = start;
+	cache_map[idx].end = end;
+	cache_map[idx].type = type;
+	cache_map[idx].fixed = 0;
+	cache_map_n++;
+
+	return 0;
+}
+
+/* Clear a part of an entry. Return 1 if start of entry is still valid. */
+static int clr_map_range_at(u64 start, u64 end, int idx)
+{
+	int ret = start != cache_map[idx].start;
+	u64 tmp;
+
+	if (start == cache_map[idx].start && end == cache_map[idx].end) {
+		rm_map_entry_at(idx);
+	} else if (start == cache_map[idx].start) {
+		cache_map[idx].start = end;
+	} else if (end == cache_map[idx].end) {
+		cache_map[idx].end = start;
+	} else {
+		tmp = cache_map[idx].end;
+		cache_map[idx].end = start;
+		add_map_entry_at(end, tmp, cache_map[idx].type, idx + 1);
+	}
+
+	return ret;
+}
+
+/*
+ * Add MTRR to the map.  The current map is scanned and each part of the MTRR
+ * either overlapping with an existing entry or with a hole in the map is
+ * handled separately.
+ */
+static void add_map_entry(u64 start, u64 end, u8 type)
+{
+	u8 new_type, old_type;
+	u64 tmp;
+	int i;
+
+	for (i = 0; i < cache_map_n && start < end; i++) {
+		if (start >= cache_map[i].end)
+			continue;
+
+		if (start < cache_map[i].start) {
+			/* Region start has no overlap. */
+			tmp = min(end, cache_map[i].start);
+			i -= add_map_entry_at(start, tmp,  type, i);
+			start = tmp;
+			continue;
+		}
+
+		new_type = get_effective_type(type, cache_map[i].type);
+		old_type = cache_map[i].type;
+
+		if (cache_map[i].fixed || new_type == old_type) {
+			/* Cut off start of new entry. */
+			start = cache_map[i].end;
+			continue;
+		}
+
+		/* Handle only overlapping part of region. */
+		tmp = min(end, cache_map[i].end);
+		i += clr_map_range_at(start, tmp, i);
+		i -= add_map_entry_at(start, tmp, new_type, i);
+		start = tmp;
+	}
+
+	/* Add rest of region after last map entry (rest might be empty). */
+	add_map_entry_at(start, end, type, i);
+}
+
+/* Add variable MTRRs to cache map. */
+static void map_add_var(void)
+{
+	u64 start, size;
+	unsigned int i;
+	u8 type;
+
+	/*
+	 * Add AMD TOP_MEM2 area.  Can't be added in mtrr_build_map(), as it
+	 * needs to be added again when rebuilding the map due to potentially
+	 * having moved as a result of variable MTRRs for memory below 4GB.
+	 */
+	if (mtrr_tom2) {
+		add_map_entry(BIT_ULL(32), mtrr_tom2, MTRR_TYPE_WRBACK);
+		cache_map[cache_map_n - 1].fixed = 1;
+	}
+
+	for (i = 0; i < num_var_ranges; i++) {
+		type = get_var_mtrr_state(i, &start, &size);
+		if (type != MTRR_TYPE_INVALID)
+			add_map_entry(start, start + size, type);
+	}
+}
+
+/*
+ * Rebuild map by replacing variable entries.  Needs to be called when MTRR
+ * registers are being changed after boot, as such changes could include
+ * removals of registers, which are complicated to handle without rebuild of
+ * the map.
+ */
+void generic_rebuild_map(void)
+{
+	if (mtrr_if != &generic_mtrr_ops)
+		return;
+
+	cache_map_n = cache_map_fixed;
+
+	map_add_var();
+}
+
+static unsigned int __init get_cache_map_size(void)
+{
+	return cache_map_fixed + 2 * num_var_ranges + (mtrr_tom2 != 0);
+}
+
+/* Build the cache_map containing the cache modes per memory range. */
+void __init mtrr_build_map(void)
+{
+	u64 start, end, size;
+	unsigned int i;
+	u8 type;
+
+	/* Add fixed MTRRs, optimize for adjacent entries with same type. */
+	if (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED) {
+		/*
+		 * Start with 64k size fixed entries, preset 1st one (hence the
+		 * loop below is starting with index 1).
+		 */
+		start = 0;
+		end = size = 0x10000;
+		type = mtrr_state.fixed_ranges[0];
+
+		for (i = 1; i < MTRR_NUM_FIXED_RANGES; i++) {
+			/* 8 64k entries, then 16 16k ones, rest 4k. */
+			if (i == 8 || i == 24)
+				size >>= 2;
+
+			if (mtrr_state.fixed_ranges[i] != type) {
+				add_map_entry(start, end, type);
+				start = end;
+				type = mtrr_state.fixed_ranges[i];
+			}
+			end += size;
+		}
+		add_map_entry(start, end, type);
+	}
+
+	/* Mark fixed, they take precedence. */
+	for (i = 0; i < cache_map_n; i++)
+		cache_map[i].fixed = 1;
+	cache_map_fixed = cache_map_n;
+
+	map_add_var();
+
+	pr_info("MTRR map: %u entries (%u fixed + %u variable; max %u), built from %u variable MTRRs\n",
+		cache_map_n, cache_map_fixed, cache_map_n - cache_map_fixed,
+		get_cache_map_size(), num_var_ranges + (mtrr_tom2 != 0));
+}
+
+/* Copy the cache_map from __initdata memory to dynamically allocated one. */
+void __init mtrr_copy_map(void)
+{
+	unsigned int new_size = get_cache_map_size();
+
+	if (!mtrr_state.enabled || !new_size) {
+		cache_map = NULL;
+		return;
+	}
+
+	mutex_lock(&mtrr_mutex);
+
+	cache_map = kcalloc(new_size, sizeof(*cache_map), GFP_KERNEL);
+	if (cache_map) {
+		memmove(cache_map, init_cache_map,
+			cache_map_n * sizeof(*cache_map));
+		cache_map_size = new_size;
+	} else {
+		mtrr_state.enabled = 0;
+		pr_err("MTRRs disabled due to allocation failure for lookup map.\n");
+	}
+
+	mutex_unlock(&mtrr_mutex);
+}
+
 /**
  * mtrr_overwrite_state - set static MTRR state
  *
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index b7793a4..ec8670b 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -61,7 +61,7 @@
 u32 num_var_ranges;
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
-static DEFINE_MUTEX(mtrr_mutex);
+DEFINE_MUTEX(mtrr_mutex);
 
 const struct mtrr_ops *mtrr_if;
 
@@ -183,6 +183,8 @@ static void set_mtrr(unsigned int reg, unsigned long base, unsigned long size,
 				    };
 
 	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
+
+	generic_rebuild_map();
 }
 
 /**
@@ -563,6 +565,7 @@ void __init mtrr_bp_init(void)
 		 * Note that X86_FEATURE_MTRR has been reset in this case.
 		 */
 		init_table();
+		mtrr_build_map();
 		pr_info("MTRRs set to read-only\n");
 
 		return;
@@ -587,6 +590,7 @@ void __init mtrr_bp_init(void)
 			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR;
 				changed_by_mtrr_cleanup = mtrr_cleanup();
+				mtrr_build_map();
 			} else {
 				mtrr_if = NULL;
 				why = "by BIOS";
@@ -615,6 +619,12 @@ void mtrr_save_state(void)
 
 static int __init mtrr_init_finalize(void)
 {
+	/*
+	 * Map might exist if mtrr_overwrite_state() has been called or if
+	 * mtrr_enabled() returns true.
+	 */
+	mtrr_copy_map();
+
 	if (!mtrr_enabled())
 		return 0;
 
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index e1e8864..8385d7d 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -52,6 +52,7 @@ void fill_mtrr_var_range(unsigned int index,
 bool get_mtrr_state(void);
 
 extern const struct mtrr_ops *mtrr_if;
+extern struct mutex mtrr_mutex;
 
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
@@ -68,6 +69,8 @@ void mtrr_register_syscore(void);
 static inline void mtrr_set_if(void) { }
 static inline void mtrr_register_syscore(void) { }
 #endif
+void mtrr_build_map(void);
+void mtrr_copy_map(void);
 
 /* CPU specific mtrr_ops vectors. */
 extern const struct mtrr_ops amd_mtrr_ops;
@@ -76,7 +79,6 @@ extern const struct mtrr_ops centaur_mtrr_ops;
 
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(void);
-void generic_rebuild_map(void);
 
 /*
  * Must be used by code which uses mtrr_if to call platform-specific
@@ -86,3 +88,4 @@ static inline bool mtrr_enabled(void)
 {
 	return !!mtrr_if;
 }
+void generic_rebuild_map(void);
