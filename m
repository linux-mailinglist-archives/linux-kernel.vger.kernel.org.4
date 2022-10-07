Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4175F7274
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiJGBGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiJGBGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:06:06 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B860FFFF83
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 18:06:03 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 2A5B4C01E; Fri,  7 Oct 2022 03:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665104761; bh=nIw/4SZLODP2q/AJ8PriciNPLFxNn+7AHozKzYHKCNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VRR0zZxkJcKzMIEFOsOwPJw9oNOIDWEaa+6VfdWwmyBOCSyXonvnnNNrRQihgd/H5
         lOmeDQ2dMmo1zGlLxf7Ux7Mn2XyGdGwDPk8kkIW39X+Temnjd6m77ExJeDY5KT93Lx
         eZGOAwVrPJWLbc/t8hTb+xy7CoYTPQD10t2GcMTigo1M9mR0anuPCwVwKH7HSWAV1J
         0sV8Mmix+Jg/gsWOS8LGo3Hxb8Xj6fh0f29AtOq1zuQPE/8yAT0mIyQD/QNQvSChzW
         WrTK7vTxGl4tEFhz3gmzd5mw2d7PSObjnzFXrRq8aXFa/uC2D9t1ltzKBxMvpIiDYB
         yedIxy4FZ1KEw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 8595EC009;
        Fri,  7 Oct 2022 03:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665104759; bh=nIw/4SZLODP2q/AJ8PriciNPLFxNn+7AHozKzYHKCNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWjvkBLRO48TqxnHhm5nc2ra3J4C/bDU/osydRnSASDijKTSMZW9RnNdapGsWv+Q8
         EY0NLLD7sG5kqQ95TGOaLsmtaDLUpUqspmJPEoAgP+R90EF6Wexc42fxJFT9jtviz7
         V2nX+AoYZLLN2QRw2+VVrP2m3ny14jHJZQII+o1ZLGYMtU+2IYHOZN2+JrtRijExWn
         mAe9S1POyjYAH0Wjxs0J/4tVv801hl6rFBadqQ/84hTyaBkDnPJzc4iJ2el+1oBUxq
         NyilNr6OMg/eihIxCybxscs1qCa1+BVh0+Wq5EpOfwEaOIbn7e7vOKeoPoDsUnqPkR
         xTRXjcKe1QIwg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 557c5d50;
        Fri, 7 Oct 2022 01:05:55 +0000 (UTC)
Date:   Fri, 7 Oct 2022 10:05:39 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+2f20b523930c32c160cc@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/9p: use a dedicated spinlock for trans_fd
Message-ID: <Yz97YyDlV8tOr82t@codewreck.org>
References: <2470e028-9b05-2013-7198-1fdad071d999@I-love.SAKURA.ne.jp>
 <20220904112928.1308799-1-asmadeus@codewreck.org>
 <2356596.7K3kzkM6Yp@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2356596.7K3kzkM6Yp@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Thu, Oct 06, 2022 at 03:16:40PM +0200:
> >  net/9p/trans_fd.c | 42 ++++++++++++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> Late on the party, sorry. Note that you already queued a slightly different 
> version than this patch here, anyway, one thing ...

Did I? Oh, I apparently reworded the commit message a bit, sorry:

(where HEAD is this patch and 1622... the queued patch)

$ git range-diff HEAD^- 16228c9a4215^-
1:  e35fb8546af2 ! 1:  16228c9a4215 net/9p: use a dedicated spinlock for trans_fd
    @@ Commit message
     
         Since the locks actually protect different things in client.c and in
         trans_fd.c, just replace trans_fd.c's lock by a new one specific to the
    -    transport instead of using spin_lock_irq* variants everywhere
    -    (client.c's protect the idr for tag allocations, while
    -    trans_fd.c's protects its own req list and request status field
    +    transport (client.c's protect the idr for fid/tag allocations,
    +    while trans_fd.c's protects its own req list and request status field
         that acts as the transport's state machine)
     
    -    Link: https://lkml.kernel.org/r/20220904112928.1308799-1-asmadeus@codewreck.org
    +    Link: https://lore.kernel.org/r/20220904112928.1308799-1-asmadeus@codewreck.org
         Link: https://lkml.kernel.org/r/2470e028-9b05-2013-7198-1fdad071d999@I-love.SAKURA.ne.jp [1]
         Link: https://syzkaller.appspot.com/bug?extid=2f20b523930c32c160cc [2]
         Reported-by: syzbot <syzbot+2f20b523930c32c160cc@syzkaller.appspotmail.com>


> > @@ -832,6 +840,7 @@ static int p9_fd_open(struct p9_client *client, int rfd,
> > int wfd)
> > 
> >  	client->trans = ts;
> >  	client->status = Connected;
> > +	spin_lock_init(&ts->conn.req_lock);
> 
> Are you sure this is the right place for spin_lock_init()? Not rather in 
> p9_conn_create()?

Good point, 'ts->conn' (named... m over there for some reason...) is
mostly initialized in p9_conn_create; it makes much more sense to move
it there despite being slightly further away from the allocation.

It's a bit of a pain to check as the code is spread over many paths (fd,
unix, tcp) but it looks equivalent to me:
 - p9_fd_open is only called from p9_fd_create which immediately calls
p9_conn_create
 - below p9_socket_open itself immediately calls p9_conn_create

I've moved the init and updated my next branch after very basic check
https://github.com/martinetd/linux/commit/e5cfd99e9ea6c13b3f0134585f269c509247ac0e:
----
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 5b4807411281..d407f31bb49d 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -591,6 +591,7 @@ static void p9_conn_create(struct p9_client *client)
 	INIT_LIST_HEAD(&m->mux_list);
 	m->client = client;
 
+	spin_lock_init(&m->req_lock);
 	INIT_LIST_HEAD(&m->req_list);
 	INIT_LIST_HEAD(&m->unsent_req_list);
 	INIT_WORK(&m->rq, p9_read_work);
@@ -840,7 +841,6 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 
 	client->trans = ts;
 	client->status = Connected;
-	spin_lock_init(&ts->conn.req_lock);
 
 	return 0;
 
@@ -875,7 +875,6 @@ static int p9_socket_open(struct p9_client *client, struct socket *csocket)
 	p->wr = p->rd = file;
 	client->trans = p;
 	client->status = Connected;
-	spin_lock_init(&p->conn.req_lock);
 
 	p->rd->f_flags |= O_NONBLOCK;
 
----

> The rest LGTM.

Thank you for the look :)

--
Dominique
