Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C2690085
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBIGkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBIGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:40:08 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC143441
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:39:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEsQkE_1675924754;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbEsQkE_1675924754)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 14:39:15 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] erofs: remove unused device mapping in meta routine
Date:   Thu,  9 Feb 2023 14:39:10 +0800
Message-Id: <20230209063913.46341-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230209063913.46341-1-jefflexu@linux.alibaba.com>
References: <20230209063913.46341-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently metadata is always on bootstrap, and thus device mapping is
not needed so far.  Remove the redundant device mapping in the meta
routine.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 014e20962376..03de4dc99302 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -164,18 +164,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 {
 	int ret;
-	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
 	struct erofs_fscache_request *req;
-	struct erofs_map_dev mdev = {
-		.m_deviceid = 0,
-		.m_pa = folio_pos(folio),
-	};
-
-	ret = erofs_map_dev(sb, &mdev);
-	if (ret) {
-		folio_unlock(folio);
-		return ret;
-	}
 
 	req = erofs_fscache_req_alloc(folio_mapping(folio),
 				folio_pos(folio), folio_size(folio));
@@ -184,8 +174,8 @@ static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
 		return PTR_ERR(req);
 	}
 
-	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-				req, mdev.m_pa, folio_size(folio));
+	ret = erofs_fscache_read_folios_async(ctx->cookie, req,
+				folio_pos(folio), folio_size(folio));
 	if (ret)
 		req->error = ret;
 
@@ -469,6 +459,7 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 		inode->i_size = OFFSET_MAX;
 		inode->i_mapping->a_ops = &erofs_fscache_meta_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
+		inode->i_private = ctx;
 
 		ctx->inode = inode;
 	}
-- 
2.19.1.6.gb485710b

