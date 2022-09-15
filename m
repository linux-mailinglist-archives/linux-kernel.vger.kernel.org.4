Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26F45BA17C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIOTeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIOTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:33:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2929D659;
        Thu, 15 Sep 2022 12:33:11 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FIuXJe026900;
        Thu, 15 Sep 2022 19:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=grZgTx9wIT2KKNeUQSJCcPlkrUM6vypWQfQ4TypS61k=;
 b=V2VV63kBbVU9fCBmhcOt0gKUIvTfFDgMOJxHfRodoYdf88aJoTEzDNaM01sKpwYWnVgG
 I7U9+AgPhUU8VtZtj6Vs6X1lyYEekkkrpKO3UGhaMkfEcR6y/SnJ6wpdt2v1l+8FtX/Q
 4JZ30/hLOwlou2MhdUvApu+TGZM+M3FXbUA26VvNlsbbYt+Fd/aHULtTl9xtl1dYqj1z
 p8ZuYNoO1BuIRWHECPBt+SwHx1Eh5lEC/4qWV0S0Js1cyX60E2CNqONMMsSFv/G/hw7W
 2o0RkZdxQmB5QGAEAbJJFwjw59/DWgR0cRsL04uvU3qS092X2+2mHirfhenIFWJ+SNGi 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm9s5s43t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:38 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FJ0MQk011295;
        Thu, 15 Sep 2022 19:32:37 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm9s5s43a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:37 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FJJuvX005308;
        Thu, 15 Sep 2022 19:32:36 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3jm91qgg4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:36 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FJWZMG3736250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 19:32:35 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D624AE063;
        Thu, 15 Sep 2022 19:32:35 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7BBAE062;
        Thu, 15 Sep 2022 19:32:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 19:32:35 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v14 02/26] securityfs: Extend securityfs with namespacing support
Date:   Thu, 15 Sep 2022 15:31:57 -0400
Message-Id: <20220915193221.1728029-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915193221.1728029-1-stefanb@linux.ibm.com>
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TivO-db2Uf9BMQf8hdQCNbQtOzsyWxpL
X-Proofpoint-ORIG-GUID: eOiQGUUNmeCJg5Bs2Ydzdt3TC52sstFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable multiple instances of securityfs by keying each instance with a
pointer to the user namespace it belongs to.

Since we do not need the pinning of the filesystem for the virtualization
case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
case when the init_user_ns is active. This simplifies the cleanup for the
virtualization case where usage of securityfs_remove() to free dentries
is therefore not needed anymore.

For the initial securityfs, i.e. the one mounted in the host userns mount,
nothing changes. The rules for securityfs_remove() are as before and it is
still paired with securityfs_create(). Specifically, a file created via
securityfs_create_dentry() in the initial securityfs mount still needs to
be removed by a call to securityfs_remove(). Creating a new dentry in the
initial securityfs mount still pins the filesystem like it always did.
Consequently, the initial securityfs mount is not destroyed on
umount/shutdown as long as at least one user of it still has dentries that
it hasn't removed with a call to securityfs_remove().

Prevent mounting of an instance of securityfs in another user namespace
than it belongs to. Also, prevent accesses to files and directories by
a user namespace that is neither the user namespace it belongs to
nor an ancestor of the user namespace that the instance of securityfs
belongs to. Do not prevent access if securityfs was bind-mounted and
therefore the init_user_ns is the owning user namespace.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Acked-by: Serge Hallyn <serge@hallyn.com>

---
v13:
 - Clarified bind-mount comment following Serge's suggestion

v11:
 - Formatted comment's first line to be '/*'
---
 security/inode.c | 74 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 13e6780c4444..c7273fdbca4c 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,9 +21,39 @@
 #include <linux/security.h>
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
+#include <linux/user_namespace.h>
 
-static struct vfsmount *mount;
-static int mount_count;
+static struct vfsmount *init_securityfs_mount;
+static int init_securityfs_mount_count;
+
+static int securityfs_permission(struct user_namespace *mnt_userns,
+				 struct inode *inode, int mask)
+{
+	int err;
+
+	err = generic_permission(&init_user_ns, inode, mask);
+	if (!err) {
+		/*
+		 * Unless securityfs has been bind-mounted from init_user_ns
+		 * into a child user_ns container, deny access if
+		 * current_user_ns() is not ancestor.
+		 */
+		if (inode->i_sb->s_user_ns != &init_user_ns &&
+		    !in_userns(current_user_ns(), inode->i_sb->s_user_ns))
+			err = -EACCES;
+	}
+
+	return err;
+}
+
+static const struct inode_operations securityfs_dir_inode_operations = {
+	.permission	= securityfs_permission,
+	.lookup		= simple_lookup,
+};
+
+static const struct inode_operations securityfs_file_inode_operations = {
+	.permission	= securityfs_permission,
+};
 
 static void securityfs_free_inode(struct inode *inode)
 {
@@ -40,20 +70,25 @@ static const struct super_operations securityfs_super_operations = {
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
+	struct user_namespace *ns = fc->user_ns;
 	int error;
 
+	if (WARN_ON(ns != current_user_ns()))
+		return -EINVAL;
+
 	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
 	if (error)
 		return error;
 
 	sb->s_op = &securityfs_super_operations;
+	sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;
 
 	return 0;
 }
 
 static int securityfs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, securityfs_fill_super);
+	return get_tree_keyed(fc, securityfs_fill_super, fc->user_ns);
 }
 
 static const struct fs_context_operations securityfs_context_ops = {
@@ -71,6 +106,7 @@ static struct file_system_type fs_type = {
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
+	.fs_flags =	FS_USERNS_MOUNT,
 };
 
 /**
@@ -109,6 +145,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 					const struct file_operations *fops,
 					const struct inode_operations *iops)
 {
+	struct user_namespace *ns = current_user_ns();
 	struct dentry *dentry;
 	struct inode *dir, *inode;
 	int error;
@@ -118,12 +155,19 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 
 	pr_debug("securityfs: creating file '%s'\n",name);
 
-	error = simple_pin_fs(&fs_type, &mount, &mount_count);
-	if (error)
-		return ERR_PTR(error);
+	if (ns == &init_user_ns) {
+		error = simple_pin_fs(&fs_type, &init_securityfs_mount,
+				      &init_securityfs_mount_count);
+		if (error)
+			return ERR_PTR(error);
+	}
 
-	if (!parent)
-		parent = mount->mnt_root;
+	if (!parent) {
+		if (ns == &init_user_ns)
+			parent = init_securityfs_mount->mnt_root;
+		else
+			return ERR_PTR(-EINVAL);
+	}
 
 	dir = d_inode(parent);
 
@@ -148,7 +192,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
-		inode->i_op = &simple_dir_inode_operations;
+		inode->i_op = &securityfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 		inc_nlink(inode);
 		inc_nlink(dir);
@@ -156,6 +200,7 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_op = iops ? iops : &simple_symlink_inode_operations;
 		inode->i_link = data;
 	} else {
+		inode->i_op = &securityfs_file_inode_operations;
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
@@ -167,7 +212,9 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	dentry = ERR_PTR(error);
 out:
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&init_securityfs_mount,
+				  &init_securityfs_mount_count);
 	return dentry;
 }
 
@@ -293,11 +340,14 @@ EXPORT_SYMBOL_GPL(securityfs_create_symlink);
  */
 void securityfs_remove(struct dentry *dentry)
 {
+	struct user_namespace *ns;
 	struct inode *dir;
 
 	if (!dentry || IS_ERR(dentry))
 		return;
 
+	ns = dentry->d_sb->s_user_ns;
+
 	dir = d_inode(dentry->d_parent);
 	inode_lock(dir);
 	if (simple_positive(dentry)) {
@@ -310,7 +360,9 @@ void securityfs_remove(struct dentry *dentry)
 		dput(dentry);
 	}
 	inode_unlock(dir);
-	simple_release_fs(&mount, &mount_count);
+	if (ns == &init_user_ns)
+		simple_release_fs(&init_securityfs_mount,
+				  &init_securityfs_mount_count);
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
-- 
2.36.1

