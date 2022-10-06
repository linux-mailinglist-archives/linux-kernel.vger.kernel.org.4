Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0E85F679F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJFNRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJFNR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:17:26 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953BA9260
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=8T2sFVcyf0kuqa8Hcqks7UqJO8ynKlOIJSB8sPGVj5E=; b=RjZOS2m9aaIZKYJtK4OLvKk2yG
        efbClYQBz3qcI6Zkwn+exlZBqr4DRAsW64VVvZwCguJG4YNG7ACGqzHrnF5BYRxvs5+a7LYIGKUDm
        dHCY6BQHyF2QXGtmKZU3JgAvxonLu32KLXJCrdl002eYQdylFApe31CJQXdhpl2NlzPzaW7nMOjFZ
        a1LzUChIysxuApOVqHdEQWp84oNDwlI4u7mRZP4lg036gdoY0jSdNyUMTOFVwqAtkNXpOLvMBhj8E
        pPiCqf3WdMmvfS18c7UlS2qZq6eJc04FmwqpeZz0QpsQ8yfVr1obfwaA6Q1417T0bOHz/84DhiMHy
        R8vesyTbuanSZLLVGt7EVx6/75J05vs3d+uVI707DXxudMQuQ5y83PO5pn+3JaB2cI3QxHP9/aueu
        0c62iBtngpUyo+pzdCYSHXGykgknplnCdYKpoUKQz5LvhHUzD126sFO3oboeUQ2OMChuLVpOX6NJV
        z6JsyrYIgAZqCKIQPbKKRDkETX17Nzdig3uCcrLLOwWYgwWcLQoP+TJ/zcXJfImTsdphdkBw1m4pW
        TowYyAZGSArJ0NrAkKbpIbdoj/uA+5jq/spNvNj9c4xNPcaeJ+zPCkkKPdF+hVOfwT9Y1yrObRtzg
        4j8UcrxNbpFuk5SuUfckUk3KAhHprahGc02zc3YA8=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot <syzbot+2f20b523930c32c160cc@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/9p: use a dedicated spinlock for trans_fd
Date:   Thu, 06 Oct 2022 15:16:40 +0200
Message-ID: <2356596.7K3kzkM6Yp@silver>
In-Reply-To: <20220904112928.1308799-1-asmadeus@codewreck.org>
References: <2470e028-9b05-2013-7198-1fdad071d999@I-love.SAKURA.ne.jp>
 <20220904112928.1308799-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 4. September 2022 13:29:28 CEST Dominique Martinet wrote:
> Shamelessly copying the explanation from Tetsuo Handa's suggested
> patch[1] (slightly reworded):
> syzbot is reporting inconsistent lock state in p9_req_put()[2],
> for p9_tag_remove() from p9_req_put() from IRQ context is using
> spin_lock_irqsave() on "struct p9_client"->lock but trans_fd
> (not from IRQ context) is using spin_lock().
> 
> Since the locks actually protect different things in client.c and in
> trans_fd.c, just replace trans_fd.c's lock by a new one specific to the
> transport instead of using spin_lock_irq* variants everywhere
> (client.c's protect the idr for tag allocations, while
> trans_fd.c's protects its own req list and request status field
> that acts as the transport's state machine)
> 
> Link:
> https://lkml.kernel.org/r/2470e028-9b05-2013-7198-1fdad071d999@I-love.SAKUR
> A.ne.jp [1] Link:
> https://syzkaller.appspot.com/bug?extid=2f20b523930c32c160cc [2]
> Reported-by: syzbot <syzbot+2f20b523930c32c160cc@syzkaller.appspotmail.com>
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> Tetsuo Handa-san, thank you very much!
> I'm sorry for not respecting your opinion but it's been a pleasure to
> have submissions from someone on JST :)
> 
> Both this and your previous patch only impact trans_fd which I can't
> test super easily, so while I've sent the patch here I'll only queue it
> to -next hopefully next week after I've had time to setup a compatible
> server again...
> 
>  net/9p/trans_fd.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>

Late on the party, sorry. Note that you already queued a slightly different 
version than this patch here, anyway, one thing ...

> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index ef5760971f1e..5b4807411281 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -91,6 +91,7 @@ struct p9_poll_wait {
>   * @mux_list: list link for mux to manage multiple connections (?)
>   * @client: reference to client instance for this connection
>   * @err: error state
> + * @req_lock: lock protecting req_list and requests statuses
>   * @req_list: accounting for requests which have been sent
>   * @unsent_req_list: accounting for requests that haven't been sent
>   * @rreq: read request
> @@ -114,6 +115,7 @@ struct p9_conn {
>  	struct list_head mux_list;
>  	struct p9_client *client;
>  	int err;
> +	spinlock_t req_lock;
>  	struct list_head req_list;
>  	struct list_head unsent_req_list;
>  	struct p9_req_t *rreq;
> @@ -189,10 +191,10 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
> 
>  	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);
> 
> -	spin_lock(&m->client->lock);
> +	spin_lock(&m->req_lock);
> 
>  	if (m->err) {
> -		spin_unlock(&m->client->lock);
> +		spin_unlock(&m->req_lock);
>  		return;
>  	}
> 
> @@ -205,7 +207,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>  		list_move(&req->req_list, &cancel_list);
>  	}
> 
> -	spin_unlock(&m->client->lock);
> +	spin_unlock(&m->req_lock);
> 
>  	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
>  		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
> @@ -360,7 +362,7 @@ static void p9_read_work(struct work_struct *work)
>  	if ((m->rreq) && (m->rc.offset == m->rc.capacity)) {
>  		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
>  		m->rreq->rc.size = m->rc.offset;
> -		spin_lock(&m->client->lock);
> +		spin_lock(&m->req_lock);
>  		if (m->rreq->status == REQ_STATUS_SENT) {
>  			list_del(&m->rreq->req_list);
>  			p9_client_cb(m->client, m->rreq, 
REQ_STATUS_RCVD);
> @@ -369,14 +371,14 @@ static void p9_read_work(struct work_struct *work)
>  			p9_debug(P9_DEBUG_TRANS,
>  				 "Ignore replies associated with a 
cancelled request\n");
>  		} else {
> -			spin_unlock(&m->client->lock);
> +			spin_unlock(&m->req_lock);
>  			p9_debug(P9_DEBUG_ERROR,
>  				 "Request tag %d errored out while we 
were reading the reply\n",
>  				 m->rc.tag);
>  			err = -EIO;
>  			goto error;
>  		}
> -		spin_unlock(&m->client->lock);
> +		spin_unlock(&m->req_lock);
>  		m->rc.sdata = NULL;
>  		m->rc.offset = 0;
>  		m->rc.capacity = 0;
> @@ -454,10 +456,10 @@ static void p9_write_work(struct work_struct *work)
>  	}
> 
>  	if (!m->wsize) {
> -		spin_lock(&m->client->lock);
> +		spin_lock(&m->req_lock);
>  		if (list_empty(&m->unsent_req_list)) {
>  			clear_bit(Wworksched, &m->wsched);
> -			spin_unlock(&m->client->lock);
> +			spin_unlock(&m->req_lock);
>  			return;
>  		}
> 
> @@ -472,7 +474,7 @@ static void p9_write_work(struct work_struct *work)
>  		m->wpos = 0;
>  		p9_req_get(req);
>  		m->wreq = req;
> -		spin_unlock(&m->client->lock);
> +		spin_unlock(&m->req_lock);
>  	}
> 
>  	p9_debug(P9_DEBUG_TRANS, "mux %p pos %d size %d\n",
> @@ -670,10 +672,10 @@ static int p9_fd_request(struct p9_client *client,
> struct p9_req_t *req) if (m->err < 0)
>  		return m->err;
> 
> -	spin_lock(&client->lock);
> +	spin_lock(&m->req_lock);
>  	req->status = REQ_STATUS_UNSENT;
>  	list_add_tail(&req->req_list, &m->unsent_req_list);
> -	spin_unlock(&client->lock);
> +	spin_unlock(&m->req_lock);
> 
>  	if (test_and_clear_bit(Wpending, &m->wsched))
>  		n = EPOLLOUT;
> @@ -688,11 +690,13 @@ static int p9_fd_request(struct p9_client *client,
> struct p9_req_t *req)
> 
>  static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
>  {
> +	struct p9_trans_fd *ts = client->trans;
> +	struct p9_conn *m = &ts->conn;
>  	int ret = 1;
> 
>  	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
> 
> -	spin_lock(&client->lock);
> +	spin_lock(&m->req_lock);
> 
>  	if (req->status == REQ_STATUS_UNSENT) {
>  		list_del(&req->req_list);
> @@ -700,21 +704,24 @@ static int p9_fd_cancel(struct p9_client *client,
> struct p9_req_t *req) p9_req_put(client, req);
>  		ret = 0;
>  	}
> -	spin_unlock(&client->lock);
> +	spin_unlock(&m->req_lock);
> 
>  	return ret;
>  }
> 
>  static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
>  {
> +	struct p9_trans_fd *ts = client->trans;
> +	struct p9_conn *m = &ts->conn;
> +
>  	p9_debug(P9_DEBUG_TRANS, "client %p req %p\n", client, req);
> 
> -	spin_lock(&client->lock);
> +	spin_lock(&m->req_lock);
>  	/* Ignore cancelled request if message has been received
>  	 * before lock.
>  	 */
>  	if (req->status == REQ_STATUS_RCVD) {
> -		spin_unlock(&client->lock);
> +		spin_unlock(&m->req_lock);
>  		return 0;
>  	}
> 
> @@ -723,7 +730,8 @@ static int p9_fd_cancelled(struct p9_client *client,
> struct p9_req_t *req) */
>  	list_del(&req->req_list);
>  	req->status = REQ_STATUS_FLSHD;
> -	spin_unlock(&client->lock);
> +	spin_unlock(&m->req_lock);
> +
>  	p9_req_put(client, req);
> 
>  	return 0;
> @@ -832,6 +840,7 @@ static int p9_fd_open(struct p9_client *client, int rfd,
> int wfd)
> 
>  	client->trans = ts;
>  	client->status = Connected;
> +	spin_lock_init(&ts->conn.req_lock);

Are you sure this is the right place for spin_lock_init()? Not rather in 
p9_conn_create()?

>  	return 0;
> 
> @@ -866,6 +875,7 @@ static int p9_socket_open(struct p9_client *client,
> struct socket *csocket) p->wr = p->rd = file;
>  	client->trans = p;
>  	client->status = Connected;
> +	spin_lock_init(&p->conn.req_lock);

Same here.

> 
>  	p->rd->f_flags |= O_NONBLOCK;

The rest LGTM.

Best regards,
Christian Schoenebeck


