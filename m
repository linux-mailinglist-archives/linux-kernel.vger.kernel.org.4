Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CBC692F38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBKHvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBKHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:50:55 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DFE5C487
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:50:54 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 7DE77C022; Sat, 11 Feb 2023 08:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101875; bh=UfsDrit7eLpVkZZfZcRzk8BZOU6gKynjWaH0yapJsnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qx0iUfzqF/T5Yf4GrgHdYITABitWEhGjzLEbJRqCdfw7m6bG2rzy3p3LI7y3tZjFB
         dBgR7K0l8tXkQi/TWBim0tBCufYAd5d9xjUbbjbr/ZGhTGMMi8AIlNyu4VYZqA6UWt
         wuA2NA4A3e/nLp6YFoC1O3hFa+BqvIYh5+8ry+594hRzqv7zF1rpzVF9ts6outy8fO
         uF3jTEkvu9gAgYAQ+Di0tyd+Ic3I8RzypErVtfyrhKn+ViFSwXJEO2Dra/WAYynLdW
         Yq4AMS1JX2upKu7Kznfi7E7L9PW8i0IgX2OGQdkI6VnjRHh63b7z1RTG/FUx+aYRUi
         9G9o6vkzi6Asw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E1A88C01C;
        Sat, 11 Feb 2023 08:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101874; bh=UfsDrit7eLpVkZZfZcRzk8BZOU6gKynjWaH0yapJsnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBM2t+sS5avUYvRjF5rsRwgVGggc9u9dqiKiC5icg2O6vsFE3kcuoL0LOV/SgASNs
         jLR/49+n5k5SExlQXpUt955wZuPAfpyqh6NXvGhcP3y2wTErD34R9XoN/8nO7mimtM
         yRdHraNzyNHO+y50M93xQGUXRO3ItL7Tq/rxHRwgKkGd6zSNbWY5GW8Iyd0u9e6ea0
         s2RMYNMTxusmxsXDu5QVy6XoYTqQ+b07TFH57zBzemu0cFnLFL3owUehAjLorssump
         KL1vgktz2F5MKKj7Bw7QIh9OzmY6HzMObv0SZGW3N/rkhorTM42d0eHUOkZFoMAGh8
         qwajrNOhuYLZQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6bace919;
        Sat, 11 Feb 2023 07:50:43 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 1/5] 9p/net: move code in preparation of async rpc
Date:   Sat, 11 Feb 2023 16:50:19 +0900
Message-Id: <20230211075023.137253-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230211075023.137253-1-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit containers no code change:
 - move p9_fid_* higher in code as p9_fid_destroy will be used
in async callback
 - move p9_client_flush as it will no longer call p9_client_rpc
and can simplify forward declaration a bit later

This just simplifies the next commits to make diffs cleaner.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 198 ++++++++++++++++++++++++------------------------
 1 file changed, 99 insertions(+), 99 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 622ec6a586ee..53ebd07c36ee 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -428,6 +428,66 @@ static void p9_tag_cleanup(struct p9_client *c)
 	rcu_read_unlock();
 }
 
+static struct p9_fid *p9_fid_create(struct p9_client *clnt)
+{
+	int ret;
+	struct p9_fid *fid;
+
+	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
+	fid = kzalloc(sizeof(*fid), GFP_KERNEL);
+	if (!fid)
+		return NULL;
+
+	fid->mode = -1;
+	fid->uid = current_fsuid();
+	fid->clnt = clnt;
+	refcount_set(&fid->count, 1);
+
+	idr_preload(GFP_KERNEL);
+	spin_lock_irq(&clnt->lock);
+	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
+			    GFP_NOWAIT);
+	spin_unlock_irq(&clnt->lock);
+	idr_preload_end();
+	if (!ret) {
+		trace_9p_fid_ref(fid, P9_FID_REF_CREATE);
+		return fid;
+	}
+
+	kfree(fid);
+	return NULL;
+}
+
+static void p9_fid_destroy(struct p9_fid *fid)
+{
+	struct p9_client *clnt;
+	unsigned long flags;
+
+	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
+	trace_9p_fid_ref(fid, P9_FID_REF_DESTROY);
+	clnt = fid->clnt;
+	spin_lock_irqsave(&clnt->lock, flags);
+	idr_remove(&clnt->fids, fid->fid);
+	spin_unlock_irqrestore(&clnt->lock, flags);
+	kfree(fid->rdir);
+	kfree(fid);
+}
+
+/* We also need to export tracepoint symbols for tracepoint_enabled() */
+EXPORT_TRACEPOINT_SYMBOL(9p_fid_ref);
+
+void do_trace_9p_fid_get(struct p9_fid *fid)
+{
+	trace_9p_fid_ref(fid, P9_FID_REF_GET);
+}
+EXPORT_SYMBOL(do_trace_9p_fid_get);
+
+void do_trace_9p_fid_put(struct p9_fid *fid)
+{
+	trace_9p_fid_ref(fid, P9_FID_REF_PUT);
+}
+EXPORT_SYMBOL(do_trace_9p_fid_put);
+
 /**
  * p9_client_cb - call back from transport to client
  * @c: client state
@@ -570,6 +630,45 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 	return err;
 }
 
+static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
+					      int8_t type, uint t_size, uint r_size,
+					      const char *fmt, va_list ap)
+{
+	int err;
+	struct p9_req_t *req;
+	va_list apc;
+
+	p9_debug(P9_DEBUG_MUX, "client %p op %d\n", c, type);
+
+	/* we allow for any status other than disconnected */
+	if (c->status == Disconnected)
+		return ERR_PTR(-EIO);
+
+	/* if status is begin_disconnected we allow only clunk request */
+	if (c->status == BeginDisconnect && type != P9_TCLUNK)
+		return ERR_PTR(-EIO);
+
+	va_copy(apc, ap);
+	req = p9_tag_alloc(c, type, t_size, r_size, fmt, apc);
+	va_end(apc);
+	if (IS_ERR(req))
+		return req;
+
+	/* marshall the data */
+	p9pdu_prepare(&req->tc, req->tc.tag, type);
+	err = p9pdu_vwritef(&req->tc, c->proto_version, fmt, ap);
+	if (err)
+		goto reterr;
+	p9pdu_finalize(c, &req->tc);
+	trace_9p_client_req(c, type, req->tc.tag);
+	return req;
+reterr:
+	p9_req_put(c, req);
+	/* We have to put also the 2nd reference as it won't be used */
+	p9_req_put(c, req);
+	return ERR_PTR(err);
+}
+
 static struct p9_req_t *
 p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 
@@ -613,45 +712,6 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
 	return 0;
 }
 
-static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
-					      int8_t type, uint t_size, uint r_size,
-					      const char *fmt, va_list ap)
-{
-	int err;
-	struct p9_req_t *req;
-	va_list apc;
-
-	p9_debug(P9_DEBUG_MUX, "client %p op %d\n", c, type);
-
-	/* we allow for any status other than disconnected */
-	if (c->status == Disconnected)
-		return ERR_PTR(-EIO);
-
-	/* if status is begin_disconnected we allow only clunk request */
-	if (c->status == BeginDisconnect && type != P9_TCLUNK)
-		return ERR_PTR(-EIO);
-
-	va_copy(apc, ap);
-	req = p9_tag_alloc(c, type, t_size, r_size, fmt, apc);
-	va_end(apc);
-	if (IS_ERR(req))
-		return req;
-
-	/* marshall the data */
-	p9pdu_prepare(&req->tc, req->tc.tag, type);
-	err = p9pdu_vwritef(&req->tc, c->proto_version, fmt, ap);
-	if (err)
-		goto reterr;
-	p9pdu_finalize(c, &req->tc);
-	trace_9p_client_req(c, type, req->tc.tag);
-	return req;
-reterr:
-	p9_req_put(c, req);
-	/* We have to put also the 2nd reference as it won't be used */
-	p9_req_put(c, req);
-	return ERR_PTR(err);
-}
-
 /**
  * p9_client_rpc - issue a request and wait for a response
  * @c: client session
@@ -838,66 +898,6 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	return ERR_PTR(safe_errno(err));
 }
 
-static struct p9_fid *p9_fid_create(struct p9_client *clnt)
-{
-	int ret;
-	struct p9_fid *fid;
-
-	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
-	fid = kzalloc(sizeof(*fid), GFP_KERNEL);
-	if (!fid)
-		return NULL;
-
-	fid->mode = -1;
-	fid->uid = current_fsuid();
-	fid->clnt = clnt;
-	refcount_set(&fid->count, 1);
-
-	idr_preload(GFP_KERNEL);
-	spin_lock_irq(&clnt->lock);
-	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
-			    GFP_NOWAIT);
-	spin_unlock_irq(&clnt->lock);
-	idr_preload_end();
-	if (!ret) {
-		trace_9p_fid_ref(fid, P9_FID_REF_CREATE);
-		return fid;
-	}
-
-	kfree(fid);
-	return NULL;
-}
-
-static void p9_fid_destroy(struct p9_fid *fid)
-{
-	struct p9_client *clnt;
-	unsigned long flags;
-
-	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
-	trace_9p_fid_ref(fid, P9_FID_REF_DESTROY);
-	clnt = fid->clnt;
-	spin_lock_irqsave(&clnt->lock, flags);
-	idr_remove(&clnt->fids, fid->fid);
-	spin_unlock_irqrestore(&clnt->lock, flags);
-	kfree(fid->rdir);
-	kfree(fid);
-}
-
-/* We also need to export tracepoint symbols for tracepoint_enabled() */
-EXPORT_TRACEPOINT_SYMBOL(9p_fid_ref);
-
-void do_trace_9p_fid_get(struct p9_fid *fid)
-{
-	trace_9p_fid_ref(fid, P9_FID_REF_GET);
-}
-EXPORT_SYMBOL(do_trace_9p_fid_get);
-
-void do_trace_9p_fid_put(struct p9_fid *fid)
-{
-	trace_9p_fid_ref(fid, P9_FID_REF_PUT);
-}
-EXPORT_SYMBOL(do_trace_9p_fid_put);
-
 static int p9_client_version(struct p9_client *c)
 {
 	int err = 0;
-- 
2.39.1

