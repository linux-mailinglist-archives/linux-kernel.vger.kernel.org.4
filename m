Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702E0681BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjA3U4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjA3U4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:56:14 -0500
Received: from out-151.mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D91402E6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:56:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePKn7wp1b3FbqZznSS/x2B/da1B4by5dKxtQzEtZAxA=;
        b=cW/knli1mct1hN8VKhy84oK1lCkEnRxbrn0Bzq8wHyRAEtZylNL8NaxR82FYgXhxPOV45q
        TiG9opJh/CR4Dl6WT16EtZJq6GOEh34hNr0pi0fJZgIAo5qxMs/0msRB3R0d/2Og6PYwqq
        qlelPQSU7Sr1vmkhLpJj+wl66a2Q8a4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 04/18] lib/stackdepot, mm: rename stack_depot_want_early_init
Date:   Mon, 30 Jan 2023 21:49:28 +0100
Message-Id: <cb34925852c81be2ec6aac75766292e4e590523e.1675111415.git.andreyknvl@google.com>
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

Rename stack_depot_want_early_init to stack_depot_request_early_init.

The old name is confusing, as it hints at returning some kind of intention
of stack depot. The new name reflects that this function requests an action
from stack depot instead.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/stackdepot.h | 14 +++++++-------
 lib/stackdepot.c           | 10 +++++-----
 mm/page_owner.c            |  2 +-
 mm/slub.c                  |  4 ++--
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 1296a6eeaec0..c4e3abc16b16 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -31,26 +31,26 @@ typedef u32 depot_stack_handle_t;
  * enabled as part of mm_init(), for subsystems where it's known at compile time
  * that stack depot will be used.
  *
- * Another alternative is to call stack_depot_want_early_init(), when the
+ * Another alternative is to call stack_depot_request_early_init(), when the
  * decision to use stack depot is taken e.g. when evaluating kernel boot
  * parameters, which precedes the enablement point in mm_init().
  *
- * stack_depot_init() and stack_depot_want_early_init() can be called regardless
- * of CONFIG_STACKDEPOT and are no-op when disabled. The actual save/fetch/print
- * functions should only be called from code that makes sure CONFIG_STACKDEPOT
- * is enabled.
+ * stack_depot_init() and stack_depot_request_early_init() can be called
+ * regardless of CONFIG_STACKDEPOT and are no-op when disabled. The actual
+ * save/fetch/print functions should only be called from code that makes sure
+ * CONFIG_STACKDEPOT is enabled.
  */
 #ifdef CONFIG_STACKDEPOT
 int stack_depot_init(void);
 
-void __init stack_depot_want_early_init(void);
+void __init stack_depot_request_early_init(void);
 
 /* This is supposed to be called only from mm_init() */
 int __init stack_depot_early_init(void);
 #else
 static inline int stack_depot_init(void) { return 0; }
 
-static inline void stack_depot_want_early_init(void) { }
+static inline void stack_depot_request_early_init(void) { }
 
 static inline int stack_depot_early_init(void)	{ return 0; }
 #endif
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 90c4dd48d75e..8743fad1485f 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -71,7 +71,7 @@ struct stack_record {
 	unsigned long entries[];	/* Variable-sized array of entries. */
 };
 
-static bool __stack_depot_want_early_init __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
+static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
 
 static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
@@ -107,12 +107,12 @@ static int __init is_stack_depot_disabled(char *str)
 }
 early_param("stack_depot_disable", is_stack_depot_disabled);
 
-void __init stack_depot_want_early_init(void)
+void __init stack_depot_request_early_init(void)
 {
-	/* Too late to request early init now */
+	/* Too late to request early init now. */
 	WARN_ON(__stack_depot_early_init_passed);
 
-	__stack_depot_want_early_init = true;
+	__stack_depot_early_init_requested = true;
 }
 
 int __init stack_depot_early_init(void)
@@ -128,7 +128,7 @@ int __init stack_depot_early_init(void)
 	if (kasan_enabled() && !stack_hash_order)
 		stack_hash_order = STACK_HASH_ORDER_MAX;
 
-	if (!__stack_depot_want_early_init || stack_depot_disable)
+	if (!__stack_depot_early_init_requested || stack_depot_disable)
 		return 0;
 
 	if (stack_hash_order)
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d27f532df4c..90a4a087e6c7 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -48,7 +48,7 @@ static int __init early_page_owner_param(char *buf)
 	int ret = kstrtobool(buf, &page_owner_enabled);
 
 	if (page_owner_enabled)
-		stack_depot_want_early_init();
+		stack_depot_request_early_init();
 
 	return ret;
 }
diff --git a/mm/slub.c b/mm/slub.c
index 13459c69095a..f2c6c356bc36 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1592,7 +1592,7 @@ static int __init setup_slub_debug(char *str)
 		} else {
 			slab_list_specified = true;
 			if (flags & SLAB_STORE_USER)
-				stack_depot_want_early_init();
+				stack_depot_request_early_init();
 		}
 	}
 
@@ -1611,7 +1611,7 @@ static int __init setup_slub_debug(char *str)
 out:
 	slub_debug = global_flags;
 	if (slub_debug & SLAB_STORE_USER)
-		stack_depot_want_early_init();
+		stack_depot_request_early_init();
 	if (slub_debug != 0 || slub_debug_string)
 		static_branch_enable(&slub_debug_enabled);
 	else
-- 
2.25.1

