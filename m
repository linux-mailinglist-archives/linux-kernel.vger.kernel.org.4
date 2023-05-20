Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A477C70AA90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjETSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjETSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:41:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF4B9D
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:41:22 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 62A9C3F550
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684608079;
        bh=UtM140w+OA9xiNlPUQXTvPpvdgpWJ8ePnnagXIr6OLw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=luMcPEVlUg2BW9q++aYe/SwNSS+g6pa/h1hAo78nNqMHSHjq+ScUuL/dGNFh9o0Q+
         wGRQI9aeZnePTsu2Wk1GSoyc5DIUjdp1Q9NKUz7of0skZJd9LTzgUJOnLGfC1vOJZz
         mJSfd1+RDoeOv5RvAzetbW4quNnwwiueE4cWsgNumwPqqK44amLKplWbeJAiLJ++mU
         rFVN1oVRnVOzdOM2YzSDcnGNnJ+O0I/BuQAB8DBFW/g0OpyopjNzOsf4W+w+pRBvCy
         jTFed9BPCnCeS+CXcT0OqGfrdSwOnNInH+D2U0d+I8WUV2nbOVoIXCwottgAVb3qZm
         ++itFG5xVn1uA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-969d75fec7aso573179966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684608079; x=1687200079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtM140w+OA9xiNlPUQXTvPpvdgpWJ8ePnnagXIr6OLw=;
        b=ZWX6jLfAFpxkMb1tu/gR1RQ9r+0e8Ms+mU3ENeEOTpKAVKJvpuXmLJ+cwkxyq/i3f5
         mdxrxrxwQg+CqG43tfHKYe+yRU1EpHmt7tms8MwwDc1hRho5PsIAbOAZWolD1vuVCwPQ
         klS0RjrGTgJk+xY/eLGEYaRqgXf5HupWtxECC6Ko6qjEmzBZauaeP2oC/AvmFcviXAl/
         FMIGJ6140P34EsWAsdQlIYxIEGOlABS8u0UwRMPdiWoqw2i6NmGYNQuRqP0uQVWNlXFG
         cSZXLjdPl48ps/0nBzZHSA1H8qdw6vTD5jaZyTEl2tOKh1GI2ESHUUKWA55RENv9NvFa
         9pqw==
X-Gm-Message-State: AC+VfDy1JKHrCPsFFsZPnAAjxXjLIiJ09pHWb7jWhzA4zV2gbr2k7eDY
        dVMguKnm3vatcM9pbyotG8HKf/qn+eo9Ota2QLw0SuGeJyQz9cYHWKB1xOrDoT1FUMErQaYKs7R
        a8NXa+RwGnBUPwVZyNh5dx/GhuqS1voFizEzrMOokCA==
X-Received: by 2002:a17:907:7da7:b0:94e:fa56:a74f with SMTP id oz39-20020a1709077da700b0094efa56a74fmr6201368ejc.14.1684608079144;
        Sat, 20 May 2023 11:41:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5a5Lm2AhtkS1N/2KSIVxMvDV+nPIiEdxwK1Opi1nCSlLHAt/n26B8eylKryT0i8acMHZnQcA==
X-Received: by 2002:a17:907:7da7:b0:94e:fa56:a74f with SMTP id oz39-20020a1709077da700b0094efa56a74fmr6201352ejc.14.1684608078882;
        Sat, 20 May 2023 11:41:18 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-10-127-160.retail.telecomitalia.it. [87.10.127.160])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709065ac600b009663115c8f8sm1046294ejs.152.2023.05.20.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 11:41:18 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ovl: make consistent use of OVL_FS()
Date:   Sat, 20 May 2023 20:41:14 +0200
Message-Id: <20230520184114.77725-3-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520184114.77725-1-andrea.righi@canonical.com>
References: <20230520184114.77725-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always use OVL_FS() to retrieve the corresponding struct ovl_fs from a
struct super_block.

Moreover, make sure that it is exclusively used with an overlayfs
superblock when CONFIG_OVERLAY_FS_DEBUG is enabled (otherwise trigger a
WARN_ON_ONCE).

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/export.c    | 10 +++++-----
 fs/overlayfs/inode.c     |  8 ++++----
 fs/overlayfs/namei.c     |  2 +-
 fs/overlayfs/ovl_entry.h | 16 ++++++++++++++++
 fs/overlayfs/super.c     | 12 ++++++------
 fs/overlayfs/util.c      | 18 +++++++++---------
 7 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index f658cc8ea492..60aa615820e7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -905,7 +905,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 				  int flags)
 {
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 
 	if (!ofs->config.metacopy)
 		return false;
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index defd4e231ad2..f5f0ef8e3ce8 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -182,7 +182,7 @@ static int ovl_connect_layer(struct dentry *dentry)
  */
 static int ovl_check_encode_origin(struct dentry *dentry)
 {
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 
 	/* Upper file handle for pure upper */
 	if (!ovl_dentry_lower(dentry))
@@ -434,7 +434,7 @@ static struct dentry *ovl_lookup_real_inode(struct super_block *sb,
 					    struct dentry *real,
 					    const struct ovl_layer *layer)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 	struct dentry *index = NULL;
 	struct dentry *this = NULL;
 	struct inode *inode;
@@ -655,7 +655,7 @@ static struct dentry *ovl_get_dentry(struct super_block *sb,
 				     struct ovl_path *lowerpath,
 				     struct dentry *index)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 	const struct ovl_layer *layer = upper ? &ofs->layers[0] : lowerpath->layer;
 	struct dentry *real = upper ?: (index ?: lowerpath->dentry);
 
@@ -680,7 +680,7 @@ static struct dentry *ovl_get_dentry(struct super_block *sb,
 static struct dentry *ovl_upper_fh_to_d(struct super_block *sb,
 					struct ovl_fh *fh)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 	struct dentry *dentry;
 	struct dentry *upper;
 
@@ -700,7 +700,7 @@ static struct dentry *ovl_upper_fh_to_d(struct super_block *sb,
 static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 					struct ovl_fh *fh)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 	struct ovl_path origin = { };
 	struct ovl_path *stack = &origin;
 	struct dentry *dentry = NULL;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 541cf3717fc2..c27823f6e7aa 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -334,7 +334,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 bool ovl_is_private_xattr(struct super_block *sb, const char *name)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	if (ofs->config.userxattr)
 		return strncmp(name, OVL_XATTR_USER_PREFIX,
@@ -689,7 +689,7 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)
 {
 	if (flags & S_ATIME) {
-		struct ovl_fs *ofs = inode->i_sb->s_fs_info;
+		struct ovl_fs *ofs = OVL_FS(inode->i_sb);
 		struct path upperpath = {
 			.mnt = ovl_upper_mnt(ofs),
 			.dentry = ovl_upperdentry_dereference(OVL_I(inode)),
@@ -952,7 +952,7 @@ static inline void ovl_lockdep_annotate_inode_mutex_key(struct inode *inode)
 
 static void ovl_next_ino(struct inode *inode)
 {
-	struct ovl_fs *ofs = inode->i_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
 
 	inode->i_ino = atomic_long_inc_return(&ofs->last_ino);
 	if (unlikely(!inode->i_ino))
@@ -1284,7 +1284,7 @@ struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
 static bool ovl_hash_bylower(struct super_block *sb, struct dentry *upper,
 			     struct dentry *lower, bool index)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	/* No, if pure upper */
 	if (!lower)
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index cfb3420b7df0..d0f196b85541 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -832,7 +832,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 {
 	struct ovl_entry *oe;
 	const struct cred *old_cred;
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = dentry->d_parent->d_fsdata;
 	struct ovl_entry *roe = dentry->d_sb->s_root->d_fsdata;
 	struct ovl_path *stack = NULL, *origin_path = NULL;
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index fd11fe6d6d45..0b93b1d9ad79 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -95,8 +95,24 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(struct ovl_fs *ofs)
 	return mnt_idmap(ovl_upper_mnt(ofs));
 }
 
+extern struct file_system_type ovl_fs_type;
+
+#ifdef CONFIG_OVERLAY_FS_DEBUG
+static inline bool is_ovl_fs_sb(struct super_block *sb)
+{
+	return sb->s_type == &ovl_fs_type;
+}
+#else
+static inline bool is_ovl_fs_sb(struct super_block *sb)
+{
+	return true;
+}
+#endif
+
 static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 {
+	WARN_ON_ONCE(!is_ovl_fs_sb(sb));
+
 	return (struct ovl_fs *)sb->s_fs_info;
 }
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f97ad8b40dbb..2ed0f498fce4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -259,7 +259,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 
 static void ovl_put_super(struct super_block *sb)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	ovl_free_fs(ofs);
 }
@@ -267,7 +267,7 @@ static void ovl_put_super(struct super_block *sb)
 /* Sync real dirty inodes in upper filesystem (if it exists) */
 static int ovl_sync_fs(struct super_block *sb, int wait)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 	struct super_block *upper_sb;
 	int ret;
 
@@ -315,7 +315,7 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
  */
 static int ovl_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *root_dentry = dentry->d_sb->s_root;
 	struct path path;
 	int err;
@@ -364,7 +364,7 @@ static inline int ovl_xino_def(void)
 static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 {
 	struct super_block *sb = dentry->d_sb;
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	seq_show_option(m, "lowerdir", ofs->config.lowerdir);
 	if (ofs->config.upperdir) {
@@ -396,7 +396,7 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 
 static int ovl_remount(struct super_block *sb, int *flags, char *data)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 	struct super_block *upper_sb;
 	int ret = 0;
 
@@ -2083,7 +2083,7 @@ static struct dentry *ovl_mount(struct file_system_type *fs_type, int flags,
 	return mount_nodev(fs_type, flags, raw_data, ovl_fill_super);
 }
 
-static struct file_system_type ovl_fs_type = {
+struct file_system_type ovl_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "overlay",
 	.fs_flags	= FS_USERNS_MOUNT,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..2425240ef139 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -18,25 +18,25 @@
 
 int ovl_want_write(struct dentry *dentry)
 {
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	return mnt_want_write(ovl_upper_mnt(ofs));
 }
 
 void ovl_drop_write(struct dentry *dentry)
 {
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	mnt_drop_write(ovl_upper_mnt(ofs));
 }
 
 struct dentry *ovl_workdir(struct dentry *dentry)
 {
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	return ofs->workdir;
 }
 
 const struct cred *ovl_override_creds(struct super_block *sb)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	return override_creds(ofs->creator_cred);
 }
@@ -62,7 +62,7 @@ int ovl_can_decode_fh(struct super_block *sb)
 
 struct dentry *ovl_indexdir(struct super_block *sb)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	return ofs->indexdir;
 }
@@ -70,7 +70,7 @@ struct dentry *ovl_indexdir(struct super_block *sb)
 /* Index all files on copy up. For now only enabled for NFS export */
 bool ovl_index_all(struct super_block *sb)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	return ofs->config.nfs_export && ofs->config.index;
 }
@@ -78,7 +78,7 @@ bool ovl_index_all(struct super_block *sb)
 /* Verify lower origin on lookup. For now only enabled for NFS export */
 bool ovl_verify_lower(struct super_block *sb)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	return ofs->config.nfs_export && ofs->config.index;
 }
@@ -152,7 +152,7 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry)
 
 void ovl_path_upper(struct dentry *dentry, struct path *path)
 {
-	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 
 	path->mnt = ovl_upper_mnt(ofs);
 	path->dentry = ovl_dentry_upper(dentry);
@@ -415,7 +415,7 @@ bool ovl_dentry_needs_data_copy_up(struct dentry *dentry, int flags)
 
 bool ovl_redirect_dir(struct super_block *sb)
 {
-	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_fs *ofs = OVL_FS(sb);
 
 	return ofs->config.redirect_dir && !ofs->noxattr;
 }
-- 
2.39.2

