Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5145EE8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiI1V6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI1V6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:58:10 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A1390190
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:58:09 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 55E07C01A; Wed, 28 Sep 2022 23:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664402287; bh=Xms6OhcaZEPNuIqUCXLPQE9kG90emaV6twlho5yTI74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTY3wRxaUDIhe38PxByPCNAAUQUE6P7HVlJE6U1HEfyUlWlPOTwpj6eCv1diEzL0Y
         e+YojKW38ZnNXsqsaMbr6bma3ullio5lO1yZxMdV5Vp9gqjCqhwOtHEkUwOny5aZzQ
         nAv6bh2y3gbI/nPZOnBziCPokVNeUZ1NH46JgcPjScz1x9JSYhv9HDiU6K9OhoqLO6
         WJEdrOPTiaBAqGYCRVDgnQoPW0XqrVmHL5oMXsviZUrO1WfG6gU4LZtJVkBTBFir6T
         L+VcXGbl0XNBQK6udUzvEsST+jG/KYvLByNip6sMLaBgRTCdkxuiqtjszG5mHqioin
         DjNOuQLO+SIDg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 44333C009;
        Wed, 28 Sep 2022 23:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664402286; bh=Xms6OhcaZEPNuIqUCXLPQE9kG90emaV6twlho5yTI74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcNNyH5VJD3MWqo305PALLdeO9RvzGf3OesebRR3BBOb3ZOrYjYg2sVJhWTIXd154
         jZ7p065pdWNCO6/0jWVd8JcaOxhjku3TaO1Fp2xPtgsy8ISp/fiuHNS8Aqx8OgiO6u
         2lQbktiDFTd9Tdn8fq60Vnk/6UM+IzXS0uKRnUn0bKCVOr8L7uftIpPY2OgIe30L7/
         X7TDVZZ8uOC/gmcfE7k8eMlaIR2Tw4XajPC0U0imVaR9A4X1rEzVfyfLGD37BhLDP4
         FCU+YwZocIpZ2HtS7UAvXg9vHjACMm8cvZ8mjTCQuyFUYE/ZPSvdBic9B6RN5m6KMv
         odQ4cgMzlzFlw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 90872eb6;
        Wed, 28 Sep 2022 21:58:02 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Leon Romanovsky <leon@kernel.org>, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Subject: [PATCH 1/2 v2] 9p: client_create/destroy: only call trans_mod->close after create
Date:   Thu, 29 Sep 2022 06:58:00 +0900
Message-Id: <20220928215800.1749929-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928214417.1749609-1-asmadeus@codewreck.org>
References: <20220928214417.1749609-1-asmadeus@codewreck.org>
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

As pointed out in later mail, rdma actually does set trans->priv then
fails, so we also need to reset clnt->trans on create errors.

That's getting uglier than I wish it'd be, but the cleanup code I just
trashed away really isn't pretty either so I guess it'll have to do...
At least close() should now really never be called on create failures.

 net/9p/client.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index bfa80f01992e..8cf952f2de68 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -971,6 +971,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	spin_lock_init(&clnt->lock);
 	idr_init(&clnt->fids);
 	idr_init(&clnt->reqs);
+	clnt->trans = ERR_PTR(-EINVAL);
 
 	err = parse_opts(options, clnt);
 	if (err < 0)
@@ -990,8 +991,14 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 		 clnt, clnt->trans_mod, clnt->msize, clnt->proto_version);
 
 	err = clnt->trans_mod->create(clnt, dev_name, options);
-	if (err)
+	// ensure clnt->trans is initialized to call close() on destroy
+	// if and only if create succeeded
+	if (err < 0) {
+		clnt->trans = PTR_ERR(err);
 		goto out;
+	}
+	if (IS_ERR(clnt->trans))
+		clnt->trans = NULL;
 
 	if (clnt->msize > clnt->trans_mod->maxsize) {
 		clnt->msize = clnt->trans_mod->maxsize;
@@ -1036,7 +1043,7 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
 
-	if (clnt->trans_mod)
+	if (clnt->trans_mod && !IS_ERR(client->trans))
 		clnt->trans_mod->close(clnt);
 
 	v9fs_put_trans(clnt->trans_mod);
-- 
2.35.1

