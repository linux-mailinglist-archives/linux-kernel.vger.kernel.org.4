Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59F36489E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLIVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLIVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:13:06 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40996209A8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:13:04 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id CE3C1C01B; Fri,  9 Dec 2022 22:13:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670620392; bh=p0JkWQYo17MvQtwFDQ0yp7GACzWzHONdNs6Rir7LK/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0Ef99TMlJQdgB85frHbFJe7cNCXxpXAOdh/gVe/b9ZFsKFEKCPMLSYXQYPlZ+g97
         P3nEVmpaW0N/4RG09VpcEZaEfDUeC+Nem6Tr9/7XAH3GFTt7UbTCsp3LR1ubYP7Yo1
         9AvJojoBQq86oXmSJC3cwWatZRjIbjQdOBsl4XjiQT5RUsWTqOv6vO8M6dD0Ocs7LO
         kng9eWVAA8lZx1zUXcjbXYseRQ84wC63Y4Kc7sz6bPwR4oCzljHh7nt0bpogsL3m8A
         aLJXSWzlEMb0TKKbCx/A8JCsTrzMaxx2V7rPT5Nr1VJJOYmOfkUH0PnbA+2BYBCn5d
         h1D2AFw8K+xqw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 93E1CC01B;
        Fri,  9 Dec 2022 22:13:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670620392; bh=p0JkWQYo17MvQtwFDQ0yp7GACzWzHONdNs6Rir7LK/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0Ef99TMlJQdgB85frHbFJe7cNCXxpXAOdh/gVe/b9ZFsKFEKCPMLSYXQYPlZ+g97
         P3nEVmpaW0N/4RG09VpcEZaEfDUeC+Nem6Tr9/7XAH3GFTt7UbTCsp3LR1ubYP7Yo1
         9AvJojoBQq86oXmSJC3cwWatZRjIbjQdOBsl4XjiQT5RUsWTqOv6vO8M6dD0Ocs7LO
         kng9eWVAA8lZx1zUXcjbXYseRQ84wC63Y4Kc7sz6bPwR4oCzljHh7nt0bpogsL3m8A
         aLJXSWzlEMb0TKKbCx/A8JCsTrzMaxx2V7rPT5Nr1VJJOYmOfkUH0PnbA+2BYBCn5d
         h1D2AFw8K+xqw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 7c24ea7f;
        Fri, 9 Dec 2022 21:12:57 +0000 (UTC)
Date:   Sat, 10 Dec 2022 06:12:41 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
Message-ID: <Y5Okye5vE3grF2Qm@codewreck.org>
References: <20221205124756.426350-1-asmadeus@codewreck.org>
 <167052961.MU3OA6Uzks@silver>
 <Y5J4Voie1ik6BqnR@codewreck.org>
 <2603677.8PHbUxGoeg@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2603677.8PHbUxGoeg@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Fri, Dec 09, 2022 at 02:45:51PM +0100:
> > > What about p9_tag_alloc()?
> > 
> > I think that one's ok: it happens during the allocation before the
> > request is enqueued in the idr, so it should be race-free by defition.
> > 
> > tools/memory-model/Documentation/access-marking.txt says
> > "Initialization-time and cleanup-time accesses" should use plain
> > C-language accesses, so I stuck to that.
> 
> When it is allocated then it is safe, but the object may also come from a pool
> here. It's probably not likely to cause an issue here, just saying.

If it comes from the pool then it is gated by the refcount... But that
would require a similar barrier indeed (init stuff, wmb, init refcount
// get req + check refcount, rmb, read stuff e.g. tag); just a
write_once would not help.

For the init side I assume unlocking c->lock acts as a write barrier
after tag is set, which is conveniently the last step, but we'd need a
read barrier here in tag lookup:
--------
diff --git a/net/9p/client.c b/net/9p/client.c
index fef6516a0639..68585ad9003c 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -363,6 +363,7 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
 		 */
 		if (!p9_req_try_get(req))
 			goto again;
+		smp_rmb();
 		if (req->tc.tag != tag) {
 			p9_req_put(c, req);
 			goto again;
--------

OTOH this cannot happen with a normal server (a req should only be looked
up after it has been sent to the server and comes back, which involves a
few round trip and a few locks in the recv paths for tcp); but if syzbot
tries hard enough I guess that could be hit...
I don't have a strong opinion on this: I don't think anything really bad
can happen here as long as the refcount is correct (status is read under
lock when it matters before extra decrements of the refcount, and writes
to the buffer itself are safe from a memory pov), even if it's obviously
not correct strictly speaking.
(And I have no way of measuring what impact that extra barrier would have
tbh; for virtio at least lookup is actually never used...)

-- 
Dominique
