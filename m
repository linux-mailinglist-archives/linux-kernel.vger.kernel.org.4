Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305C712778
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbjEZN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjEZN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:26:09 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B434198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685107567;
  x=1716643567;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kGcEORmcjqsDDRn5OZ/5Wb++WiIzuQvNjLEwUt1X/v0=;
  b=U2fu9L9r7bpc9dUPuKYddjM+Gx75LNY0uyuVzjR7bd+OVv9r0d3NqdHh
   ERkryOqhnXXznDSBUI3xCpYhC9QjA4kIMOFKCr3JtgbNAM6C8eKu5yI06
   MtDXem4OqufNrboivXNZiuR+B8eH7CX8b3spyEp/bIctBj9we/PFab29G
   Yv4dfCnPwzmwxVseVZqBU9rbxZJyDeLWgPvvODJJdGZC/iIr6X8LpmAyj
   FGNJbrItp2pa0T3Fr1v7SEFfEGjKIFs7A45C2p8G3C+D+zqFlYXJuvvPA
   myk0PqbTSYqv+r9fRHWo8sPfEjSRU4SEFiaZRPHNUbWdRkgGVadaMZ4Fe
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 26 May 2023 15:25:46 +0200
Subject: [PATCH mm-nonmm-unstable 2/2] squashfs: fix page indices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230526-squashfs-cache-fixup-v1-2-d54a7fa23e7b@axis.com>
References: <20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com>
In-Reply-To: <20230526-squashfs-cache-fixup-v1-0-d54a7fa23e7b@axis.com>
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
 fs/squashfs/block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index f2412e5fc84b..447fb04f2b61 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -142,7 +142,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 
 	if (head_to_cache) {
 		int ret = add_to_page_cache_lru(head_to_cache, cache_mapping,
-						read_start, GFP_NOIO);
+						read_start >> PAGE_SHIFT, GFP_NOIO);
 
 		if (!ret) {
 			SetPageUptodate(head_to_cache);
@@ -153,7 +153,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 
 	if (tail_to_cache) {
 		int ret = add_to_page_cache_lru(tail_to_cache, cache_mapping,
-						read_end - PAGE_SIZE, GFP_NOIO);
+						(read_end >> PAGE_SHIFT) - 1, GFP_NOIO);
 
 		if (!ret) {
 			SetPageUptodate(tail_to_cache);
@@ -192,7 +192,7 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 
 		if (cache_mapping)
 			page = find_get_page(cache_mapping,
-					     read_start + i * PAGE_SIZE);
+					     (read_start >> PAGE_SHIFT) + i);
 		if (!page)
 			page = alloc_page(GFP_NOIO);
 

-- 
2.34.1

