Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F972285A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjFEOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjFEOId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCEC10C;
        Mon,  5 Jun 2023 07:08:17 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaGDd7MJXaa2FJU0NllJ0xk2tgFw0REh0aLkSUldAww=;
        b=a15gONczb4BFxPmWs4g8EyYoS87WoIZfX8IMsZdHCkLRebAyj1BF4pxO9QgU9hoLMHZCtw
        2/iR1TWXqUzYM/A2f7lkIzBdjop7cvCPmSYVgFtim7FxR5hEbck6DoTrN2GCsGRv2rnRkW
        s8urblLpf7J1MuNThWHj3/jGTX45mNS+pr0z8vzRk9Y4u3gq406SzLxyJyr/hIoCWk3h25
        OC6DLAADXKd5aDD/IpRY+IqYGCmMzqR8XMHHi8pPyTVhIZ2Y46p/xXReeHAJ1USqj62u7O
        fyy3dJxB+QGgekSQHskCd7j2J6dmNwP16uUVd/AA4v1KIoooFxgyd65j51b38w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaGDd7MJXaa2FJU0NllJ0xk2tgFw0REh0aLkSUldAww=;
        b=2gF63JUmwO8nwruKRdbUi28Awm2HlNPVCwHtl4wj1JCSrDl+fHbzIk+Q4GYOXmVsKBbkEj
        GMHhRxCqmA9WqvDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Add mtrr=debug command line option
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-13-jgross@suse.com>
References: <20230502120931.20719-13-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409440.404.8757171815443940445.tip-bot2@tip-bot2>
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

Commit-ID:     a4316603534cf7f4dcd9f9f1ed170257b987cca9
Gitweb:        https://git.kernel.org/tip/a4316603534cf7f4dcd9f9f1ed170257b987cca9
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:27 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Add mtrr=debug command line option

Add a new command line option "mtrr=debug" for getting debug output
after building the new cache mode map. The output will include MTRR
register values and the resulting map.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-13-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 arch/x86/kernel/cpu/mtrr/generic.c              | 64 +++++++++++-----
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab2..44a87ad 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3423,6 +3423,10 @@
 			[HW] Make the MicroTouch USB driver use raw coordinates
 			('y', default) or cooked coordinates ('n')
 
+	mtrr=debug	[X86]
+			Enable printing debug information related to MTRR
+			registers at boot time.
+
 	mtrr_chunk_size=nn[KMG] [X86]
 			used for mtrr cleanup. It is largest continuous chunk
 			that could hold holes aka. UC entries.
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e0db6fc..852031e 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -41,6 +41,23 @@ struct cache_map {
 	u64 fixed:1;
 };
 
+static bool mtrr_debug;
+
+static int __init mtrr_param_setup(char *str)
+{
+	int rc = 0;
+
+	if (!str)
+		return -EINVAL;
+	if (!strcmp(str, "debug"))
+		mtrr_debug = true;
+	else
+		rc = -EINVAL;
+
+	return rc;
+}
+early_param("mtrr", mtrr_param_setup);
+
 /*
  * CACHE_MAP_MAX is the maximum number of memory ranges in cache_map, where
  * no 2 adjacent ranges have the same cache mode (those would be merged).
@@ -515,6 +532,14 @@ void __init mtrr_build_map(void)
 	pr_info("MTRR map: %u entries (%u fixed + %u variable; max %u), built from %u variable MTRRs\n",
 		cache_map_n, cache_map_fixed, cache_map_n - cache_map_fixed,
 		get_cache_map_size(), num_var_ranges + (mtrr_tom2 != 0));
+
+	if (mtrr_debug) {
+		for (i = 0; i < cache_map_n; i++) {
+			pr_info("%3u: %016llx-%016llx %s\n", i,
+				cache_map[i].start, cache_map[i].end - 1,
+				mtrr_attrib_to_str(cache_map[i].type));
+		}
+	}
 }
 
 /* Copy the cache_map from __initdata memory to dynamically allocated one. */
@@ -721,8 +746,8 @@ static void __init print_fixed_last(void)
 	if (!last_fixed_end)
 		return;
 
-	pr_debug("  %05X-%05X %s\n", last_fixed_start,
-		 last_fixed_end - 1, mtrr_attrib_to_str(last_fixed_type));
+	pr_info("  %05X-%05X %s\n", last_fixed_start,
+		last_fixed_end - 1, mtrr_attrib_to_str(last_fixed_type));
 
 	last_fixed_end = 0;
 }
@@ -760,10 +785,10 @@ static void __init print_mtrr_state(void)
 	unsigned int i;
 	int high_width;
 
-	pr_debug("MTRR default type: %s\n",
-		 mtrr_attrib_to_str(mtrr_state.def_type));
+	pr_info("MTRR default type: %s\n",
+		mtrr_attrib_to_str(mtrr_state.def_type));
 	if (mtrr_state.have_fixed) {
-		pr_debug("MTRR fixed ranges %sabled:\n",
+		pr_info("MTRR fixed ranges %sabled:\n",
 			((mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED) &&
 			 (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)) ?
 			 "en" : "dis");
@@ -778,27 +803,27 @@ static void __init print_mtrr_state(void)
 		/* tail */
 		print_fixed_last();
 	}
-	pr_debug("MTRR variable ranges %sabled:\n",
-		 mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED ? "en" : "dis");
+	pr_info("MTRR variable ranges %sabled:\n",
+		mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED ? "en" : "dis");
 	high_width = (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {
 		if (mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V)
-			pr_debug("  %u base %0*X%05X000 mask %0*X%05X000 %s\n",
-				 i,
-				 high_width,
-				 mtrr_state.var_ranges[i].base_hi,
-				 mtrr_state.var_ranges[i].base_lo >> 12,
-				 high_width,
-				 mtrr_state.var_ranges[i].mask_hi,
-				 mtrr_state.var_ranges[i].mask_lo >> 12,
-				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo &
+			pr_info("  %u base %0*X%05X000 mask %0*X%05X000 %s\n",
+				i,
+				high_width,
+				mtrr_state.var_ranges[i].base_hi,
+				mtrr_state.var_ranges[i].base_lo >> 12,
+				high_width,
+				mtrr_state.var_ranges[i].mask_hi,
+				mtrr_state.var_ranges[i].mask_lo >> 12,
+				mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo &
 						    MTRR_PHYSBASE_TYPE));
 		else
-			pr_debug("  %u disabled\n", i);
+			pr_info("  %u disabled\n", i);
 	}
 	if (mtrr_tom2)
-		pr_debug("TOM2: %016llx aka %lldM\n", mtrr_tom2, mtrr_tom2>>20);
+		pr_info("TOM2: %016llx aka %lldM\n", mtrr_tom2, mtrr_tom2>>20);
 }
 
 /* Grab all of the MTRR state for this CPU into *state */
@@ -833,7 +858,8 @@ bool __init get_mtrr_state(void)
 		mtrr_tom2 &= 0xffffff800000ULL;
 	}
 
-	print_mtrr_state();
+	if (mtrr_debug)
+		print_mtrr_state();
 
 	mtrr_state_set = 1;
 
