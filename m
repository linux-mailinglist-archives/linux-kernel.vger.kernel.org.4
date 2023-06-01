Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF9719AED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjFALX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFALXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:23:54 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4679123
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:23:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vk5zEu._1685618622;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk5zEu._1685618622)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 19:23:50 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix compact 4B support for 16k block size
Date:   Thu,  1 Jun 2023 19:23:41 +0800
Message-Id: <20230601112341.56960-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In compact 4B, two adjacent lclusters are packed together as a unit to
form on-disk indexes for effective random access, as below:

(amortized = 4, vcnt = 2)
       _____________________________________________
      |___@_____ encoded bits __________|_ blkaddr _|
      0        .                                    amortized * vcnt = 8
      .             .
      .                  .              amortized * vcnt - 4 = 4
      .                        .
      .____________________________.
      |_type (2 bits)_|_clusterofs_|

Therefore, encoded bits for each pack are 32 bits (4 bytes). IOWs,
since each lcluster can get 16 bits for its type and clusterofs, the
maximum supported lclustersize for compact 4B format is 16k (14 bits).

Fix this to enable compact 4B format for 16k lclusters (blocks), which
is tested on an arm64 server with 16k page size.

Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index d37c5c89c728..920fb4dbc731 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -129,7 +129,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	u8 *in, type;
 	bool big_pcluster;
 
-	if (1 << amortizedshift == 4)
+	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
 	else if (1 << amortizedshift == 2 && lclusterbits == 12)
 		vcnt = 16;
@@ -231,7 +231,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct inode *const inode = m->inode;
 	struct erofs_inode *const vi = EROFS_I(inode);
-	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	const erofs_off_t ebase = sizeof(struct z_erofs_map_header) +
 		ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
 	unsigned int totalidx = erofs_iblks(inode);
@@ -239,9 +238,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int amortizedshift;
 	erofs_off_t pos;
 
-	if (lclusterbits != 12)
-		return -EOPNOTSUPP;
-
 	if (lcn >= totalidx)
 		return -EINVAL;
 
-- 
2.24.4

