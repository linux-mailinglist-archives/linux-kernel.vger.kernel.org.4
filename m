Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD155F4B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJDVvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJDVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:51:26 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF83642B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:51:23 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 81598C009; Tue,  4 Oct 2022 23:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664920281; bh=qaNkDQFrkcyo3sLZ2xyMU1UXskCEKW4uD45n4O+N46A=;
        h=From:To:Cc:Subject:Date:From;
        b=Hh2ylzjJGpmxgi1mMy18Os4jqoatBYtpB850uLC6tROsK8uB0p7PNmcgDK4K8V0Rr
         MAJtbQgN1f+AFY/9UWdQAlkIiPPIMJMqxOrqliHJkObWoaVYjRl2iRFiiP6V5oxJ7g
         gP9KfUK99U6qvffPSnzj57LSpzNAT+eYwUsADVQHbymskyT1QnvzWLPDRRzgxR0ZVF
         5UnSsroDq3xu5jdApModjfnMVIUFu9iwruj6ad2Wb4oRI2VwY20TROLjmkBL20yo8F
         uRlzYDvhBi7ojqcW22O97Jq/fKS5G5vew6v++cQ7rfDxk2PEUyjdJnVkt6sT2T7mi5
         YcnC2MwWTQSTA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 78832C009;
        Tue,  4 Oct 2022 23:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664920280; bh=qaNkDQFrkcyo3sLZ2xyMU1UXskCEKW4uD45n4O+N46A=;
        h=From:To:Cc:Subject:Date:From;
        b=HACU+p+4txJQlTl6SapHOc0xHw2ZYJr2w7goWUGamRmOkobXJ4KYfNZKEl6t7s1QA
         jWEKlVI+3jvRJlJPeVCXk7XQPd19aI9t8a5FNLj4ZRL7w/G1zbrpamdQC7PZbQCfea
         Th17QUI6BcNYvFwuI+kBw9pqv0RfUMixSc1IFHcI3uV6Shb/2YfzX99OFpQSS6T0Ae
         NdjdpUl38bmcY1QcV8NQvi+VL7yRmZhkr5I8t6jvdK3nQjy1zWobvO4jVdVK/YTBFE
         vXUx+e4EpHRYm6F1YcQS/UDD+GuK5xxWfBNp1RFPwL41zNbRgHjTtb3Qh4nGlKy7tm
         YwaHYds4Qg1Ag==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9a191204;
        Tue, 4 Oct 2022 21:51:15 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Subject: [PATCH 1/2] 9p: client_create/destroy: only call trans_mod->close after create
Date:   Wed,  5 Oct 2022 06:51:13 +0900
Message-Id: <20221004215114.1850991-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

destroy code would incorrectly call close() if trans_mod exists after some
hasty code cleanup: we need to make sure we only call close after create

The new bool added to track this has been added in a hole of the struct
and will not increase p9_client's size.
It might be possible to do better with a bit more work, but that will
have to do for now.

Link: https://lkml.kernel.org/r/00000000000015ac7905e97ebaed@google.com
Reported-by: syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Reported-by: Leon Romanovsky <leon@kernel.org>
Fixes: 3ff51294a055 ("9p: p9_client_create: use p9_client_destroy on failure")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v4: start over from scratch with a pool to properly track initialization
state instead of kludging over clnt->trans itself which is "private" to
the trans

 include/net/9p/client.h | 2 ++
 net/9p/client.c         | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 78ebcf782ce5..3f7f473da05a 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -89,6 +89,7 @@ struct p9_req_t {
  * @lock: protect @fids and @reqs
  * @msize: maximum data size negotiated by protocol
  * @proto_version: 9P protocol version to use
+ * @trans_initialized: Whether transport's close() is safe to call
  * @trans_mod: module API instantiated with this client
  * @status: connection state
  * @trans: tranport instance state and API
@@ -103,6 +104,7 @@ struct p9_client {
 	spinlock_t lock;
 	unsigned int msize;
 	unsigned char proto_version;
+	bool trans_initialized;
 	struct p9_trans_module *trans_mod;
 	enum p9_trans_status status;
 	void *trans;
diff --git a/net/9p/client.c b/net/9p/client.c
index bfa80f01992e..cf2d5b60b61b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -992,6 +992,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	err = clnt->trans_mod->create(clnt, dev_name, options);
 	if (err)
 		goto out;
+	clnt->trans_initialized = true;
 
 	if (clnt->msize > clnt->trans_mod->maxsize) {
 		clnt->msize = clnt->trans_mod->maxsize;
@@ -1036,7 +1037,7 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	p9_debug(P9_DEBUG_MUX, "clnt %p\n", clnt);
 
-	if (clnt->trans_mod)
+	if (clnt->trans_mod && clnt->trans_initialized)
 		clnt->trans_mod->close(clnt);
 
 	v9fs_put_trans(clnt->trans_mod);
-- 
2.35.1

