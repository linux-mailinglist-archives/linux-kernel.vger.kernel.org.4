Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B766A878
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjANB6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjANB6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:58:42 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2EB7458F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:58:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZWAukk_1673661515;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZWAukk_1673661515)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 09:58:37 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs: remove linux/buffer_head.h dependency
Date:   Sat, 14 Jan 2023 09:58:12 +0800
Message-Id: <20230114015812.96836-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
References: <20230114015812.96836-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EROFS actually never uses buffer heads, therefore just get rid of
BH_xxx definitions and linux/buffer_head.h inclusive.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 20 ++++++--------------
 fs/erofs/super.c    |  1 -
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 168c21f16383..b4cc40fa3803 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/bio.h>
-#include <linux/buffer_head.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -388,25 +387,18 @@ extern struct file_system_type erofs_fs_type;
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
 
-enum {
-	BH_Encoded = BH_PrivateStart,
-	BH_FullMapped,
-	BH_Fragment,
-	BH_Partialref,
-};
-
 /* Has a disk mapping */
-#define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+#define EROFS_MAP_MAPPED	0x0001
 /* Located in metadata (could be copied from bd_inode) */
-#define EROFS_MAP_META		(1 << BH_Meta)
+#define EROFS_MAP_META		0x0002
 /* The extent is encoded */
-#define EROFS_MAP_ENCODED	(1 << BH_Encoded)
+#define EROFS_MAP_ENCODED	0x0004
 /* The length of extent is full */
-#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+#define EROFS_MAP_FULL_MAPPED	0x0008
 /* Located in the special packed inode */
-#define EROFS_MAP_FRAGMENT	(1 << BH_Fragment)
+#define EROFS_MAP_FRAGMENT	0x0010
 /* The extent refers to partial decompressed data */
-#define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
+#define EROFS_MAP_PARTIAL_REF	0x0020
 
 struct erofs_map_blocks {
 	struct erofs_buf buf;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 481788c24a68..36b795f1ad44 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include <linux/module.h>
-#include <linux/buffer_head.h>
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
-- 
2.24.4

