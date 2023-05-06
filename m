Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD826F929A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjEFPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjEFPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:09:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A525E1157B;
        Sat,  6 May 2023 08:09:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115e652eeso25653214b3a.0;
        Sat, 06 May 2023 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683385759; x=1685977759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF8GDeVIxyqlJEAfd0RcDDRRi9wR9sAYdpzmsClyNvE=;
        b=nHr4+3jU7Qavm5W04l5x1287DlXrE+tyxBSvJm42iij5SAri4RknRKSUGKQPCM+j5K
         rk/d1yj/966tKVSY5CAlnEgpcQmJP5y9oXWvA3asP2fs8HFYc8JwHbEk/22TpvJn6o9n
         KYZVKm+RThNcRNuYJiYiaq/gEFTI0HXkJbQkwH3X6egT7h4cGB3FVZYejXJqZBXNGf6a
         3+g/SQUlkNBw6yAmGtAGPa3jpsfQpCxxAAMdI9PjIZMsKMUzjnQPneN3iP81Lq6aUXW2
         dUdy/lAUGXdLfmwpsaj1St+MhHogwZb+Csi/CcrabRAPm+1bwXw8SF+NFdjl3cp+Vv+C
         bV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683385759; x=1685977759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF8GDeVIxyqlJEAfd0RcDDRRi9wR9sAYdpzmsClyNvE=;
        b=KQTdoo6g2AHuHz7mVz7AkB3bVNXuZoJQLaEJOf+D4UYgiOeBAZAPWJjAsbuG7frVST
         vyJCnX8Lt0sISd0Q4iqWhtc9I7WTBs+5Gk/JG/lJbLzy72Oox1cId5rTLE7+eSxhfg41
         4q0652M/L/c5VYXjs9jSCnNrEgP+CDjKdxmsMt5JchjsnFwM+2rdxGCGgCcM7wLmeNH3
         nMKuBfguIZpav3N6Fld3TiNf+yPwjwReeAttqk5+hbh5K0bVCMrXM4wC2TIqxnzZI//4
         1PeWQbq91aSo7QGEp+GC1A3DfD1FlHQELo7eZaOb+61jP24B3scoXw44hcjYXLPegoE0
         8laA==
X-Gm-Message-State: AC+VfDztbJ7lB1LsfdpY1knDnnlknAD9gKHotQYwWUvJxaGdHg0R8RMl
        ngPH8R+DlRZFYruZYb7362I=
X-Google-Smtp-Source: ACHHUZ7yrrFvsmZLxYpRQvwebKg4YynQZdND3cQLzZjomKfjgRuMl4mVVOciLBKkrL3SCEw7iHQvKA==
X-Received: by 2002:a05:6a20:144f:b0:ef:8de0:6a5 with SMTP id a15-20020a056a20144f00b000ef8de006a5mr6083765pzi.3.1683385758731;
        Sat, 06 May 2023 08:09:18 -0700 (PDT)
Received: from localhost.localdomain ([47.98.195.232])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7854f000000b0063db25e140bsm3347182pfn.32.2023.05.06.08.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 08:09:18 -0700 (PDT)
From:   wenjun93 <gwj0511@gmail.com>
X-Google-Original-From: wenjun93 <gwj1235@yeah.net>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenjun93 <gwj1235@yeah.net>
Subject: [PATCH v2] overlayfs: clean error handling
Date:   Sat,  6 May 2023 23:09:11 +0800
Message-Id: <20230506150911.1983249-1-gwj1235@yeah.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <amir73il@gmail.com>
References: <amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove PTR_ERR from unused code path and
assign error value where it exactly happens.
This cleans the code and also helps to reduce 
the possibility of incorrect err settings
when it's set globally and is forgotten to be
overwrite in custom development.

Signed-off-by: wenjun93 <gwj1235@yeah.net>
---
 fs/overlayfs/copy_up.c |  20 ++++----
 fs/overlayfs/dir.c     | 101 ++++++++++++++++++++++++-----------------
 fs/overlayfs/export.c  |  22 +++++----
 fs/overlayfs/namei.c   |  34 ++++++++------
 fs/overlayfs/readdir.c |   5 +-
 fs/overlayfs/super.c   |  80 ++++++++++++++++++--------------
 fs/overlayfs/util.c    |   2 +-
 7 files changed, 154 insertions(+), 110 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index f658cc8ea492..2ec25bcacf8f 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -507,9 +507,10 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 		return err;
 
 	temp = ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
-	err = PTR_ERR(temp);
-	if (IS_ERR(temp))
+	if (IS_ERR(temp)) {
+		err = PTR_ERR(temp);
 		goto free_name;
+	}
 
 	err = ovl_set_upper_fh(ofs, upper, temp);
 	if (err)
@@ -705,9 +706,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	};
 
 	/* workdir and destdir could be the same when copying up to indexdir */
-	err = -EIO;
-	if (lock_rename(c->workdir, c->destdir) != NULL)
+	if (lock_rename(c->workdir, c->destdir) != NULL) {
+		err = -EIO;
 		goto unlock;
+	}
 
 	err = ovl_prep_cu_creds(c->dentry, &cc);
 	if (err)
@@ -716,9 +718,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	temp = ovl_create_temp(ofs, c->workdir, &cattr);
 	ovl_revert_cu_creds(&cc);
 
-	err = PTR_ERR(temp);
-	if (IS_ERR(temp))
+	if (IS_ERR(temp)) {
+		err = PTR_ERR(temp);
 		goto unlock;
+	}
 
 	/*
 	 * Copy up data first and then xattrs. Writing data after
@@ -741,9 +744,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
 				 c->destname.len);
-	err = PTR_ERR(upper);
-	if (IS_ERR(upper))
+	if (IS_ERR(upper)) {
+		err = PTR_ERR(upper);
 		goto cleanup;
+	}
 
 	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
 	dput(upper);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fc25fb95d5fc..e083bb343ffa 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -115,9 +115,10 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 	int flags = 0;
 
 	whiteout = ovl_whiteout(ofs);
-	err = PTR_ERR(whiteout);
-	if (IS_ERR(whiteout))
+	if (IS_ERR(whiteout)) {
+		err = PTR_ERR(whiteout);
 		return err;
+	}
 
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
@@ -176,9 +177,10 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 	if (IS_ERR(newdentry))
 		return newdentry;
 
-	err = -ESTALE;
-	if (newdentry->d_inode)
+	if (newdentry->d_inode) {
+		err = -ESTALE;
 		goto out;
+	}
 
 	if (attr->hardlink) {
 		err = ovl_do_link(ofs, attr->hardlink, dir, newdentry);
@@ -336,9 +338,10 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
-	err = PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
+	if (IS_ERR(newdentry)) {
+		err = PTR_ERR(newdentry);
 		goto out_unlock;
+	}
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
@@ -394,9 +397,10 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 		goto out_unlock;
 
 	opaquedir = ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode));
-	err = PTR_ERR(opaquedir);
-	if (IS_ERR(opaquedir))
+	if (IS_ERR(opaquedir)) {
+		err = PTR_ERR(opaquedir);
 		goto out_unlock;
+	}
 
 	err = ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
 	if (err)
@@ -473,18 +477,21 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 
 	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
 				 dentry->d_name.len);
-	err = PTR_ERR(upper);
-	if (IS_ERR(upper))
+	if (IS_ERR(upper)) {
+		err = PTR_ERR(upper);
 		goto out_unlock;
+	}
 
-	err = -ESTALE;
-	if (d_is_negative(upper) || !IS_WHITEOUT(d_inode(upper)))
+	if (d_is_negative(upper) || !IS_WHITEOUT(d_inode(upper))) {
+		err = -ESTALE;
 		goto out_dput;
+	}
 
 	newdentry = ovl_create_temp(ofs, workdir, cattr);
-	err = PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
+	if (IS_ERR(newdentry)) {
+		err = PTR_ERR(newdentry);
 		goto out_dput;
+	}
 
 	/*
 	 * mode could have been mutilated due to umask (e.g. sgid directory)
@@ -577,10 +584,11 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	}
 
 	if (!attr->hardlink) {
-		err = -ENOMEM;
 		override_cred = prepare_creds();
-		if (!override_cred)
+		if (!override_cred) {
+			err = -ENOMEM;
 			goto out_revert_creds;
+		}
 		/*
 		 * In the creation cases(create, mkdir, mknod, symlink),
 		 * ovl should transfer current's fs{u,g}id to underlying
@@ -632,10 +640,11 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 		goto out;
 
 	/* Preallocate inode to be used by ovl_get_inode() */
-	err = -ENOMEM;
 	inode = ovl_new_inode(dentry->d_sb, mode, rdev);
-	if (!inode)
+	if (!inode) {
+		err = -ENOMEM;
 		goto out_drop_write;
+	}
 
 	spin_lock(&inode->i_lock);
 	inode->i_state |= I_CREATING;
@@ -759,9 +768,10 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 
 	if (!list_empty(list)) {
 		opaquedir = ovl_clear_empty(dentry, list);
-		err = PTR_ERR(opaquedir);
-		if (IS_ERR(opaquedir))
+		if (IS_ERR(opaquedir)) {
+			err = PTR_ERR(opaquedir);
 			goto out;
+		}
 	}
 
 	err = ovl_lock_rename_workdir(workdir, upperdir);
@@ -770,14 +780,15 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 
 	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
 				 dentry->d_name.len);
-	err = PTR_ERR(upper);
-	if (IS_ERR(upper))
+	if (IS_ERR(upper)) {
+		err = PTR_ERR(upper);
 		goto out_unlock;
+	}
 
-	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
 	    (!opaquedir && ovl_dentry_upper(dentry) &&
 	     !ovl_matches_upper(dentry, upper))) {
+		err = -ESTALE;
 		goto out_dput_upper;
 	}
 
@@ -810,22 +821,25 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 
 	if (!list_empty(list)) {
 		opaquedir = ovl_clear_empty(dentry, list);
-		err = PTR_ERR(opaquedir);
-		if (IS_ERR(opaquedir))
+		if (IS_ERR(opaquedir)) {
+			err = PTR_ERR(opaquedir);
 			goto out;
+		}
 	}
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
 				 dentry->d_name.len);
-	err = PTR_ERR(upper);
-	if (IS_ERR(upper))
+	if (IS_ERR(upper)) {
+		err = PTR_ERR(upper);
 		goto out_unlock;
+	}
 
-	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
-	    (!opaquedir && !ovl_matches_upper(dentry, upper)))
+	    (!opaquedir && !ovl_matches_upper(dentry, upper))) {
+		err = -ESTALE;
 		goto out_dput_upper;
+	}
 
 	if (is_dir)
 		err = ovl_do_rmdir(ofs, dir, upper);
@@ -1098,18 +1112,18 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	struct ovl_fs *ofs = OVL_FS(old->d_sb);
 	LIST_HEAD(list);
 
-	err = -EINVAL;
-	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
+	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE)) {
+		err = -EINVAL;
 		goto out;
+	}
 
 	flags &= ~RENAME_NOREPLACE;
 
 	/* Don't copy up directory trees */
-	err = -EXDEV;
-	if (!ovl_can_move(old))
-		goto out;
-	if (!overwrite && !ovl_can_move(new))
+	if (!ovl_can_move(old) || (!overwrite && !ovl_can_move(new))) {
+		err = -EXDEV;
 		goto out;
+	}
 
 	if (overwrite && new_is_dir && !ovl_pure_upper(new)) {
 		err = ovl_check_empty_dir(new, &list);
@@ -1159,8 +1173,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 
 	if (!list_empty(&list)) {
 		opaquedir = ovl_clear_empty(new, &list);
-		err = PTR_ERR(opaquedir);
 		if (IS_ERR(opaquedir)) {
+			err = PTR_ERR(opaquedir);
 			opaquedir = NULL;
 			goto out_revert_creds;
 		}
@@ -1192,19 +1206,22 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 
 	olddentry = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
 				     old->d_name.len);
-	err = PTR_ERR(olddentry);
-	if (IS_ERR(olddentry))
+	if (IS_ERR(olddentry)) {
+		err = PTR_ERR(olddentry);
 		goto out_unlock;
+	}
 
-	err = -ESTALE;
-	if (!ovl_matches_upper(old, olddentry))
+	if (!ovl_matches_upper(old, olddentry)) {
+		err = -ESTALE;
 		goto out_dput_old;
+	}
 
 	newdentry = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
 				     new->d_name.len);
-	err = PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
+	if (IS_ERR(newdentry)) {
+		err = PTR_ERR(newdentry);
 		goto out_dput_old;
+	}
 
 	old_opaque = ovl_dentry_is_opaque(old);
 	new_opaque = ovl_dentry_is_opaque(new);
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index defd4e231ad2..00183ebf8d28 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -379,10 +379,11 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	 * connected real path from the top.
 	 */
 	inode_lock_nested(dir, I_MUTEX_PARENT);
-	err = -ECHILD;
 	parent = dget_parent(real);
-	if (ovl_dentry_real_at(connected, layer->idx) != parent)
+	if (ovl_dentry_real_at(connected, layer->idx) != parent) {
+		err = -ECHILD;
 		goto fail;
+	}
 
 	/*
 	 * We also need to take a snapshot of real dentry name to protect us
@@ -716,9 +717,10 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 	if (!d_is_dir(origin.dentry) ||
 	    !(origin.dentry->d_flags & DCACHE_DISCONNECTED)) {
 		inode = ovl_lookup_inode(sb, origin.dentry, false);
-		err = PTR_ERR(inode);
-		if (IS_ERR(inode))
+		if (IS_ERR(inode)) {
+			err = PTR_ERR(inode);
 			goto out_err;
+		}
 		if (inode) {
 			dentry = d_find_any_alias(inode);
 			iput(inode);
@@ -730,8 +732,8 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 	/* Then lookup indexed upper/whiteout by origin fh */
 	if (ofs->indexdir) {
 		index = ovl_get_index_fh(ofs, fh);
-		err = PTR_ERR(index);
 		if (IS_ERR(index)) {
+			err = PTR_ERR(index);
 			index = NULL;
 			goto out_err;
 		}
@@ -741,9 +743,10 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 	if (index && d_is_dir(index)) {
 		struct dentry *upper = ovl_index_upper(ofs, index, true);
 
-		err = PTR_ERR(upper);
-		if (IS_ERR_OR_NULL(upper))
+		if (IS_ERR_OR_NULL(upper)) {
+			err = PTR_ERR(upper);
 			goto out_err;
+		}
 
 		dentry = ovl_get_dentry(sb, upper, NULL, NULL);
 		dput(upper);
@@ -810,9 +813,10 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	int err;
 
 	fh = ovl_fid_to_fh(fid, len, fh_type);
-	err = PTR_ERR(fh);
-	if (IS_ERR(fh))
+	if (IS_ERR(fh)) {
+		err = PTR_ERR(fh);
 		goto out_err;
+	}
 
 	err = ovl_check_fh_len(fh, len);
 	if (err)
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index cfb3420b7df0..665e9f19d8de 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -462,8 +462,8 @@ int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	int err;
 
 	fh = ovl_encode_real_fh(ofs, real, is_upper);
-	err = PTR_ERR(fh);
 	if (IS_ERR(fh)) {
+		err = PTR_ERR(fh);
 		fh = NULL;
 		goto fail;
 	}
@@ -533,19 +533,22 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
 	if (!d_inode(index))
 		return 0;
 
-	err = -EINVAL;
-	if (index->d_name.len < sizeof(struct ovl_fb)*2)
+	if (index->d_name.len < sizeof(struct ovl_fb)*2) {
+		err = -EINVAL;
 		goto fail;
+	}
 
-	err = -ENOMEM;
 	len = index->d_name.len / 2;
 	fh = kzalloc(len + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
-	if (!fh)
+	if (!fh) {
+		err = -ENOMEM;
 		goto fail;
+	}
 
-	err = -EINVAL;
-	if (hex2bin(fh->buf, index->d_name.name, len))
+	if (hex2bin(fh->buf, index->d_name.name, len)) {
+		err = -EINVAL;
 		goto fail;
+	}
 
 	err = ovl_check_fb_len(&fh->fb, len);
 	if (err)
@@ -905,11 +908,12 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	if (!d.stop && poe->numlower) {
-		err = -ENOMEM;
 		stack = kcalloc(ofs->numlayer - 1, sizeof(struct ovl_path),
 				GFP_KERNEL);
-		if (!stack)
+		if (!stack) {
+			err = -ENOMEM;
 			goto out_put_upper;
+		}
 	}
 
 	for (i = 0; !d.stop && i < poe->numlower; i++) {
@@ -994,10 +998,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		 * Only following redirects when redirects are enabled disables
 		 * this attack vector when not necessary.
 		 */
-		err = -EPERM;
 		if (d.redirect && !ofs->config.redirect_follow) {
 			pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n",
 					    dentry);
+			err = -EPERM;
 			goto out_put;
 		}
 
@@ -1068,9 +1072,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	oe = ovl_alloc_entry(ctr);
-	err = -ENOMEM;
-	if (!oe)
+	if (!oe) {
+		err = -ENOMEM;
 		goto out_put;
+	}
 
 	memcpy(oe->lowerstack, stack, sizeof(struct ovl_path) * ctr);
 	dentry->d_fsdata = oe;
@@ -1115,9 +1120,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		};
 
 		inode = ovl_get_inode(dentry->d_sb, &oip);
-		err = PTR_ERR(inode);
-		if (IS_ERR(inode))
+		if (IS_ERR(inode)) {
+			err = PTR_ERR(inode);
 			goto out_free_oe;
+		}
 		if (upperdentry && !uppermetacopy)
 			ovl_set_flag(OVL_UPPERDATA, inode);
 	}
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b6952b21a7ee..ad5363ac3a68 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -764,9 +764,10 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		struct ovl_dir_cache *cache;
 
 		cache = ovl_cache_get(dentry);
-		err = PTR_ERR(cache);
-		if (IS_ERR(cache))
+		if (IS_ERR(cache)) {
+			err = PTR_ERR(cache);
 			goto out;
+		}
 
 		od->cache = cache;
 		ovl_seek_cursor(od, ctx->pos);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f97ad8b40dbb..f683ff46edaf 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -801,9 +801,10 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto out_dput;
 
 		/* Weird filesystem returning with hashed negative (kernfs)? */
-		err = -EINVAL;
-		if (d_really_is_negative(work))
+		if (d_really_is_negative(work)) {
+			err = -EINVAL;
 			goto out_dput;
+		}
 
 		/*
 		 * Try to remove POSIX ACL xattrs from workdir.  We are good if:
@@ -1130,8 +1131,8 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 		goto out;
 
 	upper_mnt = clone_private_mount(upperpath);
-	err = PTR_ERR(upper_mnt);
 	if (IS_ERR(upper_mnt)) {
+		err = PTR_ERR(upper_mnt);
 		pr_err("failed to clone upperpath\n");
 		goto out;
 	}
@@ -1184,13 +1185,14 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
-	err = PTR_ERR(temp);
-	if (IS_ERR(temp))
+	if (IS_ERR(temp)) {
+		err = PTR_ERR(temp);
 		goto out_unlock;
+	}
 
 	dest = ovl_lookup_temp(ofs, workdir);
-	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
+		err = PTR_ERR(dest);
 		dput(temp);
 		goto out_unlock;
 	}
@@ -1205,9 +1207,10 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	}
 
 	whiteout = ovl_lookup_upper(ofs, name.name.name, workdir, name.name.len);
-	err = PTR_ERR(whiteout);
-	if (IS_ERR(whiteout))
+	if (IS_ERR(whiteout)) {
+		err = PTR_ERR(whiteout);
 		goto cleanup_temp;
+	}
 
 	err = ovl_is_whiteout(whiteout);
 
@@ -1284,9 +1287,10 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		return err;
 
 	workdir = ovl_workdir_create(ofs, OVL_WORKDIR_NAME, false);
-	err = PTR_ERR(workdir);
-	if (IS_ERR_OR_NULL(workdir))
+	if (IS_ERR_OR_NULL(workdir)) {
+		err = PTR_ERR(workdir);
 		goto out;
+	}
 
 	ofs->workdir = workdir;
 
@@ -1598,10 +1602,11 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	int err;
 	unsigned int i;
 
-	err = -ENOMEM;
 	ofs->fs = kcalloc(numlower + 1, sizeof(struct ovl_sb), GFP_KERNEL);
-	if (ofs->fs == NULL)
+	if (ofs->fs == NULL) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	/* idx/fsid 0 are reserved for upper fs even with lower only overlay */
 	ofs->numfs++;
@@ -1652,8 +1657,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		}
 
 		mnt = clone_private_mount(&stack[i]);
-		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
+			err = PTR_ERR(mnt);
 			pr_err("failed to clone lowerpath\n");
 			iput(trap);
 			goto out;
@@ -1729,7 +1734,6 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	if (!stack)
 		return ERR_PTR(-ENOMEM);
 
-	err = -EINVAL;
 	for (i = 0; i < numlower; i++) {
 		err = ovl_lower_dir(lower, &stack[i], ofs, &sb->s_stack_depth);
 		if (err)
@@ -1738,10 +1742,10 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		lower = strchr(lower, '\0') + 1;
 	}
 
-	err = -EINVAL;
 	sb->s_stack_depth++;
 	if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
 		pr_err("maximum fs stacking depth exceeded\n");
+		err = -EINVAL;
 		goto out_err;
 	}
 
@@ -1749,10 +1753,11 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	if (err)
 		goto out_err;
 
-	err = -ENOMEM;
 	oe = ovl_alloc_entry(numlower);
-	if (!oe)
+	if (!oe) {
+		err = -ENOMEM;
 		goto out_err;
+	}
 
 	for (i = 0; i < numlower; i++) {
 		oe->lowerstack[i].dentry = dget(stack[i].dentry);
@@ -1894,21 +1899,24 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	unsigned int numlower;
 	int err;
 
-	err = -EIO;
-	if (WARN_ON(sb->s_user_ns != current_user_ns()))
+	if (WARN_ON(sb->s_user_ns != current_user_ns())) {
+		err = -EIO;
 		goto out;
+	}
 
 	sb->s_d_op = &ovl_dentry_operations;
 
-	err = -ENOMEM;
 	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
-	if (!ofs)
+	if (!ofs) {
+		err = -ENOMEM;
 		goto out;
+	}
 
-	err = -ENOMEM;
 	ofs->creator_cred = cred = prepare_creds();
-	if (!cred)
+	if (!cred) {
+		err = -ENOMEM;
 		goto out_err;
+	}
 
 	/* Is there a reason anyone would want not to share whiteouts? */
 	ofs->share_whiteout = true;
@@ -1922,30 +1930,32 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto out_err;
 
-	err = -EINVAL;
 	if (!ofs->config.lowerdir) {
 		if (!silent)
 			pr_err("missing 'lowerdir'\n");
+		err = -EINVAL;
 		goto out_err;
 	}
 
-	err = -ENOMEM;
 	splitlower = kstrdup(ofs->config.lowerdir, GFP_KERNEL);
-	if (!splitlower)
+	if (!splitlower) {
+		err = -ENOMEM;
 		goto out_err;
+	}
 
-	err = -EINVAL;
 	numlower = ovl_split_lowerdirs(splitlower);
 	if (numlower > OVL_MAX_STACK) {
 		pr_err("too many lower directories, limit is %d\n",
 		       OVL_MAX_STACK);
+		err = -EINVAL;
 		goto out_err;
 	}
 
-	err = -ENOMEM;
 	layers = kcalloc(numlower + 1, sizeof(struct ovl_layer), GFP_KERNEL);
-	if (!layers)
+	if (!layers) {
+		err = -ENOMEM;
 		goto out_err;
+	}
 
 	ofs->layers = layers;
 	/* Layer 0 is reserved for upper even if there's no upper */
@@ -1969,9 +1979,9 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	if (ofs->config.upperdir) {
 		struct super_block *upper_sb;
 
-		err = -EINVAL;
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
+			err = -EINVAL;
 			goto out_err;
 		}
 
@@ -2000,9 +2010,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
-	err = PTR_ERR(oe);
-	if (IS_ERR(oe))
+	if (IS_ERR(oe)) {
+		err = PTR_ERR(oe);
 		goto out_err;
+	}
 
 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
 	if (!ovl_upper_mnt(ofs))
@@ -2054,10 +2065,11 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_flags |= SB_POSIXACL;
 	sb->s_iflags |= SB_I_SKIP_SYNC;
 
-	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
-	if (!root_dentry)
+	if (!root_dentry) {
+		err = -ENOMEM;
 		goto out_free_oe;
+	}
 
 	mntput(upperpath.mnt);
 	kfree(splitlower);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 923d66d131c1..4b9f09a274ae 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -851,8 +851,8 @@ static void ovl_cleanup_index(struct dentry *dentry)
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	index = ovl_lookup_upper(ofs, name.name, indexdir, name.len);
-	err = PTR_ERR(index);
 	if (IS_ERR(index)) {
+		err = PTR_ERR(index);
 		index = NULL;
 	} else if (ovl_index_all(dentry->d_sb)) {
 		/* Whiteout orphan index to block future open by handle */
-- 
2.27.0

