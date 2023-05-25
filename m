Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9457102BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjEYCPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjEYCPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:15:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0D1B1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:14:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso925714a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684980870; x=1687572870;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzBlJLFAfyWSWb9nUXk9FvhTpGSd0CozzP+TkVxRg2s=;
        b=DcGMR9DBSVzrk5auQ81PVyyXqY8c/vFLnhHRdHPhhPmZz0vtzbwzTvIOJjrTT0zIKZ
         bG9JjhgNIS9oX2kG0Sa805UV4jYkp+MfUjb0VCp8XZAj+kQ7WKnOFOJI+bT++XPYQLtb
         +0sINuIAfwJhxEwF9LT/NBBRTEv4AejT+ozTzIijOSfml1JNZajVMKsCcowJg1JcxrSe
         m2IAOHXsiTAHzD6xiKvulAa0TbKcaYgArLYYZ5BDkiiSC2TSqiFVdZHxgZx/f8ZsBdu7
         a7z8boqqtBLe8OQg1kV/5ze9dvsm7gtQAaKQbBeM1oC5X4mwe4ceKHPK6QacXs+LgxaP
         /UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684980870; x=1687572870;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzBlJLFAfyWSWb9nUXk9FvhTpGSd0CozzP+TkVxRg2s=;
        b=F63+NL/E6bnFeVcemPOs1sbJxFpPAN4YoOtfDL7CXY5rZLfh7Fs6gRQ7fjItEkHyUn
         neUV35MWs8HMCeYIMN0Ssi5IbptBdRqr8qe7WyXv3hVCtdmERET2UgZGY91+kdZ2C9NT
         H/h7fcFojbs+GF06IeGtYV5vwijnH5fxtyo6ylR6Epfbdt1rV6LniUMxUoBBXti04HjW
         knVKoNUxq61V6MlpZ4VT28QBkkZOxq9rvT/n55z9JXnPqoWnVRyBNii9++C83rjBIKQ5
         LdrYXhbQG/ym5fA35sAqKcmbLH2JY4M3IhgaLKKy6lD3cV0L4mjnDinhUTrUIJXV2cdL
         ovgQ==
X-Gm-Message-State: AC+VfDw42nyO0aMNlRRJCXDB/0cyyR2IgyGy4q7IFwtYy4kLy1ezIHT/
        efXTKmLnzrKUxslHSx96Wiq2GTF41Wk=
X-Google-Smtp-Source: ACHHUZ43FYWuhk0l+Ak68yTcquXM88HZT1KFK0hTwq6+94J/kpjUCgMfXykuPcsBujVQAY4P4jFEpg==
X-Received: by 2002:a17:90b:4b04:b0:253:5728:f631 with SMTP id lx4-20020a17090b4b0400b002535728f631mr19992pjb.15.1684980870426;
        Wed, 24 May 2023 19:14:30 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t30-20020a63225e000000b0051afa49e07asm8419929pgm.50.2023.05.24.19.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 19:14:29 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH v2] erofs: remove end parameter from z_erofs_pcluster_readmore()
Date:   Thu, 25 May 2023 10:14:15 +0800
Message-Id: <20230525021415.8594-1-zbestahu@gmail.com>
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

Also, remove linux/prefetch.h that is not used anymore after commit
386292919c25 ("erofs: introduce readmore decompression strategy").

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2:
 - change to use if-else to obtain end value
 - minor commit message update

 fs/erofs/zdata.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5cd971bcf95e..874fee35af32 100644
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
@@ -1825,16 +1824,18 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
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
+		if (rac)
+			end = f->headoffset + readahead_length(rac) - 1;
+		else
+			end = f->headoffset + PAGE_SIZE - 1;
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
@@ -1894,10 +1895,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	trace_erofs_readpage(page, false);
 	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
 
-	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
-				  &pagepool, true);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, true);
 	err = z_erofs_do_read_page(&f, page, &pagepool);
-	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, NULL, &pagepool, false);
 
 	(void)z_erofs_collector_end(&f);
 
@@ -1923,8 +1923,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 
 	f.headoffset = readahead_pos(rac);
 
-	z_erofs_pcluster_readmore(&f, rac, f.headoffset +
-				  readahead_length(rac) - 1, &pagepool, true);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, true);
 	nr_pages = readahead_count(rac);
 	trace_erofs_readpages(inode, readahead_index(rac), nr_pages, false);
 
@@ -1947,7 +1946,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 				  page->index, EROFS_I(inode)->nid);
 		put_page(page);
 	}
-	z_erofs_pcluster_readmore(&f, rac, 0, &pagepool, false);
+	z_erofs_pcluster_readmore(&f, rac, &pagepool, false);
 	(void)z_erofs_collector_end(&f);
 
 	z_erofs_runqueue(&f, &pagepool,
-- 
2.17.1

