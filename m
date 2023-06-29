Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BA0742821
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjF2OSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjF2OSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:18:09 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DDA1737
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688048287;
  x=1719584287;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=/EACAvCkqaq5SWsngoSCmDYPrtH4Wz7SJv4BW6QmdMI=;
  b=bBbcSEsxarDnMjaFAdXLmJ7oTwjegItzZ/M7U3u74beXPcGsDYIHb4Zc
   sdWSQxjmRwlgSOioXtJuD0vvzdEQSLP9raqfyIg81NV76oXmf2BLc7F+O
   rQBuITpEmfASG+DRmMBZc14gHcXJ94THixkb2NudyWrxSbE3AkFTmfWki
   Ug2s9eaNojh83qZINUM8yxXj13MGbWLSIWMJwSf88nKs89PgjwN06JQtB
   0sgWscodyCeeEATB1gI4B7fScMvfAMqAFtjf38nsF7GptBT6OxwiCT8qP
   v4ywD5cV9DTr0a3qXHAlvYYBtGXNGyynBvmZTNi8myn/h620TKyZRU911
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Thu, 29 Jun 2023 16:17:57 +0200
Subject: [PATCH] squashfs: fix cache race with migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230629-squashfs-cache-migration-v1-1-d50ebe55099d@axis.com>
X-B4-Tracking: v=1; b=H4sIAJSSnWQC/x2NQQ7CMAwEv1L5jKU0TUHlK4iDG5zGBxKwASFV/
 Tspx1lpZlcwVmGDc7eC8kdMamnQHzqImcrCKLfG4J0f3NFPaM83WU6GkWJmvMui9GoS+lM/Bhp
 dCmGCps9kjLNSiXkPpFqHfX4oJ/n+Hy/XbfsByl3ZJYEAAAA=
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migration replaces the page in the mapping before copying the contents
and the flags over from the old page, so check that the page in the page
cache is really up to date before using it.  Without this, stressing
squashfs reads with parallel compaction sometimes results in squashfs
reporting data corruption.

Fixes: e994f5b677ee ("squashfs: cache partial compressed blocks")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/squashfs/block.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 6aa9c2e1e8ebe..581ce95193390 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -166,6 +166,26 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 	return 0;
 }
 
+static struct page *squashfs_get_cache_page(struct address_space *mapping,
+					    pgoff_t index)
+{
+	struct page *page;
+
+	if (!mapping)
+		return NULL;
+
+	page = find_get_page(mapping, index);
+	if (!page)
+		return NULL;
+
+	if (!PageUptodate(page)) {
+		put_page(page);
+		return NULL;
+	}
+
+	return page;
+}
+
 static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 			     struct bio **biop, int *block_offset)
 {
@@ -190,11 +210,10 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 	for (i = 0; i < page_count; ++i) {
 		unsigned int len =
 			min_t(unsigned int, PAGE_SIZE - offset, total_len);
-		struct page *page = NULL;
+		pgoff_t index = (read_start >> PAGE_SHIFT) + i;
+		struct page *page;
 
-		if (cache_mapping)
-			page = find_get_page(cache_mapping,
-					     (read_start >> PAGE_SHIFT) + i);
+		page = squashfs_get_cache_page(cache_mapping, index);
 		if (!page)
 			page = alloc_page(GFP_NOIO);
 

---
base-commit: 3a8a670eeeaa40d87bd38a587438952741980c18
change-id: 20230629-squashfs-cache-migration-27154a50f449

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

