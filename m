Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4AE725FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbjFGMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240895AbjFGMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:37:10 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D01F173B;
        Wed,  7 Jun 2023 05:37:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Qbmmf4yRxz9y9xH;
        Wed,  7 Jun 2023 20:26:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnJgLMeYBkSckaAw--.4176S7;
        Wed, 07 Jun 2023 13:36:55 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 5/5] ramfs: Initialize security of in-memory inodes
Date:   Wed,  7 Jun 2023 14:36:12 +0200
Message-Id: <20230607123612.2791303-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
References: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCnJgLMeYBkSckaAw--.4176S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWUKFWkXw13Jry5AF13Jwb_yoW8tF15pF
        4Iqas8Grn5WFZrWr1SyFWUuw1ftayfKrsrJrs7uw17A3Z7Jr1Dtr4Syr13uFyrGrW8Gw1S
        qF4Y9r45C3W7ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj4pZzgAAsr
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a call security_inode_init_security() after ramfs_get_inode(), to let
LSMs initialize the inode security field. Skip ramfs_fill_super(), as the
initialization is done through the sb_set_mnt_opts hook.

Calling security_inode_init_security() call inside ramfs_get_inode() is
not possible since, for CONFIG_SHMEM=n, tmpfs also calls the former after
the latter.

Pass NULL as initxattrs() callback to security_inode_init_security(), since
the purpose of the call is only to initialize the in-memory inodes.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/ramfs/inode.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 5ba580c7883..e6b5f04b2b2 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -102,6 +102,14 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	int error = -ENOSPC;
 
 	if (inode) {
+		error = security_inode_init_security(inode, dir,
+						     &dentry->d_name, NULL,
+						     NULL);
+		if (error && error != -EOPNOTSUPP) {
+			iput(inode);
+			return error;
+		}
+
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
@@ -134,6 +142,15 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	inode = ramfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
+
+		error = security_inode_init_security(inode, dir,
+						     &dentry->d_name, NULL,
+						     NULL);
+		if (error && error != -EOPNOTSUPP) {
+			iput(inode);
+			return error;
+		}
+
 		error = page_symlink(inode, symname, l);
 		if (!error) {
 			d_instantiate(dentry, inode);
@@ -149,10 +166,20 @@ static int ramfs_tmpfile(struct mnt_idmap *idmap,
 			 struct inode *dir, struct file *file, umode_t mode)
 {
 	struct inode *inode;
+	int error;
 
 	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
 	if (!inode)
 		return -ENOSPC;
+
+	error = security_inode_init_security(inode, dir,
+					     &file_dentry(file)->d_name, NULL,
+					     NULL);
+	if (error && error != -EOPNOTSUPP) {
+		iput(inode);
+		return error;
+	}
+
 	d_tmpfile(file, inode);
 	return finish_open_simple(file, 0);
 }
-- 
2.25.1

