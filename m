Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C0E737D92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjFUIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFUIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:32:18 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C841A19F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:32:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VlfH3v6_1687336331;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlfH3v6_1687336331)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 16:32:11 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [RFC 2/2] erofs: optimize getxattr with bloom filter
Date:   Wed, 21 Jun 2023 16:32:09 +0800
Message-Id: <20230621083209.116024-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boost the negative xattr lookup with bloom filter.

The bit value for the bloom filter map has a reverse semantics for
compatibility.  That is, the mapped bits will be cleared to 0, while the
bit value of 1 indicates the absence of corresponding xattr.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/xattr.c    | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1e39c03357d1..49b4b350af8a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -285,6 +285,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_bloom, compat, COMPAT_XATTR_BLOOM)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
@@ -304,6 +305,7 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	unsigned int xattr_isize;
 
+	unsigned long xattr_bloom_map;
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
 
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 4376f654474d..1ab481b46e8d 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2022, Alibaba Cloud
  */
 #include <linux/security.h>
+#include <linux/xxhash.h>
 #include "xattr.h"
 
 struct erofs_xattr_iter {
@@ -87,6 +88,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	ih = it.kaddr + erofs_blkoff(sb, it.pos);
+	vi->xattr_bloom_map = le32_to_cpu(ih->h_map);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
@@ -392,8 +394,11 @@ int erofs_getxattr(struct inode *inode, int index,
 		   const char *name,
 		   void *buffer, size_t buffer_size)
 {
-	int ret;
+	int i, ret;
+	uint32_t bit;
 	struct erofs_xattr_iter it;
+	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!name)
 		return -EINVAL;
@@ -402,6 +407,15 @@ int erofs_getxattr(struct inode *inode, int index,
 	if (ret)
 		return ret;
 
+	if (erofs_sb_has_xattr_bloom(sbi) && vi->xattr_bloom_map) {
+		for (i = 0; i < EROFS_XATTR_BLOOM_COUNTS; i++) {
+			bit = xxh32(name, strlen(name), index + i);
+			bit &= EROFS_XATTR_BLOOM_MASK;
+			if (test_bit(bit, &vi->xattr_bloom_map))
+				return -ENOATTR;
+		}
+	}
+
 	it.index = index;
 	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
-- 
2.19.1.6.gb485710b

