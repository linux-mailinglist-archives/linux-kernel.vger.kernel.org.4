Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B66F4370
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjEBMLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjEBMLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:11:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03A61A2
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:10:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B7EA1F8CC;
        Tue,  2 May 2023 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQsbhe24VGyqOwRLrkzmuRDIYmio0BvErgoPF3HlFlQ=;
        b=WNEeYr+qXJxvlfE1X10e+9mFORaK4t4tCkFrUQ4BvdxxFx/XWA7NBLImwyAnvPYCCCLnyR
        HrqgJjZf2nnAlO2J8SL49rPrO5MyeOVWMPJ/V4x63FnDLP2LFaoitEzF/oPCV7rBDYnsQt
        4vqkJFDu0qlHlUHxhApGRlC/gPGN9nQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8A59139C3;
        Tue,  2 May 2023 12:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pSC3L8T9UGQcMAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:10:44 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 11/16] x86/mtrr: construct a memory map with cache modes
Date:   Tue,  2 May 2023 14:09:26 +0200
Message-Id: <20230502120931.20719-12-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
References: <20230502120931.20719-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V3:
- new patch
V5:
- fix setting of mtrr_tom2
- change cache_map .type and .fixed to bitfields (Boris Petkov)
- use memmove() (Boris Petkov)
- a lot of comments (Boris Petkov)
- rewrite setting of merge bools (Boris Petkov)
- mark mtrr_build_map() as __init
- add pr_info() (Boris Petkov)
V6:
- handle allocation failure for map
- remove check in mtrr_build_map() (Boris Petkov)
- add more comments (Boris Petkov)
- avoid calling memmove() with zero size (Boris Petkov)
---
 arch/x86/kernel/cpu/mtrr/generic.c | 300 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  10 +-
 arch/x86/kernel/cpu/mtrr/mtrr.h    |   3 +
 3 files changed, 312 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 44e035a8e9fb..a6dd240a09cb 100644
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
@@ -86,6 +118,20 @@ static u64 get_mtrr_size(u64 mask)
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
@@ -250,6 +296,256 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
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
+static void rebuild_map(void)
+{
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
@@ -841,6 +1137,10 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 
 	cache_enable();
 	local_irq_restore(flags);
+
+	/* On the first CPU rebuild the cache mode memory map. */
+	if (smp_processor_id() == cpumask_first(cpu_online_mask))
+		rebuild_map();
 }
 
 int generic_validate_add_page(unsigned long base, unsigned long size,
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 0eeb03d92d8c..441e3f9d64f7 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -65,7 +65,7 @@ static bool mtrr_enabled(void)
 }
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
-static DEFINE_MUTEX(mtrr_mutex);
+DEFINE_MUTEX(mtrr_mutex);
 
 const struct mtrr_ops *mtrr_if;
 
@@ -567,6 +567,7 @@ void __init mtrr_bp_init(void)
 		 * Note that X86_FEATURE_MTRR has been reset in this case.
 		 */
 		init_table();
+		mtrr_build_map();
 		pr_info("MTRRs set to read-only\n");
 
 		return;
@@ -591,6 +592,7 @@ void __init mtrr_bp_init(void)
 			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR;
 				changed_by_mtrr_cleanup = mtrr_cleanup();
+				mtrr_build_map();
 			} else {
 				mtrr_if = NULL;
 				why = "by BIOS";
@@ -619,6 +621,12 @@ void mtrr_save_state(void)
 
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
index f626febeb545..5c690175580a 100644
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
-- 
2.35.3

