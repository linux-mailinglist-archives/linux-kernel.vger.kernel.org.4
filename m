Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47396DAEB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjDGOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDGORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:17:18 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387876E95
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:17:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX8evk_1680877033;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX8evk_1680877033)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:13 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] erofs: initialize packed inode after root inode is assigned
Date:   Fri,  7 Apr 2023 22:17:05 +0800
Message-Id: <20230407141710.113882-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 8f7acdae2cd4 ("staging: erofs: kill all failure handling in
fill_super()"), move the initialization of packed inode after root
inode is assigned, so that the iput() in .put_super() is adequate as
the failure handling.

Otherwise, iput() is also needed in .kill_sb(), in case of the mounting
fails halfway.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2bcff3194e4a..caea9dc1cd82 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -157,6 +157,7 @@ struct erofs_sb_info {
 
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
+	erofs_nid_t packed_nid;
 	/* used for statfs, f_files - f_favail */
 	u64 inos;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 58ffbf410bfb..325602820dc8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -388,17 +388,7 @@ static int erofs_read_superblock(struct super_block *sb)
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
-#ifdef CONFIG_EROFS_FS_ZIP
-	sbi->packed_inode = NULL;
-	if (erofs_sb_has_fragments(sbi) && dsb->packed_nid) {
-		sbi->packed_inode =
-			erofs_iget(sb, le64_to_cpu(dsb->packed_nid));
-		if (IS_ERR(sbi->packed_inode)) {
-			ret = PTR_ERR(sbi->packed_inode);
-			goto out;
-		}
-	}
-#endif
+	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
 	sbi->inos = le64_to_cpu(dsb->inos);
 
 	sbi->build_time = le64_to_cpu(dsb->build_time);
@@ -820,6 +810,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	erofs_shrinker_register(sb);
 	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
+#ifdef CONFIG_EROFS_FS_ZIP
+	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
+		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
+		if (IS_ERR(sbi->packed_inode)) {
+			err = PTR_ERR(sbi->packed_inode);
+			sbi->packed_inode = NULL;
+			return err;
+		}
+	}
+#endif
 	err = erofs_init_managed_cache(sb);
 	if (err)
 		return err;
-- 
2.19.1.6.gb485710b

