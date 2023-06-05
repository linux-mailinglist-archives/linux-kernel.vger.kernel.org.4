Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4651722851
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjFEOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjFEOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402AE6;
        Mon,  5 Jun 2023 07:08:14 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6YOL9Rgt9lvDTVOb3ebTcdBIQiiEJodcNt05vT0jYo=;
        b=4hkJRa3DyVV0hllCSx18C073Yaz3ywtKHUB8GTw1c9zFtIF9WPNC1Na91k80NWLinJbi/9
        eHv6uu5Znc7eXpqtXQuJH1bXF3ZtRkEk84nqsybgaUO5IhSfBj6OPYGT4pJw2MUIrW7L99
        3bibuSGd0PdKt8XjJD4JOrUAE4hjR+3YFyfllt2lzqUUrmxanlb22WJ23SZynRDuLKwyK7
        /RPxMAYnWu4rt9RvnaPRYB9Xz00wBStazGUWC9ci+3kY901iPLv83+/JSUax/Yh9Aw86p4
        b7yX4bVL08QXlDM0d2ysrrlWN5anueQexSgBgk0SndI2Alfvh6PcEckAxIPenQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/6YOL9Rgt9lvDTVOb3ebTcdBIQiiEJodcNt05vT0jYo=;
        b=cOZ7JmDxgKFi0ySah6n5i6Wv9qwklg3S61GWLpo1ydYlSv7l2tDbchY0iJxTLvLqMuzLdd
        nVm8KHNKbPP3xDCQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Unify debugging printing
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
References: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
MIME-Version: 1.0
Message-ID: <168597409240.404.7826107142104196133.tip-bot2@tip-bot2>
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

Commit-ID:     7c1dee734f3b8003429c40fb9186401485670dfd
Gitweb:        https://git.kernel.org/tip/7c1dee734f3b8003429c40fb9186401485670dfd
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 31 May 2023 19:23:34 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Unify debugging printing

Put all the debugging output behind "mtrr=debug" and get rid of
"mtrr_cleanup_debug" which wasn't even documented anywhere.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 59 +++++++++++------------------
 arch/x86/kernel/cpu/mtrr/generic.c |  2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  5 +--
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  3 +-
 4 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index ed5f84c..18cf79d 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -55,9 +55,6 @@ static int __initdata				nr_range;
 
 static struct var_mtrr_range_state __initdata	range_state[RANGE_NUM];
 
-static int __initdata debug_print;
-#define Dprintk(x...) do { if (debug_print) pr_debug(x); } while (0)
-
 #define BIOS_BUG_MSG \
 	"WARNING: BIOS bug: VAR MTRR %d contains strange UC entry under 1M, check with your system vendor!\n"
 
@@ -79,12 +76,11 @@ x86_get_mtrr_mem_range(struct range *range, int nr_range,
 		nr_range = add_range_with_merge(range, RANGE_NUM, nr_range,
 						base, base + size);
 	}
-	if (debug_print) {
-		pr_debug("After WB checking\n");
-		for (i = 0; i < nr_range; i++)
-			pr_debug("MTRR MAP PFN: %016llx - %016llx\n",
-				 range[i].start, range[i].end);
-	}
+
+	Dprintk("After WB checking\n");
+	for (i = 0; i < nr_range; i++)
+		Dprintk("MTRR MAP PFN: %016llx - %016llx\n",
+			 range[i].start, range[i].end);
 
 	/* Take out UC ranges: */
 	for (i = 0; i < num_var_ranges; i++) {
@@ -112,24 +108,22 @@ x86_get_mtrr_mem_range(struct range *range, int nr_range,
 		subtract_range(range, RANGE_NUM, extra_remove_base,
 				 extra_remove_base + extra_remove_size);
 
-	if  (debug_print) {
-		pr_debug("After UC checking\n");
-		for (i = 0; i < RANGE_NUM; i++) {
-			if (!range[i].end)
-				continue;
-			pr_debug("MTRR MAP PFN: %016llx - %016llx\n",
-				 range[i].start, range[i].end);
-		}
+	Dprintk("After UC checking\n");
+	for (i = 0; i < RANGE_NUM; i++) {
+		if (!range[i].end)
+			continue;
+
+		Dprintk("MTRR MAP PFN: %016llx - %016llx\n",
+			 range[i].start, range[i].end);
 	}
 
 	/* sort the ranges */
 	nr_range = clean_sort_range(range, RANGE_NUM);
-	if  (debug_print) {
-		pr_debug("After sorting\n");
-		for (i = 0; i < nr_range; i++)
-			pr_debug("MTRR MAP PFN: %016llx - %016llx\n",
-				 range[i].start, range[i].end);
-	}
+
+	Dprintk("After sorting\n");
+	for (i = 0; i < nr_range; i++)
+		Dprintk("MTRR MAP PFN: %016llx - %016llx\n",
+			range[i].start, range[i].end);
 
 	return nr_range;
 }
@@ -164,13 +158,6 @@ static int __init enable_mtrr_cleanup_setup(char *str)
 }
 early_param("enable_mtrr_cleanup", enable_mtrr_cleanup_setup);
 
-static int __init mtrr_cleanup_debug_setup(char *str)
-{
-	debug_print = 1;
-	return 0;
-}
-early_param("mtrr_cleanup_debug", mtrr_cleanup_debug_setup);
-
 static void __init
 set_var_mtrr(unsigned int reg, unsigned long basek, unsigned long sizek,
 	     unsigned char type)
@@ -267,7 +254,7 @@ range_to_mtrr(unsigned int reg, unsigned long range_startk,
 			align = max_align;
 
 		sizek = 1UL << align;
-		if (debug_print) {
+		if (mtrr_debug) {
 			char start_factor = 'K', size_factor = 'K';
 			unsigned long start_base, size_base;
 
@@ -542,7 +529,7 @@ static void __init print_out_mtrr_range_state(void)
 		start_base = to_size_factor(start_base, &start_factor);
 		type = range_state[i].type;
 
-		pr_debug("reg %d, base: %ld%cB, range: %ld%cB, type %s\n",
+		Dprintk("reg %d, base: %ld%cB, range: %ld%cB, type %s\n",
 			i, start_base, start_factor,
 			size_base, size_factor,
 			(type == MTRR_TYPE_UNCACHABLE) ? "UC" :
@@ -714,7 +701,7 @@ int __init mtrr_cleanup(void)
 		return 0;
 
 	/* Print original var MTRRs at first, for debugging: */
-	pr_debug("original variable MTRRs\n");
+	Dprintk("original variable MTRRs\n");
 	print_out_mtrr_range_state();
 
 	memset(range, 0, sizeof(range));
@@ -746,7 +733,7 @@ int __init mtrr_cleanup(void)
 
 		if (!result[i].bad) {
 			set_var_mtrr_all();
-			pr_debug("New variable MTRRs\n");
+			Dprintk("New variable MTRRs\n");
 			print_out_mtrr_range_state();
 			return 1;
 		}
@@ -766,7 +753,7 @@ int __init mtrr_cleanup(void)
 
 			mtrr_calc_range_state(chunk_size, gran_size,
 				      x_remove_base, x_remove_size, i);
-			if (debug_print) {
+			if (mtrr_debug) {
 				mtrr_print_out_one_result(i);
 				pr_info("\n");
 			}
@@ -790,7 +777,7 @@ int __init mtrr_cleanup(void)
 		gran_size <<= 10;
 		x86_setup_var_mtrrs(range, nr_range, chunk_size, gran_size);
 		set_var_mtrr_all();
-		pr_debug("New variable MTRRs\n");
+		Dprintk("New variable MTRRs\n");
 		print_out_mtrr_range_state();
 		return 1;
 	} else {
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index f6b426d..2d6aa5d 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -41,7 +41,7 @@ struct cache_map {
 	u64 fixed:1;
 };
 
-static bool mtrr_debug;
+bool mtrr_debug;
 
 static int __init mtrr_param_setup(char *str)
 {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index ec8670b..767bf1c 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -332,7 +332,7 @@ static int mtrr_check(unsigned long base, unsigned long size)
 {
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
 		pr_warn("size and base must be multiples of 4 kiB\n");
-		pr_debug("size: 0x%lx  base: 0x%lx\n", size, base);
+		Dprintk("size: 0x%lx  base: 0x%lx\n", size, base);
 		dump_stack();
 		return -1;
 	}
@@ -423,8 +423,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 			}
 		}
 		if (reg < 0) {
-			pr_debug("no MTRR for %lx000,%lx000 found\n",
-				 base, size);
+			Dprintk("no MTRR for %lx000,%lx000 found\n", base, size);
 			goto out;
 		}
 	}
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 8385d7d..5655f25 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -10,6 +10,9 @@
 #define MTRR_CHANGE_MASK_VARIABLE  0x02
 #define MTRR_CHANGE_MASK_DEFTYPE   0x04
 
+extern bool mtrr_debug;
+#define Dprintk(x...) do { if (mtrr_debug) pr_info(x); } while (0)
+
 extern unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 
 struct mtrr_ops {
