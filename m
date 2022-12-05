Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B36428C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiLEMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLEMuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:50:09 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B51B7A1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:50:07 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 01B7EC01E; Mon,  5 Dec 2022 13:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670244615; bh=QAarV8Ja9R/8Y4UMPRKfOUajmT0qSFp0zvjj/2ewzDY=;
        h=From:To:Cc:Subject:Date:From;
        b=l0pyG+G6mPtydrgguovt+XvYIS2ryFWGegR3HOuALxFQ6dPcHl+a0g1Qp8BSLk9H3
         f4kDVItmFEXOZsTJizEQ5So8bEU1KWcZ3YyegRrRCXhCpQZYai+GuwKFAf7F3V3QKn
         wO1NNjzPAaSmekScHTAInWiFHWHMc9kQCUjL1Bn33CKQUZlJDFHZgHAn5MBNhKSSkm
         TreWgu5r4gYcB6WNCcJCOpYr9lsL0FE09jqgaLBEaYZU9QUswSjxuR2rVZ25WidFVj
         iBPcKYI/DRzxSFSrs64ScCHtjko3lOSTxr+/lfee2vAlPEamfDE5UYNHqiR3SQlWPo
         rhuj/umhLWFNw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 92A6AC009;
        Mon,  5 Dec 2022 13:50:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670244612; bh=QAarV8Ja9R/8Y4UMPRKfOUajmT0qSFp0zvjj/2ewzDY=;
        h=From:To:Cc:Subject:Date:From;
        b=fQtfg3kVsl0stuZeDf9FXvXNFqKzaEwDb4f0fCssgVSR0lAd72E/qvJKh8b3z1fak
         NBmw66VfeWBc2jMg3CFrK7t6PjVDMbTkjF4w8ngiYf4/6G8jhr19BxAZanRGurXq54
         aJvoe4s5BmPacYlhts4om4CnElAbChxNmMA5Xd3XRUJTVSsSFVtRmFzksasCvSD/9+
         vYIRuvXctD5++EZ8o7d8a8oQqEA4S5Fg3uFvEwQJhDyF3RQ05ZL88D3cOF2EM3HGsq
         ljoPxbmsnmzOaNBx+9Y8IRLEsaX/lRroLQTp+hvrQ0x2DoD+jmF/oIiXAQ9Rf6baxZ
         cLlhRK8UpUx2g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id d7825266;
        Mon, 5 Dec 2022 12:49:58 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Marco Elver <elver@google.com>
Subject: [PATCH] 9p/client: fix data race on req->status
Date:   Mon,  5 Dec 2022 21:47:56 +0900
Message-Id: <20221205124756.426350-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN reported a race between writing req->status in p9_client_cb and
accessing it in p9_client_rpc's wait_event.

Accesses to req itself is protected by the data barrier (writing req
fields, write barrier, writing status // reading status, read barrier,
reading other req fields), but status accesses themselves apparently
also must be annotated properly with WRITE_ONCE/READ_ONCE when we
access it without locks.

Follows:
 - error paths writing status in various threads all can notify
p9_client_rpc, so these all also need WRITE_ONCE
 - there's a similar read loop in trans_virtio for zc case that also
needs READ_ONCE
 - other reads in trans_fd should be protected by the trans_fd lock and
lists state machine, as corresponding writers all are within trans_fd
and should be under the same lock. If KCSAN complains on them we likely
will have something else to fix as well, so it's better to leave them
unmarked and look again if required.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c       | 15 ++++++++-------
 net/9p/trans_fd.c     | 12 ++++++------
 net/9p/trans_rdma.c   |  4 ++--
 net/9p/trans_virtio.c |  9 +++++----
 net/9p/trans_xen.c    |  4 ++--
 5 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index b554f8357f96..b5aa25f82b78 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -443,7 +443,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 	 * the status change is visible to another thread
 	 */
 	smp_wmb();
-	req->status = status;
+	WRITE_ONCE(req->status, status);
 
 	wake_up(&req->wq);
 	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
@@ -605,7 +605,7 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
 	/* if we haven't received a response for oldreq,
 	 * remove it from the list
 	 */
-	if (oldreq->status == REQ_STATUS_SENT) {
+	if (READ_ONCE(oldreq->status) == REQ_STATUS_SENT) {
 		if (c->trans_mod->cancelled)
 			c->trans_mod->cancelled(c, oldreq);
 	}
@@ -702,7 +702,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(req->wq,
+				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 
 	/* Make sure our req is coherent with regard to updates in other
 	 * threads - echoes to wmb() in the callback
@@ -716,7 +717,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 		goto again;
 	}
 
-	if (req->status == REQ_STATUS_ERROR) {
+	if (READ_ONCE(req->status) == REQ_STATUS_ERROR) {
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
 		err = req->t_err;
 	}
@@ -729,7 +730,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 			p9_client_flush(c, req);
 
 		/* if we received the response anyway, don't signal error */
-		if (req->status == REQ_STATUS_RCVD)
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
 			err = 0;
 	}
 recalc_sigpending:
@@ -798,7 +799,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 		if (err != -ERESTARTSYS)
 			goto recalc_sigpending;
 	}
-	if (req->status == REQ_STATUS_ERROR) {
+	if (READ_ONCE(req->status) == REQ_STATUS_ERROR) {
 		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
 		err = req->t_err;
 	}
@@ -811,7 +812,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 			p9_client_flush(c, req);
 
 		/* if we received the response anyway, don't signal error */
-		if (req->status == REQ_STATUS_RCVD)
+		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
 			err = 0;
 	}
 recalc_sigpending:
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 06ec9f7d3318..f8899745571c 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -201,11 +201,11 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 
 	list_for_each_entry_safe(req, rtmp, &m->req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
-		req->status = REQ_STATUS_ERROR;
+		WRITE_ONCE(req->status, REQ_STATUS_ERROR);
 	}
 	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
-		req->status = REQ_STATUS_ERROR;
+		WRITE_ONCE(req->status, REQ_STATUS_ERROR);
 	}
 
 	spin_unlock(&m->req_lock);
@@ -466,7 +466,7 @@ static void p9_write_work(struct work_struct *work)
 
 		req = list_entry(m->unsent_req_list.next, struct p9_req_t,
 			       req_list);
-		req->status = REQ_STATUS_SENT;
+		WRITE_ONCE(req->status, REQ_STATUS_SENT);
 		p9_debug(P9_DEBUG_TRANS, "move req %p\n", req);
 		list_move_tail(&req->req_list, &m->req_list);
 
@@ -675,7 +675,7 @@ static int p9_fd_request(struct p9_client *client, struct p9_req_t *req)
 		return m->err;
 
 	spin_lock(&m->req_lock);
-	req->status = REQ_STATUS_UNSENT;
+	WRITE_ONCE(req->status, REQ_STATUS_UNSENT);
 	list_add_tail(&req->req_list, &m->unsent_req_list);
 	spin_unlock(&m->req_lock);
 
@@ -702,7 +702,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
 
 	if (req->status == REQ_STATUS_UNSENT) {
 		list_del(&req->req_list);
-		req->status = REQ_STATUS_FLSHD;
+		WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
 		p9_req_put(client, req);
 		ret = 0;
 	}
@@ -731,7 +731,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 	 * remove it from the list.
 	 */
 	list_del(&req->req_list);
-	req->status = REQ_STATUS_FLSHD;
+	WRITE_ONCE(req->status, REQ_STATUS_FLSHD);
 	spin_unlock(&m->req_lock);
 
 	p9_req_put(client, req);
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 33a9ac6f2d55..83f9100d46bf 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -506,7 +506,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 	 * because doing if after could erase the REQ_STATUS_RCVD
 	 * status in case of a very fast reply.
 	 */
-	req->status = REQ_STATUS_SENT;
+	WRITE_ONCE(req->status, REQ_STATUS_SENT);
 	err = ib_post_send(rdma->qp, &wr, NULL);
 	if (err)
 		goto send_error;
@@ -516,7 +516,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 
  /* Handle errors that happened during or while preparing the send: */
  send_error:
-	req->status = REQ_STATUS_ERROR;
+	WRITE_ONCE(req->status, REQ_STATUS_ERROR);
 	kfree(c);
 	p9_debug(P9_DEBUG_ERROR, "Error %d in rdma_request()\n", err);
 
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 19bccfa0d593..3c27ffb781e3 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -262,7 +262,7 @@ p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 
 	p9_debug(P9_DEBUG_TRANS, "9p debug: virtio request\n");
 
-	req->status = REQ_STATUS_SENT;
+	WRITE_ONCE(req->status, REQ_STATUS_SENT);
 req_retry:
 	spin_lock_irqsave(&chan->lock, flags);
 
@@ -468,7 +468,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 			inlen = n;
 		}
 	}
-	req->status = REQ_STATUS_SENT;
+	WRITE_ONCE(req->status, REQ_STATUS_SENT);
 req_retry_pinned:
 	spin_lock_irqsave(&chan->lock, flags);
 
@@ -531,9 +531,10 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	kicked = 1;
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
-	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(req->wq,
+			          READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 	// RERROR needs reply (== error string) in static data
-	if (req->status == REQ_STATUS_RCVD &&
+	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
 	    unlikely(req->rc.sdata[4] == P9_RERROR))
 		handle_rerror(req, in_hdr_len, offs, in_pages);
 
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index aaa5fd364691..cf1b89ba522b 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -157,7 +157,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 			      &masked_prod, masked_cons,
 			      XEN_9PFS_RING_SIZE(ring));
 
-	p9_req->status = REQ_STATUS_SENT;
+	WRITE_ONCE(p9_req->status, REQ_STATUS_SENT);
 	virt_wmb();			/* write ring before updating pointer */
 	prod += size;
 	ring->intf->out_prod = prod;
@@ -212,7 +212,7 @@ static void p9_xen_response(struct work_struct *work)
 			dev_warn(&priv->dev->dev,
 				 "requested packet size too big: %d for tag %d with capacity %zd\n",
 				 h.size, h.tag, req->rc.capacity);
-			req->status = REQ_STATUS_ERROR;
+			WRITE_ONCE(req->status, REQ_STATUS_ERROR);
 			goto recv_error;
 		}
 
-- 
2.38.1

