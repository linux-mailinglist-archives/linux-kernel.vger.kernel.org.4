Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9B687F84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBBOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjBBOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:05:37 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F466A309
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:05:31 -0800 (PST)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id B9B1340737B2;
        Thu,  2 Feb 2023 14:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B9B1340737B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675346728;
        bh=yFPH1PpzFSBpxkPserZBguNlhwYBSbaUwAf3RQn5fPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKMSk1SSkGj8pje4Wmta5TmgX7skoMM+MeATblwfPhlWIFcDnMGGMM7yNHMM2lqse
         emqDaQGotT4cci6Y9wVJ9gcIg3M8qIAlXS8vH49qIRKUENJcQuAS1Choq0sBQPgnSD
         4HUDz87oDEEPxJcBYoAQhXXBUfWRzJYCFrLai05Y=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     Jan Kara <jack@suse.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH v2] udf: Check consistency of Space Bitmap Descriptor
Date:   Thu,  2 Feb 2023 17:04:56 +0300
Message-Id: <20230202140456.1908875-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124084303.pn7glett53qh6pcp@quack3>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bits, which are related to Bitmap Descriptor logical blocks,
are not reset when buffer headers are allocated for them. As the
result, these logical blocks can be treated as free and
be used for other blocks.This can cause usage of one buffer header
for several types of data. UDF issues WARNING in this situation:

WARNING: CPU: 0 PID: 2703 at fs/udf/inode.c:2014
  __udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014

RIP: 0010:__udf_add_aext+0x685/0x7d0 fs/udf/inode.c:2014
Call Trace:
 udf_setup_indirect_aext+0x573/0x880 fs/udf/inode.c:1980
 udf_add_aext+0x208/0x2e0 fs/udf/inode.c:2067
 udf_insert_aext fs/udf/inode.c:2233 [inline]
 udf_update_extents fs/udf/inode.c:1181 [inline]
 inode_getblk+0x1981/0x3b70 fs/udf/inode.c:885

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
v2: Do not clear bits related to Bitmap Descriptor logical blocks,
but return -EFSCORRUPTED error instead.
 fs/udf/balloc.c  | 24 ++++++++++++++++++++++++
 fs/udf/udfdecl.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 8e597db4d971..ce28d2567f91 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -37,6 +37,11 @@ static int read_block_bitmap(struct super_block *sb,
 {
 	struct buffer_head *bh = NULL;
 	int retval = 0;
+	int i;
+	int max_bits = 0;
+	int max_bits_1st;
+	int max_bits_others;
+	int rest_bits;
 	struct kernel_lb_addr loc;
 
 	loc.logicalBlockNum = bitmap->s_extPosition;
@@ -47,6 +52,25 @@ static int read_block_bitmap(struct super_block *sb,
 		retval = -EIO;
 
 	bitmap->s_block_bitmap[bitmap_nr] = bh;
+	/* Check consistency of Space Bitmap buffer. */
+	if (bh) {
+		max_bits_others = sb->s_blocksize * 8;
+		max_bits_1st = max_bits_others - (sizeof(struct spaceBitmapDesc) << 3);
+		rest_bits = (bitmap->s_nr_groups > max_bits_1st) ?
+					bitmap->s_nr_groups - max_bits_1st : 0;
+		if (!bitmap_nr)
+			max_bits = min(max_bits_1st, bitmap->s_nr_groups);
+		else if (bitmap_nr < rest_bits / max_bits_others + 1)
+			max_bits = max_bits_others;
+		else if (bitmap_nr == rest_bits / max_bits_others + 1)
+			max_bits = rest_bits % max_bits_others;
+		for (i = 0; i < max_bits; i++) {
+			if (udf_test_bit(i + (bitmap_nr ? 0 :
+				(sizeof(struct spaceBitmapDesc) << 3)),
+				 bh->b_data))
+				return -EFSCORRUPTED;
+		}
+	}
 	return retval;
 }
 
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 7e258f15b8ef..130290ae3329 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -16,6 +16,7 @@
 #include "udfend.h"
 #include "udf_i.h"
 
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #define UDF_DEFAULT_PREALLOC_BLOCKS	8
 
 extern __printf(3, 4) void _udf_err(struct super_block *sb,
-- 
2.34.1

