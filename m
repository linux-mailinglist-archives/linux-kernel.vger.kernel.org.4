Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E118658978
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiL2FCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2FCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:02:23 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC624D98
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:02:22 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jn22so17900339plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1mivAos7aw2lF7pffWtnDAp/fEv2Z2GFmHst6ajZYY=;
        b=a9jmeWZYD+lMRIIZhzmSW9OJWC0whsa71FgNE1tFNJ3c4jzi6Fa0MYT04DeDhhMtH9
         T772SGmJTlgVYd5ueXF+Neo+rV8ahl/Q52y28GMNMUFsYZ6yPiuJhRlTKEQ3dtqeNzjJ
         H3mfrbqUwyumD7+Zrt8npldkGei8lKAEey09n1S62wB17SgBiqw/a4eGQJJZHTLiZiTp
         qbI/ZD6BMeBcem9oY+CmwX6felfkUckj5XsAOGDZa1Lsn2xTsEMWyuEiwATZa7F16KT4
         021P09tP26Mf4zExBzhVWlYMz1POvk1/gbrEqaEI4sjoHANYERmvSk30eFDoMILOr0LB
         pfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1mivAos7aw2lF7pffWtnDAp/fEv2Z2GFmHst6ajZYY=;
        b=Gg9u3mGb6jE/FbpvD+sgBVv/F9xuJUUYC4upXc3KqRY7zeMGDdWu8WMGjDO9RzCB/9
         gANVPH+bfgqOY0o1UNNtVJmP8i017kk4odge2egyD6iDyrQs8QkzP7MZdyRCzVdscdV1
         YDUripiNF5M/fFp94wzsOtpcNdb3UOCT3c5FdVhWaJlL+ivM/CEgPw/DXYyAfi7M+ilN
         4I8hnNt3J1vhtD059Rm5MQU7BKAQuHZ7DnryQ+c+CogipTctNUbRHL7V9S3AXLQXTgQp
         uPack+3etkC5538nq/GkfZi0XQt6Evs4Z1trzYxE7mJ7sB2djfMquHNZKBd+me74G9J9
         6FhA==
X-Gm-Message-State: AFqh2koMNDMnMqC6AjhfFxM0XwmyRe0P1vBmCD+hwnKGAvpIQI4OgNVM
        Sz2EffSQH6X+ot1d7ZdY9b8=
X-Google-Smtp-Source: AMrXdXv4jrMPnsTLW7G62bFpu/9iy22MCb5hdyPP6OggYcA4O3zlguPHKvOsHd0O6lWVPLpIzgCt6g==
X-Received: by 2002:a05:6a21:9216:b0:af:ca6c:7d9f with SMTP id tl22-20020a056a21921600b000afca6c7d9fmr37981006pzb.19.1672290142423;
        Wed, 28 Dec 2022 21:02:22 -0800 (PST)
Received: from localhost.localdomain ([103.158.43.18])
        by smtp.googlemail.com with ESMTPSA id 72-20020a63064b000000b00477602ff6a8sm10093654pgg.94.2022.12.28.21.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 21:02:22 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        syzbot+908340a8367281960537@syzkaller.appspotmail.com
Subject: [PATCH] udf: Fix slab-out-of-bound write in udf_write_aext
Date:   Thu, 29 Dec 2022 10:31:42 +0530
Message-Id: <20221229050142.448537-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports an out of bound write in udf_write_aext.
This bug can be reproduced by mounting a UDF filesystem with the
noadinicb mount option and then creating a directory inside.

The bug is caused because udf_add_entry function tries to incorrectly
round off the previous extent for the newly created inode.

Fix the bug by creating an extent before calling udf_add_entry when the
noadinicb option is used, in udf_mkdir function.

Link: https://syzkaller.appspot.com/bug?id=5870f4bbc7294f2b4405a408e35e7e96100fb284
Reported-and-tested-by: syzbot+908340a8367281960537@syzkaller.appspotmail.com
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 fs/udf/namei.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 7c95c549dd64..796fd3be3769 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -678,6 +678,47 @@ static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	iinfo = UDF_I(inode);
 	inode->i_op = &udf_dir_inode_operations;
 	inode->i_fop = &udf_dir_operations;
+	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
+		struct kernel_lb_addr eloc;
+		struct extent_position epos = {};
+		udf_pblk_t block;
+		uint32_t bsize;
+
+		block = udf_new_block(dir->i_sb, inode,
+				      iinfo->i_location.partitionReferenceNum,
+				      iinfo->i_location.logicalBlockNum, &err);
+		if (!block) {
+			inode_dec_link_count(inode);
+			discard_new_inode(inode);
+			goto out;
+		}
+		epos.block = iinfo->i_location;
+		epos.offset = udf_file_entry_alloc_offset(inode);
+		epos.bh = NULL;
+		eloc.logicalBlockNum = block;
+		eloc.partitionReferenceNum =
+			iinfo->i_location.partitionReferenceNum;
+		bsize = dir->i_sb->s_blocksize;
+		iinfo->i_lenExtents = bsize;
+		udf_add_aext(inode, &epos, &eloc, bsize, 0);
+		brelse(epos.bh);
+
+		block = udf_get_pblock(dir->i_sb, block,
+				       iinfo->i_location.partitionReferenceNum,
+				       0);
+		epos.bh = udf_tgetblk(dir->i_sb, block);
+		if (unlikely(!epos.bh)) {
+			err = -ENOMEM;
+			inode_dec_link_count(inode);
+			discard_new_inode(inode);
+			goto out;
+		}
+		lock_buffer(epos.bh);
+		memset(epos.bh->b_data, 0x00, bsize);
+		set_buffer_uptodate(epos.bh);
+		unlock_buffer(epos.bh);
+		mark_buffer_dirty_inode(epos.bh, inode);
+	}
 	fi = udf_add_entry(inode, NULL, &fibh, &cfi, &err);
 	if (!fi) {
 		inode_dec_link_count(inode);
-- 
2.38.1

