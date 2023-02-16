Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A2699B89
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBPRsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBPRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:48:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044544C3F8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676569635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=blWK0SRcDdae8keGRRM8FpEp32/QxHaadHljMinb1BI=;
        b=izhneq7glk95eYK0bu0dPA2Z22cSeQozTHfvNR2jDQ9CILAkYFz4mqmRP1gLAIMptS3u2j
        2LcZT1tQIPK7sWliXMVbFSTgfiPrfACBBTvvVXLj3xJJ5Sr9maMWe2Bi1YYYEJ/GCLzsvr
        cRqGLFB8dyRwtlzXdN0OnAaXWHtVQOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-pr65g2nCNQuTPbjqXP78rA-1; Thu, 16 Feb 2023 12:47:10 -0500
X-MC-Unique: pr65g2nCNQuTPbjqXP78rA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DA0985A5A3;
        Thu, 16 Feb 2023 17:47:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CE0A2166B30;
        Thu, 16 Feb 2023 17:47:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 31GHl8ID024130;
        Thu, 16 Feb 2023 12:47:08 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 31GHl8mk024126;
        Thu, 16 Feb 2023 12:47:08 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 16 Feb 2023 12:47:08 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     snitzer@kernel.org, Yang Shi <shy828301@gmail.com>
cc:     mgorman@techsingularity.net, agk@redhat.com, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dm-crypt: allocate compound pages if possible
Message-ID: <alpine.LRH.2.21.2302161245210.18393@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that allocating pages for the write buffer in dm-crypt
causes measurable overhead [1].

This patch changes dm-crypt to allocate compound pages if they are
available. If not, we fall back to the mempool.

[1] https://listman.redhat.com/archives/dm-devel/2023-February/053284.html

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-crypt.c |   50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-crypt.c	2023-01-20 13:22:38.000000000 +0100
+++ linux-2.6/drivers/md/dm-crypt.c	2023-02-16 18:33:42.000000000 +0100
@@ -1657,6 +1657,9 @@ static void crypt_free_buffer_pages(stru
  * In order to not degrade performance with excessive locking, we try
  * non-blocking allocations without a mutex first but on failure we fallback
  * to blocking allocations with a mutex.
+ *
+ * In order to reduce allocation overhead, we try to allocate compound pages in
+ * the first pass. If they are not available, we fall back to the mempool.
  */
 static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
 {
@@ -1664,8 +1667,9 @@ static struct bio *crypt_alloc_buffer(st
 	struct bio *clone;
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
-	unsigned i, len, remaining_size;
+	unsigned remaining_size;
 	struct page *page;
+	unsigned order = MAX_ORDER - 1;
 
 retry:
 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
@@ -1678,20 +1682,37 @@ retry:
 
 	remaining_size = size;
 
-	for (i = 0; i < nr_iovecs; i++) {
+	while (remaining_size) {
+		unsigned o;
+		unsigned remaining_order = __fls((remaining_size + PAGE_SIZE - 1) >> PAGE_SHIFT);
+		order = min(order, remaining_order);
+
+		while (order > 0) {
+			page = alloc_pages(gfp_mask
+				| __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN, order);
+			if (likely(page != NULL))
+				goto have_pages;
+			order--;
+		}
+
 		page = mempool_alloc(&cc->page_pool, gfp_mask);
 		if (!page) {
 			crypt_free_buffer_pages(cc, clone);
 			bio_put(clone);
 			gfp_mask |= __GFP_DIRECT_RECLAIM;
+			order = 0;
 			goto retry;
 		}
 
-		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
-
-		bio_add_page(clone, page, len, 0);
+have_pages:
+		page->compound_order = order;
 
-		remaining_size -= len;
+		for (o = 0; o < 1U << order; o++) {
+			unsigned len = min((unsigned)PAGE_SIZE, remaining_size);
+			bio_add_page(clone, page, len, 0);
+			remaining_size -= len;
+			page++;
+		}
 	}
 
 	/* Allocate space for integrity tags */
@@ -1711,10 +1732,23 @@ static void crypt_free_buffer_pages(stru
 {
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
+	unsigned skip_entries = 0;
 
 	bio_for_each_segment_all(bv, clone, iter_all) {
-		BUG_ON(!bv->bv_page);
-		mempool_free(bv->bv_page, &cc->page_pool);
+		unsigned order;
+		struct page *page = bv->bv_page;
+		BUG_ON(!page);
+		if (skip_entries) {
+			skip_entries--;
+			continue;
+		}
+		order = page->compound_order;
+		if (order) {
+			__free_pages(page, order);
+			skip_entries = (1U << order) - 1;
+		} else {
+			mempool_free(page, &cc->page_pool);
+		}
 	}
 }
 

