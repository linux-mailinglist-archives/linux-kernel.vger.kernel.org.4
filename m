Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B97747DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjGEHEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjGEHEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:04:37 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D5E72
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:04:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmfjzPH_1688540669;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmfjzPH_1688540669)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:04:30 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [PATCH v2 2/2] erofs: boost negative xattr lookup with bloom filter
Date:   Wed,  5 Jul 2023 15:04:27 +0800
Message-Id: <20230705070427.92579-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit value for the bloom filter map has a reverse semantics for
compatibility.  That is, the bit value of 0 indicates existence, while
the bit value of 1 indicates the absence of corresponding xattr.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/xattr.c    | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 36e32fa542f0..7e447b48a46b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -251,6 +251,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
@@ -270,6 +271,7 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	unsigned int xattr_isize;
 
+	unsigned long xattr_name_filter;
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
 
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 40178b6e0688..1137723303d3 100644
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
+	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
@@ -392,7 +394,10 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 		   void *buffer, size_t buffer_size)
 {
 	int ret;
+	uint32_t bit;
 	struct erofs_xattr_iter it;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!name)
 		return -EINVAL;
@@ -401,6 +406,13 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	if (ret)
 		return ret;
 
+	if (erofs_sb_has_xattr_filter(sbi)) {
+		bit = xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index);
+		bit &= EROFS_XATTR_FILTER_MASK;
+		if (test_bit(bit, &vi->xattr_name_filter))
+			return -ENOATTR;
+	}
+
 	it.index = index;
 	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
-- 
2.19.1.6.gb485710b

