Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC7632BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKUR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiKUR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:59:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5F9D92F2;
        Mon, 21 Nov 2022 09:59:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 892041F8AC;
        Mon, 21 Nov 2022 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669053543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=44EUHZK2+7LroGLrO/sdeQ2g9vjpmkmO6JfvjGdqyUY=;
        b=kmH/CJRWgUfNkoHM0QIGHup6M/jnRjyzoMSLtgCcaoMyZ7u+cybdbLx2j9ZAedBTj/6ru/
        Akn0gj03DF5mZ0qg0ehU9xtmxHO3vV3Yyjvbps1Qo1xyFoUzcSYvNVHGcsZS1TsKXi63NW
        3rvoczDcjRdsg3KFqV+aZg1rPO4w5K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669053543;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=44EUHZK2+7LroGLrO/sdeQ2g9vjpmkmO6JfvjGdqyUY=;
        b=XWuXEq0g41TSz1G1aKWdeLnw4eXiZQ6uHaF2s2XjLIx2fLf/PYHMfZVNcNfmxjZGh/pQly
        5e8jwTlO15hqAPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 246C71376E;
        Mon, 21 Nov 2022 17:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /lbfBWe8e2OBEwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 21 Nov 2022 17:59:03 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 8d21cd82;
        Mon, 21 Nov 2022 18:00:04 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] ceph: make sure directories aren't complete after setting crypt context
Date:   Mon, 21 Nov 2022 18:00:04 +0000
Message-Id: <20221121180004.8038-1-lhenriques@suse.de>
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

When setting a directory's crypt context, __ceph_dir_clear_complete() needs
to be used otherwise, if it was complete before, any old dentry that's still
around will be valid.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi Xiubo!

I've added the __fscrypt_prepare_readdir() wrapper as you suggested, but I
had to change it slightly because we also need to handle the error cases.

Changes since v1:
- Moved the __ceph_dir_clear_complete() call from ceph_crypt_get_context()
  to ceph_lookup().
- Added an __fscrypt_prepare_readdir() wrapper to check key status changes

 fs/ceph/dir.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index edc2bf0aab83..2cac7e3ab352 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -763,6 +763,27 @@ static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
 		strncmp(dentry->d_name.name, ".ceph", 5) == 0;
 }
 
+/*
+ * Simple wrapper around __fscrypt_prepare_readdir() that will return:
+ *
+ * - '1' if directory was locked and key is now loaded (i.e. dir is unlocked),
+ * - '0' if directory is still locked, or
+ * - an error (< 0) if __fscrypt_prepare_readdir() fails.
+ */
+static int ceph_fscrypt_prepare_readdir(struct inode *dir)
+{
+	bool had_key = fscrypt_has_encryption_key(dir);
+	int err;
+
+	err = __fscrypt_prepare_readdir(dir);
+	if (err)
+		return err;
+	/* is directory now unlocked? */
+	if (!had_key && fscrypt_has_encryption_key(dir))
+		return 1;
+	return 0;
+}
+
 /*
  * Look up a single dir entry.  If there is a lookup intent, inform
  * the MDS so that it gets our 'caps wanted' value in a single op.
@@ -784,10 +805,14 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
 
 	if (IS_ENCRYPTED(dir)) {
-		err = __fscrypt_prepare_readdir(dir);
-		if (err)
+		err = ceph_fscrypt_prepare_readdir(dir);
+		if (err < 0)
 			return ERR_PTR(err);
-		if (!fscrypt_has_encryption_key(dir)) {
+		if (err) {
+			/* directory just got unlocked */
+			__ceph_dir_clear_complete(ceph_inode(dir));
+		} else {
+			/* no encryption key */
 			spin_lock(&dentry->d_lock);
 			dentry->d_flags |= DCACHE_NOKEY_NAME;
 			spin_unlock(&dentry->d_lock);
