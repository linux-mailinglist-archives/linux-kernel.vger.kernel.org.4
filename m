Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47C4681BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjA3UvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjA3Uu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:50:57 -0500
Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AEA10AA2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:50:55 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OedhC/9cTS2mJq0ENA72OMR4Ifsg2rHWEhi+f8KNzJM=;
        b=X7HUu+4VKFLQaJcV8B6kbT97Jm9iANg+sHOULAtlvOJSDASHctA+opcf+7oIrknNH8pARg
        ZnVh8nbjs5qes+RW9pvG2fcJuq86Fn6L9IoAgFzfLRdGB/OQfojrMtYNskx0G2E5v3XKHj
        VqRPxgIzxVdiKqMCcMhLKgpakaL0HPw=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 08/18] lib/stackdepot: reorder and annotate global variables
Date:   Mon, 30 Jan 2023 21:49:32 +0100
Message-Id: <4ed1d0828e837e15566a7cfa7688a47006e3f4b3.1675111415.git.andreyknvl@google.com>
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

Group stack depot global variables by their purpose:

1. Hash table-related variables,
2. Slab-related variables,

and add comments.

Also clean up comments for hash table-related constants.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index cb098bc99286..89aee133303a 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -75,24 +75,31 @@ static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
 
-static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
-
-static int depot_index;
-static int next_slab_inited;
-static size_t depot_offset;
-static DEFINE_RAW_SPINLOCK(depot_lock);
-
-/* one hash table bucket entry per 16kB of memory */
+/* Use one hash table bucket per 16 KB of memory. */
 #define STACK_HASH_SCALE	14
-/* limited between 4k and 1M buckets */
+/* Limit the number of buckets between 4K and 1M. */
 #define STACK_HASH_ORDER_MIN	12
 #define STACK_HASH_ORDER_MAX	20
+/* Initial seed for jhash2. */
 #define STACK_HASH_SEED 0x9747b28c
 
+/* Hash table of pointers to stored stack traces. */
+static struct stack_record **stack_table;
+/* Fixed order of the number of table buckets. Used when KASAN is enabled. */
 static unsigned int stack_hash_order;
+/* Hash mask for indexing the table. */
 static unsigned int stack_hash_mask;
 
-static struct stack_record **stack_table;
+/* Array of memory regions that store stack traces. */
+static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
+/* Currently used slab in stack_slabs. */
+static int depot_index;
+/* Offset to the unused space in the currently used slab. */
+static size_t depot_offset;
+/* Lock that protects the variables above. */
+static DEFINE_RAW_SPINLOCK(depot_lock);
+/* Whether the next slab is initialized. */
+static int next_slab_inited;
 
 static int __init disable_stack_depot(char *str)
 {
-- 
2.25.1

