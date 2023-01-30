Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17010681BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjA3Uw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjA3UwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:52:12 -0500
Received: from out-80.mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741F45220
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:51:58 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HatpIAXF9ywMATjIlRO5zkwkJoWVcZESn/qWFP01cUE=;
        b=wXtDfrkYlD8IpL/lQ8l++bN1YdtjxhnwL1anSh49Js2VOzOsVnOBIPbJSklgemF2REahtq
        DvdvaNag4m/GqwVZu03XHDBsOWpGjVLbIuihC73epl6av328Yy8aLHk/DlbB90DLAwCqg2
        4Z44QfKvcXgws9zhTONc9RpzBkBuxac=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 16/18] lib/stackdepot: annotate racy slab_index accesses
Date:   Mon, 30 Jan 2023 21:49:40 +0100
Message-Id: <19512bb03eed27ced5abeb5bd03f9a8381742cb1.1675111415.git.andreyknvl@google.com>
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

Accesses to slab_index are protected by slab_lock everywhere except
in a sanity check in stack_depot_fetch. The read access there can race
with the write access in depot_alloc_stack.

Use WRITE/READ_ONCE() to annotate the racy accesses.

As the sanity check is only used to print a warning in case of a
violation of the stack depot interface usage, it does not make a lot
of sense to use proper synchronization.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index f291ad6a4e72..cc2fe8563af4 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -269,8 +269,11 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 			return NULL;
 		}
 
-		/* Move on to the next slab. */
-		slab_index++;
+		/*
+		 * Move on to the next slab.
+		 * WRITE_ONCE annotates a race with stack_depot_fetch.
+		 */
+		WRITE_ONCE(slab_index, slab_index + 1);
 		slab_offset = 0;
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() in
@@ -492,6 +495,8 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
 	union handle_parts parts = { .handle = handle };
+	/* READ_ONCE annotates a race with depot_alloc_stack. */
+	int slab_index_cached = READ_ONCE(slab_index);
 	void *slab;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
@@ -500,9 +505,9 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle)
 		return 0;
 
-	if (parts.slab_index > slab_index) {
+	if (parts.slab_index > slab_index_cached) {
 		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
-			parts.slab_index, slab_index, handle);
+			parts.slab_index, slab_index_cached, handle);
 		return 0;
 	}
 	slab = stack_slabs[parts.slab_index];
-- 
2.25.1

