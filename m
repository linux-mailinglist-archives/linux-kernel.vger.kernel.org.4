Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96379710645
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjEYH0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbjEYH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:26:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1653E19D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:26:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53404873a19so907899a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684999578; x=1687591578;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SJbCVUIsT35lU+xRPnFefGg51IAUFGSv1jqsyRTZiM=;
        b=f5ZL36ok/3gXEzE4fhHCkfw4YlVUBqqfrYaIGoQ5ab96Vf7QOaFKHooBgNCgfSPu6g
         8wI7+ESiSgCgg4ouND4fHXMM0a2PmppNw0PmqiI/J54vHxZOFKABgFSykbHXiF7boQ11
         vQnqJAdATQZ1rL86eI5SDhsESspq4BKZ+oTXYKZzNlTf9u16hujkLWb/UPbzxQZix97O
         r5/N55HsKRFGH4BUn8Dh6nD+TAbt8iQ8fzmjtPH8l+s95SVhG2XPySMUtho7GQvIOj7K
         pn7Fy/2EyFfp78HlgakUr9YEWGBzmqG9WCBMK73J5wXdz9tNi62gDOEwdhZOXb2E4l7a
         MF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684999578; x=1687591578;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SJbCVUIsT35lU+xRPnFefGg51IAUFGSv1jqsyRTZiM=;
        b=du9TpdNE6H5Rb5sA0th0wJNjoipspgzHP3hOCKi1fwgMfa/T3t0IFTqRgx0RA449Gp
         37/BlcEBQ86AMNdWiLeNkigYakqfSLJSBmX+LBIVxcE3rUQ+cjwp2dzZ2fAk1SQ3Pmzf
         f5P5F0Ifg8/uh1jtBgG/Du56rn6miPcL7XEd/YfEQLR390J+Z+cDi6RR2XgEO6ZFceNi
         OXteDgLTXEoPbCTuFDYjcLpyEcHqeB1YGumOqrJkXu7wTLmo6ltvyJe+l9pbeg+rLcbI
         GsaO2XELi6XdCb5RCEhXd2vTFDJN8CLaUMEzyUKuAmGiyc0lEsHqGyCGkXGnzWh8dZo4
         8DVw==
X-Gm-Message-State: AC+VfDxgQD98ajd+7cE3zeSjeqDCOF8WEKZQFnGVw+qeM+BWz7EEoKxn
        JRLksd1sUJX6k5LvuTEU49KtF71ZXVc=
X-Google-Smtp-Source: ACHHUZ5fJoS4o+wP556Zv5XjmhbFm5S1ET3O0EOwC9y5gVxg43wKVXRRqW4ZqpuqECM/qcZDH6P+Jg==
X-Received: by 2002:a17:902:7b82:b0:1ae:4553:edfa with SMTP id w2-20020a1709027b8200b001ae4553edfamr647078pll.29.1684999578400;
        Thu, 25 May 2023 00:26:18 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001ac2c3e436asm684225plg.186.2023.05.25.00.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 00:26:18 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] erofs: clean up z_erofs_pcluster_readmore()
Date:   Thu, 25 May 2023 15:26:05 +0800
Message-Id: <20230525072605.17857-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

No need end parameter since it's pointless for !backmost, we can get it
for backmost internally.  And we only expand the trailing edge, so the
newstart can be replaced with ->headoffset.

Also, remove linux/prefetch.h that is not used anymore after commit
386292919c25 ("erofs: introduce readmore decompression strategy").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5cd971bcf95e..bab8dcb8e848 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Alibaba Cloud
  */
 #include "compress.h"
-#include <linux/prefetch.h>
 #include <linux/psi.h>
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
@@ -1825,28 +1824,28 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
  */
 static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 				      struct readahead_control *rac,
-				      erofs_off_t end,
-				      struct page **pagepool,
-				      bool backmost)
+				      struct page **pagepool, bool backmost)
 {
 	struct inode *inode = f->inode;
 	struct erofs_map_blocks *map = &f->map;
-	erofs_off_t cur;
+	erofs_off_t cur, end, headoffset = f->headoffset;
 	int err;
 
 	if (backmost) {
+		if (rac)
+			end = headoffset + readahead_length(rac) - 1;
+		else
+			end = headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
 		if (err)
 			return;
 
-		/* expend ra for the trailing edge if readahead */
+		/* expand ra for the trailing edge if readahead */
 		if (rac) {
-			loff_t newstart = readahead_pos(rac);
-
 			cur = round_up(map->m_la + map->m_llen, PAGE_SIZE);
-			readahead_expand(rac, newstart, cur - newstart);
+			readahead_expand(rac, headoffset, cur - headoffset);
 			return;
 		}
 		end = round_up(end, PAGE_SIZE);
@@ -1894,10 +1893,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
-				  &pagepool, true);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, true);
 	err = z_erofs_do_read_page(&f, page, &pagepool);
-	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, false);
 
 	(void)z_erofs_collector_end(&f);
 
@@ -1923,8 +1921,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	f.headoffset = readahead_pos(rac);
 
-	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
-				  readahead_length(rac) - 1, &pagepool, true);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, true);
 	nr_pages = readahead_count(rac);
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
@@ -1947,7 +1944,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, false);
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-- 
2.17.1

