Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07A472C6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjFLOBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbjFLOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:00:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59D310D9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:00:54 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QftYR4Th3zLqLh;
        Mon, 12 Jun 2023 21:57:47 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 22:00:51 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     Jan Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 1/2] udf: add helper function udf_check_tagged_bh to check tagged page
Date:   Tue, 13 Jun 2023 11:22:53 +0800
Message-ID: <20230613032254.1235752-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230613032254.1235752-1-haowenchao2@huawei.com>
References: <20230613032254.1235752-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper function is used to check if a buffer head's data is valid
and would be called in future.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 fs/udf/misc.c    | 60 ++++++++++++++++++++++++++++--------------------
 fs/udf/udfdecl.h |  1 +
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 3777468d06ce..b20b53fc8d41 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -179,6 +179,40 @@ struct genericFormat *udf_get_extendedattr(struct inode *inode, uint32_t type,
 	return NULL;
 }
 
+bool udf_check_tagged_bh(struct super_block *sb, struct buffer_head *bh)
+{
+	u8 checksum;
+	struct tag *tag_p = (struct tag *)(bh->b_data);
+
+	/* Verify the tag checksum */
+	checksum = udf_tag_checksum(tag_p);
+	if (checksum != tag_p->tagChecksum) {
+		udf_err(sb, "tag checksum failed, block %llu: 0x%02x != 0x%02x\n",
+			bh->b_blocknr, checksum, tag_p->tagChecksum);
+		return false;
+	}
+
+	/* Verify the tag version */
+	if (tag_p->descVersion != cpu_to_le16(0x0002U) &&
+	    tag_p->descVersion != cpu_to_le16(0x0003U)) {
+		udf_err(sb, "tag version 0x%04x != 0x0002 || 0x0003, block %llu\n",
+			le16_to_cpu(tag_p->descVersion), bh->b_blocknr);
+		return false;
+	}
+
+	/* Verify the descriptor CRC */
+	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize ||
+	    le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
+					bh->b_data + sizeof(struct tag),
+					le16_to_cpu(tag_p->descCRCLength)))
+		return true;
+
+	udf_debug("Crc failure block %llu: crc = %u, crclen = %u\n", bh->b_blocknr,
+		  le16_to_cpu(tag_p->descCRC),
+		  le16_to_cpu(tag_p->descCRCLength));
+	return false;
+}
+
 /*
  * udf_read_tagged
  *
@@ -194,7 +228,6 @@ struct buffer_head *udf_read_tagged(struct super_block *sb, uint32_t block,
 {
 	struct tag *tag_p;
 	struct buffer_head *bh = NULL;
-	u8 checksum;
 
 	/* Read the block */
 	if (block == 0xFFFFFFFF)
@@ -217,32 +250,9 @@ struct buffer_head *udf_read_tagged(struct super_block *sb, uint32_t block,
 		goto error_out;
 	}
 
-	/* Verify the tag checksum */
-	checksum = udf_tag_checksum(tag_p);
-	if (checksum != tag_p->tagChecksum) {
-		udf_err(sb, "tag checksum failed, block %u: 0x%02x != 0x%02x\n",
-			block, checksum, tag_p->tagChecksum);
-		goto error_out;
-	}
-
-	/* Verify the tag version */
-	if (tag_p->descVersion != cpu_to_le16(0x0002U) &&
-	    tag_p->descVersion != cpu_to_le16(0x0003U)) {
-		udf_err(sb, "tag version 0x%04x != 0x0002 || 0x0003, block %u\n",
-			le16_to_cpu(tag_p->descVersion), block);
-		goto error_out;
-	}
-
-	/* Verify the descriptor CRC */
-	if (le16_to_cpu(tag_p->descCRCLength) + sizeof(struct tag) > sb->s_blocksize ||
-	    le16_to_cpu(tag_p->descCRC) == crc_itu_t(0,
-					bh->b_data + sizeof(struct tag),
-					le16_to_cpu(tag_p->descCRCLength)))
+	if (udf_check_tagged_bh(sb, bh))
 		return bh;
 
-	udf_debug("Crc failure block %u: crc = %u, crclen = %u\n", block,
-		  le16_to_cpu(tag_p->descCRC),
-		  le16_to_cpu(tag_p->descCRCLength));
 error_out:
 	brelse(bh);
 	return NULL;
diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
index 88692512a466..fb269752b9c6 100644
--- a/fs/udf/udfdecl.h
+++ b/fs/udf/udfdecl.h
@@ -180,6 +180,7 @@ extern struct genericFormat *udf_add_extendedattr(struct inode *, uint32_t,
 						  uint32_t, uint8_t);
 extern struct genericFormat *udf_get_extendedattr(struct inode *, uint32_t,
 						  uint8_t);
+extern bool udf_check_tagged_bh(struct super_block *sb, struct buffer_head *bh);
 extern struct buffer_head *udf_read_tagged(struct super_block *, uint32_t,
 					   uint32_t, uint16_t *);
 extern struct buffer_head *udf_read_ptagged(struct super_block *,
-- 
2.35.3

