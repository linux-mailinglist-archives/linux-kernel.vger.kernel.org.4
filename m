Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E696FB5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjEHRD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjEHRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:03:24 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D46EAB;
        Mon,  8 May 2023 10:03:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QFS6H31Nbz9xFPp;
        Tue,  9 May 2023 00:53:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHMzo5K1lkVOGLAg--.32526S3;
        Mon, 08 May 2023 18:03:04 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        yoonjaeh@amazon.com, kamatam@amazon.com, mengcc@amazon.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 2/2] smack: Record transmuting in smk_transmuted
Date:   Mon,  8 May 2023 19:02:34 +0200
Message-Id: <20230508170234.3595105-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508170234.3595105-1-roberto.sassu@huaweicloud.com>
References: <20230508170234.3595105-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHMzo5K1lkVOGLAg--.32526S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyxtr45Zw4DXF4xGrW7urg_yoWruw4fpF
        WDGasxKFnYyFn29392yr4UuF4SkFZ3Wr15GrnrK3saqFnIqw1xKF40qr129FyfJrn7Zr1Y
        qF4a9ry5Ww1jkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jf
        cTPUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj4z6dwAAs+
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

smack_dentry_create_files_as() determines whether transmuting should occur
based on the label of the parent directory the new inode will be added to,
and not the label of the directory where it is created.

This helps for example to do transmuting on overlayfs, since the latter
first creates the inode in the working directory, and then moves it to the
correct destination.

However, despite smack_dentry_create_files_as() provides the correct label,
smack_inode_init_security() does not know from passed information whether
or not transmuting occurred. Without this information,
smack_inode_init_security() cannot set SMK_INODE_CHANGED in smk_flags,
which will result in the SMACK64TRANSMUTE xattr not being set in
smack_d_instantiate().

Thus, add the smk_transmuted field to the task_smack structure, and set it
in smack_dentry_create_files_as() to smk_task if transmuting occurred. If
smk_task is equal to smk_transmuted in smack_inode_init_security(), act as
if transmuting was successful but without taking the label from the parent
directory (the inode label was already set correctly from the current
credentials in smack_inode_alloc_security()).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack.h     |  1 +
 security/smack/smack_lsm.c | 41 +++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index e2239be7bd6..aa15ff56ed6 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -120,6 +120,7 @@ struct inode_smack {
 struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
+	struct smack_known	*smk_transmuted;/* label when transmuted */
 	struct list_head	smk_rules;	/* per task access rules */
 	struct mutex		smk_rules_lock;	/* lock for the rules */
 	struct list_head	smk_relabel;	/* transit allowed labels */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c7e37ed2799..6e270cf3fd3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -933,8 +933,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *issp = smack_inode(inode);
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	int may;
@@ -943,20 +944,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		*name = XATTR_SMACK_SUFFIX;
 
 	if (value && len) {
-		rcu_read_lock();
-		may = smk_access_entry(skp->smk_known, dsp->smk_known,
-				       &skp->smk_rules);
-		rcu_read_unlock();
+		/*
+		 * If equal, transmuting already occurred in
+		 * smack_dentry_create_files_as(). No need to check again.
+		 */
+		if (tsp->smk_task != tsp->smk_transmuted) {
+			rcu_read_lock();
+			may = smk_access_entry(skp->smk_known, dsp->smk_known,
+					       &skp->smk_rules);
+			rcu_read_unlock();
+		}
 
 		/*
-		 * If the access rule allows transmutation and
-		 * the directory requests transmutation then
-		 * by all means transmute.
+		 * In addition to having smk_task equal to smk_transmuted,
+		 * if the access rule allows transmutation and the directory
+		 * requests transmutation then by all means transmute.
 		 * Mark the inode as changed.
 		 */
-		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-		    smk_inode_transmutable(dir)) {
-			isp = dsp;
+		if ((tsp->smk_task == tsp->smk_transmuted) ||
+		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
+		     smk_inode_transmutable(dir))) {
+			/*
+			 * The caller of smack_dentry_create_files_as()
+			 * should have overridden the current cred, so the
+			 * inode label was already set correctly in
+			 * smack_inode_alloc_security().
+			 */
+			if (tsp->smk_task != tsp->smk_transmuted)
+				isp = dsp;
 			issp->smk_flags |= SMK_INODE_CHANGED;
 		}
 
@@ -4767,8 +4782,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 		 * providing access is transmuting use the containing
 		 * directory label instead of the process label.
 		 */
-		if (may > 0 && (may & MAY_TRANSMUTE))
+		if (may > 0 && (may & MAY_TRANSMUTE)) {
 			ntsp->smk_task = isp->smk_inode;
+			ntsp->smk_transmuted = ntsp->smk_task;
+		}
 	}
 	return 0;
 }
-- 
2.25.1

