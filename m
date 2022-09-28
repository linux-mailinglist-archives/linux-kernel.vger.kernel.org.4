Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9932B5EE88A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiI1Von (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI1Vok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:44:40 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91445FB2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:44:37 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 8640DC01F; Wed, 28 Sep 2022 23:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664401474; bh=UmhaJMECcRYmREt7/tMqA6aB1TydkXl9QzrOPmc/ArE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgiHNJZSmT706nye3erb+e0zf8MszeHX5843yn+BSuaO1TSnEul/h1Pnn0lrPoce1
         WCmXZYSo+k/PFLQtCHFCHLQ+/Uhpks+2WX98PB9CrR/DElNCYvqbFQSd1nUNHQjAQa
         7R0LD9Oz7GavNZ9L7Zjd3c6jQ075mxpGRQcOlsOr1u+e9SM+ljOJcEgf7VQkdd0KGP
         5f9xqtEzABpRxvuSs5ZKp/Fnbt2wJbh1hyRuAS+2mf2uKo+V2LLRnGG+EpHQYG/CPx
         5TSXPKPua+M0R2d0E8FnVO0vb+eYBCIcCugK5wxKE1G6U1NxUD0R9eng8yo4gEwpLr
         4OEmESu6xL5Dg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 8622EC009;
        Wed, 28 Sep 2022 23:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664401473; bh=UmhaJMECcRYmREt7/tMqA6aB1TydkXl9QzrOPmc/ArE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yltSH9hCDL97tJShageOdXo1pcVGpvqc7R5PJjb/bkqxP4ZqJhuoOtaLKZLuu7QC9
         DJ0nLnbWKlbK7KUltKxQewcdvOwkC0KpYUoVbOdmbJUeC8StHnZ7Ja//aI3jz7dCoe
         7l6AsIH1cGK8sP07aobThwBARiZmrWmfteJzGnymQUhoTiJRBmZBm88huGBKgSj4Uf
         4XRGy8T5E4x/IytD4nK8oZR3galJZN/n13kWdPVS21e8myCFFRu8V6dULP847x8XRV
         UEFk+C6VBTNPh1rbu5uPxvnu6xgLt0tOe49b0Uc8wTK3Zx4Viij6q1FlcrwWU5CbBy
         nfGWembNZqeuA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8209d52e;
        Wed, 28 Sep 2022 21:44:29 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Leon Romanovsky <leon@kernel.org>, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Subject: [PATCH 1/2] 9p: client_create/destroy: only call trans_mod->close after create
Date:   Thu, 29 Sep 2022 06:44:16 +0900
Message-Id: <20220928214417.1749609-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <YzQc2yaDufjp+rHc@unreal>
References: <YzQc2yaDufjp+rHc@unreal>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

destroy code would incorrectly call close() if trans_mod exists after some
hasty code cleanup: we need to make sure we only call close after create

Link: https://lkml.kernel.org/r/00000000000015ac7905e97ebaed@google.com
Reported-by: syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Reported-by: Leon Romanovsky <leon@kernel.org>
Fixes: 3ff51294a055 ("9p: p9_client_create: use p9_client_destroy on failure")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
I tried to make trans->create() return clnt->trans to assign directly
from there, but rdma callbacks need clnt->trans to be set early during
init and the diff was just too big for a simple fix.
This should work for all transports without any change, and ensures we
only call close if create succeeded.

 net/9p/client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index bfa80f01992e..40b59431a566 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -971,6 +971,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	spin_lock_init(&clnt->lock);
 	idr_init(&clnt->fids);
 	idr_init(&clnt->reqs);
+	clnt->trans = ERR_PTR(-EINVAL);
 
 	err = parse_opts(options, clnt);
 	if (err < 0)
@@ -992,6 +993,9 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	err = clnt->trans_mod->create(clnt, dev_name, options);
 	if (err)
 		goto out;
+	// ensure clnt->trans is initialized to call close() on destroy
+	if (IS_ERR(clnt->trans))
+		clnt->trans = NULL;
 
 	if (clnt->msize > clnt->trans_mod->maxsize) {
 		clnt->msize = clnt->trans_mod->maxsize;
@@ -1036,7 +1040,7 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
 
-	if (clnt->trans_mod)
+	if (clnt->trans_mod && !IS_ERR(client->trans))
 		clnt->trans_mod->close(clnt);
 
 	v9fs_put_trans(clnt->trans_mod);
-- 
2.35.1

