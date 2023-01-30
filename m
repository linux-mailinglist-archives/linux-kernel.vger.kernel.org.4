Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03F681BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjA3Uu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjA3Uuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:50:54 -0500
Received: from out-223.mta0.migadu.com (out-223.mta0.migadu.com [IPv6:2001:41d0:1004:224b::df])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A507ABF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:50:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXUvy5WDZhr7BlKZ84VBiDQ9FKi0bXR5FVmrmN5uemo=;
        b=qTAqH/h3lvp3LBinh9ZgKXdhYP02imBJEuB8uqH1iUms1FkvE7RqMS6kgwiVfxPo6dPFiZ
        INjsSD6+m11nC0jZlXtAXeRY8JnQiDDTw74kkvq8iy8WIY5f1IjA3puf+2wSsDQv7yH1KS
        kCzz9lKkR7o1ZLchiqq6nGUmdZMJN3g=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 06/18] lib/stackdepot: annotate init and early init functions
Date:   Mon, 30 Jan 2023 21:49:30 +0100
Message-Id: <be09b64fb196ffe0c19ce7afc4130efba5425df9.1675111415.git.andreyknvl@google.com>
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

Add comments to stack_depot_early_init and stack_depot_init to explain
certain parts of their implementation.

Also add a pr_info message to stack_depot_early_init similar to the one
in stack_depot_init.

Also move the scale variable in stack_depot_init to the scope where it
is being used.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 6e8aef12cf89..b06f6a5caa83 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -115,24 +115,34 @@ void __init stack_depot_request_early_init(void)
 	__stack_depot_early_init_requested = true;
 }
 
+/* Allocates a hash table via memblock. Can only be used during early boot. */
 int __init stack_depot_early_init(void)
 {
 	unsigned long entries = 0;
 
-	/* This is supposed to be called only once, from mm_init() */
+	/* This function must be called only once, from mm_init(). */
 	if (WARN_ON(__stack_depot_early_init_passed))
 		return 0;
-
 	__stack_depot_early_init_passed = true;
 
+	/*
+	 * If KASAN is enabled, use the maximum order: KASAN is frequently used
+	 * in fuzzing scenarios, which leads to a large number of different
+	 * stack traces being stored in stack depot.
+	 */
 	if (kasan_enabled() && !stack_hash_order)
 		stack_hash_order = STACK_HASH_ORDER_MAX;
 
 	if (!__stack_depot_early_init_requested || stack_depot_disabled)
 		return 0;
 
+	/*
+	 * If stack_hash_order is not set, leave entries as 0 to rely on the
+	 * automatic calculations performed by alloc_large_system_hash.
+	 */
 	if (stack_hash_order)
-		entries = 1UL <<  stack_hash_order;
+		entries = 1UL << stack_hash_order;
+	pr_info("allocating hash table via alloc_large_system_hash\n");
 	stack_table = alloc_large_system_hash("stackdepot",
 						sizeof(struct stack_record *),
 						entries,
@@ -142,7 +152,6 @@ int __init stack_depot_early_init(void)
 						&stack_hash_mask,
 						1UL << STACK_HASH_ORDER_MIN,
 						1UL << STACK_HASH_ORDER_MAX);
-
 	if (!stack_table) {
 		pr_err("hash table allocation failed, disabling\n");
 		stack_depot_disabled = true;
@@ -152,6 +161,7 @@ int __init stack_depot_early_init(void)
 	return 0;
 }
 
+/* Allocates a hash table via kvmalloc. Can be used after boot. */
 int stack_depot_init(void)
 {
 	static DEFINE_MUTEX(stack_depot_init_mutex);
@@ -160,11 +170,16 @@ int stack_depot_init(void)
 	mutex_lock(&stack_depot_init_mutex);
 	if (!stack_depot_disabled && !stack_table) {
 		unsigned long entries;
-		int scale = STACK_HASH_SCALE;
 
+		/*
+		 * Similarly to stack_depot_early_init, use stack_hash_order
+		 * if assigned, and rely on automatic scaling otherwise.
+		 */
 		if (stack_hash_order) {
 			entries = 1UL << stack_hash_order;
 		} else {
+			int scale = STACK_HASH_SCALE;
+
 			entries = nr_free_buffer_pages();
 			entries = roundup_pow_of_two(entries);
 
@@ -179,7 +194,7 @@ int stack_depot_init(void)
 		if (entries > 1UL << STACK_HASH_ORDER_MAX)
 			entries = 1UL << STACK_HASH_ORDER_MAX;
 
-		pr_info("allocating hash table of %lu entries with kvcalloc\n",
+		pr_info("allocating hash table of %lu entries via kvcalloc\n",
 				entries);
 		stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
 		if (!stack_table) {
-- 
2.25.1

