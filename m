Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1764A17B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiLLNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiLLNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:40:32 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66026E0F6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=fz5Bb1HkOnzUlPrBGL969RO1qlOdWuFW9bWTEczProg=; b=Aqs69a/o+oA9QIgpROLGuDvWka
        RNL8sZxXLpKl3wZ5E6/G+Jykc/Ibedh4SbTEqHCTjxfPRFtX0wTOwqyJXpVmayN1/Ms/UJckgWOmk
        7QXCtFy7TxknO2aaq8AQ3N378RuIRqGWKWPSs7TGv80WRahRZbPD7ZLF5jh7yu4EP1eZ3gq7oW2QL
        QCY9kgqNsYUWeMkqgB99laieyj6PStMRcYM6nFEFgEy9zFNOlod1D8Vo3qyEv/DX0iSPIg7iGK6nn
        POaQnyVsBHvfYJpjciQwY+QjWVLr1qfPzIT0mktetZe/pXdAW0VdJH+MmRYZbo3m3DeOnCa5EUTMB
        saoB4c3ujfvogygLjgFb20srtkp5xRXr46fovgySqoLoyIU2Loj7MyB4jLM0e9uxYwZZZSDAiUKKj
        Cqjuf58jsEG2IsJdLR5iHbB5DLazAQqwNeP5sByQ9reZwxoh6qikcWXwRxf5IkqxWV5aGR0iUcBu5
        BteRhBgK8J80TS2DErDcFmyAE7f+4liAuA9L1Ldhm8SRzk1BrwX6NwmTvgO9n9nup1XosdBYwpEHr
        HFVHgAJ3GG75Drhy7wnvBFbQkd+JQ043KZ6yYeCr8vK9UDPrzREMS2PE6mY7faNQMgRXAqJHLnkkt
        pWOSNBAISSSxxpIqG3ss2S4FIk1RqLUPZ0jduuqOQ=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
Date:   Mon, 12 Dec 2022 14:39:43 +0100
Message-ID: <14282286.flAjB0pb5C@silver>
In-Reply-To: <Y5Okye5vE3grF2Qm@codewreck.org>
References: <20221205124756.426350-1-asmadeus@codewreck.org> <2603677.8PHbUxGoeg@silver>
 <Y5Okye5vE3grF2Qm@codewreck.org>
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

On Friday, December 9, 2022 10:12:41 PM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Fri, Dec 09, 2022 at 02:45:51PM +0100:
> > > > What about p9_tag_alloc()?
> > > 
> > > I think that one's ok: it happens during the allocation before the
> > > request is enqueued in the idr, so it should be race-free by defition.
> > > 
> > > tools/memory-model/Documentation/access-marking.txt says
> > > "Initialization-time and cleanup-time accesses" should use plain
> > > C-language accesses, so I stuck to that.
> > 
> > When it is allocated then it is safe, but the object may also come from a pool
> > here. It's probably not likely to cause an issue here, just saying.
> 
> If it comes from the pool then it is gated by the refcount... But that
> would require a similar barrier indeed (init stuff, wmb, init refcount
> // get req + check refcount, rmb, read stuff e.g. tag); just a
> write_once would not help.
> 
> For the init side I assume unlocking c->lock acts as a write barrier
> after tag is set, which is conveniently the last step, but we'd need a
> read barrier here in tag lookup:
> --------
> diff --git a/net/9p/client.c b/net/9p/client.c
> index fef6516a0639..68585ad9003c 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -363,6 +363,7 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
>  		 */
>  		if (!p9_req_try_get(req))
>  			goto again;
> +		smp_rmb();
>  		if (req->tc.tag != tag) {
>  			p9_req_put(c, req);
>  			goto again;
> --------
> 
> OTOH this cannot happen with a normal server (a req should only be looked
> up after it has been sent to the server and comes back, which involves a
> few round trip and a few locks in the recv paths for tcp); but if syzbot
> tries hard enough I guess that could be hit...
> I don't have a strong opinion on this: I don't think anything really bad
> can happen here as long as the refcount is correct (status is read under
> lock when it matters before extra decrements of the refcount, and writes
> to the buffer itself are safe from a memory pov), even if it's obviously
> not correct strictly speaking.
> (And I have no way of measuring what impact that extra barrier would have
> tbh; for virtio at least lookup is actually never used...)

Yeah agreed, this was more of a theoretical issue. With the other memory
barrier patch posted by you already:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>



