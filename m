Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7963EA74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLAHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLAHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:43:03 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E700718392
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:43:01 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW7ouC6_1669880578;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW7ouC6_1669880578)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 15:42:59 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] erofs: enable large folios for fscache mode
Date:   Thu,  1 Dec 2022 15:42:56 +0800
Message-Id: <20221201074256.16639-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221201074256.16639-1-jefflexu@linux.alibaba.com>
References: <20221201074256.16639-1-jefflexu@linux.alibaba.com>
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

Enable large folios for fscache mode.  Enable this feature for
non-compressed format for now, until the compression part supports large
folios later.

One thing worth noting is that, the feature is not enabled for the meta
data routine since meta inodes don't need large folios for now, nor do
they support readahead yet.

Also document this new feature.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 Documentation/filesystems/erofs.rst | 2 ++
 fs/erofs/inode.c                    | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 82af67fdaf99..1c1f7404b338 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -72,6 +72,8 @@ Here are the main features of EROFS:
 
  - Support merging tail-end data into a special inode as fragments.
 
+ - Support large folios for uncompressed files.
+
  - Support direct I/O on uncompressed files to avoid double caching for loop
    devices;
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index e457b8a59ee7..85932086d23f 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -295,8 +295,7 @@ static int erofs_fill_inode(struct inode *inode)
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
-	if (!erofs_is_fscache_mode(inode->i_sb))
-		mapping_set_large_folios(inode->i_mapping);
+	mapping_set_large_folios(inode->i_mapping);
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (erofs_is_fscache_mode(inode->i_sb))
 		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
-- 
2.19.1.6.gb485710b

