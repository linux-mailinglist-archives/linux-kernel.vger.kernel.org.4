Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3959E7387DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjFUOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFUOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C021BEC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5D4A6157B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D30C433C0;
        Wed, 21 Jun 2023 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358926;
        bh=Twhymvij7GMEOcAsaX36D+IkSGE4MqrBW94lrQP4NQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFTPXVd44hNS4f3FJSjgQd++7tIfGJmG7i+80p4uyFKReYWLxFWQ76WLjhn4RErn0
         iqtt1+P+gz2rNFpONT9jue1IeNA/Wp0P1d3/IQirTMf6WqYPASJBonEzVqXXEVKLhA
         XWV790ovj8nS6KDlRefHRki1WSUFsIKm6UUl1zQF20gYoSpK+NH23ygDWZPdywzBfe
         2OvsQayjVMkrgKHhvYQXg7vZrKZbML4325biEnin8Zt52K/2whyEbIlSmxGT+ZlCL7
         ttq5/eiWyJY1qecg+Rxhu5kMosxS0qmLWEBkUoPp7z5bkmRUyw59zSR8F0mWLwB92/
         I77YvLWhAN7OA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 41/79] jffs2: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:54 -0400
Message-ID: <20230621144735.55953-40-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/dir.c      | 19 ++++++++++---------
 fs/jffs2/file.c     |  3 ++-
 fs/jffs2/fs.c       | 10 +++++-----
 fs/jffs2/os-linux.h |  2 +-
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 5075a0a6d594..2ade386a2c02 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -204,7 +204,7 @@ static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
 	if (ret)
 		goto fail;
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(ri->ctime));
+	dir_i->i_mtime = inode_ctime_set(dir_i, ITIME(je32_to_cpu(ri->ctime)));
 
 	jffs2_free_raw_inode(ri);
 
@@ -237,7 +237,7 @@ static int jffs2_unlink(struct inode *dir_i, struct dentry *dentry)
 	if (dead_f->inocache)
 		set_nlink(d_inode(dentry), dead_f->inocache->pino_nlink);
 	if (!ret)
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = inode_ctime_set(dir_i, ITIME(now));
 	return ret;
 }
 /***********************************************************************/
@@ -271,7 +271,7 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 		set_nlink(d_inode(old_dentry), ++f->inocache->pino_nlink);
 		mutex_unlock(&f->sem);
 		d_instantiate(dentry, d_inode(old_dentry));
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = inode_ctime_set(dir_i, ITIME(now));
 		ihold(d_inode(old_dentry));
 	}
 	return ret;
@@ -422,7 +422,7 @@ static int jffs2_symlink (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = inode_ctime_set(dir_i, ITIME(je32_to_cpu(rd->mctime)));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -566,7 +566,7 @@ static int jffs2_mkdir (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = inode_ctime_set(dir_i, ITIME(je32_to_cpu(rd->mctime)));
 	inc_nlink(dir_i);
 
 	jffs2_free_raw_dirent(rd);
@@ -607,7 +607,7 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	ret = jffs2_do_unlink(c, dir_f, dentry->d_name.name,
 			      dentry->d_name.len, f, now);
 	if (!ret) {
-		dir_i->i_mtime = dir_i->i_ctime = ITIME(now);
+		dir_i->i_mtime = inode_ctime_set(dir_i, ITIME(now));
 		clear_nlink(d_inode(dentry));
 		drop_nlink(dir_i);
 	}
@@ -743,7 +743,7 @@ static int jffs2_mknod (struct mnt_idmap *idmap, struct inode *dir_i,
 		goto fail;
 	}
 
-	dir_i->i_mtime = dir_i->i_ctime = ITIME(je32_to_cpu(rd->mctime));
+	dir_i->i_mtime = inode_ctime_set(dir_i, ITIME(je32_to_cpu(rd->mctime)));
 
 	jffs2_free_raw_dirent(rd);
 
@@ -864,14 +864,15 @@ static int jffs2_rename (struct mnt_idmap *idmap,
 		 * caller won't do it on its own since we are returning an error.
 		 */
 		d_invalidate(new_dentry);
-		new_dir_i->i_mtime = new_dir_i->i_ctime = ITIME(now);
+		new_dir_i->i_mtime = inode_ctime_set(new_dir_i, ITIME(now));
 		return ret;
 	}
 
 	if (d_is_dir(old_dentry))
 		drop_nlink(old_dir_i);
 
-	new_dir_i->i_mtime = new_dir_i->i_ctime = old_dir_i->i_mtime = old_dir_i->i_ctime = ITIME(now);
+	new_dir_i->i_mtime = inode_ctime_set(new_dir_i, ITIME(now));
+	old_dir_i->i_mtime = inode_ctime_set(old_dir_i, ITIME(now));
 
 	return 0;
 }
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 2345ca3f09ee..1935e4eb9aa8 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -317,7 +317,8 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 			inode->i_size = pos + writtenlen;
 			inode->i_blocks = (inode->i_size + 511) >> 9;
 
-			inode->i_ctime = inode->i_mtime = ITIME(je32_to_cpu(ri->ctime));
+			inode->i_mtime = ITIME(je32_to_cpu(ri->ctime));
+			inode_ctime_set(inode, inode->i_mtime);
 		}
 	}
 
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 038516bee1ab..1d77c4616ca5 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -115,7 +115,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	ri->isize = cpu_to_je32((ivalid & ATTR_SIZE)?iattr->ia_size:inode->i_size);
 	ri->atime = cpu_to_je32(I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode->i_atime));
 	ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
-	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode->i_ctime));
+	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode_ctime_peek(inode)));
 
 	ri->offset = cpu_to_je32(0);
 	ri->csize = ri->dsize = cpu_to_je32(mdatalen);
@@ -148,7 +148,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	}
 	/* It worked. Update the inode */
 	inode->i_atime = ITIME(je32_to_cpu(ri->atime));
-	inode->i_ctime = ITIME(je32_to_cpu(ri->ctime));
+	inode_ctime_set(inode, ITIME(je32_to_cpu(ri->ctime)));
 	inode->i_mtime = ITIME(je32_to_cpu(ri->mtime));
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_uid_write(inode, je16_to_cpu(ri->uid));
@@ -284,7 +284,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 	inode->i_size = je32_to_cpu(latest_node.isize);
 	inode->i_atime = ITIME(je32_to_cpu(latest_node.atime));
 	inode->i_mtime = ITIME(je32_to_cpu(latest_node.mtime));
-	inode->i_ctime = ITIME(je32_to_cpu(latest_node.ctime));
+	inode_ctime_set(inode, ITIME(je32_to_cpu(latest_node.ctime)));
 
 	set_nlink(inode, f->inocache->pino_nlink);
 
@@ -388,7 +388,7 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 	iattr.ia_gid = inode->i_gid;
 	iattr.ia_atime = inode->i_atime;
 	iattr.ia_mtime = inode->i_mtime;
-	iattr.ia_ctime = inode->i_ctime;
+	iattr.ia_ctime = inode_ctime_peek(inode);
 
 	jffs2_do_setattr(inode, &iattr);
 }
@@ -475,7 +475,7 @@ struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_r
 	inode->i_mode = jemode_to_cpu(ri->mode);
 	i_gid_write(inode, je16_to_cpu(ri->gid));
 	i_uid_write(inode, je16_to_cpu(ri->uid));
-	inode->i_atime = inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	ri->atime = ri->mtime = ri->ctime = cpu_to_je32(I_SEC(inode->i_mtime));
 
 	inode->i_blocks = 0;
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 8da19766c101..2c22fdd4762e 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -35,7 +35,7 @@ struct kvec;
 #define ITIME(sec) ((struct timespec64){sec, 0})
 #define JFFS2_NOW() JFFS2_CLAMP_TIME(ktime_get_real_seconds())
 #define I_SEC(tv) JFFS2_CLAMP_TIME((tv).tv_sec)
-#define JFFS2_F_I_CTIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_ctime)
+#define JFFS2_F_I_CTIME(f) I_SEC(inode_ctime_peek(OFNI_EDONI_2SFFJ(f)))
 #define JFFS2_F_I_MTIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_mtime)
 #define JFFS2_F_I_ATIME(f) I_SEC(OFNI_EDONI_2SFFJ(f)->i_atime)
 #define sleep_on_spinunlock(wq, s)				\
-- 
2.41.0

