Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67426A16A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 07:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBXGhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 01:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXGhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 01:37:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511E7580F2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:37:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1D9F3482B;
        Fri, 24 Feb 2023 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677220653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbPyqq5eVD3uXwE7N0Em9Sy5J2byjVce6MnkwDL8TUA=;
        b=Bh4NPmDsc8TCrf1uMdzEQaQSJk4nqGafx7CDzs6uwpaG/b3tREHJkIDxomydCa4hsiQAnL
        AQQe7WBMA8k06ulIgW3OOF5BEqzxdzL0HiQOvhayNe6z6lgfYoSmplzS6/gSXA8IVJFc1y
        3FK8Mifc9XjhXc8AFJcpDip/CMbNwQ0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EAC313A3A;
        Fri, 24 Feb 2023 06:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iq45JS1b+GPVYgAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 24 Feb 2023 06:37:33 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3.1 10/12] x86/mtrr: use new cache_map in mtrr_type_lookup()
Date:   Fri, 24 Feb 2023 07:37:18 +0100
Message-Id: <20230224063718.27666-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230223093243.1180-11-jgross@suse.com>
References: <20230223093243.1180-11-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of crawling through the MTRR register state, use the new
cache_map for looking up the cache type(s) of a memory region.

This allows now to set the uniform parameter according to the
uniformity of the cache mode of the region, instead of setting it
only if the complete region is mapped by a single MTRR. This now
includes even the region covered by the fixed MTRR registers.

Make sure uniform is always set.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
V3.1:
- fix type_merge() (Michael Kelley)
---
 arch/x86/kernel/cpu/mtrr/generic.c | 227 ++++-------------------------
 1 file changed, 32 insertions(+), 195 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index ca9b8cec81a0..1926a9e64769 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -138,154 +138,6 @@ static u8 get_effective_type(u8 type1, u8 type2)
 	return type1;
 }
 
-/*
- * Check and return the effective type for MTRR-MTRR type overlap.
- * Returns true if the effective type is UNCACHEABLE, else returns false
- */
-static bool check_type_overlap(u8 *prev, u8 *curr)
-{
-	*prev = *curr = get_effective_type(*curr, *prev);
-
-	return *prev == MTRR_TYPE_UNCACHABLE;
-}
-
-/**
- * mtrr_type_lookup_fixed - look up memory type in MTRR fixed entries
- *
- * Return the MTRR fixed memory type of 'start'.
- *
- * MTRR fixed entries are divided into the following ways:
- *  0x00000 - 0x7FFFF : This range is divided into eight 64KB sub-ranges
- *  0x80000 - 0xBFFFF : This range is divided into sixteen 16KB sub-ranges
- *  0xC0000 - 0xFFFFF : This range is divided into sixty-four 4KB sub-ranges
- *
- * Return Values:
- * MTRR_TYPE_(type)  - Matched memory type
- * MTRR_TYPE_INVALID - Unmatched
- */
-static u8 mtrr_type_lookup_fixed(u64 start, u64 end)
-{
-	int idx;
-
-	if (start >= 0x100000)
-		return MTRR_TYPE_INVALID;
-
-	/* 0x0 - 0x7FFFF */
-	if (start < 0x80000) {
-		idx = 0;
-		idx += (start >> 16);
-		return mtrr_state.fixed_ranges[idx];
-	/* 0x80000 - 0xBFFFF */
-	} else if (start < 0xC0000) {
-		idx = 1 * 8;
-		idx += ((start - 0x80000) >> 14);
-		return mtrr_state.fixed_ranges[idx];
-	}
-
-	/* 0xC0000 - 0xFFFFF */
-	idx = 3 * 8;
-	idx += ((start - 0xC0000) >> 12);
-	return mtrr_state.fixed_ranges[idx];
-}
-
-/**
- * mtrr_type_lookup_variable - look up memory type in MTRR variable entries
- *
- * Return Value:
- * MTRR_TYPE_(type) - Matched memory type or default memory type (unmatched)
- *
- * Output Arguments:
- * repeat - Set to 1 when [start:end] spanned across MTRR range and type
- *	    returned corresponds only to [start:*partial_end].  Caller has
- *	    to lookup again for [*partial_end:end].
- *
- * uniform - Set to 1 when an MTRR covers the region uniformly, i.e. the
- *	     region is fully covered by a single MTRR entry or the default
- *	     type.
- */
-static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
-				    int *repeat, u8 *uniform)
-{
-	int i;
-	u64 base, mask;
-	u8 prev_match, curr_match;
-
-	*repeat = 0;
-	*uniform = 1;
-
-	prev_match = MTRR_TYPE_INVALID;
-	for (i = 0; i < num_var_ranges; ++i) {
-		unsigned short start_state, end_state, inclusive;
-
-		if (!(mtrr_state.var_ranges[i].mask_lo & (1 << 11)))
-			continue;
-
-		base = (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
-		       (mtrr_state.var_ranges[i].base_lo & PAGE_MASK);
-		mask = (((u64)mtrr_state.var_ranges[i].mask_hi) << 32) +
-		       (mtrr_state.var_ranges[i].mask_lo & PAGE_MASK);
-
-		start_state = ((start & mask) == (base & mask));
-		end_state = ((end & mask) == (base & mask));
-		inclusive = ((start < base) && (end > base));
-
-		if ((start_state != end_state) || inclusive) {
-			/*
-			 * We have start:end spanning across an MTRR.
-			 * We split the region into either
-			 *
-			 * - start_state:1
-			 * (start:mtrr_end)(mtrr_end:end)
-			 * - end_state:1
-			 * (start:mtrr_start)(mtrr_start:end)
-			 * - inclusive:1
-			 * (start:mtrr_start)(mtrr_start:mtrr_end)(mtrr_end:end)
-			 *
-			 * depending on kind of overlap.
-			 *
-			 * Return the type of the first region and a pointer
-			 * to the start of next region so that caller will be
-			 * advised to lookup again after having adjusted start
-			 * and end.
-			 *
-			 * Note: This way we handle overlaps with multiple
-			 * entries and the default type properly.
-			 */
-			if (start_state)
-				*partial_end = base + get_mtrr_size(mask);
-			else
-				*partial_end = base;
-
-			if (unlikely(*partial_end <= start)) {
-				WARN_ON(1);
-				*partial_end = start + PAGE_SIZE;
-			}
-
-			end = *partial_end - 1; /* end is inclusive */
-			*repeat = 1;
-			*uniform = 0;
-		}
-
-		if ((start & mask) != (base & mask))
-			continue;
-
-		curr_match = mtrr_state.var_ranges[i].base_lo & 0xff;
-		if (prev_match == MTRR_TYPE_INVALID) {
-			prev_match = curr_match;
-			continue;
-		}
-
-		*uniform = 0;
-		if (check_type_overlap(&prev_match, &curr_match))
-			return curr_match;
-	}
-
-	if (prev_match != MTRR_TYPE_INVALID)
-		return prev_match;
-
-	return mtrr_state.def_type;
-}
-
 static void rm_map_entry_at(int idx)
 {
 	int i;
@@ -532,6 +384,20 @@ void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
 	mtrr_state_set = 1;
 }
 
+static u8 type_merge(u8 type, u8 new_type, u8 *uniform)
+{
+	u8 effective_type;
+
+	if (type == MTRR_TYPE_INVALID)
+		return new_type;
+
+	effective_type = get_effective_type(type, new_type);
+	if (type != effective_type)
+		*uniform = 0;
+
+	return effective_type;
+}
+
 /**
  * mtrr_type_lookup - look up memory type in MTRR
  *
@@ -540,66 +406,37 @@ void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
  * MTRR_TYPE_INVALID - MTRR is disabled
  *
  * Output Argument:
- * uniform - Set to 1 when an MTRR covers the region uniformly, i.e. the
- *	     region is fully covered by a single MTRR entry or the default
- *	     type.
+ * uniform - Set to 1 when the returned MTRR type is valid for the whole
+ *	     region, set to 0 else.
  */
 u8 mtrr_type_lookup(u64 start, u64 end, u8 *uniform)
 {
-	u8 type, prev_type, is_uniform = 1, dummy;
-	int repeat;
-	u64 partial_end;
-
-	/* Make end inclusive instead of exclusive */
-	end--;
+	u8 type = MTRR_TYPE_INVALID;
+	unsigned int i;
 
-	if (!mtrr_state_set)
+	if (!mtrr_state_set || !cache_map) {
+		*uniform = 0;	/* Uniformity is unknown. */
 		return MTRR_TYPE_INVALID;
+	}
+
+	*uniform = 1;
 
 	if (!(mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED))
 		return MTRR_TYPE_INVALID;
 
-	/*
-	 * Look up the fixed ranges first, which take priority over
-	 * the variable ranges.
-	 */
-	if ((start < 0x100000) &&
-	    (mtrr_state.have_fixed) &&
-	    (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)) {
-		is_uniform = 0;
-		type = mtrr_type_lookup_fixed(start, end);
-		goto out;
-	}
-
-	/*
-	 * Look up the variable ranges.  Look of multiple ranges matching
-	 * this address and pick type as per MTRR precedence.
-	 */
-	type = mtrr_type_lookup_variable(start, end, &partial_end,
-					 &repeat, &is_uniform);
+	for (i = 0; i < cache_map_n && start < end; i++) {
+		if (start >= cache_map[i].end)
+			continue;
+		if (start < cache_map[i].start)
+			type = type_merge(type, mtrr_state.def_type, uniform);
+		type = type_merge(type, cache_map[i].type, uniform);
 
-	/*
-	 * Common path is with repeat = 0.
-	 * However, we can have cases where [start:end] spans across some
-	 * MTRR ranges and/or the default type.  Do repeated lookups for
-	 * that case here.
-	 */
-	while (repeat) {
-		prev_type = type;
-		start = partial_end;
-		is_uniform = 0;
-		type = mtrr_type_lookup_variable(start, end, &partial_end,
-						 &repeat, &dummy);
-
-		if (check_type_overlap(&prev_type, &type))
-			goto out;
+		start = cache_map[i].end;
 	}
 
-	if (mtrr_tom2 && (start >= (1ULL<<32)) && (end < mtrr_tom2))
-		type = MTRR_TYPE_WRBACK;
+	if (start < end)
+		type = type_merge(type, mtrr_state.def_type, uniform);
 
-out:
-	*uniform = is_uniform;
 	return type;
 }
 
-- 
2.35.3

