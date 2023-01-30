Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E92681BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjA3UvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjA3Uu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:50:56 -0500
Received: from out-232.mta0.migadu.com (out-232.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FBA2B0A5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:50:54 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ThIc/E8It52Ai7wF9nGezLQDQ6i5NEX+ZonMvNBuyU=;
        b=oaNF1e2Zp8D74xhXSi9Xe8Em5fla04L3chl/gZgXxmenAMqSyBOC0TK0L+frAQoublm+D6
        y3a+B2b/IEkOa1iD1H2U0A+sIMqhuheKhY5InYI2bt99cXYWbPbe8vQKOEBSspaWphgQIM
        onT6jzEMY8KySqyE2k0QGKr+jJVppcs=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 09/18] lib/stackdepot: rename hash table constants and variables
Date:   Mon, 30 Jan 2023 21:49:33 +0100
Message-Id: <5456286e2c9f3cd5abf25ad2e7e60dc997c71f66.1675111415.git.andreyknvl@google.com>
In-Reply-To: <cover.1675111415.git.andreyknvl@google.com>
References: <cover.1675111415.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Give more meaningful names to hash table-related constants and variables:

1. Rename STACK_HASH_SCALE to STACK_TABLE_SCALE to point out that it is
   related to scaling the hash table.

2. Rename STACK_HASH_ORDER_MIN/MAX to STACK_BUCKET_NUMBER_ORDER_MIN/MAX
   to point out that it is related to the number of hash table buckets.

3. Rename stack_hash_order to stack_bucket_number_order for the same
   reason as #2.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 89aee133303a..cddcf029e307 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -76,17 +76,17 @@ static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_ST
 static bool __stack_depot_early_init_passed __initdata;
 
 /* Use one hash table bucket per 16 KB of memory. */
-#define STACK_HASH_SCALE	14
+#define STACK_TABLE_SCALE 14
 /* Limit the number of buckets between 4K and 1M. */
-#define STACK_HASH_ORDER_MIN	12
-#define STACK_HASH_ORDER_MAX	20
+#define STACK_BUCKET_NUMBER_ORDER_MIN 12
+#define STACK_BUCKET_NUMBER_ORDER_MAX 20
 /* Initial seed for jhash2. */
 #define STACK_HASH_SEED 0x9747b28c
 
 /* Hash table of pointers to stored stack traces. */
 static struct stack_record **stack_table;
 /* Fixed order of the number of table buckets. Used when KASAN is enabled. */
-static unsigned int stack_hash_order;
+static unsigned int stack_bucket_number_order;
 /* Hash mask for indexing the table. */
 static unsigned int stack_hash_mask;
 
@@ -137,28 +137,28 @@ int __init stack_depot_early_init(void)
 	 * in fuzzing scenarios, which leads to a large number of different
 	 * stack traces being stored in stack depot.
 	 */
-	if (kasan_enabled() && !stack_hash_order)
-		stack_hash_order = STACK_HASH_ORDER_MAX;
+	if (kasan_enabled() && !stack_bucket_number_order)
+		stack_bucket_number_order = STACK_BUCKET_NUMBER_ORDER_MAX;
 
 	if (!__stack_depot_early_init_requested || stack_depot_disabled)
 		return 0;
 
 	/*
-	 * If stack_hash_order is not set, leave entries as 0 to rely on the
-	 * automatic calculations performed by alloc_large_system_hash.
+	 * If stack_bucket_number_order is not set, leave entries as 0 to rely
+	 * on the automatic calculations performed by alloc_large_system_hash.
 	 */
-	if (stack_hash_order)
-		entries = 1UL << stack_hash_order;
+	if (stack_bucket_number_order)
+		entries = 1UL << stack_bucket_number_order;
 	pr_info("allocating hash table via alloc_large_system_hash\n");
 	stack_table = alloc_large_system_hash("stackdepot",
 						sizeof(struct stack_record *),
 						entries,
-						STACK_HASH_SCALE,
+						STACK_TABLE_SCALE,
 						HASH_EARLY | HASH_ZERO,
 						NULL,
 						&stack_hash_mask,
-						1UL << STACK_HASH_ORDER_MIN,
-						1UL << STACK_HASH_ORDER_MAX);
+						1UL << STACK_BUCKET_NUMBER_ORDER_MIN,
+						1UL << STACK_BUCKET_NUMBER_ORDER_MAX);
 	if (!stack_table) {
 		pr_err("hash table allocation failed, disabling\n");
 		stack_depot_disabled = true;
@@ -181,13 +181,13 @@ int stack_depot_init(void)
 		goto out_unlock;
 
 	/*
-	 * Similarly to stack_depot_early_init, use stack_hash_order
+	 * Similarly to stack_depot_early_init, use stack_bucket_number_order
 	 * if assigned, and rely on automatic scaling otherwise.
 	 */
-	if (stack_hash_order) {
-		entries = 1UL << stack_hash_order;
+	if (stack_bucket_number_order) {
+		entries = 1UL << stack_bucket_number_order;
 	} else {
-		int scale = STACK_HASH_SCALE;
+		int scale = STACK_TABLE_SCALE;
 
 		entries = nr_free_buffer_pages();
 		entries = roundup_pow_of_two(entries);
@@ -198,10 +198,10 @@ int stack_depot_init(void)
 			entries <<= (PAGE_SHIFT - scale);
 	}
 
-	if (entries < 1UL << STACK_HASH_ORDER_MIN)
-		entries = 1UL << STACK_HASH_ORDER_MIN;
-	if (entries > 1UL << STACK_HASH_ORDER_MAX)
-		entries = 1UL << STACK_HASH_ORDER_MAX;
+	if (entries < 1UL << STACK_BUCKET_NUMBER_ORDER_MIN)
+		entries = 1UL << STACK_BUCKET_NUMBER_ORDER_MIN;
+	if (entries > 1UL << STACK_BUCKET_NUMBER_ORDER_MAX)
+		entries = 1UL << STACK_BUCKET_NUMBER_ORDER_MAX;
 
 	pr_info("allocating hash table of %lu entries via kvcalloc\n", entries);
 	stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
-- 
2.25.1

