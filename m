Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D506A33F4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBZUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:33:39 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F601EFB4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GxO2uYWlsxAHA3bGuVbRNRMMLQdwnwKGZfXabY8QhIY=;
  b=ZnJmDUlwY1uAsx3eps5CukAYOqu+Ac9GIL0vmKQuL27+YOVEdnYDGD+y
   Ko2q8O7KF/zWHtOlzj76MrtlZ09jMkMn+3Irg1sPgMRJF478QaYuIdTqn
   rJFIYtHaWtMnJe+n0llLg3lre6o0U1cG9dznGGhtlRniQRJLQzkfed/iH
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,330,1669071600"; 
   d="scan'208";a="48664654"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 21:33:35 +0100
Date:   Sun, 26 Feb 2023 21:33:34 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] coccinelle: put_device: Include of_node_put to avoid
 false positives
In-Reply-To: <Y/u/mV6GUC5+l3m6@ubun2204.myguest.virtualbox.org>
Message-ID: <alpine.DEB.2.22.394.2302262130430.2761@hadrien>
References: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org> <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr> <Y/u/mV6GUC5+l3m6@ubun2204.myguest.virtualbox.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Feb 2023, Deepak R Varma wrote:

> On Sat, Feb 25, 2023 at 08:17:01PM +0100, Julia Lawall wrote:
> > > The node reference increased by of_find_device_by_node() can also be
> > > released by using a call to of_node_put(). Hence when this exists, the
> > > script should not trigger a warning, which otherwise will be a false
> > > positive.
> >
> > Could you explain more about why of_node_put is sufficient?
>
> You are right. In fact, I think calling of_node_put() for a prior
> of_find_device_by_node() is buggy as a call to of_find_device_by_node()
> increments the kref for the device embedding the node and not the kref of the
> node. Hence a call to put_device() is required to decrement the device kref.
> Calling the of_node_put() attempts to decrement the kref of the node, which I
> think is not correct.
>
> May I request any comment on my understanding?

I think that decrementing a kref and reaching 0 would trigger some cleanup
action.  I don't know what that cleanup action is in this case.

Did someone tell you that of_node_put was good enough?  Perhaps that
person could provide more explanation.

In looking quickly though the code, the focus seemed to be on the device.
The of node is just used for comparison to check that we have the right
one.  But I don't know if cleaning up the of node could somehow trigger
cleaning up the device as well.

julia

>
> Thank you,
> deepak.
>
> >
> > thanks,
> > julia
> >
> > > Also, improve the warning message to include of_node_put too is missing.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > > scripts/coccinelle/free/put_device.cocci | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/coccinelle/free/put_device.cocci
> > > b/scripts/coccinelle/free/put_device.cocci
> > > index f09f1e79bfa6..259195b501aa 100644
> > > --- a/scripts/coccinelle/free/put_device.cocci
> > > +++ b/scripts/coccinelle/free/put_device.cocci
> > > @@ -18,8 +18,10 @@ type T,T1,T2,T3;
> > >
> > > id = of_find_device_by_node@p1(x)
> > > ... when != e = id
> > > +    when != of_node_put(x)
> > > if (id == NULL || ...) { ... return ...; }
> > > ... when != put_device(&id->dev)
> > > +    when != of_node_put(x)
> > >     when != platform_device_put(id)
> > >     when != if (id) { ... put_device(&id->dev) ... }
> > >     when != e1 = (T)id
> > > @@ -42,7 +44,7 @@ p2 << search.p2;
> > > @@
> > >
> > > coccilib.report.print_report(p2[0],
> > > -                             "ERROR: missing put_device; call
> > > of_find_device_by_node on line "
> > > +                             "ERROR: missing put_device or of_node_put; call
> > > of_find_device_by_node on line "
> > >                              + p1[0].line
> > >                              + ", but without a corresponding object release within this function.")
> > >
> > > --
> > > 2.34.1
>
>
>
