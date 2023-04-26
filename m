Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7419F6EF067
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbjDZIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbjDZIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:45:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DDD2684
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:45:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24b89b9a72cso3146508a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682498703; x=1685090703;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNu7vD1mUAOPWPPCLuonoHF/qKJcaDrZr6u09Js53+Q=;
        b=k3YUwEGKnZgw2ZIFSI7w3xy42irEElPKklzcAkwNdvRh0nkJTSAKfk7sJgUQYlHjuv
         iQ0t/n+ASWfHscSjYgQksetRLpZpBcsbDFlfHc6HZzlYSD0Yn9+1xz0eXcllJA4l99bI
         w/NUNqUj4rqTqubfrRg0RJyjWJfcguHIDWDRxv+gicCuO9Ly4qjcsEOZ6ajRAxu7Vryi
         vVSKEnDYfO8bES7F3wl8jdsvnL2MZIaaWADA8tZYfnkSHR6W8Jpg8n31SFqIYA1e5AKu
         RFWM6U/D8xCIjldtgsIY3X4kxp7fe1uKBbgLjoJEpVdT8vXe9epO2bOeCDPGhPmQ5S7C
         LhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682498703; x=1685090703;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNu7vD1mUAOPWPPCLuonoHF/qKJcaDrZr6u09Js53+Q=;
        b=FjIRrtp/YWrKQQxx38dOmaupy+W+w6PlVGt0j8XI6VvT+8LN8qgzLffET+K1qqkYE1
         5oXbJwtTrMeJZ6pYC3QZz3irvDYe+4gb76agmjexskQ25d1h35P6S/Hj5i6JgB2ZjOn2
         eDOa/7sixcevKENbgk6axvZRjj+AEqW+EIMw/ho0ZKfspOGj+QsIP6Ak9KZOTMpDpq8k
         SxbISKpjOKB/I1yvoDkU8o5ZvAWymQ9Ok6/CpWsnZq6JgMSdI7NKiQfAB1Te/z/uhhs2
         i3Y7EjetbqSvlxiKUDUrH4qvizbi7pOGo3lY4N2tZXEATMXyyedOGdwb9aiUCQCtPVMm
         71iQ==
X-Gm-Message-State: AAQBX9d65+MLZsgj4oCS7Tx1YajuJ5m5a4h8VRN3zayuv2ZR3QNMppMK
        x/GZ/sCmot1g0iqPy5xLqNHPZv1JDBs=
X-Google-Smtp-Source: AKy350YbGbwFOFqkJ36bCgdjW82+T26Giy4o1eeWJPBupmIJDDIDVigW6NwGuaxsDdjjkPF9/9dIHA==
X-Received: by 2002:a17:90a:e2d1:b0:24b:af7c:4626 with SMTP id fr17-20020a17090ae2d100b0024baf7c4626mr10706116pjb.16.1682498702794;
        Wed, 26 Apr 2023 01:45:02 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id gw13-20020a17090b0a4d00b002470b9503desm11001082pjb.55.2023.04.26.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:45:02 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Subject: [PATCH v2] erofs: fold in z_erofs_decompress()
Date:   Wed, 26 Apr 2023 16:44:49 +0800
Message-Id: <20230426084449.12781-1-zbestahu@gmail.com>
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

No need this helper since it's just a simple wrapper for decompress
method and only one caller.  So, let's fold in directly instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2:
 - rename decompressors[] -> erofs_decompressors[]
 - do not copy struct z_erofs_decompressor item

 fs/erofs/compress.h     | 3 +--
 fs/erofs/decompressor.c | 8 +-------
 fs/erofs/zdata.c        | 4 +++-
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..b1b846504027 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -89,8 +89,7 @@ static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
 
 int z_erofs_fixup_insize(struct z_erofs_decompress_req *rq, const char *padbuf,
 			 unsigned int padbufsize);
-int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct page **pagepool);
+extern const struct z_erofs_decompressor erofs_decompressors[];
 
 /* prototypes for specific algorithms */
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 7021e2cf6146..2a29943fa5cc 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -363,7 +363,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	return 0;
 }
 
-static struct z_erofs_decompressor decompressors[] = {
+const struct z_erofs_decompressor erofs_decompressors[] = {
 	[Z_EROFS_COMPRESSION_SHIFTED] = {
 		.decompress = z_erofs_transform_plain,
 		.name = "shifted"
@@ -383,9 +383,3 @@ static struct z_erofs_decompressor decompressors[] = {
 	},
 #endif
 };
-
-int z_erofs_decompress(struct z_erofs_decompress_req *rq,
-		       struct page **pagepool)
-{
-	return decompressors[rq->alg].decompress(rq, pagepool);
-}
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a90d37c7bdd7..5ef9d3863ff9 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1290,6 +1290,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
+	const struct z_erofs_decompressor *decompressor =
+				&erofs_decompressors[pcl->algorithmformat];
 	unsigned int i, inputsize;
 	int err2;
 	struct page *page;
@@ -1333,7 +1335,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	else
 		inputsize = pclusterpages * PAGE_SIZE;
 
-	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+	err = decompressor->decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
 					.out = be->decompressed_pages,
-- 
2.17.1

