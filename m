Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A216750A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjATJVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjATJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:21:02 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77146A327
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:20:58 -0800 (PST)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 034F440D4004;
        Fri, 20 Jan 2023 09:11:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 034F440D4004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1674205863;
        bh=UTt+tHsj42HOFpnyUfg6hKr4i6wD1HxdMR25Jv6eyNE=;
        h=From:To:Cc:Subject:Date:From;
        b=lMqevCYj2IT5hFXSvTK0gttjZCRW1fsnD2DU1j8yY7aYcZ3GUKHOzr/9rSPez3+Qw
         ddH38d1Q/IqgdHC3Fr/cZOEXxlxbzRWNimDduQC0nUCDfbDg/cN5ZNVWNdxrw6i3TK
         mmg6Pk1iWgTDC6qVfR3rWsqYxTsEjWajH0fCElY4=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     Jan Kara <jack@suse.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] udf: Check return code from udf_update_extents
Date:   Fri, 20 Jan 2023 12:10:28 +0300
Message-Id: <20230120091028.1591622-1-VEfanov@ispras.ru>
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

udf_add_aext() does not create new extent and returns ENOSPC if new
block was not created by udf_bitmap_new_block(). The caller,
udf_insert_aext(), does not check this return code and returns OK to
its caller(udf_update_extents). Finally the error is being lost. So
an inconsistency in inode.i_size and extents length becomes.

Later this inconsistency leads to WARNING:

WARNING: CPU: 3 PID: 1104 at fs/udf/truncate.c:226
        udf_truncate_extents+0x7e0/0x8e0 fs/udf/truncate.c:226

RIP: 0010:udf_truncate_extents+0x7e0/0x8e0 fs/udf/truncate.c:226
Call Trace:
 udf_write_failed.isra.0+0x173/0x1c0 fs/udf/inode.c:179
 udf_write_begin+0x8d/0xb0 fs/udf/inode.c:214
 generic_perform_write+0x20a/0x4e0 mm/filemap.c:3333
 __generic_file_write_iter+0x252/0x610 mm/filemap.c:3462
 udf_file_write_iter+0x2cc/0x4e0 fs/udf/file.c:168
 call_write_iter include/linux/fs.h:1904 [inline]
 new_sync_write+0x42c/0x660 fs/read_write.c:518
 vfs_write+0x75b/0xa40 fs/read_write.c:605

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
 fs/udf/inode.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 34e416327dd4..74b8695f23ca 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -64,7 +64,7 @@ static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
 static void udf_prealloc_extents(struct inode *, int, int,
 				 struct kernel_long_ad *, int *);
 static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
-static void udf_update_extents(struct inode *, struct kernel_long_ad *, int,
+static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
 			       int, struct extent_position *);
 static int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
 
@@ -876,7 +876,11 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	/* write back the new extents, inserting new extents if the new number
 	 * of extents is greater than the old number, and deleting extents if
 	 * the new number of extents is less than the old number */
-	udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	if (udf_update_extents(inode, laarr, startnum, endnum, &prev_epos) < 0) {
+		udf_debug("udf_update_extents rc != 0");
+		*err = -ENOSPC;
+		goto out_free;
+	}
 
 	newblock = udf_get_pblock(inode->i_sb, newblocknum,
 				iinfo->i_location.partitionReferenceNum, 0);
@@ -1159,21 +1163,26 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
 	}
 }
 
-static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
+static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
 			       int startnum, int endnum,
 			       struct extent_position *epos)
 {
 	int start = 0, i;
 	struct kernel_lb_addr tmploc;
 	uint32_t tmplen;
+	int rc;
 
 	if (startnum > endnum) {
 		for (i = 0; i < (startnum - endnum); i++)
 			udf_delete_aext(inode, *epos);
 	} else if (startnum < endnum) {
 		for (i = 0; i < (endnum - startnum); i++) {
-			udf_insert_aext(inode, *epos, laarr[i].extLocation,
+			rc = udf_insert_aext(inode, *epos, laarr[i].extLocation,
 					laarr[i].extLength);
+			if (rc < 0) {
+				udf_debug("udfd_insert_aext.rc = %d", rc);
+				return rc;
+			}
 			udf_next_aext(inode, epos, &laarr[i].extLocation,
 				      &laarr[i].extLength, 1);
 			start++;
@@ -1185,6 +1194,7 @@ static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr
 		udf_write_aext(inode, epos, &laarr[i].extLocation,
 			       laarr[i].extLength, 1);
 	}
+	return 0;
 }
 
 struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
@@ -2209,6 +2219,7 @@ static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
 	struct kernel_lb_addr oeloc;
 	uint32_t oelen;
 	int8_t etype;
+	int rc;
 
 	if (epos.bh)
 		get_bh(epos.bh);
@@ -2218,7 +2229,12 @@ static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
 		neloc = oeloc;
 		nelen = (etype << 30) | oelen;
 	}
-	udf_add_aext(inode, &epos, &neloc, nelen, 1);
+	rc = udf_add_aext(inode, &epos, &neloc, nelen, 1);
+	if (rc) {
+		udf_debug("udf_add_aext.rc = %d", rc);
+		brelse(epos.bh);
+		return rc;
+	}
 	brelse(epos.bh);
 
 	return (nelen >> 30);
-- 
2.34.1

