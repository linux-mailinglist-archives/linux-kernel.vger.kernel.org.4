Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D346291E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiKOGgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiKOGgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:36:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C051F2E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:36:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j12so12288227plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HKZAEUVQQUBttDmyc7IKUPKjfreDh+ajk8XM2NRY3o=;
        b=a4yJy1ooSkHn+oYyYqCVoMQVZzD/uU5LFhOK0nPMBaEpYkghqShsP/rETQ1BHs3HXe
         Mty1rEssYGt5wbQmyhAEQGzaLj3QyYSHjvB8UhQKQ28xgmfxW5X7KydjCIbc6LfRS69H
         1mxMokS35vYoggGeNRZvbkKyNsSwiLASJuLqZNTLiwlrYLrySOYaEwJL0r8GsTRu4IvL
         EBzJSjb5XODMKQHHInsT6rpxccfOeXgs7ViB9j6h0xJ1/N8jd6q3C2lIu04kAx3EIQQ+
         Yl2UUgfahLk2gRljblLqXdHpHboy37jImoK2/+B2XV5VvITePgTI0jlyQvwmIUCKHG9E
         utng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HKZAEUVQQUBttDmyc7IKUPKjfreDh+ajk8XM2NRY3o=;
        b=oUCOmML16i9PKVnxWxjfTufSurUHVHJsnmws/BewmWUvT2gn0QFn5laocvHsn2LmIi
         SSJ4Xbado40mSw3NGY/VR5RaBrR1QBz1eaDWgI5ZxnZT74jCpGGq/JUNoeOiej8F/T6J
         hMuWW3gFBxOTZ5zkjEGQgmPVbRJDT7aJnbor2s30JCLRrLxFIeGOxewxge3eIGs1GJ65
         fHZJSs6E9+SWnEaL2FBt3ma5KGrRtnvGRYTOIRjaUCS2Hcn1rSQZkbFrAeDO/SKltFZl
         UwS8vckMpoc1Em/fD6of9X4fhyLANLvsuq33lf5B2HjmIRt76uIbrMbMBbpNLRSRhCaR
         prjg==
X-Gm-Message-State: ANoB5plEQd0Q3IFQslzE18zm0ErJv7RCSslV1Z/iVymgx9uwu1pHOeuw
        IDTNYbHTm8jt+HAiu/GgZKyJ2Nk2xbI=
X-Google-Smtp-Source: AA0mqf43JnCfXobNbI1CW7VnWqHCB8eV8NhwkeGxU6gwreo1mX/VPKdstNMos7HR1AZAx69v61zLOw==
X-Received: by 2002:a17:90a:6e04:b0:213:22d:b2e2 with SMTP id b4-20020a17090a6e0400b00213022db2e2mr713827pjk.148.1668494163260;
        Mon, 14 Nov 2022 22:36:03 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001822121c45asm8767874pld.28.2022.11.14.22.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:36:02 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH v2 3/3] f2fs: change type for 'sbi->readdir_ra'
Date:   Tue, 15 Nov 2022 14:35:37 +0800
Message-Id: <20221115063537.59023-4-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
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

Before this patch, the varibale 'readdir_ra' takes effect if it's equal
to '1' or not, so we can change type for it from 'int' to 'bool'.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/dir.c   | 2 +-
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/super.c | 2 +-
 fs/f2fs/sysfs.c | 5 +++++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 21960a899b6a..eecbf5d6b002 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1000,7 +1000,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
 	struct blk_plug plug;
-	bool readdir_ra = sbi->readdir_ra == 1;
+	bool readdir_ra = sbi->readdir_ra;
 	bool found_valid_dirent = false;
 	int err = 0;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..384840216e7f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1693,7 +1693,7 @@ struct f2fs_sb_info {
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
 	int dir_level;				/* directory level */
-	int readdir_ra;				/* readahead inode in readdir */
+	bool readdir_ra;			/* readahead inode in readdir */
 	u64 max_io_bytes;			/* max io bytes to merge IOs */
 
 	block_t user_block_count;		/* # of user blocks */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3e974c003b77..0d1adfdd0603 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4068,7 +4068,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 					1 << F2FS_IPU_HONOR_OPU_WRITE;
 	}
 
-	sbi->readdir_ra = 1;
+	sbi->readdir_ra = true;
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..53fbbb87dd0f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -649,6 +649,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "readdir_ra")) {
+		sbi->readdir_ra = !!t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
-- 
2.34.1

