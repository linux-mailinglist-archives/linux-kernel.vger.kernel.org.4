Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958B96DB674
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDGW2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDGW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:28:13 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E7B740
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 15:28:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfY-f.6_1680906488;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfY-f.6_1680906488)
          by smtp.aliyun-inc.com;
          Sat, 08 Apr 2023 06:28:08 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] erofs: enable long extended attribute name prefixes
Date:   Sat,  8 Apr 2023 06:28:08 +0800
Message-Id: <20230407222808.19670-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-8-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-8-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's enable long xattr name prefix feature.  Old kernels will just
ignore / skip such extended attributes so that in case you don't want
to mount such images.  Add another incompatible feature as an option
for this.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
v2: fix build error when CONFIG_EROFS_FS_XATTR is not defined
---
 fs/erofs/erofs_fs.h | 4 +++-
 fs/erofs/internal.h | 1 +
 fs/erofs/super.c    | 7 +++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index ea62f83dac40..ac42a7255b39 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -27,6 +27,7 @@
 #define EROFS_FEATURE_INCOMPAT_ZTAILPACKING	0x00000010
 #define EROFS_FEATURE_INCOMPAT_FRAGMENTS	0x00000020
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
+#define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_ALL_FEATURE_INCOMPAT		\
 	(EROFS_FEATURE_INCOMPAT_ZERO_PADDING | \
 	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
@@ -36,7 +37,8 @@
 	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2 | \
 	 EROFS_FEATURE_INCOMPAT_ZTAILPACKING | \
 	 EROFS_FEATURE_INCOMPAT_FRAGMENTS | \
-	 EROFS_FEATURE_INCOMPAT_DEDUPE)
+	 EROFS_FEATURE_INCOMPAT_DEDUPE | \
+	 EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5a9c19654b19..f675050af2bb 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -285,6 +285,7 @@ EROFS_FEATURE_FUNCS(compr_head2, incompat, INCOMPAT_COMPR_HEAD2)
 EROFS_FEATURE_FUNCS(ztailpacking, incompat, INCOMPAT_ZTAILPACKING)
 EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
+EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bf396e0c243a..e44cd69c9d9c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -385,6 +385,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
+	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
+	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
@@ -822,6 +824,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	err = erofs_xattr_prefixes_init(sb);
+	if (err)
+		return err;
+
 	err = erofs_register_sysfs(sb);
 	if (err)
 		return err;
@@ -981,6 +987,7 @@ static void erofs_put_super(struct super_block *sb)
 
 	erofs_unregister_sysfs(sb);
 	erofs_shrinker_unregister(sb);
+	erofs_xattr_prefixes_cleanup(sb);
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
-- 
2.19.1.6.gb485710b

