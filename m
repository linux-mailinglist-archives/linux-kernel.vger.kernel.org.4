Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331DC681BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjA3U4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjA3U4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:56:11 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 12:56:10 PST
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3182A15A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:56:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vpL8/NdYX1/weZXFrNrkU0jpgSm404fZwOGAfIO2ueo=;
        b=l/E56Ec3WqQvEhqdZjl8IUp453ZZ1+XVexohawe9WXRwZLVX9lAj0fJNkLKpd1L0XbJ/cZ
        r7uaM/Wl4isiyHyMF6tbOKjX8DK6rY8u5FVwTS72y6me8Wdk0ledgHuQWb2LrJtfpWi2lC
        Ire9k++4IxKra40cnB4YNO9o09pIkPQ=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 01/18] lib/stackdepot: fix setting next_slab_inited in init_stack_slab
Date:   Mon, 30 Jan 2023 21:49:25 +0100
Message-Id: <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
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

In commit 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in
stack_slabs"), init_stack_slab was changed to only use preallocated
memory for the next slab if the slab number limit is not reached.
However, setting next_slab_inited was not moved together with updating
stack_slabs.

Set next_slab_inited only if the preallocated memory was used for the
next slab.

Fixes: 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in stack_slabs")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 79e894cf8406..0eed9bbcf23e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -105,12 +105,13 @@ static bool init_stack_slab(void **prealloc)
 		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
 			stack_slabs[depot_index + 1] = *prealloc;
 			*prealloc = NULL;
+			/*
+			 * This smp_store_release pairs with smp_load_acquire()
+			 * from |next_slab_inited| above and in
+			 * stack_depot_save().
+			 */
+			smp_store_release(&next_slab_inited, 1);
 		}
-		/*
-		 * This smp_store_release pairs with smp_load_acquire() from
-		 * |next_slab_inited| above and in stack_depot_save().
-		 */
-		smp_store_release(&next_slab_inited, 1);
 	}
 	return true;
 }
-- 
2.25.1

