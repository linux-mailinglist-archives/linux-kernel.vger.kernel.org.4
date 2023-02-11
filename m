Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1892A692F40
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBKHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:51:14 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4984171007
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:51:06 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 023FDC026; Sat, 11 Feb 2023 08:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101886; bh=Awb21O0vXpVV+2crD+UEksVt5c15/VZc1nIv355OlHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9514OBk1mSoo/s8WQMymBl6Xc/ZKaL2FdUfe24zNFVju1sAU+NQA7KTKkWTzD0Sw
         H4HITxIvKHRbesBKUELbh6iNn3pfH0eI9fM1tDt0V+EOGCu5kSkx1IPCNc+T+U6WQF
         2yHc+Kd7+4Y7VWBUtuKSazK2wY/4B+Blo7Nap1xGN6dQbrH4XSx+5JdXhcA+52mCbD
         YQW7AkpMGfjcQBVShK7Zj80j/UFg1oaZrnXWVBMvS8QInk3X4DZIzIxV0zyjfon2+R
         c5C8LeuSghdVumUCbT9wuckwmuuAs28ESKZYtSF5t5BIOxflPHywyESOOlLCLpSe94
         A7DqMZ0E1TiNg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 28B5AC01B;
        Sat, 11 Feb 2023 08:51:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101884; bh=Awb21O0vXpVV+2crD+UEksVt5c15/VZc1nIv355OlHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hBDLiok5J97wnV0H5zWJEcW2GYHKuGikXzDPe/NfEX/AtWDbRLsRn9Xc9jDr9vrt4
         BQg+udlqJgkQxFy0l8P7QpLcx0MjT7bczG3Ol2eUgMFifO4AGSc6pV+kefLATJV4g3
         3wkmNXKzkFZ0EQr4RsSMH/2gBqbCupE5lx3U74JQu85cBwA3Tdcn5wl1fs0Iwq3GqD
         3Ol9ZTUKcvqKu1igt7yP13gk9Nwrz6bcapRQZPCCI+DOaZ9Y9nbExVNqRhaTZGDPO5
         NNW+b+hojqQx0wE7Es5mKWiQDbQ6Juh95RtM9OZAg7bbFnr1jg9BDRzl8HQhtV7TWb
         V64HpXvohmZvg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6c15f3d7;
        Sat, 11 Feb 2023 07:50:47 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 4/5] 9p/net: add async clunk for retries
Date:   Sat, 11 Feb 2023 16:50:22 +0900
Message-Id: <20230211075023.137253-5-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230211075023.137253-1-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clunks in 9p are absolute: once the request is sent to the server,
the local end should consider the fid freed.

Unfortunately our retry logic is hazardous at best, if we got
ERESTARTSYS and we call p9_client_rpc again odds are we'll just
notice the same signal is pending again and fail, leaking the fd.

This used to work, because we never actually got to second retry with
the flush logic, as most servers ignore the flush request and send the
clunk reply first, in which case p9_client_rpc() will return
successfully even if it got interrupted.

Once async flush come into play we will start leaking fids everytime a
task is interrupted, avoid this by resending the flush and handling it
asynchronously.
Note that it's possible that the server got the clunk twice, but it will
be a clunk for a fid that is not used (client controls fid number
allocation), and the async cb does not consider the client return value.

We do not make all clunks asynchronous because some tests failed when
this was tried in [1] ; clunk in 9p should not act like a barrier like
close() does (e.g. flushing contents) but I have no time to debug.
This might still be a problem with the retries, but we are still better
than the current code which gives up and leaks the fid.

What should probably be done next is to make all calls to p9_fid_put
check for errors, at which point the failed clunk can be returned as an
error to userspace which could then notice the error. (Not like most
programs check for close() return value in the first place...)

Link: http://lkml.kernel.org/r/1544532108-21689-2-git-send-email-asmadeus@codewreck.org [1]
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 include/net/9p/client.h |  4 +++
 net/9p/client.c         | 58 ++++++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 348ea191ac66..dd493f7b8059 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -74,6 +74,7 @@ enum p9_req_status_t {
  * @rc: the response fcall structure
  * @req_list: link for transports to chain requests (used by trans_fd)
  * @async_list: link used to check on async requests
+ * @clunked_fid: for clunk, points to fid
  */
 struct p9_req_t {
 	int status;
@@ -84,6 +85,9 @@ struct p9_req_t {
 	struct p9_fcall rc;
 	struct list_head req_list;
 	struct list_head async_list;
+	union {
+		struct p9_fid *clunked_fid;
+	};
 };
 
 /**
diff --git a/net/9p/client.c b/net/9p/client.c
index 3235543c1884..f4b85c33c465 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -509,7 +509,13 @@ static void p9_client_async_cb(struct p9_client *c, struct p9_req_t *req)
 	if (likely(list_empty(&req->async_list)))
 		return;
 
-	WARN(1, "Async request received with tc.id %d\n", req->tc.id);
+	if (req->tc.id == P9_TCLUNK) {
+		p9_debug(P9_DEBUG_MUX, "async destroying fid %d\n",
+			 req->clunked_fid->fid);
+		p9_fid_destroy(req->clunked_fid);
+	} else {
+		WARN(1, "Async request received with tc.id %d\n", req->tc.id);
+	}
 
 	spin_lock_irqsave(&c->async_req_lock, flags);
 	list_del(&req->async_list);
@@ -1497,16 +1503,35 @@ int p9_client_fsync(struct p9_fid *fid, int datasync)
 }
 EXPORT_SYMBOL(p9_client_fsync);
 
+static int p9_client_async_clunk(struct p9_fid *fid)
+{
+	struct p9_client *clnt;
+	struct p9_req_t *req;
+
+	p9_debug(P9_DEBUG_9P, ">>> async TCLUNK fid %d\n", fid->fid);
+	clnt = fid->clnt;
+
+	req = p9_client_async_rpc(clnt, P9_TCLUNK, "d", fid->fid);
+	if (IS_ERR(req)) {
+		/* leak fid until umount... */
+		return PTR_ERR(req);
+	}
+
+	req->clunked_fid = fid;
+	spin_lock_irq(&clnt->lock);
+	list_add(&req->async_list, &clnt->async_req_list);
+	spin_unlock_irq(&clnt->lock);
+
+	return 0;
+}
+
 int p9_client_clunk(struct p9_fid *fid)
 {
 	int err;
 	struct p9_client *clnt;
 	struct p9_req_t *req;
-	int retries = 0;
 
-again:
-	p9_debug(P9_DEBUG_9P, ">>> TCLUNK fid %d (try %d)\n",
-		 fid->fid, retries);
+	p9_debug(P9_DEBUG_9P, ">>> TCLUNK fid %d\n", fid->fid);
 	err = 0;
 	clnt = fid->clnt;
 
@@ -1520,16 +1545,23 @@ int p9_client_clunk(struct p9_fid *fid)
 
 	p9_req_put(clnt, req);
 error:
-	/* Fid is not valid even after a failed clunk
-	 * If interrupted, retry once then give up and
-	 * leak fid until umount.
+	/* Fid is not valid even after a failed clunk, but we do not
+	 * know if we successfully sent the request so send again
+	 * asynchronously ('err' cannot differentiate between:
+	 * failure on the client side before send, interrupted
+	 * before we sent the request, interrupted after we sent
+	 * the request and error from the server)
+	 * In doubt it's better to try to ask again (for the
+	 * 'interrupted before we sent the request' case), other
+	 * patterns will just ignore again.
+	 * Return the original error though.
 	 */
-	if (err == -ERESTARTSYS) {
-		if (retries++ == 0)
-			goto again;
-	} else {
-		p9_fid_destroy(fid);
+	if (err) {
+		p9_client_async_clunk(fid);
+		return err;
 	}
+
+	p9_fid_destroy(fid);
 	return err;
 }
 EXPORT_SYMBOL(p9_client_clunk);
-- 
2.39.1

