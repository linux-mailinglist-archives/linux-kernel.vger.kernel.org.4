Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72A5EE946
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiI1WTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI1WTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:19:36 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA3B91
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:19:35 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 83004C01E; Thu, 29 Sep 2022 00:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664403573; bh=s8v7euaD+Iw8Rlbt89l6wSiw8vlpRm5+S9b6T6Y34jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjKKgo02VyBfUDesqIscXbdMQ+WAfJkenJJ0PDjW3Qu9Uc0QwV4rnJCi1BC8XqqkB
         wFC2LHZZ+Yr9NR6CkWrOISv2N26h9IDeRTjetCE7/c76ozRz+TtpAxFHDRe2sZWF48
         t4KBaCuk6F81M4kOZDlFBX/+3sFje4SlrZK1XQHnUZBNjg4D0HpJeQpdSw/aeq2cqZ
         SRupt5WBZQlH1v2VTrQMI+pI+BcbzRN2KaVYGih0cSsl/KPkGv4M8P+VRIwRjEZlzC
         zKuBjPdthbH/9gUI0aSDdN7XL//OZUxBW72jbPn3CRwrFY8+3kuWEuBIxKmVDMG6XA
         4hhR1IFVAqIAw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C38ADC009;
        Thu, 29 Sep 2022 00:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664403571; bh=s8v7euaD+Iw8Rlbt89l6wSiw8vlpRm5+S9b6T6Y34jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ox6s95DptvlFBuo1ui9DuVQpX3L9L+dkPkIzGxN+NGTqYNDtz5QoiJ3lj26mZFcnH
         aw/zkXbTd9oT/pJHr74ciAYbYjq76OprOEswHbjRmA+XBEfa/f7C7pRqXZ4oRwoOV2
         5F56au5wAOMNejb05sim3xlzmyCrxP+NwB9T5KHs+fGmK0GLUuOhcNXiYSHIffQfb1
         Ipj28OrzztVgxqFmv9j7CYg7+iHPwBCxDeBgjn8hLhJ98Pl2illvt+YhQMDHRHe8av
         JXtELYFFphefvYYXqCZddXRDqJy6gmc3slOgUvHGJ4jpQUF6ZfA159DAkWGTa2aDj4
         qvi1vADRqPFBg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8a009fd5;
        Wed, 28 Sep 2022 22:19:27 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Leon Romanovsky <leon@kernel.org>, linux_oss@crudebyte.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Subject: [PATCH v3] 9p: client_create/destroy: only call trans_mod->close after create
Date:   Thu, 29 Sep 2022 07:19:23 +0900
Message-Id: <20220928221923.1751130-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928215800.1749929-1-asmadeus@codewreck.org>
References: <20220928215800.1749929-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

destroy code would incorrectly call close() if trans_mod exists after some
hasty code cleanup: we need to make sure we only call close after create

Link: https://lkml.kernel.org/r/20220928214417.1749609-1-asmadeus@codewreck.org
Link: https://lkml.kernel.org/r/00000000000015ac7905e97ebaed@google.com
Reported-by: syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Reported-by: Leon Romanovsky <leon@kernel.org>
Fixes: 3ff51294a055 ("9p: p9_client_create: use p9_client_destroy on failure")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v1->v2: also reset trans on create error
v2->v3: fix silly compile errors

Sorry for the multiple mails, that's what I get for not even doing basic
tests before talking...

 net/9p/client.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index bfa80f01992e..41e825a8da7c 100644
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
+		clnt->trans = ERR_PTR(err);
 		goto out;
+	}
+	if (IS_ERR(clnt->trans))
+		clnt->trans = NULL;
 
 	if (clnt->msize > clnt->trans_mod->maxsize) {
 		clnt->msize = clnt->trans_mod->maxsize;
@@ -1036,7 +1043,7 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
 
-	if (clnt->trans_mod)
+	if (clnt->trans_mod && !IS_ERR(clnt->trans))
 		clnt->trans_mod->close(clnt);
 
 	v9fs_put_trans(clnt->trans_mod);
-- 
2.35.1

