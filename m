Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBE25F7640
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJGJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJGJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:29:24 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF3BB56DF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=C+D7+hOHycfn5UGsK+QEShGplvumi31tH2Ocmf5n6Pw=; b=FOvMLnKHYlt9J3Ks99lXraJuMl
        CP1pYk5jOXnhZUcsxg4LuymL8L1xs4DLeeQ185O6VEALOWi8/my/h5dbunhGV75NAmRUC1ATA2Z18
        mSFSZb9ZdJhUUMvD1slcc1l9ams5zX7Gnn/v3MjkRW5aODXv60NNNxuxEI4JeNbvkVTmKRe9T+nv3
        /1dhjJK0qpvI9oIeH2+QBKgYLh6itkbtZ+zfUFOrUMLMjIQ1hZ9cRO1+HKoRoiE28aiZqjfn33jhg
        can+Ld1qRctQK8a3a3U55XBVGHPaHt7tylwDS/FjycZFLkC7O+xdQ6IJVW1oCWvQrYmy5Ao5f5040
        Lril1kuLWYboMz3VUTxFhL05Lafn85p7K4df3V5PoNH8O10ShqxPMS4kA6dpu3bP7HIw7aipqF26F
        Ldfda45lZUB3A9kvN/NGg6+MmCIUFllFoX5h497ChWzPA3veNxXJ/exBDUdfKaTAYOSGiwtwvGl4g
        crFJB8SdP8Gv8oTUzGoDI5lYim8pW96CfPCqLcq9EhhZlUm/EpQ5qnNvid+TtMAfSNY+RlwlrD72V
        29gvb2zuSRIyGOkjaWJJnVyjPClUM9h4+pgezpOkrt+xGVAod9X2rO75RnxoMWRKl0+HGxI5iy1Yf
        lqSYPp+coYGgviif85S+1UIqnTPZlaDSlQsq10cq4=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+2f20b523930c32c160cc@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/9p: use a dedicated spinlock for trans_fd
Date:   Fri, 07 Oct 2022 11:29:12 +0200
Message-ID: <2239557.riDjnQHxZP@silver>
In-Reply-To: <Yz97YyDlV8tOr82t@codewreck.org>
References: <2470e028-9b05-2013-7198-1fdad071d999@I-love.SAKURA.ne.jp>
 <2356596.7K3kzkM6Yp@silver> <Yz97YyDlV8tOr82t@codewreck.org>
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

On Freitag, 7. Oktober 2022 03:05:39 CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Thu, Oct 06, 2022 at 03:16:40PM +0200:
> > >  net/9p/trans_fd.c | 42 ++++++++++++++++++++++++++----------------
> > >  1 file changed, 26 insertions(+), 16 deletions(-)
> > 
> > Late on the party, sorry. Note that you already queued a slightly
> > different
> > version than this patch here, anyway, one thing ...
> 
> Did I? Oh, I apparently reworded the commit message a bit, sorry:
> 
> (where HEAD is this patch and 1622... the queued patch)
> 
> $ git range-diff HEAD^- 16228c9a4215^-
> 1:  e35fb8546af2 ! 1:  16228c9a4215 net/9p: use a dedicated spinlock for
> trans_fd @@ Commit message
> 
>          Since the locks actually protect different things in client.c and
> in trans_fd.c, just replace trans_fd.c's lock by a new one specific to the
> -    transport instead of using spin_lock_irq* variants everywhere -   
> (client.c's protect the idr for tag allocations, while
>     -    trans_fd.c's protects its own req list and request status field
>     +    transport (client.c's protect the idr for fid/tag allocations,
>     +    while trans_fd.c's protects its own req list and request status
> field that acts as the transport's state machine)
> 
>     -    Link:
> https://lkml.kernel.org/r/20220904112928.1308799-1-asmadeus@codewreck.org +
>    Link:
> https://lore.kernel.org/r/20220904112928.1308799-1-asmadeus@codewreck.org
> Link:
> https://lkml.kernel.org/r/2470e028-9b05-2013-7198-1fdad071d999@I-love.SAKUR
> A.ne.jp [1] Link:
> https://syzkaller.appspot.com/bug?extid=2f20b523930c32c160cc [2]
> Reported-by: syzbot <syzbot+2f20b523930c32c160cc@syzkaller.appspotmail.com>

No, that's not what I meant, but my bad, it was the following chunk that 
didn't apply here:

diff a/net/9p/trans_fd.c b/net/9p/trans_fd.c    (rejected hunks)
@@ -205,7 +207,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
                list_move(&req->req_list, &cancel_list);
        }
 
-       spin_unlock(&m->client->lock);
+       spin_unlock(&m->req_lock);
 
        list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
                p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);

And that was because this patch was based on:
https://github.com/martinetd/linux/commit/52f1c45dde9136f964d

I usually tag patches depending on another patch not being merged yet (and not 
being tied to the same series) like:

  Based-on: <message-id>

> > > @@ -832,6 +840,7 @@ static int p9_fd_open(struct p9_client *client, int
> > > rfd, int wfd)
> > > 
> > >  	client->trans = ts;
> > >  	client->status = Connected;
> > > 
> > > +	spin_lock_init(&ts->conn.req_lock);
> > 
> > Are you sure this is the right place for spin_lock_init()? Not rather in
> > p9_conn_create()?
> 
> Good point, 'ts->conn' (named... m over there for some reason...) is
> mostly initialized in p9_conn_create; it makes much more sense to move
> it there despite being slightly further away from the allocation.
> 
> It's a bit of a pain to check as the code is spread over many paths (fd,
> unix, tcp) but it looks equivalent to me:
>  - p9_fd_open is only called from p9_fd_create which immediately calls
> p9_conn_create
>  - below p9_socket_open itself immediately calls p9_conn_create

Yeah, looks pretty much the same, but better to have init code at the same 
place. Either or.

> I've moved the init and updated my next branch after very basic check
> https://github.com/martinetd/linux/commit/e5cfd99e9ea6c13b3f0134585f269c5092
> 47ac0e: ----
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 5b4807411281..d407f31bb49d 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -591,6 +591,7 @@ static void p9_conn_create(struct p9_client *client)
>  	INIT_LIST_HEAD(&m->mux_list);
>  	m->client = client;
> 
> +	spin_lock_init(&m->req_lock);
>  	INIT_LIST_HEAD(&m->req_list);
>  	INIT_LIST_HEAD(&m->unsent_req_list);
>  	INIT_WORK(&m->rq, p9_read_work);
> @@ -840,7 +841,6 @@ static int p9_fd_open(struct p9_client *client, int rfd,
> int wfd)
> 
>  	client->trans = ts;
>  	client->status = Connected;
> -	spin_lock_init(&ts->conn.req_lock);
> 
>  	return 0;
> 
> @@ -875,7 +875,6 @@ static int p9_socket_open(struct p9_client *client,
> struct socket *csocket) p->wr = p->rd = file;
>  	client->trans = p;
>  	client->status = Connected;
> -	spin_lock_init(&p->conn.req_lock);
> 
>  	p->rd->f_flags |= O_NONBLOCK;
> 
> ----
> 
> > The rest LGTM.
> 
> Thank you for the look :)

With that changed, you can add my RB-tag. :)

Thanks!

Best regards,
Christian Schoenebeck


