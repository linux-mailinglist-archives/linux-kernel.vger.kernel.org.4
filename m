Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEC7725FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjFGMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjFGMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:37:03 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2549173A;
        Wed,  7 Jun 2023 05:37:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qbmkp2Yghz9xFb8;
        Wed,  7 Jun 2023 20:25:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCnJgLMeYBkSckaAw--.4176S5;
        Wed, 07 Jun 2023 13:36:47 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 3/5] smack: Always determine inode labels in smack_inode_init_security()
Date:   Wed,  7 Jun 2023 14:36:10 +0200
Message-Id: <20230607123612.2791303-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
References: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCnJgLMeYBkSckaAw--.4176S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWkWr1rKry7tr1xGF1rJFb_yoWrGr4fpa
        yUWa9xCF1ktFnxu3y0yF47Ww4YkFyrCr4UWr9Fqr9avFsrtryIqrW0qryYgFyxXr97Zrn0
        qr4avryrZ3WY9wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj4pZywABsv
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

The inode_init_security hook is already a good place to initialize the
in-memory inode. And that is also what SELinux does.

In preparation for this, move the existing smack_inode_init_security() code
outside the 'if (xattr)' condition, and set the xattr, if provided.

This change does not have any impact on the current code, since every time
security_inode_init_security() is called, the initxattr() callback is
passed and, thus, xattr is non-NULL.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack_lsm.c | 78 +++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 162ca400f07..f7382448e12 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -948,49 +948,51 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	int may;
 
-	if (xattr) {
-		/*
-		 * If equal, transmuting already occurred in
-		 * smack_dentry_create_files_as(). No need to check again.
-		 */
-		if (tsp->smk_task != tsp->smk_transmuted) {
-			rcu_read_lock();
-			may = smk_access_entry(skp->smk_known, dsp->smk_known,
-					       &skp->smk_rules);
-			rcu_read_unlock();
-		}
+	/*
+	 * If equal, transmuting already occurred in
+	 * smack_dentry_create_files_as(). No need to check again.
+	 */
+	if (tsp->smk_task != tsp->smk_transmuted) {
+		rcu_read_lock();
+		may = smk_access_entry(skp->smk_known, dsp->smk_known,
+				       &skp->smk_rules);
+		rcu_read_unlock();
+	}
+
+	/*
+	 * In addition to having smk_task equal to smk_transmuted,
+	 * if the access rule allows transmutation and the directory
+	 * requests transmutation then by all means transmute.
+	 * Mark the inode as changed.
+	 */
+	if ((tsp->smk_task == tsp->smk_transmuted) ||
+	    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
+	     smk_inode_transmutable(dir))) {
+		struct xattr *xattr_transmute;
 
 		/*
-		 * In addition to having smk_task equal to smk_transmuted,
-		 * if the access rule allows transmutation and the directory
-		 * requests transmutation then by all means transmute.
-		 * Mark the inode as changed.
+		 * The caller of smack_dentry_create_files_as()
+		 * should have overridden the current cred, so the
+		 * inode label was already set correctly in
+		 * smack_inode_alloc_security().
 		 */
-		if ((tsp->smk_task == tsp->smk_transmuted) ||
-		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-		     smk_inode_transmutable(dir))) {
-			struct xattr *xattr_transmute;
-
-			/*
-			 * The caller of smack_dentry_create_files_as()
-			 * should have overridden the current cred, so the
-			 * inode label was already set correctly in
-			 * smack_inode_alloc_security().
-			 */
-			if (tsp->smk_task != tsp->smk_transmuted)
-				isp = dsp;
-			xattr_transmute = lsm_get_xattr_slot(xattrs, xattr_count);
-			if (xattr_transmute) {
-				xattr_transmute->value = kmemdup(TRANS_TRUE,
-						TRANS_TRUE_SIZE, GFP_NOFS);
-				if (xattr_transmute->value == NULL)
-					return -ENOMEM;
-
-				xattr_transmute->value_len = TRANS_TRUE_SIZE;
-				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
-			}
+		if (tsp->smk_task != tsp->smk_transmuted)
+			isp = dsp;
+
+		xattr_transmute = lsm_get_xattr_slot(xattrs, xattr_count);
+		if (xattr_transmute) {
+			xattr_transmute->value = kmemdup(TRANS_TRUE,
+							 TRANS_TRUE_SIZE,
+							 GFP_NOFS);
+			if (xattr_transmute->value == NULL)
+				return -ENOMEM;
+
+			xattr_transmute->value_len = TRANS_TRUE_SIZE;
+			xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
 		}
+	}
 
+	if (xattr) {
 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
 		if (xattr->value == NULL)
 			return -ENOMEM;
-- 
2.25.1

