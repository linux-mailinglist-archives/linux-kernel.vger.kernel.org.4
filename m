Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6445EB8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiI0D32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiI0D2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:28:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641F107DCD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:26:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so7420169pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KZblzyshVRsZqp8gcyYhUjl47k0q6CEw/a6KSnrIuT0=;
        b=SY1jDJoWRbBK/7TMYE8e22/APXrF9W/gl9jIEBX+t4PwNBwRwwMrkTasdYFuRa4tii
         jpB3Peaa889ximjpj9Gch6FTF9O7lDJSSFrboeXsDIh6IbhmsrtZJ2ir7+APJ2qfvkWG
         3FX8x0rxnxpPmt8I+rOZFscoN1NdZPQ1VUMhRoh3nf8bfUbcUm3YIMm3KvFxeeIO/8Nk
         TUuirFCfuRIOoYSn7CjmbmLEa1iz35M7P7Eh22ia/IUjVNY9e6sZLKwPru3qI9jDuX+M
         /p2tNZ2EKt4n15HcthRT5pbspWIVKagK5uQnNWMZhSGreA7rzfxh5KvfH91c3BX28uYf
         +u5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KZblzyshVRsZqp8gcyYhUjl47k0q6CEw/a6KSnrIuT0=;
        b=3BOhGKV/E8hbX1MOcUbmndOgFWtygXea7qjIRnLVoff4BsJqeUhnVReBWOMJekJIQ/
         +kbCGOH2BNt+hV9HpIMw6SBGYKsRV4WtTLUGdACHPVNeKonyUZTqB6T/2ORdshfpt2R6
         j2npMTBMAWOCGkCiztjvJ6bS2LwXTwLdZrVg5zk81vj7QpssKHd8u6VTxU8DOzerXkUv
         2mnAdh5POpqxvewbTabwhEnL6XoddWZUxjntqKyn/mIZRN2tJhcQoqEQUmnLizejQOYq
         pOkatxYpoPgu8CGORPp53pjNEW3bdiOBqrP85KP8XjMARnH2malW9j/xyooM7D9zBofu
         fLXQ==
X-Gm-Message-State: ACrzQf04vXTxdmKuOU0tdY3f54CK3JLtqXD6O4pXzOoPa6HviEOTx7N1
        gl/NqNqjMJ8Kjn5j94mNcxiXD6lbM9Q=
X-Google-Smtp-Source: AMsMyM6ehde7iMnPLV2L8onbpU6kIXx//z/vxwguggErnKb0GtFbTCnRrazAf7zHjjB2+/Z5dYufOQ==
X-Received: by 2002:a63:698a:0:b0:41c:8dfb:29cb with SMTP id e132-20020a63698a000000b0041c8dfb29cbmr22481624pgc.170.1664249168435;
        Mon, 26 Sep 2022 20:26:08 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b0017550eaa3eesm223390plk.71.2022.09.26.20.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:26:08 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: fold in z_erofs_reload_indexes()
Date:   Tue, 27 Sep 2022 11:25:18 +0800
Message-Id: <20220927032518.25266-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

The name of this function looks not very accurate compared to it's
implementation and it's only a wrapper to erofs_read_metabuf(). So,
let's fold it directly instead.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/zmap.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index ccdddb755be8..4cecd32b87c6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -166,18 +166,6 @@ struct z_erofs_maprecorder {
 	bool partialref;
 };
 
-static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
-				  erofs_blk_t eblk)
-{
-	struct super_block *const sb = m->inode->i_sb;
-
-	m->kaddr = erofs_read_metabuf(&m->map->buf, sb, eblk,
-				      EROFS_KMAP_ATOMIC);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
-	return 0;
-}
-
 static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					 unsigned long lcn)
 {
@@ -190,11 +178,11 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 		lcn * sizeof(struct z_erofs_vle_decompressed_index);
 	struct z_erofs_vle_decompressed_index *di;
 	unsigned int advise, type;
-	int err;
 
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
-	if (err)
-		return err;
+	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
+				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
+	if (IS_ERR(m->kaddr))
+		return PTR_ERR(m->kaddr);
 
 	m->nextpackoff = pos + sizeof(struct z_erofs_vle_decompressed_index);
 	m->lcn = lcn;
@@ -393,7 +381,6 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	unsigned int compacted_4b_initial, compacted_2b;
 	unsigned int amortizedshift;
 	erofs_off_t pos;
-	int err;
 
 	if (lclusterbits != 12)
 		return -EOPNOTSUPP;
@@ -430,9 +417,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	amortizedshift = 2;
 out:
 	pos += lcn * (1 << amortizedshift);
-	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
-	if (err)
-		return err;
+	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
+				      erofs_blknr(pos), EROFS_KMAP_ATOMIC);
+	if (IS_ERR(m->kaddr))
+		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-- 
2.17.1

