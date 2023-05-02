Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE186F436E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjEBMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjEBMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:11:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93B65FE7;
        Tue,  2 May 2023 05:10:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF8FD1F8BE;
        Tue,  2 May 2023 12:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UokXgkWhNqi0xmtTfifqq0OnoWcJAag/Oc0h5DkNreY=;
        b=KrWOrtFCJedieSykS9Jct4rTuBScw/RdGMiGR1JONhQcMlsDbdJihM1pMvv6wLXAdaIcsf
        /Fwzw0GF3GmtcjAZgGfp074ngH/Llni/vZRTou42txOR+hmAj0R82XuqJl5XZwRTG6VHWQ
        TZ7VV1l/7lV2H4/e53JhaCjmOfFZM0I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78192139C3;
        Tue,  2 May 2023 12:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MlsRHMr9UGQsMAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:10:50 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 12/16] x86/mtrr: add mtrr=debug command line option
Date:   Tue,  2 May 2023 14:09:27 +0200
Message-Id: <20230502120931.20719-13-jgross@suse.com>
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

Add a new command line option "mtrr=debug" for getting debug output
after building the new cache mode map. The output will include MTRR
register values and the resulting map.

For printing the MTRR register values print_mtrr_state() can be used.
Just change it to use pr_info() instead of pr_debug() and call it only
if mtrr=debug was specified.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V6:
- new patch (Boris Petkov)
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 arch/x86/kernel/cpu/mtrr/generic.c            | 64 +++++++++++++------
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..44a87ada7145 100644
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
index a6dd240a09cb..e002856a5f4e 100644
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
@@ -519,6 +536,14 @@ void __init mtrr_build_map(void)
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
@@ -725,8 +750,8 @@ static void __init print_fixed_last(void)
 	if (!last_fixed_end)
 		return;
 
-	pr_debug("  %05X-%05X %s\n", last_fixed_start,
-		 last_fixed_end - 1, mtrr_attrib_to_str(last_fixed_type));
+	pr_info("  %05X-%05X %s\n", last_fixed_start,
+		last_fixed_end - 1, mtrr_attrib_to_str(last_fixed_type));
 
 	last_fixed_end = 0;
 }
@@ -764,10 +789,10 @@ static void __init print_mtrr_state(void)
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
@@ -782,27 +807,27 @@ static void __init print_mtrr_state(void)
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
@@ -838,7 +863,8 @@ bool __init get_mtrr_state(void)
 		mtrr_tom2 &= 0xffffff800000ULL;
 	}
 
-	print_mtrr_state();
+	if (mtrr_debug)
+		print_mtrr_state();
 
 	mtrr_state_set = 1;
 
-- 
2.35.3

