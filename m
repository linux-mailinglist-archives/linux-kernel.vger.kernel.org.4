Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83B9692F42
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBKHv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBKHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:51:26 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897A63580
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:51:11 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E0ECDC01E; Sat, 11 Feb 2023 08:51:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101891; bh=+UMZTOAl7PgxJc9ldQNYn/dq+/3fCg8KJj367+x2Kwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxOxIb8aRgK+IGt78uvFeRBgpnkMSw8q45yU5jfU1XFMhVJhfzYAVv7DZ3kIe0KvQ
         y7cCs+/oRhYwmRtembKTO5WO6Ld6lPcZHTFkXvjQHPhQtScliBixXTemD1ff+/e+dr
         RD/Aqu8tybfQKiE7AwLQkeQbYi8TN7UdNFu2wWOCJKRA1ONF5saewdGkF95ohzuGD9
         QlaG690CYbdQYvIRmNEFWyjdAPRncMyebK2GYS0CGMG9ABwHJnsbFUzm22/PILkAot
         MGh1Aj0qhoDhSi8y46DhXix3Jg3QaMctPhu3GudE6a92qiE+ysPZrNO4xLvw2lcBJR
         WmGIymSR33fjw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D3AF0C01F;
        Sat, 11 Feb 2023 08:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101889; bh=+UMZTOAl7PgxJc9ldQNYn/dq+/3fCg8KJj367+x2Kwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tklAVM4XKDVG4gf899kWFcDDQu+r2Ed5oKmTpMSTD0ICtrSkdi4zblHJ4Qw2f3YRC
         4dZiqJHetIIejJy4yLudKlSRtS0bxw2pmmSqP9RrtMbvg5NU4csfYFPTWGApu2/RvO
         HXx9s7tn8bkiI4W4NmdAY7xi2rXPuK6LL9WkeY6bucfqJ5+FFnV3QB8YxSPdjN4VWr
         RO0o5PHuulAsp4Jvz15qhBnqXz7Si29CdfRCa3Z0V61IS5rmo1n0O+azVq37/ZHXmt
         RlEagldeYqgd1MVQfrepN5LKmWnNSUazRSBMWZKRxU9SyFm71xH+YXfVn60sRmUTc5
         uzXSn9qqquVaA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 53778030;
        Sat, 11 Feb 2023 07:50:48 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 5/5] 9p/net: make flush asynchronous
Date:   Sat, 11 Feb 2023 16:50:23 +0900
Message-Id: <20230211075023.137253-6-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230211075023.137253-1-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the client flush asynchronous so we don't need to ignore signals in
rpc functions:
 - on signal, send a flush request as we previously did but use the new
asynchronous helper and return immediately
 - when the reply has been received or connection is destroyed, free
both tags in the handler

Since the 9p client has no way of knowing if a request has been replayed
after flush, we also need to wait for all flush to have been processed
in order to avoid the following example scenario:
1. Send write#1 [0; 1MB[
2. Receive signal and interrupt the write, code sends flush and return
3. Resend write as write#2 [0; 1MB[
4. write#2 is handled
5. Send write#3 [1MB-4k; 1MB[
6. write#3 is handled
7. write#1 is handled and write#3's content overwritten
(flush is later ack'd)

In practice, all transports use a connection-oriented pipe (e.g.
messages are received in order), so requests are guaranteed to be
received by the server in the order they were sent; but the server has
no way of knowing that the second write is a replay of the first and
could be dispatched to another thread leading to such scenario.

This means the connection is effectively put on hold after any flush has
been sent, but hopefully flush are rare enough to not make a difference
in normal workloads.

Not looping forever in p9_client_rpc and its zc counterpart has been
a goal for a long time, but will also in particular fix a new hang with
the TWA_SIGNAL based task_work as reported by Pengfei Xu and Jens Axboe
recently.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Reported-by: Jens Axboe <axboe@kernel.dk>
Link: http://lkml.kernel.org/r/1544532108-21689-3-git-send-email-asmadeus@codewreck.org (v1)
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 include/net/9p/client.h |   2 +
 net/9p/client.c         | 187 ++++++++++++++++++++++++----------------
 2 files changed, 113 insertions(+), 76 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index dd493f7b8059..9eec67108096 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -75,6 +75,7 @@ enum p9_req_status_t {
  * @req_list: link for transports to chain requests (used by trans_fd)
  * @async_list: link used to check on async requests
  * @clunked_fid: for clunk, points to fid
+ * @flushed_req: for flush, points to matching flushed req
  */
 struct p9_req_t {
 	int status;
@@ -87,6 +88,7 @@ struct p9_req_t {
 	struct list_head async_list;
 	union {
 		struct p9_fid *clunked_fid;
+		struct p9_req_t *flushed_req;
 	};
 };
 
diff --git a/net/9p/client.c b/net/9p/client.c
index f4b85c33c465..4c328021dc98 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -503,6 +503,8 @@ EXPORT_SYMBOL(do_trace_9p_fid_put);
  */
 static void p9_client_async_cb(struct p9_client *c, struct p9_req_t *req)
 {
+	/* extra req to put e.g. flush target */
+	struct p9_req_t *extra_req = NULL;
 	unsigned long flags;
 
 	/* Nothing to do for non-async requests */
@@ -513,14 +515,31 @@ static void p9_client_async_cb(struct p9_client *c, struct p9_req_t *req)
 		p9_debug(P9_DEBUG_MUX, "async destroying fid %d\n",
 			 req->clunked_fid->fid);
 		p9_fid_destroy(req->clunked_fid);
+	} else if (req->tc.id == P9_TFLUSH) {
+		p9_debug(P9_DEBUG_MUX,
+			 "flushing oldreq tag %d status %d, flush_req tag %d\n",
+			 req->flushed_req->tc.tag,
+			 req->flushed_req->status,
+			 req->tc.tag);
+		if (req->flushed_req->status < REQ_STATUS_RCVD) {
+			/* won't receive reply now */
+			if (c->trans_mod->cancelled)
+				c->trans_mod->cancelled(c, req);
+			wake_up_all(&req->flushed_req->wq);
+			p9_req_put(c, req->flushed_req);
+		}
+		extra_req = req->flushed_req;
 	} else {
 		WARN(1, "Async request received with tc.id %d\n", req->tc.id);
 	}
-
+	/* Put old refs whatever reqs actually returned */
 	spin_lock_irqsave(&c->async_req_lock, flags);
 	list_del(&req->async_list);
 	spin_unlock_irqrestore(&c->async_req_lock, flags);
 	p9_tag_remove(c, req);
+
+	if (extra_req)
+		p9_req_put(c, extra_req);
 }
 
 /**
@@ -542,7 +561,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 	smp_wmb();
 	WRITE_ONCE(req->status, status);
 
-	wake_up(&req->wq);
+	wake_up_all(&req->wq);
 	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
 	p9_req_put(c, req);
 }
@@ -754,9 +773,6 @@ static void p9_client_cleanup_async(struct p9_client *c)
 	spin_unlock_irqrestore(&c->async_req_lock, flags);
 }
 
-static struct p9_req_t *
-p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
-
 /**
  * p9_client_flush - flush (cancel) a request
  * @c: client state
@@ -772,28 +788,68 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
 static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
 {
 	struct p9_req_t *req;
-	s16 oldtag;
-	int err;
-
-	err = p9_parse_header(&oldreq->tc, NULL, NULL, &oldtag, 1);
-	if (err)
-		return err;
+	s16 oldtag = oldreq->tc.tag;
 
 	p9_debug(P9_DEBUG_9P, ">>> TFLUSH tag %d\n", oldtag);
-
-	req = p9_client_rpc(c, P9_TFLUSH, "w", oldtag);
+	req = p9_client_async_rpc(c, P9_TFLUSH, "w", oldtag);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	/* if we haven't received a response for oldreq,
-	 * remove it from the list
-	 */
-	if (READ_ONCE(oldreq->status) == REQ_STATUS_SENT) {
-		if (c->trans_mod->cancelled)
-			c->trans_mod->cancelled(c, oldreq);
-	}
+	p9_debug(P9_DEBUG_MUX, "sent flush for oldreq %d type %d with flush tag %d\n",
+		 oldtag, oldreq->tc.id, req->tc.tag);
+	req->flushed_req = oldreq;
+	spin_lock_irq(&c->lock);
+	list_add(&req->async_list, &c->async_req_list);
+	spin_unlock_irq(&c->lock);
 
-	p9_req_put(c, req);
+	return 0;
+}
+
+/**
+ * p9_client_wait_flush - wait for any in flight flush
+ * @c: client state
+ *
+ * Since we cannot know if a request is a replay for a request that was
+ * previous flushed, we need to wait for all in flight flush to send
+ * new requests to avoid racing with a previously cancelled flush.
+ */
+
+static int p9_client_wait_flush(struct p9_client *c)
+{
+	struct p9_req_t *req;
+	unsigned long flags;
+	int err;
+
+	/* As an optimization check if list is empty without lock first;
+	 * that should be the case most of the time, and if we see it
+	 * as empty we are not a thread that recently issued a flush
+	 */
+	if (list_empty(&c->async_req_list))
+		return 0;
+
+again:
+	spin_lock_irqsave(&c->async_req_lock, flags);
+	list_for_each_entry(req, &c->async_req_list, async_list) {
+		/* received request will be deleted shortly and can be ignored */
+		if (req->status >= REQ_STATUS_RCVD)
+			continue;
+
+		if (req->tc.id == P9_TFLUSH) {
+			/* also ok if its target has been ack'd */
+			if (req->flushed_req->status >= REQ_STATUS_RCVD)
+				continue;
+			/* take ref on flushed req, drop lock and wait for it... */
+			p9_req_get(req->flushed_req);
+			spin_unlock_irqrestore(&c->async_req_lock, flags);
+			err = wait_event_interruptible(req->flushed_req->wq,
+						       READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+			p9_req_put(c, req->flushed_req);
+			if (err < 0)
+				return err;
+			goto again;
+		}
+	}
+	spin_unlock_irqrestore(&c->async_req_lock, flags);
 	return 0;
 }
 
@@ -810,8 +866,8 @@ static struct p9_req_t *
 p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 {
 	va_list ap;
-	int sigpending, err;
-	unsigned long flags;
+	int err;
+	int flushing = 0;
 	struct p9_req_t *req;
 
 	va_start(ap, fmt);
@@ -825,21 +881,21 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	req->rc.zc = false;
 
 	if (signal_pending(current)) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-	} else {
-		sigpending = 0;
+		err = -ERESTARTSYS;
+		goto not_sent;
 	}
 
+	err = p9_client_wait_flush(c);
+	if (err < 0)
+		goto not_sent;
+
 	err = c->trans_mod->request(c, req);
 	if (err < 0) {
-		/* write won't happen */
-		p9_req_put(c, req);
 		if (err != -ERESTARTSYS && err != -EFAULT)
 			c->status = Disconnected;
-		goto recalc_sigpending;
+		goto not_sent;
 	}
-again:
+
 	/* Wait for the response */
 	err = wait_event_killable(req->wq,
 				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
@@ -849,34 +905,15 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	 */
 	smp_rmb();
 
-	if (err == -ERESTARTSYS && c->status == Connected &&
-	    type == P9_TFLUSH) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-		goto again;
-	}
-
-	if (READ_ONCE(req->status) == REQ_STATUS_ERROR) {
+	if (req->status == REQ_STATUS_ERROR) {
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
 		err = req->t_err;
 	}
 	if (err == -ERESTARTSYS && c->status == Connected) {
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
 
-		if (c->trans_mod->cancel(c, req))
-			p9_client_flush(c, req);
-
-		/* if we received the response anyway, don't signal error */
-		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
-			err = 0;
-	}
-recalc_sigpending:
-	if (sigpending) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		if (c->trans_mod->cancel(c, req) && !p9_client_flush(c, req))
+				flushing = 1;
 	}
 	if (err < 0)
 		goto reterr;
@@ -885,8 +922,12 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	trace_9p_client_res(c, type, req->rc.tag, err);
 	if (!err)
 		return req;
-reterr:
+	goto reterr;
+not_sent:
 	p9_req_put(c, req);
+reterr:
+	if (!flushing)
+		p9_req_put(c, req);
 	return ERR_PTR(safe_errno(err));
 }
 
@@ -910,8 +951,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 					 const char *fmt, ...)
 {
 	va_list ap;
-	int sigpending, err;
-	unsigned long flags;
+	int err;
+	int flushing = 0;
 	struct p9_req_t *req;
 
 	va_start(ap, fmt);
@@ -927,19 +968,21 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	req->rc.zc = true;
 
 	if (signal_pending(current)) {
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
-	} else {
-		sigpending = 0;
+		err = -ERESTARTSYS;
+		goto not_sent;
 	}
 
+	err = p9_client_wait_flush(c);
+	if (err < 0)
+		goto not_sent;
+
 	err = c->trans_mod->zc_request(c, req, uidata, uodata,
 				       inlen, olen, in_hdrlen);
 	if (err < 0) {
 		if (err == -EIO)
 			c->status = Disconnected;
 		if (err != -ERESTARTSYS)
-			goto recalc_sigpending;
+			goto not_sent;
 	}
 	if (READ_ONCE(req->status) == REQ_STATUS_ERROR) {
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
@@ -947,21 +990,9 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	}
 	if (err == -ERESTARTSYS && c->status == Connected) {
 		p9_debug(P9_DEBUG_MUX, "flushing\n");
-		sigpending = 1;
-		clear_thread_flag(TIF_SIGPENDING);
 
-		if (c->trans_mod->cancel(c, req))
-			p9_client_flush(c, req);
-
-		/* if we received the response anyway, don't signal error */
-		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
-			err = 0;
-	}
-recalc_sigpending:
-	if (sigpending) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		if (c->trans_mod->cancel(c, req) && !p9_client_flush(c, req))
+			flushing = 1;
 	}
 	if (err < 0)
 		goto reterr;
@@ -970,8 +1001,12 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 	trace_9p_client_res(c, type, req->rc.tag, err);
 	if (!err)
 		return req;
-reterr:
+	goto reterr;
+not_sent:
 	p9_req_put(c, req);
+reterr:
+	if (!flushing)
+		p9_req_put(c, req);
 	return ERR_PTR(safe_errno(err));
 }
 
-- 
2.39.1

