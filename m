Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994DD6D2076
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjCaMeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjCaMdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:33:54 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5E20C23;
        Fri, 31 Mar 2023 05:33:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PnzwS1CsSz9v7Yt;
        Fri, 31 Mar 2023 20:23:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnumHa0iZkr6ziAQ--.5882S6;
        Fri, 31 Mar 2023 13:33:10 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v10 4/4] evm: Support multiple LSMs providing an xattr
Date:   Fri, 31 Mar 2023 14:32:21 +0200
Message-Id: <20230331123221.3273328-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnumHa0iZkr6ziAQ--.5882S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGryktFy8JF1rur15Kw48WFg_yoWrKr1Dpa
        98tas8Arn5JFy7Wr9aya18ua4SgrW8Cw1UK393JryjyFnIqr1IvryIyr15ur98WrW8JrnI
        yw4Yvw15Cw15t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07jxwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj4dsJQABs1
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Currently, evm_inode_init_security() processes a single LSM xattr from the
array passed by security_inode_init_security(), and calculates the HMAC on
it and other inode metadata.

As the LSM infrastructure now can pass to EVM an array with multiple
xattrs, scan them until the terminator (xattr name NULL), and calculate the
HMAC on all of them.

Also, double check that the xattrs array terminator is the first non-filled
slot (obtained with lsm_get_xattr_slot()). Consumers of the xattrs array,
such as the initxattrs() callbacks, rely on the terminator.

Finally, change the name of the lsm_xattr parameter of evm_init_hmac() to
xattrs, to reflect the new type of information passed.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/evm/evm.h        |  4 +++-
 security/integrity/evm/evm_crypto.c | 11 +++++++++--
 security/integrity/evm/evm_main.c   | 29 +++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index f8b8c5004fc..53bd7fec93f 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -46,6 +46,8 @@ struct evm_digest {
 	char digest[IMA_MAX_DIGEST_SIZE];
 } __packed;
 
+int evm_protected_xattr(const char *req_xattr_name);
+
 int evm_init_key(void);
 int evm_update_evmxattr(struct dentry *dentry,
 			const char *req_xattr_name,
@@ -58,7 +60,7 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
 		  size_t req_xattr_value_len, char type,
 		  struct evm_digest *data);
-int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
+int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		  char *hmac_val);
 int evm_init_secfs(void);
 
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 033804f5a5f..0fdd382b58e 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -385,10 +385,11 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 	return rc;
 }
 
-int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
+int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		  char *hmac_val)
 {
 	struct shash_desc *desc;
+	const struct xattr *xattr;
 
 	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
@@ -396,7 +397,13 @@ int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
 		return PTR_ERR(desc);
 	}
 
-	crypto_shash_update(desc, lsm_xattr->value, lsm_xattr->value_len);
+	for (xattr = xattrs; xattr->name != NULL; xattr++) {
+		if (!evm_protected_xattr(xattr->name))
+			continue;
+
+		crypto_shash_update(desc, xattr->value, xattr->value_len);
+	}
+
 	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
 	kfree(desc);
 	return 0;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 475196ce712..e9441419a81 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -306,7 +306,7 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
 	return found;
 }
 
-static int evm_protected_xattr(const char *req_xattr_name)
+int evm_protected_xattr(const char *req_xattr_name)
 {
 	return evm_protected_xattr_common(req_xattr_name, false);
 }
@@ -870,14 +870,35 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    int *xattr_count)
 {
 	struct evm_xattr *xattr_data;
-	struct xattr *evm_xattr;
+	struct xattr *xattr, *evm_xattr;
+	bool evm_protected_xattrs = false;
 	int rc;
 
-	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
-	    !evm_protected_xattr(xattrs->name))
+	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs)
+		return 0;
+
+	/*
+	 * security_inode_init_security() makes sure that the xattrs array is
+	 * contiguous, there is enough space for security.evm, and that there is
+	 * a terminator at the end of the array.
+	 */
+	for (xattr = xattrs; xattr->name != NULL; xattr++) {
+		if (evm_protected_xattr(xattr->name))
+			evm_protected_xattrs = true;
+	}
+
+	/* EVM xattr not needed. */
+	if (!evm_protected_xattrs)
 		return 0;
 
 	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	/*
+	 * Array terminator (xattr name = NULL) must be the first non-filled
+	 * xattr slot.
+	 */
+	WARN_ONCE(evm_xattr != xattr,
+		  "%s: xattrs terminator is not the first non-filled slot\n",
+		  __func__);
 
 	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
 	if (!xattr_data)
-- 
2.25.1

