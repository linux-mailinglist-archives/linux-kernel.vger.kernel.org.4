Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86B8692907
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjBJVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjBJVQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:16:14 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1C75375
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:16:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1W2C2HZe7YWsaOly5qIInZGLXczRmh4K22qjFQ2kImw=;
        b=SbrBALja+Ooglua5ZF4CpZXeCqhnn3ktsGqlo80JYGScIgCd0Ef8Sogpvh9B6KEJ1l9nbn
        bTrUyYzIfNYfjbYKAuyfsSFN/0AdP6+6xd5cjSKKeHV5VDBTK/njzgsYccEE+MB4tqIlLk
        Obf2ZoUmkwsQQEiMXFd5LJ0j55MgSt0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 04/18] lib/stackdepot: rename stack_depot_disable
Date:   Fri, 10 Feb 2023 22:15:52 +0100
Message-Id: <d78a07d222e689926e5ead229e4a2e3d87dc9aa7.1676063693.git.andreyknvl@google.com>
In-Reply-To: <cover.1676063693.git.andreyknvl@google.com>
References: <cover.1676063693.git.andreyknvl@google.com>
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

Rename stack_depot_disable to stack_depot_disabled to make its name look
similar to the names of other stack depot flags.

Also put stack_depot_disabled's definition together with the other flags.

Also rename is_stack_depot_disabled to disable_stack_depot: this name
looks more conventional for a function that processes a boot parameter.

No functional changes.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 136706efe339..202e07c4f02d 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -71,6 +71,7 @@ struct stack_record {
 	unsigned long entries[];	/* Variable-sized array of entries. */
 };
 
+static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
 
@@ -91,21 +92,20 @@ static DEFINE_RAW_SPINLOCK(depot_lock);
 static unsigned int stack_hash_order;
 static unsigned int stack_hash_mask;
 
-static bool stack_depot_disable;
 static struct stack_record **stack_table;
 
-static int __init is_stack_depot_disabled(char *str)
+static int __init disable_stack_depot(char *str)
 {
 	int ret;
 
-	ret = kstrtobool(str, &stack_depot_disable);
-	if (!ret && stack_depot_disable) {
+	ret = kstrtobool(str, &stack_depot_disabled);
+	if (!ret && stack_depot_disabled) {
 		pr_info("disabled\n");
 		stack_table = NULL;
 	}
 	return 0;
 }
-early_param("stack_depot_disable", is_stack_depot_disabled);
+early_param("stack_depot_disable", disable_stack_depot);
 
 void __init stack_depot_request_early_init(void)
 {
@@ -128,7 +128,7 @@ int __init stack_depot_early_init(void)
 	if (kasan_enabled() && !stack_hash_order)
 		stack_hash_order = STACK_HASH_ORDER_MAX;
 
-	if (!__stack_depot_early_init_requested || stack_depot_disable)
+	if (!__stack_depot_early_init_requested || stack_depot_disabled)
 		return 0;
 
 	if (stack_hash_order)
@@ -145,7 +145,7 @@ int __init stack_depot_early_init(void)
 
 	if (!stack_table) {
 		pr_err("hash table allocation failed, disabling\n");
-		stack_depot_disable = true;
+		stack_depot_disabled = true;
 		return -ENOMEM;
 	}
 
@@ -158,7 +158,7 @@ int stack_depot_init(void)
 	int ret = 0;
 
 	mutex_lock(&stack_depot_init_mutex);
-	if (!stack_depot_disable && !stack_table) {
+	if (!stack_depot_disabled && !stack_table) {
 		unsigned long entries;
 		int scale = STACK_HASH_SCALE;
 
@@ -184,7 +184,7 @@ int stack_depot_init(void)
 		stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
 		if (!stack_table) {
 			pr_err("hash table allocation failed, disabling\n");
-			stack_depot_disable = true;
+			stack_depot_disabled = true;
 			ret = -ENOMEM;
 		}
 		stack_hash_mask = entries - 1;
@@ -353,7 +353,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 */
 	nr_entries = filter_irq_stacks(entries, nr_entries);
 
-	if (unlikely(nr_entries == 0) || stack_depot_disable)
+	if (unlikely(nr_entries == 0) || stack_depot_disabled)
 		goto fast_exit;
 
 	hash = hash_stack(entries, nr_entries);
-- 
2.25.1

