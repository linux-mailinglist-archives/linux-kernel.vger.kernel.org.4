Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB997127DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbjEZN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbjEZN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:57:40 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4740EF3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685109459;
  x=1716645459;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4n8uWwoKijuf7hNq7pa6eDg5K8Opr8XjUEd1CHMUr5Q=;
  b=Z4Qhd1HaPyBYT/3hKcPykXUdMHlRUjMoitobLFnFMNVvzG20o+wtN/1k
   qz5+VYMu0ENl107lr1jXK/I72S+rKiJLsN3lbCZu1922d5AuN9PlYF4K/
   PVdxD5jWc/SOyYz8NK35Mllq7FStFKEn9txAH6RroiGQsqJ2Zo+slRAuQ
   O2aKgxMyRgfUmcu6HjV6n9T8yZbDdtKL6hiQ16VqhioJn9iBXvKCxCVUI
   e3BAvnzrJEKxr+8kbS0EwIOXDuxsqzDMyEElkzMZnf2mQTu+5+8meR1oO
   78XsKHb9jmHW2Z9SEr/TwfsKjah7v3zPHOZSLYp+/0h11Sv5hcI2WKrk9
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 26 May 2023 15:57:31 +0200
Subject: [PATCH mm-nonmm-unstable v2 2/2] squashfs: fix page indices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230526-squashfs-cache-fixup-v2-2-6fb7723c3647@axis.com>
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

The page cache functions want the page index as an argument but we're
currently passing in the byte address.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/squashfs/block.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index f2412e5fc84b..6aa9c2e1e8eb 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -142,7 +142,8 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 
 	if (head_to_cache) {
 		int ret = add_to_page_cache_lru(head_to_cache, cache_mapping,
-						read_start, GFP_NOIO);
+						read_start >> PAGE_SHIFT,
+						GFP_NOIO);
 
 		if (!ret) {
 			SetPageUptodate(head_to_cache);
@@ -153,7 +154,8 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 
 	if (tail_to_cache) {
 		int ret = add_to_page_cache_lru(tail_to_cache, cache_mapping,
-						read_end - PAGE_SIZE, GFP_NOIO);
+						(read_end >> PAGE_SHIFT) - 1,
+						GFP_NOIO);
 
 		if (!ret) {
 			SetPageUptodate(tail_to_cache);
@@ -192,7 +194,7 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 
 		if (cache_mapping)
 			page = find_get_page(cache_mapping,
-					     read_start + i * PAGE_SIZE);
+					     (read_start >> PAGE_SHIFT) + i);
 		if (!page)
 			page = alloc_page(GFP_NOIO);
 

-- 
2.34.1

