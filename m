Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095F5607445
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJUJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJUJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:39:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4624362F;
        Fri, 21 Oct 2022 02:39:36 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mtzp02GvDz15Lwd;
        Fri, 21 Oct 2022 17:34:48 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:39:34 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <serge@hallyn.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] apparmor: Fix memleak issue in unpack_profile()
Date:   Fri, 21 Oct 2022 17:36:02 +0800
Message-ID: <20221021093602.102839-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before aa_alloc_profile(), it has allocated string for @*ns_name if @tmpns
is not NULL, so directly return -ENOMEM if aa_alloc_profile() failed will
cause a memleak issue, and even if aa_alloc_profile() succeed, in the
@fail_profile tag of aa_unpack(), it need to free @ns_name as well, this
patch fixes them.

Fixes: 736ec752d95e ("AppArmor: policy routines for loading and unpacking policy")
Fixes: 04dc715e24d0 ("apparmor: audit policy ns specified in policy load")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/apparmor/policy_unpack.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 2e028d540c6b..1bf8cfb8700a 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -858,8 +858,11 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	}
 
 	profile = aa_alloc_profile(name, NULL, GFP_KERNEL);
-	if (!profile)
-		return ERR_PTR(-ENOMEM);
+	if (!profile) {
+		info = "out of memory";
+		error = -ENOMEM;
+		goto fail;
+	}
 	rules = list_first_entry(&profile->rules, typeof(*rules), list);
 
 	/* profile renaming is optional */
@@ -1090,6 +1093,10 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	if (error == 0)
 		/* default error covers most cases */
 		error = -EPROTO;
+	if (*ns_name) {
+		kfree(*ns_name);
+		*ns_name = NULL;
+	}
 	if (profile)
 		name = NULL;
 	else if (!name)
@@ -1392,6 +1399,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 {
 	struct aa_load_ent *tmp, *ent;
 	struct aa_profile *profile = NULL;
+	char *ns_name = NULL;
 	int error;
 	struct aa_ext e = {
 		.start = udata->data,
@@ -1401,7 +1409,6 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
 	*ns = NULL;
 	while (e.pos < e.end) {
-		char *ns_name = NULL;
 		void *start;
 		error = verify_header(&e, e.pos == e.start, ns);
 		if (error)
@@ -1432,6 +1439,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 
 		ent->new = profile;
 		ent->ns_name = ns_name;
+		ns_name = NULL;
 		list_add_tail(&ent->list, lh);
 	}
 	udata->abi = e.version & K_ABI_MASK;
@@ -1452,6 +1460,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
 	return 0;
 
 fail_profile:
+	kfree(ns_name);
 	aa_put_profile(profile);
 
 fail:
-- 
2.17.1

