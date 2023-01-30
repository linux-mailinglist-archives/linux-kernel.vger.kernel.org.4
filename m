Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B73681BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjA3Uu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjA3Uuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:50:54 -0500
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51C10AA2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:50:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjOybIkwS91rz6SeT9/1Q1LG8Upe4qgP6MFeV739ipg=;
        b=OaUFrjC9mmR+C+LBAr653ALAA4e7MQZabwuqvf4knolohngrfhCy2mosvw6gzcWCNRkTMN
        e4lFrKKKYsFoufKHKOU+htEFWJY05stO+hGZZ42o5pGje6WBWk41AYL8bVD4znF7k68LuE
        CXnkNDDkYwdEcPDPk+BQYLTO4g/oDug=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 07/18] lib/stackdepot: lower the indentation in stack_depot_init
Date:   Mon, 30 Jan 2023 21:49:31 +0100
Message-Id: <eb6f0a014b8d0bfa73a8bbd358c627dc66cf51b7.1675111415.git.andreyknvl@google.com>
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

stack_depot_init does most things inside an if check. Move them out and
use a goto statement instead.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 70 +++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index b06f6a5caa83..cb098bc99286 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -165,46 +165,50 @@ int __init stack_depot_early_init(void)
 int stack_depot_init(void)
 {
 	static DEFINE_MUTEX(stack_depot_init_mutex);
+	unsigned long entries;
 	int ret = 0;
 
 	mutex_lock(&stack_depot_init_mutex);
-	if (!stack_depot_disabled && !stack_table) {
-		unsigned long entries;
 
-		/*
-		 * Similarly to stack_depot_early_init, use stack_hash_order
-		 * if assigned, and rely on automatic scaling otherwise.
-		 */
-		if (stack_hash_order) {
-			entries = 1UL << stack_hash_order;
-		} else {
-			int scale = STACK_HASH_SCALE;
-
-			entries = nr_free_buffer_pages();
-			entries = roundup_pow_of_two(entries);
-
-			if (scale > PAGE_SHIFT)
-				entries >>= (scale - PAGE_SHIFT);
-			else
-				entries <<= (PAGE_SHIFT - scale);
-		}
+	if (stack_depot_disabled || stack_table)
+		goto out_unlock;
 
-		if (entries < 1UL << STACK_HASH_ORDER_MIN)
-			entries = 1UL << STACK_HASH_ORDER_MIN;
-		if (entries > 1UL << STACK_HASH_ORDER_MAX)
-			entries = 1UL << STACK_HASH_ORDER_MAX;
-
-		pr_info("allocating hash table of %lu entries via kvcalloc\n",
-				entries);
-		stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
-		if (!stack_table) {
-			pr_err("hash table allocation failed, disabling\n");
-			stack_depot_disabled = true;
-			ret = -ENOMEM;
-		}
-		stack_hash_mask = entries - 1;
+	/*
+	 * Similarly to stack_depot_early_init, use stack_hash_order
+	 * if assigned, and rely on automatic scaling otherwise.
+	 */
+	if (stack_hash_order) {
+		entries = 1UL << stack_hash_order;
+	} else {
+		int scale = STACK_HASH_SCALE;
+
+		entries = nr_free_buffer_pages();
+		entries = roundup_pow_of_two(entries);
+
+		if (scale > PAGE_SHIFT)
+			entries >>= (scale - PAGE_SHIFT);
+		else
+			entries <<= (PAGE_SHIFT - scale);
 	}
+
+	if (entries < 1UL << STACK_HASH_ORDER_MIN)
+		entries = 1UL << STACK_HASH_ORDER_MIN;
+	if (entries > 1UL << STACK_HASH_ORDER_MAX)
+		entries = 1UL << STACK_HASH_ORDER_MAX;
+
+	pr_info("allocating hash table of %lu entries via kvcalloc\n", entries);
+	stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
+	if (!stack_table) {
+		pr_err("hash table allocation failed, disabling\n");
+		stack_depot_disabled = true;
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+	stack_hash_mask = entries - 1;
+
+out_unlock:
 	mutex_unlock(&stack_depot_init_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
-- 
2.25.1

