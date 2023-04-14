Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256F6E1E52
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDNIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:30:42 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF59ED8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:30:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vg2zKY5_1681461034;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vg2zKY5_1681461034)
          by smtp.aliyun-inc.com;
          Fri, 14 Apr 2023 16:30:35 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: cleanup i_format-related stuffs
Date:   Fri, 14 Apr 2023 16:30:27 +0800
Message-Id: <20230414083027.12307-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
References: <20230414083027.12307-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch EROFS_I_{VERSION,DATALAYOUT}_BITS into
EROFS_I_{VERSION,DATALAYOUT}_MASK.

Also avoid erofs_bitrange() since its functionality is simple enough.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h |  8 ++++----
 fs/erofs/internal.h | 18 ++++--------------
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 4ec422c2b74f..2c7b16e340fe 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -109,14 +109,14 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 }
 
 /* bit definitions of inode i_format */
-#define EROFS_I_VERSION_BITS            1
-#define EROFS_I_DATALAYOUT_BITS         3
+#define EROFS_I_VERSION_MASK            0x01
+#define EROFS_I_DATALAYOUT_MASK         0x07
 
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATALAYOUT_BIT          1
+#define EROFS_I_ALL_BIT			4
 
-#define EROFS_I_ALL	\
-	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
+#define EROFS_I_ALL	((1 << EROFS_I_ALL_BIT) - 1)
 
 /* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
 #define EROFS_CHUNK_FORMAT_BLKBITS_MASK		0x001F
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6c8c0504032e..e7b7d3f581c4 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -343,24 +343,14 @@ static inline erofs_off_t erofs_iloc(struct inode *inode)
 		(EROFS_I(inode)->nid << sbi->islotbits);
 }
 
-static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
-					  unsigned int bits)
+static inline unsigned int erofs_inode_version(unsigned int ifmt)
 {
-
-	return (value >> bit) & ((1 << bits) - 1);
-}
-
-
-static inline unsigned int erofs_inode_version(unsigned int value)
-{
-	return erofs_bitrange(value, EROFS_I_VERSION_BIT,
-			      EROFS_I_VERSION_BITS);
+	return (ifmt >> EROFS_I_VERSION_BIT) & EROFS_I_VERSION_MASK;
 }
 
-static inline unsigned int erofs_inode_datalayout(unsigned int value)
+static inline unsigned int erofs_inode_datalayout(unsigned int ifmt)
 {
-	return erofs_bitrange(value, EROFS_I_DATALAYOUT_BIT,
-			      EROFS_I_DATALAYOUT_BITS);
+	return (ifmt >> EROFS_I_DATALAYOUT_BIT) & EROFS_I_DATALAYOUT_MASK;
 }
 
 /*
-- 
2.24.4

