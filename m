Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23AF6111A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJ1Mgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJ1Mgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:36:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C671CCCE2;
        Fri, 28 Oct 2022 05:36:42 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MzMNx0GSwzmV75;
        Fri, 28 Oct 2022 20:31:45 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 20:36:40 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <serge@hallyn.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] apparmor: Fix memleak in alloc_ns()
Date:   Fri, 28 Oct 2022 20:33:20 +0800
Message-ID: <20221028123320.88132-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After changes in commit a1bd627b46d1 ("apparmor: share profile name on
replacement"), the hname member of struct aa_policy is not valid slab
object, but a subset of that, it can not be freed by kfree_sensitive(),
use aa_policy_destroy() to fix it.

Fixes: a1bd627b46d1 ("apparmor: share profile name on replacement")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/apparmor/policy_ns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
index 5c38563a6dcf..fd5b7afbcb48 100644
--- a/security/apparmor/policy_ns.c
+++ b/security/apparmor/policy_ns.c
@@ -132,7 +132,7 @@ static struct aa_ns *alloc_ns(const char *prefix, const char *name)
 	return ns;
 
 fail_unconfined:
-	kfree_sensitive(ns->base.hname);
+	aa_policy_destroy(&ns->base);
 fail_ns:
 	kfree_sensitive(ns);
 	return NULL;
-- 
2.17.1

