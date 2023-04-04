Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE786D5738
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 05:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjDDDaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 23:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjDDDaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 23:30:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8BD19AE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 20:30:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so32609675pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 20:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680579002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SCrUqeM1P3yGd529t2hRwHdcjRZtPKILDnamTlQUXQ=;
        b=CzqiQOeOa+ta+hA2U1HMCdV6+eZQDEMhIqvt65+TtWpqkDFS4BFWCkl4/bTULAA388
         fQDLo0/Y0eea8yR+ddCvHR9jG0D64iLIfYciavMNkE5S4mZdXwrLt68g+1b6vQYc5rjt
         kep1qzVuyw6u+L4/uTehRgKVusRBYQ4m+1fZiEUZvu0z5SM8gh/cDFR6NQcSo3yCeGV9
         kXmw/lwo/9ahE+XOGSV0G20phPROjvn155wOg4/ADwu/ZsuKMt3oMkrlcrKYH7oVs2Hu
         HaBMGFFNzlU6aAcuXs+PwOCT033QSCyZGt+K3wptCzdPXSLKxlEQ8IyUmhEtL+Fdx9Ah
         +DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680579002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SCrUqeM1P3yGd529t2hRwHdcjRZtPKILDnamTlQUXQ=;
        b=yq54bFhHpHMh355prAAwNj6u+2vlkH0yfS/BxP9Z6CcKaLjTeyG31KfIeNLy+Uw9Bc
         5G5uG1BBDYGvXmWXwAtMiQyhvBwWPb9Ku9GCT59afA8S1HOG1NB2nJxWusTr/77pZbps
         idCT7bdcadcXy/qL6ArsMEvRKYzDAAlyZ4ZH3i/DNDLkQhD3pxZpFFM1fOgC5VIBPSdU
         49aiFufklMJUEYUU/CZo+W1Cu9l0sg13L7oqFrvMtp+oZbzZtkM027m+h3ieRAUnyy1G
         SJRUMhJ0PsOVV0m4WDjZBRip5dR8j1/JxHRW37nV07P7ee9qkPqzv7vxswq7JIkbJJAz
         qobA==
X-Gm-Message-State: AAQBX9e9Gz+mpSoXJKTnkYnnUZ6kUvh78rwF3rgx+qnGTfwShF4IFFgD
        bLCas7wtbzCKerOBFCzUyfc=
X-Google-Smtp-Source: AKy350Yff+5F1amie00s7tLoMAqgIv1zZEfcaKS3xqpJN07eq8Ra+GLIW13XiS1cmeFbmR2OSqUx5g==
X-Received: by 2002:a17:90a:5314:b0:23d:3a3f:950b with SMTP id x20-20020a17090a531400b0023d3a3f950bmr1311028pjh.22.1680579002199;
        Mon, 03 Apr 2023 20:30:02 -0700 (PDT)
Received: from localhost.localdomain ([103.117.248.198])
        by smtp.gmail.com with ESMTPSA id js2-20020a17090b148200b002339491ead6sm10577019pjb.5.2023.04.03.20.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 20:30:01 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH] f2fs: use common implementation of file type
Date:   Tue,  4 Apr 2023 11:28:44 +0800
Message-Id: <20230404032844.3596879-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common implementation of file type conversion helpers.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 fs/f2fs/dir.c           | 39 +++------------------------------------
 fs/f2fs/f2fs.h          |  1 -
 fs/f2fs/inline.c        |  2 +-
 include/linux/f2fs_fs.h | 15 ---------------
 4 files changed, 4 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9ccdbe120425..225672e9469c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -42,39 +42,6 @@ static unsigned int bucket_blocks(unsigned int level)
 		return 4;
 }
 
-static unsigned char f2fs_filetype_table[F2FS_FT_MAX] = {
-	[F2FS_FT_UNKNOWN]	= DT_UNKNOWN,
-	[F2FS_FT_REG_FILE]	= DT_REG,
-	[F2FS_FT_DIR]		= DT_DIR,
-	[F2FS_FT_CHRDEV]	= DT_CHR,
-	[F2FS_FT_BLKDEV]	= DT_BLK,
-	[F2FS_FT_FIFO]		= DT_FIFO,
-	[F2FS_FT_SOCK]		= DT_SOCK,
-	[F2FS_FT_SYMLINK]	= DT_LNK,
-};
-
-static unsigned char f2fs_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]	= F2FS_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	= F2FS_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	= F2FS_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	= F2FS_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	= F2FS_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	= F2FS_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	= F2FS_FT_SYMLINK,
-};
-
-static void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
-{
-	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
-}
-
-unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de)
-{
-	if (de->file_type < F2FS_FT_MAX)
-		return f2fs_filetype_table[de->file_type];
-	return DT_UNKNOWN;
-}
-
 /* If @dir is casefolded, initialize @fname->cf_name from @fname->usr_fname. */
 int f2fs_init_casefolded_name(const struct inode *dir,
 			      struct f2fs_filename *fname)
@@ -485,7 +452,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	lock_page(page);
 	f2fs_wait_on_page_writeback(page, type, true, true);
 	de->ino = cpu_to_le32(inode->i_ino);
-	set_de_type(de, inode->i_mode);
+	de->file_type = fs_umode_to_ftype(inode->i_mode);
 	set_page_dirty(page);
 
 	dir->i_mtime = dir->i_ctime = current_time(dir);
@@ -699,7 +666,7 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 	de->name_len = cpu_to_le16(name->len);
 	memcpy(d->filename[bit_pos], name->name, name->len);
 	de->ino = cpu_to_le32(ino);
-	set_de_type(de, mode);
+	de->file_type = fs_umode_to_ftype(mode);
 	for (i = 0; i < slots; i++) {
 		__set_bit_le(bit_pos + i, (void *)d->bitmap);
 		/* avoid wrong garbage data for readdir */
@@ -1036,7 +1003,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			continue;
 		}
 
-		d_type = f2fs_get_de_type(de);
+		d_type = fs_ftype_to_dtype(de->file_type);
 
 		de_name.name = d->filename[bit_pos];
 		de_name.len = le16_to_cpu(de->name_len);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b0ab2062038a..3f39d162d858 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3489,7 +3489,6 @@ int f2fs_get_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 /*
  * dir.c
  */
-unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de);
 int f2fs_init_casefolded_name(const struct inode *dir,
 			      struct f2fs_filename *fname);
 int f2fs_setup_filename(struct inode *dir, const struct qstr *iname,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 72269e7efd26..4638fee16a91 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -497,7 +497,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 		fname.hash = de->hash_code;
 
 		ino = le32_to_cpu(de->ino);
-		fake_mode = f2fs_get_de_type(de) << S_SHIFT;
+		fake_mode = fs_ftype_to_dtype(de->file_type) << S_DT_SHIFT;
 
 		err = f2fs_add_regular_entry(dir, &fname, NULL, ino, fake_mode);
 		if (err)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 1701f25117ea..d80195d226ab 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -585,21 +585,6 @@ struct f2fs_dentry_block {
 	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
 } __packed;
 
-/* file types used in inode_info->flags */
-enum {
-	F2FS_FT_UNKNOWN,
-	F2FS_FT_REG_FILE,
-	F2FS_FT_DIR,
-	F2FS_FT_CHRDEV,
-	F2FS_FT_BLKDEV,
-	F2FS_FT_FIFO,
-	F2FS_FT_SOCK,
-	F2FS_FT_SYMLINK,
-	F2FS_FT_MAX
-};
-
-#define S_SHIFT 12
-
 #define	F2FS_DEF_PROJID		0	/* default project ID */
 
 #endif  /* _LINUX_F2FS_FS_H */
-- 
2.25.1

