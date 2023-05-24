Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC770F3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjEXKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjEXKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:13:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38F41A8
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:13:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae3fe67980so662255ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684923204; x=1687515204;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vapAR/6EU00paIGYHBQFHRt4cvB1CyiM1SCSQ+Z2hU8=;
        b=so0mpKVWCF8cYXnovBMsyDPJZEGqiHOQ4bmJT5gSVpkt+zc4rKqCMo0yWecT0I5kxx
         CSZzoncB3W45DsdGtdCM31I1OnKR/9pxx3bMJWEr+ACMiZ73quZ3PjFpDIUeqRwhHYMk
         PRgbdAZf3FiegT5kg86vmqFFk153zUDVbkxfibnhPBmViR8Qxmps6RkYxJtkNMZ4K3yS
         4aMddOG0ZHb+ZcSzwfF5sonRxm1Tb4deDTuRZI3r1sB0blpULUQ84HG90J6WfwnkO+06
         a9aRSqyuExcoEW7hTsvoqsCoetGXtt/hAjKM8E/t6wkSv0hFP/TTgQRgK15J5g2N2TXh
         k7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923204; x=1687515204;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vapAR/6EU00paIGYHBQFHRt4cvB1CyiM1SCSQ+Z2hU8=;
        b=lk0FNFaUyqcELQrQ0SuK+vMWCpkazQ7NYs/G7lEncx6Jq3+lKXhii5euSPGTQbKXl5
         PP/EDdlLJ2nvv9lEzEtzBdJ0kEd7mHss6UPWdBMFX8fbcBqTmFLv8oQizGLK/XY4/k9C
         PowHX2J1GpyO9fLVs5FDjsiDJO8D3sEgPBLM971N88vbL9fa7DYYeZdMpqN/zxNU6hvx
         3uLLhwZvB/wsYO2/drCq7QA6MI1Dtbn94AsPL3pNdwfnDUP7GZR8d+lUAjdLdlI+9KdZ
         0UB1ActyY1siEqmgXqNQ/ttr3q7PLwz4bIIC57dfooVUx3Q2njyVpGaEczwt4AI4seJR
         CMlQ==
X-Gm-Message-State: AC+VfDzNONrXkCO92ibMrnHTg6zqWcvhzYVFvaFllfrBGg08gDJhO5BI
        NBlUs3oU1l93nV4dM+9nxtDhMmWGR6Q=
X-Google-Smtp-Source: ACHHUZ5LeRVvKkhFQ85kE1QNjWyAdmje+WlxaV87/yiqhzr6oFpOEm3bqufe8MgO9SN/ZdvjC530Dg==
X-Received: by 2002:a17:902:ea0f:b0:1ad:c736:2090 with SMTP id s15-20020a170902ea0f00b001adc7362090mr19959331plg.3.1684923203810;
        Wed, 24 May 2023 03:13:23 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001aaed524541sm8336945plb.227.2023.05.24.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 03:13:23 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] erofs: remove end parameter from z_erofs_pcluster_readmore()
Date:   Wed, 24 May 2023 18:13:05 +0800
Message-Id: <20230524101305.22105-1-zbestahu@gmail.com>
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

The `end` argument is pointless if it's not backmost.  And we already
have `headoffset` in struct `*f`, so let's use this offset to get the
`end` for backmost only instead in this function.

Also, remove linux/prefetch.h since it's not used anymore after commit
386292919c25 ("erofs: introduce readmore decompression strategy").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zdata.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5cd971bcf95e..b7ebdc8f2135 100644
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
@@ -1825,16 +1824,16 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
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
+	erofs_off_t cur, end;
 	int err;
 
 	if (backmost) {
+		end = f->headoffset +
+		      rac ? readahead_length(rac) : PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
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

