Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF02722857
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjFEOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjFEOId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F39C;
        Mon,  5 Jun 2023 07:08:15 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j78QLbehlsr72zqsLShph2xOj0UCqsEkhH1vQCIBfro=;
        b=WKjNzUNF+IWZU9nWM8k780Ou/OJ+ZR+WR+8xjiD1yybBD+eez22NbgeTxjO+o2/lLT85li
        RYHUoSWMsQe+hfHg/ZFkfQF9uw9gd8OHurujxuZcpA5pI9TwG3amGoVdBrL94VvCuIojoR
        8ZIdch5PoRi1cbloKAj37tWtU2NDMBDEVfvpXA6/N5g5jvcMZmVA0ApRE/Qzuc9EL7Eo1s
        mP5Yyo/p0Cag+ch9aj2x5tFb7rPlI7f0ykKhVWKbpAvIjpqmKXGpz+9AKZacSmx2L5g9TM
        bnXX0Mi0Twq71ZFw22NAG/pMzleWHTONt+XidMIBslU4ib06zudxhwvjX1BglA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j78QLbehlsr72zqsLShph2xOj0UCqsEkhH1vQCIBfro=;
        b=CyrQszObbAHX0sJNaJDly4+1aS1l1DrteNG4iXpsn/nqpUKeykAcBELulVULyrxOt7HEoc
        5xpNxfIfDt31m5Ag==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Use new cache_map in mtrr_type_lookup()
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-14-jgross@suse.com>
References: <20230502120931.20719-14-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409404.404.5861731776377260932.tip-bot2@tip-bot2>
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

Commit-ID:     8227f40ade2362982505f66f1614b78a3a083ec9
Gitweb:        https://git.kernel.org/tip/8227f40ade2362982505f66f1614b78a3a083ec9
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Use new cache_map in mtrr_type_lookup()

Instead of crawling through the MTRR register state, use the new
cache_map for looking up the cache type(s) of a memory region.

This allows now to set the uniform parameter according to the
uniformity of the cache mode of the region, instead of setting it
only if the complete region is mapped by a single MTRR. This now
includes even the region covered by the fixed MTRR registers.

Make sure uniform is always set.

  [ bp: Massage. ]

  [ jgross: Explain mtrr_type_lookup() logic. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-14-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 237 +++++-----------------------
 1 file changed, 43 insertions(+), 194 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 852031e..4443e71 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -158,154 +158,6 @@ static u8 get_effective_type(u8 type1, u8 type2)
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
-		if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V))
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
-		curr_match = mtrr_state.var_ranges[i].base_lo & MTRR_PHYSBASE_TYPE;
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
 	cache_map_n--;
@@ -623,6 +475,20 @@ void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
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
@@ -631,66 +497,49 @@ void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
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
+	if (!mtrr_state_set) {
+		/* Uniformity is unknown. */
+		*uniform = 0;
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
+	for (i = 0; i < cache_map_n && start < end; i++) {
+		/* Region after current map entry? -> continue with next one. */
+		if (start >= cache_map[i].end)
+			continue;
 
-	/*
-	 * Look up the variable ranges.  Look of multiple ranges matching
-	 * this address and pick type as per MTRR precedence.
-	 */
-	type = mtrr_type_lookup_variable(start, end, &partial_end,
-					 &repeat, &is_uniform);
+		/* Start of region not covered by current map entry? */
+		if (start < cache_map[i].start) {
+			/* At least some part of region has default type. */
+			type = type_merge(type, mtrr_state.def_type, uniform);
+			/* End of region not covered, too? -> lookup done. */
+			if (end <= cache_map[i].start)
+				return type;
+		}
 
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
+		/* At least part of region covered by map entry. */
+		type = type_merge(type, cache_map[i].type, uniform);
+
+		start = cache_map[i].end;
 	}
 
-	if (mtrr_tom2 && (start >= (1ULL<<32)) && (end < mtrr_tom2))
-		type = MTRR_TYPE_WRBACK;
+	/* End of region past last entry in map? -> use default type. */
+	if (start < end)
+		type = type_merge(type, mtrr_state.def_type, uniform);
 
-out:
-	*uniform = is_uniform;
 	return type;
 }
 
