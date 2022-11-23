Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A268A63647B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiKWPsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiKWPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:48:35 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775FB65842;
        Wed, 23 Nov 2022 07:48:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NHQMt1vHMz9xHvb;
        Wed, 23 Nov 2022 23:41:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD34W6OQH5jUE+LAA--.33660S4;
        Wed, 23 Nov 2022 16:47:57 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 2/6] ocfs2: Switch to security_inode_init_security()
Date:   Wed, 23 Nov 2022 16:47:08 +0100
Message-Id: <20221123154712.752074-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD34W6OQH5jUE+LAA--.33660S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4kKF1UJw1rCrW5Aw1fZwb_yoW7GF4Upa
        1rtFnxtr4rJFy8Wryftr43ua1S9rWrGrZrGrs3G34DZFs8Cr1ftry0yr15ua45XrWDJFyk
        tr4Fkrsxuan8J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj4XL2AABsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for removing security_old_inode_init_security(), switch to
security_inode_init_security().

Extend the existing ocfs2_initxattrs() to take the
ocfs2_security_xattr_info structure from fs_info, and populate the
name/value/len triple with the first xattr provided by LSMs.

As fs_info was not used before, ocfs2_initxattrs() can now handle the case
of replicating the behavior of security_old_inode_init_security(), i.e.
just obtaining the xattr, in addition to setting all xattrs provided by
LSMs.

Supporting multiple xattrs is not currently supported where
security_old_inode_init_security() was called (mknod, symlink), as it
requires non-trivial changes that can be done at a later time. Like for
reiserfs, even if EVM is invoked, it will not provide an xattr (if it is
not the first to set it, its xattr will be discarded; if it is the first,
it does not have xattrs to calculate the HMAC on).

Finally, modify the handling of the return value from
ocfs2_init_security_get(). As security_inode_init_security() does not
return -EOPNOTSUPP, remove this case and directly handle the error if the
return value is not zero.

However, the previous case of receiving -EOPNOTSUPP should be still
taken into account, as security_inode_init_security() could return zero
without setting xattrs and ocfs2 would consider it as if the xattr was set.

Instead, if security_inode_init_security() returned zero, look at the xattr
if it was set, and behave accordingly, i.e. set si->enable to zero to
notify to the functions following ocfs2_init_security_get() that the xattr
is not available (same as if security_old_inode_init_security() returned
-EOPNOTSUPP).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/ocfs2/namei.c | 18 ++++++------------
 fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 05f32989bad6..55fba81cd2d1 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
 	int want_meta = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota_inode = 0;
@@ -315,12 +316,8 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
 	/* get security xattr */
 	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
 	if (status) {
-		if (status == -EOPNOTSUPP)
-			si.enable = 0;
-		else {
-			mlog_errno(status);
-			goto leave;
-		}
+		mlog_errno(status);
+		goto leave;
 	}
 
 	/* calculate meta data/clusters for setting security and acl xattr */
@@ -1805,6 +1802,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
 	int want_clusters = 0;
 	int xattr_credits = 0;
 	struct ocfs2_security_xattr_info si = {
+		.name = NULL,
 		.enable = 1,
 	};
 	int did_quota = 0, did_quota_inode = 0;
@@ -1875,12 +1873,8 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
 	/* get security xattr */
 	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
 	if (status) {
-		if (status == -EOPNOTSUPP)
-			si.enable = 0;
-		else {
-			mlog_errno(status);
-			goto bail;
-		}
+		mlog_errno(status);
+		goto bail;
 	}
 
 	/* calculate meta data/clusters for setting security xattr */
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 95d0611c5fc7..55699c573541 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
 static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 		     void *fs_info)
 {
+	struct ocfs2_security_xattr_info *si = fs_info;
 	const struct xattr *xattr;
 	int err = 0;
 
+	if (si) {
+		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
+				    GFP_KERNEL);
+		if (!si->value)
+			return -ENOMEM;
+
+		si->name = xattr_array->name;
+		si->value_len = xattr_array->value_len;
+		return 0;
+	}
+
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
 				      xattr->name, xattr->value,
@@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
 			    const struct qstr *qstr,
 			    struct ocfs2_security_xattr_info *si)
 {
+	int ret;
+
 	/* check whether ocfs2 support feature xattr */
 	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
 		return -EOPNOTSUPP;
-	if (si)
-		return security_old_inode_init_security(inode, dir, qstr,
-							&si->name, &si->value,
-							&si->value_len);
+	if (si) {
+		ret = security_inode_init_security(inode, dir, qstr,
+						   &ocfs2_initxattrs, si);
+		/*
+		 * security_inode_init_security() does not return -EOPNOTSUPP,
+		 * we have to check the xattr ourselves.
+		 */
+		if (!ret && !si->name)
+			si->enable = 0;
+
+		return ret;
+	}
 
 	return security_inode_init_security(inode, dir, qstr,
 					    &ocfs2_initxattrs, NULL);
-- 
2.25.1

