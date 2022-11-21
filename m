Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7B633071
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKUXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKUXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:02:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F91CDFFF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0F6EB816EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7EEC433C1;
        Mon, 21 Nov 2022 23:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669071716;
        bh=4BiwOETwQYdt5roOa+pyNI4BC0UtBQJIK+gof+CXNgo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tMT3E6D8Od7ZaPXYacJ0XmiiEdRQ6J4P13ZPab1S1+rTTaOqC1XLoFw6sxvx8ZK/j
         ns0TT1bq/e1rr0PqD/S4lSby5OXcQPbhJ+9JxW286Th27f8y3H3Z7e9nOqNsCLP0wO
         8/rtl+SbV4mxQ227rClC0S5HldW4+ZTixPjNJqohTtWFxtPD74d3p5WAEFhqLhnHJ6
         CWNK1a+SA3O+WWnAD5mDhoncTWhrK3yVnw5/sPAalelDPYE/pmlriv9hqLiD+UdEFn
         XzlZk+pqQvR5eqPlSPXIYW1D9exxess1/AbZvmmyUDKdabK+WiLbBJEtW6M3IrIscu
         KRh2t2CbQd/1g==
Date:   Mon, 21 Nov 2022 15:01:54 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        GUO Zihua <guozihua@huawei.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9p/xen: check logical size for buffer size
In-Reply-To: <37091478.n1eaNAWdo1@silver>
Message-ID: <alpine.DEB.2.22.394.2211211454540.1049131@ubuntu-linux-20-04-desktop>
References: <20221118135542.63400-1-asmadeus@codewreck.org> <37091478.n1eaNAWdo1@silver>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022, Christian Schoenebeck wrote:
> On Friday, November 18, 2022 2:55:41 PM CET Dominique Martinet wrote:
> > trans_xen did not check the data fits into the buffer before copying
> > from the xen ring, but we probably should.
> > Add a check that just skips the request and return an error to
> > userspace if it did not fit
> > 
> > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > ---
> > 
> > This comes more or less as a follow up of a fix for trans_fd:
> > https://lkml.kernel.org/r/20221117091159.31533-1-guozihua@huawei.com
> > Where msize should be replaced by capacity check, except trans_xen
> > did not actually use to check the size fits at all.
> > 
> > While we normally trust the hypervisor (they can probably do whatever
> > they want with our memory), a bug in the 9p server is always possible so
> > sanity checks never hurt, especially now buffers got drastically smaller
> > with a recent patch.
> > 
> > My setup for xen is unfortunately long dead so I cannot test this:
> > Stefano, you've tested v9fs xen patches in the past, would you mind
> > verifying this works as well?
> > 
> >  net/9p/trans_xen.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> > index b15c64128c3e..66ceb3b3ae30 100644
> > --- a/net/9p/trans_xen.c
> > +++ b/net/9p/trans_xen.c
> > @@ -208,6 +208,14 @@ static void p9_xen_response(struct work_struct *work)
> >  			continue;
> >  		}
> >  
> > +		if (h.size > req->rc.capacity) {
> > +			dev_warn(&priv->dev->dev,
> > +				 "requested packet size too big: %d for tag %d with capacity %zd\n",
> > +		                 h.size, h.tag, rreq->rc.capacity);
> > +			req->status = REQ_STATUS_ERROR;
> > +			goto recv_error;
> > +		}
> > +
> 
> Looks good (except of s/rreq/req/ mentioned by Stefano already).
> 
> >  		memcpy(&req->rc, &h, sizeof(h));
> 
> Is that really OK?
> 
> 1. `h` is of type xen_9pfs_header and declared as packed, whereas `rc` is of 
>    type p9_fcall not declared as packed.
> 
> 2. Probably a bit dangerous to assume the layout of xen_9pfs_header being in
>    sync with the starting layout of p9_fcall without any compile-time 
>    assertion?

You are right. It would be better to replace the memcpy with:

req->rc.size = h.size;
req->rc.id = h.id;
req->rc.tag = h.tag;

