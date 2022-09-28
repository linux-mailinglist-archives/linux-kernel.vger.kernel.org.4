Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52CB5EE88B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiI1Vop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiI1Vom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:44:42 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055960E8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:44:40 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9DD4BC020; Wed, 28 Sep 2022 23:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664401478; bh=B52/mFabXVyZkWM6X1umFbbhvQzlpiRJF9pARLLSDwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKsaER1TSz6n0eV+uMs7nT7c/m9mdyIn2BXDs2vMqjO43OH95d+6tc0Y8yvtGMPso
         ojNc2QCUPrANTJ9US3wHM1N5I8MlaaWXu2GOF2rc3oYrKz+S+xzAanciQlfUgPzcL9
         MytmctiDVca/hSpYDNivV5EgIrLqM7TXbTq0n9LBJkkdMAtotB4PksHP2s8Xb2UMyo
         PJf2phCoE1O2IBCd8kbzMaL1boKcMEy4zJc5wvSZr7Bs7fQjQzCeT44o0itTF3B/21
         XDKJo1bD4lgV/XQ/76cCg9myRmh5d6tw+G4RXEaFqHldVFaAjCdd6LkHuqjK2mC+Yv
         R/HawAtsJv7mw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 55700C01A;
        Wed, 28 Sep 2022 23:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664401478; bh=B52/mFabXVyZkWM6X1umFbbhvQzlpiRJF9pARLLSDwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RKsaER1TSz6n0eV+uMs7nT7c/m9mdyIn2BXDs2vMqjO43OH95d+6tc0Y8yvtGMPso
         ojNc2QCUPrANTJ9US3wHM1N5I8MlaaWXu2GOF2rc3oYrKz+S+xzAanciQlfUgPzcL9
         MytmctiDVca/hSpYDNivV5EgIrLqM7TXbTq0n9LBJkkdMAtotB4PksHP2s8Xb2UMyo
         PJf2phCoE1O2IBCd8kbzMaL1boKcMEy4zJc5wvSZr7Bs7fQjQzCeT44o0itTF3B/21
         XDKJo1bD4lgV/XQ/76cCg9myRmh5d6tw+G4RXEaFqHldVFaAjCdd6LkHuqjK2mC+Yv
         R/HawAtsJv7mw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f0a11f89;
        Wed, 28 Sep 2022 21:44:34 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Leon Romanovsky <leon@kernel.org>, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/2] 9p: client_create: init fcall_cache earlier
Date:   Thu, 29 Sep 2022 06:44:17 +0900
Message-Id: <20220928214417.1749609-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928214417.1749609-1-asmadeus@codewreck.org>
References: <YzQc2yaDufjp+rHc@unreal>
 <20220928214417.1749609-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fcall cache was init'd last for some reason, but we actually allocate
some requests for the version check before that.
Moving the cache creation towards the start also makes p9_client_destroy's
order match the allocation order, which might be easier to think about

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 40b59431a566..1ea326e6e271 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -977,6 +977,17 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err < 0)
 		goto out;
 
+	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
+	 * followed by data accessed from userspace by read
+	 * Note we do not check for failure here because the cache is
+	 * optional; warning will be issued on dmesg for failure.
+	 */
+	clnt->fcall_cache =
+		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+					   0, 0, P9_HDRSZ + 4,
+					   clnt->msize - (P9_HDRSZ + 4),
+					   NULL);
+
 	if (!clnt->trans_mod)
 		clnt->trans_mod = v9fs_get_default_trans();
 
@@ -1016,15 +1027,6 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto out;
 
-	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
-	 * followed by data accessed from userspace by read
-	 */
-	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
-					   0, 0, P9_HDRSZ + 4,
-					   clnt->msize - (P9_HDRSZ + 4),
-					   NULL);
-
 	return clnt;
 
 out:
-- 
2.35.1

