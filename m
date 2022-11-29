Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489E663BE1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiK2Kit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiK2Kis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:38:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5311B798;
        Tue, 29 Nov 2022 02:38:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C388F1FDDE;
        Tue, 29 Nov 2022 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669718325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sn6kDglaa1mYzXYIabbpumL2ZI4pe8py+KGgBZKikr4=;
        b=xvGmib6LfzlkleVx5q55PBbYpRgpUGDzrU0zq4cLC8FTTnSDXjvymWO2ctyL+dUdE0NP6S
        uSkKnFx3ZE+oDwgUNey51yZsqp7mQu4budFWYB9rJ8KyI3StqLuhAKF1T2Cv7azsP5ooc4
        DfCVNgzQg9g8h99zSU4SfAXBvEsJzAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669718325;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sn6kDglaa1mYzXYIabbpumL2ZI4pe8py+KGgBZKikr4=;
        b=efSCJ2l9eDfdL53PqoinnDf+OPrlWHBcYaHaTx10xJ9C4ph8UGBP/XBJvgU2YqaF6/g39o
        KWNN46svvi0PurBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BEE113AF6;
        Tue, 29 Nov 2022 10:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ODuNEzXhhWMCSwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 29 Nov 2022 10:38:45 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id d80b8a47;
        Tue, 29 Nov 2022 10:39:50 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v4] ceph: mark directory as non-complete complete after loading key
Date:   Tue, 29 Nov 2022 10:39:49 +0000
Message-Id: <20221129103949.19737-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting a directory's crypt context, ceph_dir_clear_complete() needs to
be called otherwise if it was complete before, any existing (old) dentry will
still be valid.

This patch adds a wrapper around __fscrypt_prepare_readdir() which will
ensure a directory is marked as non-complete if key status changes.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi Xiubo,

Here's a rebase of this patch.  I did some testing but since this branch
doesn't really have full fscrypt support, I couldn't even reproduce the
bug.  So, my testing was limited.

Changes since v3:
- Rebased patch to 'testing' branch

Changes since v2:
- Created helper wrapper for __fscrypt_prepare_readdir()
- Added calls to the new helper

Changes since v1:
- Moved the __ceph_dir_clear_complete() call from ceph_crypt_get_context()
  to ceph_lookup().
- Added an __fscrypt_prepare_readdir() wrapper to check key status changes


 fs/ceph/crypto.c     | 35 +++++++++++++++++++++++++++++++++--
 fs/ceph/crypto.h     |  6 ++++++
 fs/ceph/dir.c        |  8 ++++----
 fs/ceph/mds_client.c |  6 +++---
 4 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 5b807f8f4c69..fe47fbdaead9 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -277,8 +277,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
 
-	ret = __fscrypt_prepare_readdir(fname->dir);
-	if (ret)
+	ret = ceph_fscrypt_prepare_readdir(fname->dir);
+	if (ret < 0)
 		return ret;
 
 	/*
@@ -323,3 +323,34 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	fscrypt_fname_free_buffer(&_tname);
 	return ret;
 }
+
+/**
+ * ceph_fscrypt_prepare_readdir - simple __fscrypt_prepare_readdir() wrapper
+ * @dir: directory inode for readdir prep
+ *
+ * Simple wrapper around __fscrypt_prepare_readdir() that will mark directory as
+ * non-complete if this call results in having the directory unlocked.
+ *
+ * Returns:
+ *     1 - if directory was locked and key is now loaded (i.e. dir is unlocked)
+ *     0 - if directory is still locked
+ *   < 0 - if __fscrypt_prepare_readdir() fails
+ */
+int ceph_fscrypt_prepare_readdir(struct inode *dir)
+{
+	bool had_key = fscrypt_has_encryption_key(dir);
+	int err;
+
+	if (!IS_ENCRYPTED(dir))
+		return 0;
+
+	err = __fscrypt_prepare_readdir(dir);
+	if (err)
+		return err;
+	if (!had_key && fscrypt_has_encryption_key(dir)) {
+		/* directory just got unlocked, mark it as not complete */
+		ceph_dir_clear_complete(dir);
+		return 1;
+	}
+	return 0;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 05db33f1a421..f8d5f33f708a 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -94,6 +94,7 @@ static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_s
 
 int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			struct fscrypt_str *oname, bool *is_nokey);
+int ceph_fscrypt_prepare_readdir(struct inode *dir);
 
 #else /* CONFIG_FS_ENCRYPTION */
 
@@ -147,6 +148,11 @@ static inline int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscry
 	oname->len = fname->name_len;
 	return 0;
 }
+
+static inline int ceph_fscrypt_prepare_readdir(struct inode *dir)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b136fb923b7a..bc908d0dd224 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -343,8 +343,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 2;
 	}
 
-	err = fscrypt_prepare_readdir(inode);
-	if (err)
+	err = ceph_fscrypt_prepare_readdir(inode);
+	if (err < 0)
 		return err;
 
 	spin_lock(&ci->i_ceph_lock);
@@ -784,8 +784,8 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 
 	if (IS_ENCRYPTED(dir)) {
-		err = __fscrypt_prepare_readdir(dir);
-		if (err)
+		err = ceph_fscrypt_prepare_readdir(dir);
+		if (err < 0)
 			return ERR_PTR(err);
 		if (!fscrypt_has_encryption_key(dir)) {
 			spin_lock(&dentry->d_lock);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e3683305445c..cbbaf334b6b8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2551,8 +2551,8 @@ static u8 *get_fscrypt_altname(const struct ceph_mds_request *req, u32 *plen)
 	if (!IS_ENCRYPTED(dir))
 		goto success;
 
-	ret = __fscrypt_prepare_readdir(dir);
-	if (ret)
+	ret = ceph_fscrypt_prepare_readdir(dir);
+	if (ret < 0)
 		return ERR_PTR(ret);
 
 	/* No key? Just ignore it. */
@@ -2668,7 +2668,7 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for
 			spin_unlock(&cur->d_lock);
 			parent = dget_parent(cur);
 
-			ret = __fscrypt_prepare_readdir(d_inode(parent));
+			ret = ceph_fscrypt_prepare_readdir(d_inode(parent));
 			if (ret < 0) {
 				dput(parent);
 				dput(cur);
