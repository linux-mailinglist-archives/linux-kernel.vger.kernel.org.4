Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23067507D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjATJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjATJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:16:43 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE940CB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:16:17 -0800 (PST)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2691544C1026;
        Fri, 20 Jan 2023 09:10:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2691544C1026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1674205809;
        bh=fLhnMls291XVNdw4ZC7UY6ceYeUL7Xz55JPcSbwG7pg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZmA3EGjGRJQ5s/Vvk9/3LZ5l4Py6NkNytt6dGxFMoS2vaVFp44xh4AS92ajKzIL0K
         VkwuCmYDRxBwllgleunijku+sYmZF/42O30i3NQLsM10SosJMFyrrAK41jPOh2D7VP
         G6dDhXH7RhrB0THclRVM27T7+ol5/dqAXdYC5Ljk=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     Jan Kara <jack@suse.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] udf: Reserve bits for Bitmap Descriptor buffers
Date:   Fri, 20 Jan 2023 12:08:58 +0300
Message-Id: <20230120090858.1591519-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
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
 fs/udf/balloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 8e597db4d971..52dab5b63715 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -37,6 +37,7 @@ static int read_block_bitmap(struct super_block *sb,
 {
 	struct buffer_head *bh = NULL;
 	int retval = 0;
+	int i;
 	struct kernel_lb_addr loc;
 
 	loc.logicalBlockNum = bitmap->s_extPosition;
@@ -47,6 +48,12 @@ static int read_block_bitmap(struct super_block *sb,
 		retval = -EIO;
 
 	bitmap->s_block_bitmap[bitmap_nr] = bh;
+	/* Reserve bits for Space Bitmap buffer headers. */
+	if (bh && !bitmap_nr)
+		for (i = 0; i < bitmap->s_nr_groups; i++)
+			udf_clear_bit(bitmap->s_extPosition + i +
+				      (sizeof(struct spaceBitmapDesc) << 3),
+				      bh->b_data);
 	return retval;
 }
 
-- 
2.34.1

