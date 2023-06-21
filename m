Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45937387BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjFUOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjFUOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685CB210A;
        Wed, 21 Jun 2023 07:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D266612B7;
        Wed, 21 Jun 2023 14:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5C6C433C0;
        Wed, 21 Jun 2023 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358884;
        bh=602OBQOYZOHE47XEi3Ae1spcJ/o1W14lJ8xXHeSF938=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVIbTn//g7DjaISL0EEFbO0GPceKZ06PB4n+WjFMQZoc/RDOfDFZhVSb083ga5R/M
         4dSqFVfWuqNbYsjGSK7MRWKLtXOFsasXs8J+tDJuYrBNEyfEdRH2BDSvbHQTkIuGGn
         CEzsdrjqjUUw1endMJGRyaed31xVhYykwNdgGsw63ReLPFutJR0hDlpAO58bF6dqLO
         mbhH2Qnf1mRMVCkO4k2zCuEf3SK5L0DBLSHzKFOxCpMXS5PoJkz8gAly19GGdhO8KF
         UwQYcCEIeU9eAsLA/SNsX2lJLL4lLrODvwDMtTK7uY41Okagt6xQ0+kTJc4vL7KxzG
         TSQHJDh1niDqg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/79] ceph: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:45:30 -0400
Message-ID: <20230621144735.55953-16-jlayton@kernel.org>
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
 fs/ceph/acl.c   |  2 +-
 fs/ceph/caps.c  |  2 +-
 fs/ceph/inode.c | 17 ++++++++++-------
 fs/ceph/snap.c  |  2 +-
 fs/ceph/xattr.c |  2 +-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 6945a938d396..a3de2b9c3a68 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -93,7 +93,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	char *value = NULL;
 	struct iattr newattrs;
 	struct inode *inode = d_inode(dentry);
-	struct timespec64 old_ctime = inode->i_ctime;
+	struct timespec64 old_ctime = inode_ctime_peek(inode);
 	umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP) {
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 2321e5ddb664..c144a07e334e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1400,7 +1400,7 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 
 	arg->mtime = inode->i_mtime;
 	arg->atime = inode->i_atime;
-	arg->ctime = inode->i_ctime;
+	arg->ctime = inode_ctime_peek(inode);
 	arg->btime = ci->i_btime;
 	arg->change_attr = inode_peek_iversion_raw(inode);
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8e5f41d45283..f0b3b11d695e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -100,7 +100,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 	inode->i_uid = parent->i_uid;
 	inode->i_gid = parent->i_gid;
 	inode->i_mtime = parent->i_mtime;
-	inode->i_ctime = parent->i_ctime;
+	inode_ctime_set(inode, inode_ctime_peek(parent));
 	inode->i_atime = parent->i_atime;
 	ci->i_rbytes = 0;
 	ci->i_btime = ceph_inode(parent)->i_btime;
@@ -695,12 +695,14 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		      CEPH_CAP_FILE_BUFFER|
 		      CEPH_CAP_AUTH_EXCL|
 		      CEPH_CAP_XATTR_EXCL)) {
+		struct timespec64 ictime = inode_ctime_peek(inode);
+
 		if (ci->i_version == 0 ||
-		    timespec64_compare(ctime, &inode->i_ctime) > 0) {
+		    timespec64_compare(ctime, &ictime) > 0) {
 			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
-			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+			     ictime.tv_sec, ictime.tv_nsec,
 			     ctime->tv_sec, ctime->tv_nsec);
-			inode->i_ctime = *ctime;
+			inode_ctime_set(inode, *ctime);
 		}
 		if (ci->i_version == 0 ||
 		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
@@ -738,7 +740,7 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 	} else {
 		/* we have no write|excl caps; whatever the MDS says is true */
 		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) >= 0) {
-			inode->i_ctime = *ctime;
+			inode_ctime_set(inode, *ctime);
 			inode->i_mtime = *mtime;
 			inode->i_atime = *atime;
 			ci->i_time_warp_seq = time_warp_seq;
@@ -2166,7 +2168,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		bool only = (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
 					 ATTR_MODE|ATTR_UID|ATTR_GID)) == 0;
 		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
-		     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
+		     inode_ctime_peek(inode).tv_sec,
+		     inode_ctime_peek(inode).tv_nsec,
 		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
 		     only ? "ctime only" : "ignored");
 		if (only) {
@@ -2191,7 +2194,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (dirtied) {
 		inode_dirty_flags = __ceph_mark_dirty_caps(ci, dirtied,
 							   &prealloc_cf);
-		inode->i_ctime = attr->ia_ctime;
+		inode_ctime_set(inode, attr->ia_ctime);
 		inode_inc_iversion_raw(inode);
 	}
 
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 2e73ba62bd7a..f02df070fa84 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -660,7 +660,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	capsnap->size = i_size_read(inode);
 	capsnap->mtime = inode->i_mtime;
 	capsnap->atime = inode->i_atime;
-	capsnap->ctime = inode->i_ctime;
+	capsnap->ctime = inode_ctime_peek(inode);
 	capsnap->btime = ci->i_btime;
 	capsnap->change_attr = inode_peek_iversion_raw(inode);
 	capsnap->time_warp_seq = ci->i_time_warp_seq;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 806183959c47..8e217f7f58bd 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1238,7 +1238,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL,
 					       &prealloc_cf);
 		ci->i_xattrs.dirty = true;
-		inode->i_ctime = current_time(inode);
+		inode_ctime_set_current(inode);
 	}
 
 	spin_unlock(&ci->i_ceph_lock);
-- 
2.41.0

