Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF736F9088
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjEFIVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjEFIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:21:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B1511D90;
        Sat,  6 May 2023 01:21:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaea43def7so17809455ad.2;
        Sat, 06 May 2023 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683361287; x=1685953287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4CXvuhOByJMsfFhYlhQ2OXyomMugIHCYBIe2PLk5tMs=;
        b=SM4bGX5lCbTUoZktmW85hWpA4ReJAkgUmjbIE+ovEoGsZbiG2pxF21XMlkC08+2yXF
         Vj2Bq0LUtNZVgjIBvgvhvmYYr/DKIcBNlLEeO9HEsBlFqvDFNqsg0HaagStAJv5CFc4p
         hkXr73Ne/DQ4PJbVFcZ6BmKcDF4EgdADI9HUxnoHVumkLTMpDeSd3Tq9cEpOH1IvTnJI
         Ztc6uqsxE98+wiFLUD1CVApvZhK1JfDhkSHdt+RzaMcqxpTrDvQUJB6sOGJrW8kLerXw
         RgFnTTnx8m93jaqWZ8wdl91ypkjv+fcwe4C8GsPw9aeUlshHbXMwaRFt8NkpbnjK7ocs
         LKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683361287; x=1685953287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CXvuhOByJMsfFhYlhQ2OXyomMugIHCYBIe2PLk5tMs=;
        b=mCAWDAb2Uwx43PKa5242I7AOb5SnJ3zGbUqav9iUJ0V3HUHVxwrBpXa/x1+qGNr8ai
         ewOycRPMwSj2RxpA9tF6UJXpKgq8XYtj2N87zQ8F0mdA3tqRZ4Te5lhgRvS+VEBrY9b1
         L6GElieYN+3LadKxQKu47gCHSSk4dNcpk++Z2ltkw5BjjYCDx7Vq31QS3vsXqa83mYUm
         8qu05dh64IMoh+V5Vos0Z92aFifr0RMmWfI6EWzDdUUZ5WpNtZ1CuIOMkgfmIvuw5RNA
         4LfLkw53j2G9JIxr4+d3yShm1/bQoDewu1NgH9PYHuIE4gipNJ2xPeXDrrCLbYndtvat
         RqiA==
X-Gm-Message-State: AC+VfDwYFhRL/RC4nvbFoYwHxSFu/Dk68DFAtEB56Gr6wZIEHEkwFf2f
        SfVnvgjL9QHo3AAPwThbsuU=
X-Google-Smtp-Source: ACHHUZ6qo/9geOCJRQpEwA4pRAIlqHFTB69okLuLoInBWVhnwLVG2BHR14546QicA2EfOoJxRzn45A==
X-Received: by 2002:a17:902:ceca:b0:1a6:5fa2:3293 with SMTP id d10-20020a170902ceca00b001a65fa23293mr4208194plg.56.1683361286633;
        Sat, 06 May 2023 01:21:26 -0700 (PDT)
Received: from localhost.localdomain ([47.98.195.232])
        by smtp.gmail.com with ESMTPSA id ie14-20020a17090b400e00b0024e1172c1d3sm9372501pjb.32.2023.05.06.01.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 01:21:26 -0700 (PDT)
From:   wenjun93 <gwj0511@gmail.com>
X-Google-Original-From: wenjun93 <gwj1235@yeah.net>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwj1235@yeah.net
Subject: [PATCH] overlayfs: clean error handling
Date:   Sat,  6 May 2023 16:21:11 +0800
Message-Id: <20230506082111.1655980-1-gwj1235@yeah.net>
X-Mailer: git-send-email 2.27.0
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

Signed-off-by: wenjun93 <gwj1235@yeah.net>
---
 fs/overlayfs/copy_up.c |  8 ++++----
 fs/overlayfs/dir.c     | 46 ++++++++++++++++++++----------------------
 fs/overlayfs/export.c  | 10 ++++-----
 fs/overlayfs/namei.c   | 16 +++++++--------
 fs/overlayfs/readdir.c |  2 +-
 fs/overlayfs/super.c   | 41 ++++++++++++++++++-------------------
 fs/overlayfs/util.c    |  2 +-
 7 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index f658cc8ea492..1e243b7082df 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -507,8 +507,8 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 		return err;
 
 	temp = ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
-	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
+		err = PTR_ERR(temp);
 		goto free_name;
 
 	err = ovl_set_upper_fh(ofs, upper, temp);
@@ -705,8 +705,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	};
 
 	/* workdir and destdir could be the same when copying up to indexdir */
-	err = -EIO;
 	if (lock_rename(c->workdir, c->destdir) != NULL)
+		err = -EIO;
 		goto unlock;
 
 	err = ovl_prep_cu_creds(c->dentry, &cc);
@@ -716,8 +716,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	temp = ovl_create_temp(ofs, c->workdir, &cattr);
 	ovl_revert_cu_creds(&cc);
 
-	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
+		err = PTR_ERR(temp);
 		goto unlock;
 
 	/*
@@ -741,8 +741,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	upper = ovl_lookup_upper(ofs, c->destname.name, c->destdir,
 				 c->destname.len);
-	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
+		err = PTR_ERR(upper);
 		goto cleanup;
 
 	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fc25fb95d5fc..6c5fedc9ec89 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -115,8 +115,8 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 	int flags = 0;
 
 	whiteout = ovl_whiteout(ofs);
-	err = PTR_ERR(whiteout);
 	if (IS_ERR(whiteout))
+		err = PTR_ERR(whiteout);
 		return err;
 
 	if (d_is_dir(dentry))
@@ -176,8 +176,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 	if (IS_ERR(newdentry))
 		return newdentry;
 
-	err = -ESTALE;
 	if (newdentry->d_inode)
+		err = -ESTALE;
 		goto out;
 
 	if (attr->hardlink) {
@@ -336,8 +336,8 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
 						     upperdir, dentry->d_name.len),
 				    attr);
-	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
+		err = PTR_ERR(newdentry);
 		goto out_unlock;
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
@@ -394,8 +394,8 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 		goto out_unlock;
 
 	opaquedir = ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode));
-	err = PTR_ERR(opaquedir);
 	if (IS_ERR(opaquedir))
+		err = PTR_ERR(opaquedir);
 		goto out_unlock;
 
 	err = ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
@@ -473,17 +473,17 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 
 	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
 				 dentry->d_name.len);
-	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
+		err = PTR_ERR(upper);
 		goto out_unlock;
 
-	err = -ESTALE;
 	if (d_is_negative(upper) || !IS_WHITEOUT(d_inode(upper)))
+		err = -ESTALE;
 		goto out_dput;
 
 	newdentry = ovl_create_temp(ofs, workdir, cattr);
-	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
+		err = PTR_ERR(newdentry);
 		goto out_dput;
 
 	/*
@@ -577,9 +577,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	}
 
 	if (!attr->hardlink) {
-		err = -ENOMEM;
 		override_cred = prepare_creds();
 		if (!override_cred)
+			err = -ENOMEM;
 			goto out_revert_creds;
 		/*
 		 * In the creation cases(create, mkdir, mknod, symlink),
@@ -632,9 +632,9 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 		goto out;
 
 	/* Preallocate inode to be used by ovl_get_inode() */
-	err = -ENOMEM;
 	inode = ovl_new_inode(dentry->d_sb, mode, rdev);
 	if (!inode)
+		err = -ENOMEM;
 		goto out_drop_write;
 
 	spin_lock(&inode->i_lock);
@@ -759,8 +759,8 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 
 	if (!list_empty(list)) {
 		opaquedir = ovl_clear_empty(dentry, list);
-		err = PTR_ERR(opaquedir);
 		if (IS_ERR(opaquedir))
+			err = PTR_ERR(opaquedir);
 			goto out;
 	}
 
@@ -770,14 +770,14 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 
 	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
 				 dentry->d_name.len);
-	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
+		err = PTR_ERR(upper);
 		goto out_unlock;
 
-	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
 	    (!opaquedir && ovl_dentry_upper(dentry) &&
 	     !ovl_matches_upper(dentry, upper))) {
+		err = -ESTALE;
 		goto out_dput_upper;
 	}
 
@@ -810,21 +810,21 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 
 	if (!list_empty(list)) {
 		opaquedir = ovl_clear_empty(dentry, list);
-		err = PTR_ERR(opaquedir);
 		if (IS_ERR(opaquedir))
+			err = PTR_ERR(opaquedir);
 			goto out;
 	}
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
 				 dentry->d_name.len);
-	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
+		err = PTR_ERR(upper);
 		goto out_unlock;
 
-	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
 	    (!opaquedir && !ovl_matches_upper(dentry, upper)))
+		err = -ESTALE;
 		goto out_dput_upper;
 
 	if (is_dir)
@@ -1098,17 +1098,15 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	struct ovl_fs *ofs = OVL_FS(old->d_sb);
 	LIST_HEAD(list);
 
-	err = -EINVAL;
 	if (flags & ~(RENAME_EXCHANGE | RENAME_NOREPLACE))
+		err = -EINVAL;
 		goto out;
 
 	flags &= ~RENAME_NOREPLACE;
 
 	/* Don't copy up directory trees */
-	err = -EXDEV;
-	if (!ovl_can_move(old))
-		goto out;
-	if (!overwrite && !ovl_can_move(new))
+	if (!ovl_can_move(old) || (!overwrite && !ovl_can_move(new)))
+		err = -EXDEV;
 		goto out;
 
 	if (overwrite && new_is_dir && !ovl_pure_upper(new)) {
@@ -1159,8 +1157,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 
 	if (!list_empty(&list)) {
 		opaquedir = ovl_clear_empty(new, &list);
-		err = PTR_ERR(opaquedir);
 		if (IS_ERR(opaquedir)) {
+			err = PTR_ERR(opaquedir);
 			opaquedir = NULL;
 			goto out_revert_creds;
 		}
@@ -1192,18 +1190,18 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 
 	olddentry = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
 				     old->d_name.len);
-	err = PTR_ERR(olddentry);
 	if (IS_ERR(olddentry))
+		err = PTR_ERR(olddentry);
 		goto out_unlock;
 
-	err = -ESTALE;
 	if (!ovl_matches_upper(old, olddentry))
+		err = -ESTALE;
 		goto out_dput_old;
 
 	newdentry = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
 				     new->d_name.len);
-	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
+		err = PTR_ERR(newdentry);
 		goto out_dput_old;
 
 	old_opaque = ovl_dentry_is_opaque(old);
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index defd4e231ad2..a9a4c0e4a772 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -379,9 +379,9 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	 * connected real path from the top.
 	 */
 	inode_lock_nested(dir, I_MUTEX_PARENT);
-	err = -ECHILD;
 	parent = dget_parent(real);
 	if (ovl_dentry_real_at(connected, layer->idx) != parent)
+		err = -ECHILD;
 		goto fail;
 
 	/*
@@ -716,8 +716,8 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 	if (!d_is_dir(origin.dentry) ||
 	    !(origin.dentry->d_flags & DCACHE_DISCONNECTED)) {
 		inode = ovl_lookup_inode(sb, origin.dentry, false);
-		err = PTR_ERR(inode);
 		if (IS_ERR(inode))
+			err = PTR_ERR(inode);
 			goto out_err;
 		if (inode) {
 			dentry = d_find_any_alias(inode);
@@ -730,8 +730,8 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 	/* Then lookup indexed upper/whiteout by origin fh */
 	if (ofs->indexdir) {
 		index = ovl_get_index_fh(ofs, fh);
-		err = PTR_ERR(index);
 		if (IS_ERR(index)) {
+			err = PTR_ERR(index);
 			index = NULL;
 			goto out_err;
 		}
@@ -741,8 +741,8 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 	if (index && d_is_dir(index)) {
 		struct dentry *upper = ovl_index_upper(ofs, index, true);
 
-		err = PTR_ERR(upper);
 		if (IS_ERR_OR_NULL(upper))
+			err = PTR_ERR(upper);
 			goto out_err;
 
 		dentry = ovl_get_dentry(sb, upper, NULL, NULL);
@@ -810,8 +810,8 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	int err;
 
 	fh = ovl_fid_to_fh(fid, len, fh_type);
-	err = PTR_ERR(fh);
 	if (IS_ERR(fh))
+		err = PTR_ERR(fh);
 		goto out_err;
 
 	err = ovl_check_fh_len(fh, len);
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index cfb3420b7df0..c74625a4bec5 100644
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
@@ -533,18 +533,18 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
 	if (!d_inode(index))
 		return 0;
 
-	err = -EINVAL;
 	if (index->d_name.len < sizeof(struct ovl_fb)*2)
+		err = -EINVAL;
 		goto fail;
 
-	err = -ENOMEM;
 	len = index->d_name.len / 2;
 	fh = kzalloc(len + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
 	if (!fh)
+		err = -ENOMEM;
 		goto fail;
 
-	err = -EINVAL;
 	if (hex2bin(fh->buf, index->d_name.name, len))
+		err = -EINVAL;
 		goto fail;
 
 	err = ovl_check_fb_len(&fh->fb, len);
@@ -905,10 +905,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	if (!d.stop && poe->numlower) {
-		err = -ENOMEM;
 		stack = kcalloc(ofs->numlayer - 1, sizeof(struct ovl_path),
 				GFP_KERNEL);
 		if (!stack)
+			err = -ENOMEM;
 			goto out_put_upper;
 	}
 
@@ -994,10 +994,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
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
 
@@ -1068,8 +1068,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	oe = ovl_alloc_entry(ctr);
-	err = -ENOMEM;
 	if (!oe)
+		err = -ENOMEM;
 		goto out_put;
 
 	memcpy(oe->lowerstack, stack, sizeof(struct ovl_path) * ctr);
@@ -1115,8 +1115,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		};
 
 		inode = ovl_get_inode(dentry->d_sb, &oip);
-		err = PTR_ERR(inode);
 		if (IS_ERR(inode))
+			err = PTR_ERR(inode);
 			goto out_free_oe;
 		if (upperdentry && !uppermetacopy)
 			ovl_set_flag(OVL_UPPERDATA, inode);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b6952b21a7ee..5da31635a597 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -764,8 +764,8 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		struct ovl_dir_cache *cache;
 
 		cache = ovl_cache_get(dentry);
-		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
+			err = PTR_ERR(cache);
 			goto out;
 
 		od->cache = cache;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f97ad8b40dbb..268d2ca232a0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -801,8 +801,8 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto out_dput;
 
 		/* Weird filesystem returning with hashed negative (kernfs)? */
-		err = -EINVAL;
 		if (d_really_is_negative(work))
+			err = -EINVAL;
 			goto out_dput;
 
 		/*
@@ -1130,8 +1130,8 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 		goto out;
 
 	upper_mnt = clone_private_mount(upperpath);
-	err = PTR_ERR(upper_mnt);
 	if (IS_ERR(upper_mnt)) {
+		err = PTR_ERR(upper_mnt);
 		pr_err("failed to clone upperpath\n");
 		goto out;
 	}
@@ -1184,13 +1184,13 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 
 	temp = ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
-	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
+		err = PTR_ERR(temp);
 		goto out_unlock;
 
 	dest = ovl_lookup_temp(ofs, workdir);
-	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
+		err = PTR_ERR(dest);
 		dput(temp);
 		goto out_unlock;
 	}
@@ -1205,8 +1205,8 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	}
 
 	whiteout = ovl_lookup_upper(ofs, name.name.name, workdir, name.name.len);
-	err = PTR_ERR(whiteout);
 	if (IS_ERR(whiteout))
+		err = PTR_ERR(whiteout);
 		goto cleanup_temp;
 
 	err = ovl_is_whiteout(whiteout);
@@ -1284,8 +1284,8 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		return err;
 
 	workdir = ovl_workdir_create(ofs, OVL_WORKDIR_NAME, false);
-	err = PTR_ERR(workdir);
 	if (IS_ERR_OR_NULL(workdir))
+		err = PTR_ERR(workdir);
 		goto out;
 
 	ofs->workdir = workdir;
@@ -1598,9 +1598,9 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 	int err;
 	unsigned int i;
 
-	err = -ENOMEM;
 	ofs->fs = kcalloc(numlower + 1, sizeof(struct ovl_sb), GFP_KERNEL);
 	if (ofs->fs == NULL)
+		err = -ENOMEM;
 		goto out;
 
 	/* idx/fsid 0 are reserved for upper fs even with lower only overlay */
@@ -1652,8 +1652,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		}
 
 		mnt = clone_private_mount(&stack[i]);
-		err = PTR_ERR(mnt);
 		if (IS_ERR(mnt)) {
+			err = PTR_ERR(mnt);
 			pr_err("failed to clone lowerpath\n");
 			iput(trap);
 			goto out;
@@ -1729,7 +1729,6 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	if (!stack)
 		return ERR_PTR(-ENOMEM);
 
-	err = -EINVAL;
 	for (i = 0; i < numlower; i++) {
 		err = ovl_lower_dir(lower, &stack[i], ofs, &sb->s_stack_depth);
 		if (err)
@@ -1738,10 +1737,10 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 		lower = strchr(lower, '\0') + 1;
 	}
 
-	err = -EINVAL;
 	sb->s_stack_depth++;
 	if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
 		pr_err("maximum fs stacking depth exceeded\n");
+		err = -EINVAL;
 		goto out_err;
 	}
 
@@ -1749,9 +1748,9 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
 	if (err)
 		goto out_err;
 
-	err = -ENOMEM;
 	oe = ovl_alloc_entry(numlower);
 	if (!oe)
+		err = -ENOMEM;
 		goto out_err;
 
 	for (i = 0; i < numlower; i++) {
@@ -1894,20 +1893,20 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	unsigned int numlower;
 	int err;
 
-	err = -EIO;
 	if (WARN_ON(sb->s_user_ns != current_user_ns()))
+		err = -EIO;
 		goto out;
 
 	sb->s_d_op = &ovl_dentry_operations;
 
-	err = -ENOMEM;
 	ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
 	if (!ofs)
+		err = -ENOMEM;
 		goto out;
 
-	err = -ENOMEM;
 	ofs->creator_cred = cred = prepare_creds();
 	if (!cred)
+		err = -ENOMEM;
 		goto out_err;
 
 	/* Is there a reason anyone would want not to share whiteouts? */
@@ -1922,29 +1921,29 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
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
 	if (!splitlower)
+		err = -ENOMEM;
 		goto out_err;
 
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
 	if (!layers)
+		err = -ENOMEM;
 		goto out_err;
 
 	ofs->layers = layers;
@@ -1969,9 +1968,9 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	if (ofs->config.upperdir) {
 		struct super_block *upper_sb;
 
-		err = -EINVAL;
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
+			err = -EINVAL;
 			goto out_err;
 		}
 
@@ -2000,8 +1999,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
-	err = PTR_ERR(oe);
 	if (IS_ERR(oe))
+		err = PTR_ERR(oe);
 		goto out_err;
 
 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
@@ -2054,9 +2053,9 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_flags |= SB_POSIXACL;
 	sb->s_iflags |= SB_I_SKIP_SYNC;
 
-	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
 	if (!root_dentry)
+		err = -ENOMEM;
 		goto out_free_oe;
 
 	mntput(upperpath.mnt);
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

