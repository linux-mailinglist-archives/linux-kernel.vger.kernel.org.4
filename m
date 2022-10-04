Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829EA5F3EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJDIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiJDIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:45:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD36F4DF04;
        Tue,  4 Oct 2022 01:45:27 -0700 (PDT)
Received: from lenovo.Home (unknown [39.45.148.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AAF186602294;
        Tue,  4 Oct 2022 09:45:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664873125;
        bh=DDe39PfAYSVpLkDZAiTg9JOc4VmntwqihIfPrL/dtsE=;
        h=From:To:Cc:Subject:Date:From;
        b=iqud63xj3L9NEwYkQSdqmyuuhYoiWK7t9kIVINO06950UrVH/UdZSvc5c/6aeTDHI
         npwvlS4ueiA2+FBzGnCfV0LWnZYzWwkwFp6bwSAM4UQLCoi6jeD8kQmVf4sRWEzQ/k
         y0+zbEoyBi31N3RxX19Y2d96qGOhkMjOebWE5WpMuLr42l+ctQyIi1r6AhWOZtLdTN
         gH8B7MkYZw8lS1ruSB8UDRAxRnsfuJDcl6yoqqZmTESMzGUyb2neEYovX3av4u7Tey
         HtjHuwLGOIExwjZHGA1MG172ZnFIbpMPcavlKH9z6aafh6QHvA0tYBpP+hST07A+pT
         bqlgNGiTgK/Lg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: store return value of unpack_perms_table() to signed variable
Date:   Tue,  4 Oct 2022 13:45:15 +0500
Message-Id: <20221004084515.659441-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unpack_perms_table() can return error which is negative value. Store
the return value to a signed variable. policy->size is unsigned
variable. It shouldn't be used to store the return status.

Fixes: 2d6b2dea7f3c ("apparmor: add the ability for policy to specify a permission table")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 security/apparmor/policy_unpack.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 45c9dfdc8e0d..09f316943951 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -734,14 +734,18 @@ static int unpack_pdb(struct aa_ext *e, struct aa_policydb *policy,
 {
 	void *pos = e->pos;
 	int i, flags, error = -EPROTO;
+	ssize_t size;
 
-	policy->size = unpack_perms_table(e, &policy->perms);
-	if (policy->size < 0) {
-		error = policy->size;
+	size = unpack_perms_table(e, &policy->perms);
+	if (size < 0) {
+		error = size;
 		policy->perms = NULL;
 		*info = "failed to unpack - perms";
 		goto fail;
-	} else if (policy->perms) {
+	}
+	policy->size = size;
+
+	if (policy->perms) {
 		/* perms table present accept is index */
 		flags = TO_ACCEPT1_FLAG(YYTD_DATA32);
 	} else {
-- 
2.30.2

