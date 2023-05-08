Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699C56FB59F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjEHRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjEHRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:03:18 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E85E659E;
        Mon,  8 May 2023 10:03:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QFS684TNWz9xFPm;
        Tue,  9 May 2023 00:53:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHMzo5K1lkVOGLAg--.32526S2;
        Mon, 08 May 2023 18:02:57 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        yoonjaeh@amazon.com, kamatam@amazon.com, mengcc@amazon.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 1/2] smack: Retrieve transmuting information in smack_inode_getsecurity()
Date:   Mon,  8 May 2023 19:02:33 +0200
Message-Id: <20230508170234.3595105-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHMzo5K1lkVOGLAg--.32526S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryfGFWrKry5XF13JFyfXrb_yoW8Ar1fpF
        sxK3Wakr10qF9xXFZ3Gr12gFWSkFZ3KrWUXwsrW343ZFnIg340ga95tr17uF1rXrWxuFnY
        kay2qrn8u3WqkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
        w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj4j+TAABsH
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

Enhance smack_inode_getsecurity() to retrieve the value for
SMACK64TRANSMUTE from the inode security blob, similarly to SMACK64.

This helps to display accurate values in the situation where the security
labels come from mount options and not from xattrs.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack_lsm.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7a3e9ab137d..c7e37ed2799 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1463,10 +1463,19 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 	struct super_block *sbp;
 	struct inode *ip = inode;
 	struct smack_known *isp;
+	struct inode_smack *ispp;
+	size_t label_len;
+	char *label = NULL;
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
+	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		isp = smk_of_inode(inode);
-	else {
+	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		ispp = smack_inode(inode);
+		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
+			label = TRANS_TRUE;
+		else
+			label = "";
+	} else {
 		/*
 		 * The rest of the Smack xattrs are only on sockets.
 		 */
@@ -1488,13 +1497,18 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
 			return -EOPNOTSUPP;
 	}
 
+	if (!label)
+		label = isp->smk_known;
+
+	label_len = strlen(label);
+
 	if (alloc) {
-		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		*buffer = kstrdup(label, GFP_KERNEL);
 		if (*buffer == NULL)
 			return -ENOMEM;
 	}
 
-	return strlen(isp->smk_known);
+	return label_len;
 }
 
 
-- 
2.25.1

