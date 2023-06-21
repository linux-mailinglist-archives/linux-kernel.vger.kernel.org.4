Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4E7387F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjFUOxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjFUOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13530D7;
        Wed, 21 Jun 2023 07:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FE8B615A2;
        Wed, 21 Jun 2023 14:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEBFC433C0;
        Wed, 21 Jun 2023 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358963;
        bh=j/gKc8SO+4X9/hfbQM/fEoyBcWp5HKq3m4pNjrKuEFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFUtyRRgG16CLUiWlHJn2d041S5iJKhOLRSpXXIJJGZBQ0mamVeVi2A1t0Ihnq4Yp
         a7pcZcjpYEDpgSY75qaU/hgozxQOHRHSDOYpwiq9rXPpx3QXJUKEz7d6Dxpna+rriT
         h2oAFOp6/PjdAZHy26Wea960Yfxa+0gHVaVyyi/qkfqLsmBU4GCn2P1/fXmnicDAWd
         YBbya+f6juc7CYF839ABApgexrVvSYG4slOYRFtxV2h9ybi/SMo3lAn6Z0osrzJ9NN
         5OnNllJ2PKwQJSVehywRkovsNOjcSD/loezxWxsVgIfkfZ4DMH/3byUQbi5lEsFkB7
         OSFrwMTCf2btw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 62/79] smb: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:15 -0400
Message-ID: <20230621144735.55953-61-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 fs/smb/client/file.c    |  4 ++--
 fs/smb/client/fscache.h |  5 +++--
 fs/smb/client/inode.c   | 15 +++++++--------
 fs/smb/client/smb2ops.c |  2 +-
 fs/smb/server/smb2pdu.c |  8 ++++----
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 0a5fe8d5314b..07fed94b7501 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1085,7 +1085,7 @@ int cifs_close(struct inode *inode, struct file *file)
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
-				inode->i_ctime = inode->i_mtime = current_time(inode);
+				inode->i_mtime = inode_ctime_set_current(inode);
 			}
 			spin_lock(&cinode->deferred_lock);
 			cifs_add_deferred_close(cfile, dclose);
@@ -2596,7 +2596,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 					   write_data, to - from, &offset);
 		cifsFileInfo_put(open_file);
 		/* Does mm or vfs already set times? */
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 		if ((bytes_written > 0) && (offset))
 			rc = 0;
 		else if (bytes_written < 0)
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 173999610997..1c50d286c3a4 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -50,12 +50,13 @@ void cifs_fscache_fill_coherency(struct inode *inode,
 				 struct cifs_fscache_inode_coherency_data *cd)
 {
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
+	struct timespec64 ctime = inode_ctime_peek(&cifsi->netfs.inode);
 
 	memset(cd, 0, sizeof(*cd));
 	cd->last_write_time_sec   = cpu_to_le64(cifsi->netfs.inode.i_mtime.tv_sec);
 	cd->last_write_time_nsec  = cpu_to_le32(cifsi->netfs.inode.i_mtime.tv_nsec);
-	cd->last_change_time_sec  = cpu_to_le64(cifsi->netfs.inode.i_ctime.tv_sec);
-	cd->last_change_time_nsec = cpu_to_le32(cifsi->netfs.inode.i_ctime.tv_nsec);
+	cd->last_change_time_sec  = cpu_to_le64(ctime.tv_sec);
+	cd->last_change_time_nsec = cpu_to_le32(ctime.tv_nsec);
 }
 
 
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 1087ac6104a9..d986b280b6c3 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -172,7 +172,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	else
 		inode->i_atime = fattr->cf_atime;
 	inode->i_mtime = fattr->cf_mtime;
-	inode->i_ctime = fattr->cf_ctime;
+	inode_ctime_set(inode, fattr->cf_ctime);
 	inode->i_rdev = fattr->cf_rdev;
 	cifs_nlink_fattr_to_inode(inode, fattr);
 	inode->i_uid = fattr->cf_uid;
@@ -1744,9 +1744,9 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 		cifs_inode = CIFS_I(inode);
 		cifs_inode->time = 0;	/* will force revalidate to get info
 					   when needed */
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 	}
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 	cifs_inode = CIFS_I(dir);
 	CIFS_I(dir)->time = 0;	/* force revalidate of dir as well */
 unlink_out:
@@ -2060,8 +2060,8 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 	 */
 	cifsInode->time = 0;
 
-	d_inode(direntry)->i_ctime = inode->i_ctime = inode->i_mtime =
-		current_time(inode);
+	inode->i_mtime = inode_ctime_set_current(inode);
+	inode_ctime_set(d_inode(direntry), inode->i_mtime);
 
 rmdir_exit:
 	free_dentry_path(page);
@@ -2267,9 +2267,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode *source_dir,
 	/* force revalidate to go get info when needed */
 	CIFS_I(source_dir)->time = CIFS_I(target_dir)->time = 0;
 
-	source_dir->i_ctime = source_dir->i_mtime = target_dir->i_ctime =
-		target_dir->i_mtime = current_time(source_dir);
-
+	source_dir->i_mtime = inode_ctime_set_current(source_dir);
+	target_dir->i_mtime = inode_ctime_set_current(target_dir);
 cifs_rename_exit:
 	kfree(info_buf_source);
 	free_dentry_path(page2);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 5639d8c48570..52564a5dd2b1 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1391,7 +1391,7 @@ smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
 	if (file_inf.LastWriteTime)
 		inode->i_mtime = cifs_NTtimeToUnix(file_inf.LastWriteTime);
 	if (file_inf.ChangeTime)
-		inode->i_ctime = cifs_NTtimeToUnix(file_inf.ChangeTime);
+		inode_ctime_set(inode, cifs_NTtimeToUnix(file_inf.ChangeTime));
 	if (file_inf.LastAccessTime)
 		inode->i_atime = cifs_NTtimeToUnix(file_inf.LastAccessTime);
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index d31926194ebf..7a741ab6835c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4768,7 +4768,7 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	file_info->LastAccessTime = cpu_to_le64(time);
 	time = ksmbd_UnixTimeToNT(inode->i_mtime);
 	file_info->LastWriteTime = cpu_to_le64(time);
-	time = ksmbd_UnixTimeToNT(inode->i_ctime);
+	time = ksmbd_UnixTimeToNT(inode_ctime_peek(inode));
 	file_info->ChangeTime = cpu_to_le64(time);
 	file_info->DosAttributes = fp->f_ci->m_fattr;
 	file_info->Inode = cpu_to_le64(inode->i_ino);
@@ -5409,7 +5409,7 @@ int smb2_close(struct ksmbd_work *work)
 		rsp->LastAccessTime = cpu_to_le64(time);
 		time = ksmbd_UnixTimeToNT(inode->i_mtime);
 		rsp->LastWriteTime = cpu_to_le64(time);
-		time = ksmbd_UnixTimeToNT(inode->i_ctime);
+		time = ksmbd_UnixTimeToNT(inode_ctime_peek(inode));
 		rsp->ChangeTime = cpu_to_le64(time);
 		ksmbd_fd_put(work, fp);
 	} else {
@@ -5628,7 +5628,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 	if (file_info->ChangeTime)
 		attrs.ia_ctime = ksmbd_NTtimeToUnix(file_info->ChangeTime);
 	else
-		attrs.ia_ctime = inode->i_ctime;
+		attrs.ia_ctime = inode_ctime_peek(inode);
 
 	if (file_info->LastWriteTime) {
 		attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
@@ -5673,7 +5673,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 			return -EACCES;
 
 		inode_lock(inode);
-		inode->i_ctime = attrs.ia_ctime;
+		inode_ctime_set(inode, attrs.ia_ctime);
 		attrs.ia_valid &= ~ATTR_CTIME;
 		rc = notify_change(idmap, dentry, &attrs, NULL);
 		inode_unlock(inode);
-- 
2.41.0

