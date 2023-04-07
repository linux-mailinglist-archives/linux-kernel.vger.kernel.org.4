Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA6A6DAEB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbjDGORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjDGORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:17:20 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E016EB7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 07:17:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfXA6.c_1680877034;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfXA6.c_1680877034)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:14 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] erofs: move packed inode out of the compression part
Date:   Fri,  7 Apr 2023 22:17:06 +0800
Message-Id: <20230407141710.113882-4-jefflexu@linux.alibaba.com>
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

packed inode could be used in more scenarios which are independent of
compression in the future.

For example, packed inode could be used to keep extra long xattr
prefixes with the help of following patches.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 +-
 fs/erofs/super.c    | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index caea9dc1cd82..8b5168f94dd2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -134,8 +134,8 @@ struct erofs_sb_info {
 	struct inode *managed_cache;
 
 	struct erofs_sb_lz4_info lz4;
-	struct inode *packed_inode;
 #endif	/* CONFIG_EROFS_FS_ZIP */
+	struct inode *packed_inode;
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 325602820dc8..8f2f8433db61 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -810,7 +810,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	erofs_shrinker_register(sb);
 	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
-#ifdef CONFIG_EROFS_FS_ZIP
 	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
 		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
 		if (IS_ERR(sbi->packed_inode)) {
@@ -819,7 +818,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			return err;
 		}
 	}
-#endif
 	err = erofs_init_managed_cache(sb);
 	if (err)
 		return err;
@@ -986,9 +984,9 @@ static void erofs_put_super(struct super_block *sb)
 #ifdef CONFIG_EROFS_FS_ZIP
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
+#endif
 	iput(sbi->packed_inode);
 	sbi->packed_inode = NULL;
-#endif
 	erofs_free_dev_context(sbi->devs);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
-- 
2.19.1.6.gb485710b

