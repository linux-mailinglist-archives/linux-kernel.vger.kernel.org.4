Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4C692F3D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBKHvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBKHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:51:12 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25295A9EB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:51:04 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0EBDDC01C; Sat, 11 Feb 2023 08:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101885; bh=1ZCkzS/1FJu9PN2kIb6WCyEHTHdTNKRX/Kb4Z8zBiuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cS2UNnl6FBlB4ONZ/M5zBftk3kPQAv8FWhBmucPwq90iIOevATkm+6VQRzg0uWClF
         JHSxBoM3Y8vCEX4WnsJNudWhFW0xEMDjasnbU0WW1C/wKNQHRAlQR09V2WQPufy+Mj
         Qid4sTB98ohZhbIn3vQkFOh+IiiuNCrA6iMmCpw9x7J7XNmu+tlty0Sa77AYJTky4n
         BVOP2PwaMaaoeaS3J3Wr015Xyugjgd6hS+d5gFZ2k8Ng4xSLHumOn6VoHEY2cDcbP7
         u9NFsGms84TNFwqIoOOF9NVTC5v+Uq5o/TH2yPM2AwFP39HaE+wG1Gkkcal8Cv2ahc
         mKpw6QwwzYQ0g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1DE1DC01A;
        Sat, 11 Feb 2023 08:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101883; bh=1ZCkzS/1FJu9PN2kIb6WCyEHTHdTNKRX/Kb4Z8zBiuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4NQ6MeXwb+i+vda9m4Q9nZoPwdd0RNT2LU5zT2URgRjLPnX9aBfc9Hm3kzd9wAF3
         Fv7MrG6ZSh4ZGjXUtqP9OYbtO9Snyj7zauP5VPtEdnsv0/5uq72JvpUYGF/OsghjMD
         c5XPJKiDY2sfqwf8HKm3OJ7PuU2tomjh+sACG+Gk8TUu5UPMLVbJ2oOakHh6hdujgM
         ZlHJ9gt0VNDEjxnENVwqTD2MFjB2ZlfMPvPOzXIk9vItLemK8g+wF78dF4ukQgZIG9
         LNJNs5SMeQhIKaiBiea55MPHNDGNOx9xWZJkmN1nwBr1feRLngzG32TPyMqW7M/g8U
         pwi7+YwKK73ZA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6d213fc5;
        Sat, 11 Feb 2023 07:50:46 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 3/5] 9p/net: implement asynchronous rpc skeleton
Date:   Sat, 11 Feb 2023 16:50:21 +0900
Message-Id: <20230211075023.137253-4-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230211075023.137253-1-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add p9_client_async_rpc that will let us send an rpc without waiting
for the reply, as well as an async callback hook.

The callback is called, but nothing is ever put in the list at this
point and p9_client_async_rpc() is unused.

Previous version of this patch here[1] used to implement the async check
separately from the callback, but we will want to be notified when flush
has been processed.

Link: http://lkml.kernel.org/r/1544532108-21689-1-git-send-email-asmadeus@codewreck.org (v1)
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 include/net/9p/client.h |  9 ++++-
 net/9p/client.c         | 76 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 78ebcf782ce5..348ea191ac66 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -72,7 +72,8 @@ enum p9_req_status_t {
  * @wq: wait_queue for the client to block on for this request
  * @tc: the request fcall structure
  * @rc: the response fcall structure
- * @req_list: link for higher level objects to chain requests
+ * @req_list: link for transports to chain requests (used by trans_fd)
+ * @async_list: link used to check on async requests
  */
 struct p9_req_t {
 	int status;
@@ -82,6 +83,7 @@ struct p9_req_t {
 	struct p9_fcall tc;
 	struct p9_fcall rc;
 	struct list_head req_list;
+	struct list_head async_list;
 };
 
 /**
@@ -92,6 +94,9 @@ struct p9_req_t {
  * @trans_mod: module API instantiated with this client
  * @status: connection state
  * @trans: tranport instance state and API
+ * @fcall_cache: kmem cache for client request data (msize-specific)
+ * @async_req_lock: protects @async_req_list
+ * @async_req_list: list of requests waiting a reply
  * @fids: All active FID handles
  * @reqs: All active requests.
  * @name: node name used as client id
@@ -107,6 +112,8 @@ struct p9_client {
 	enum p9_trans_status status;
 	void *trans;
 	struct kmem_cache *fcall_cache;
+	spinlock_t async_req_lock;
+	struct list_head async_req_list;
 
 	union {
 		struct {
diff --git a/net/9p/client.c b/net/9p/client.c
index 4e5238db4a7a..3235543c1884 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -311,6 +311,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
 	refcount_set(&req->refcount, 0);
 	init_waitqueue_head(&req->wq);
 	INIT_LIST_HEAD(&req->req_list);
+	INIT_LIST_HEAD(&req->async_list);
 
 	idr_preload(GFP_NOFS);
 	spin_lock_irq(&c->lock);
@@ -495,6 +496,27 @@ void do_trace_9p_fid_put(struct p9_fid *fid)
 }
 EXPORT_SYMBOL(do_trace_9p_fid_put);
 
+/**
+ * p9_client_async_cb -- handle async requests in cb
+ * @c: client state
+ * @req: request received
+ */
+static void p9_client_async_cb(struct p9_client *c, struct p9_req_t *req)
+{
+	unsigned long flags;
+
+	/* Nothing to do for non-async requests */
+	if (likely(list_empty(&req->async_list)))
+		return;
+
+	WARN(1, "Async request received with tc.id %d\n", req->tc.id);
+
+	spin_lock_irqsave(&c->async_req_lock, flags);
+	list_del(&req->async_list);
+	spin_unlock_irqrestore(&c->async_req_lock, flags);
+	p9_tag_remove(c, req);
+}
+
 /**
  * p9_client_cb - call back from transport to client
  * @c: client state
@@ -506,6 +528,8 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 {
 	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc.tag);
 
+	p9_client_async_cb(c, req);
+
 	/* This barrier is needed to make sure any change made to req before
 	 * the status change is visible to another thread
 	 */
@@ -676,6 +700,54 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 	return ERR_PTR(err);
 }
 
+static struct p9_req_t *
+p9_client_async_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
+{
+	va_list ap;
+	int err;
+	struct p9_req_t *req;
+
+	va_start(ap, fmt);
+	/* auto determine an appropriate request/response size */
+	req = p9_client_prepare_req(c, type, 0, 0, fmt, ap);
+	va_end(ap);
+	if (IS_ERR(req))
+		return req;
+
+	err = c->trans_mod->request(c, req);
+	if (err < 0) {
+		/* bail out without flushing... */
+		p9_req_put(c, req);
+		p9_tag_remove(c, req);
+		if (err != -ERESTARTSYS && err != -EFAULT)
+			c->status = Disconnected;
+		return ERR_PTR(safe_errno(err));
+	}
+
+	return req;
+}
+
+static void p9_client_cleanup_async(struct p9_client *c)
+{
+	struct p9_req_t *req, *nreq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->async_req_lock, flags);
+	list_for_each_entry_safe(req, nreq, &c->async_req_list, async_list) {
+		if (req->status < REQ_STATUS_RCVD) {
+			p9_debug(P9_DEBUG_ERROR,
+				 "final async handler found req tag %d type %d status %d\n",
+				 req->tc.tag, req->tc.id, req->status);
+			if (c->trans_mod->cancelled)
+				c->trans_mod->cancelled(c, req);
+			/* won't receive reply now */
+			p9_req_put(c, req);
+		}
+		p9_client_async_cb(c, req);
+	}
+	spin_unlock_irqrestore(&c->async_req_lock, flags);
+}
+
 static struct p9_req_t *
 p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 
@@ -983,6 +1055,8 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	memcpy(clnt->name, client_id, strlen(client_id) + 1);
 
 	spin_lock_init(&clnt->lock);
+	spin_lock_init(&clnt->async_req_lock);
+	INIT_LIST_HEAD(&clnt->async_req_list);
 	idr_init(&clnt->fids);
 	idr_init(&clnt->reqs);
 
@@ -1059,6 +1133,8 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	v9fs_put_trans(clnt->trans_mod);
 
+	p9_client_cleanup_async(clnt);
+
 	idr_for_each_entry(&clnt->fids, fid, id) {
 		pr_info("Found fid %d not clunked\n", fid->fid);
 		p9_fid_destroy(fid);
-- 
2.39.1

