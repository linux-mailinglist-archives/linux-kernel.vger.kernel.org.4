Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3A6A33F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBZUXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:22:58 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B73AAB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 12:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677442974; bh=FRkGvJDmaEz0swKnwZzPE0L9HyhTVuotpdyes0dJpOM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=jqw+0L6varzZLT18Aylj+/ynQKFNmxTlAHp8XSG3in1t/wYA6y2GZhz83ApBFdnPg
         DKA6Z8JCYhcPNoEY5VHhbz7ESqbGEFIJyM6fY7w914G/GmXeAfhk/xJZ/q25BYcPlL
         kNIIsmZiISvER+/bs9FZcWng56EeqcG3XMnavuLo=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 26 Feb 2023 21:22:54 +0100 (CET)
X-EA-Auth: TAIhNcv5bfuO/MsWc1+6zY1h5Un2D9etJ70zxWicPeOZiIPqBBoL5iUIxv+so2EeDpR4HrVZUDaPoN3Gbbke0SdwJA6tU8Fz
Date:   Mon, 27 Feb 2023 01:52:49 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] coccinelle: put_device: Include of_node_put to avoid
 false positives
Message-ID: <Y/u/mV6GUC5+l3m6@ubun2204.myguest.virtualbox.org>
References: <Y+/DQ6l0pDcxC2c3@ubun2204.myguest.virtualbox.org>
 <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597798313.18813704.1677352621708.JavaMail.zimbra@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 08:17:01PM +0100, Julia Lawall wrote:
> > The node reference increased by of_find_device_by_node() can also be
> > released by using a call to of_node_put(). Hence when this exists, the
> > script should not trigger a warning, which otherwise will be a false
> > positive.
> 
> Could you explain more about why of_node_put is sufficient?

You are right. In fact, I think calling of_node_put() for a prior
of_find_device_by_node() is buggy as a call to of_find_device_by_node()
increments the kref for the device embedding the node and not the kref of the
node. Hence a call to put_device() is required to decrement the device kref.
Calling the of_node_put() attempts to decrement the kref of the node, which I
think is not correct.

May I request any comment on my understanding?

Thank you,
deepak.

> 
> thanks,
> julia
> 
> > Also, improve the warning message to include of_node_put too is missing.
> > 
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> > scripts/coccinelle/free/put_device.cocci | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/coccinelle/free/put_device.cocci
> > b/scripts/coccinelle/free/put_device.cocci
> > index f09f1e79bfa6..259195b501aa 100644
> > --- a/scripts/coccinelle/free/put_device.cocci
> > +++ b/scripts/coccinelle/free/put_device.cocci
> > @@ -18,8 +18,10 @@ type T,T1,T2,T3;
> > 
> > id = of_find_device_by_node@p1(x)
> > ... when != e = id
> > +    when != of_node_put(x)
> > if (id == NULL || ...) { ... return ...; }
> > ... when != put_device(&id->dev)
> > +    when != of_node_put(x)
> >     when != platform_device_put(id)
> >     when != if (id) { ... put_device(&id->dev) ... }
> >     when != e1 = (T)id
> > @@ -42,7 +44,7 @@ p2 << search.p2;
> > @@
> > 
> > coccilib.report.print_report(p2[0],
> > -                             "ERROR: missing put_device; call
> > of_find_device_by_node on line "
> > +                             "ERROR: missing put_device or of_node_put; call
> > of_find_device_by_node on line "
> >                              + p1[0].line
> >                              + ", but without a corresponding object release within this function.")
> > 
> > --
> > 2.34.1


