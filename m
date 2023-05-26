Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748347127DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbjEZN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243783AbjEZN5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:57:41 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ECF1A8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685109460;
  x=1716645460;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TLZNcw1d9SH4wI8Zf0nXKgmi5A3y+ZK1ObXJei0thLo=;
  b=KIeWF3uClVvlsfAMx2vhn4bzptqW0/pgvvIOvLxDrV8IKL46g9myRjha
   xbKOdYYsgmWvQ5RZLoeyyIddl52ebGi5CthFEPoO70hhKEbEtD5Zoq33S
   yV2y3zkJ9I/oRCDVnzlL2gurATkhVpKsKQDfwPVqdUMr7unVv2bq/RL0M
   5O3c3IccIzS47reo6mTG6fpOWF/8FGCPM37hxibB8zt3eoTKplaDQmIru
   AOnhKbsCByrhbYkUZJc33FSJLA9kyXqU5/r66EiMIDTjwhfnGyJtzSsJg
   qa6M7k0SbgyaG7z9iwthtPlmC1rvWec66jbYWgl1vPgsOLbJfvbVV6pPW
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 26 May 2023 15:57:30 +0200
Subject: [PATCH mm-nonmm-unstable v2 1/2] squashfs: fix page update race
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230526-squashfs-cache-fixup-v2-1-6fb7723c3647@axis.com>
References: <20230526-squashfs-cache-fixup-v2-0-6fb7723c3647@axis.com>
In-Reply-To: <20230526-squashfs-cache-fixup-v2-0-6fb7723c3647@axis.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <hch@lst.de>, <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        "Vincent Whitchurch" <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only put the page into the cache after we've read it, so the
PageUptodate() check should not be necessary.  In fact, it's actively
harmful since the check could fail (since we used find_get_page() and
not find_lock_page()) and we could end up submitting a page for I/O
after it has been read and while it's actively being used, which could
lead to corruption depending on what the block driver does with it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/squashfs/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 6285f5afb6c6..f2412e5fc84b 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -92,7 +92,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 	bio_for_each_segment_all(bv, fullbio, iter_all) {
 		struct page *page = bv->bv_page;
 
-		if (page->mapping == cache_mapping && PageUptodate(page)) {
+		if (page->mapping == cache_mapping) {
 			idx++;
 			continue;
 		}

-- 
2.34.1

