Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF8744AE4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGASyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjGASyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:54:50 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 24220171D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 11:54:48 -0700 (PDT)
Received: (qmail 1021177 invoked by uid 1000); 1 Jul 2023 14:54:46 -0400
Date:   Sat, 1 Jul 2023 14:54:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: r8a66597-hcd: host: fix port index underflow and
 UBSAN complains
Message-ID: <ad575ac5-fccb-4b1e-b6f4-26caa814414f@rowland.harvard.edu>
References: <tencent_AD4994DC28D60E6CF580E97BB028A0A1EA0A@qq.com>
 <20230701171648.orex7hx6jpkkpub3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230701171648.orex7hx6jpkkpub3@pengutronix.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 07:16:48PM +0200, Uwe Kleine-König wrote:
> On Sun, Jul 02, 2023 at 12:39:20AM +0800, Zhang Shurong wrote:
> > If wIndex is 0 (and it often is), these calculations underflow and
> > UBSAN complains, here resolve this by not decrementing the index when
> > it is equal to 0.
> > 
> > Similar commit 85e3990bea49 ("USB: EHCI: avoid undefined pointer
> > arithmetic and placate UBSAN")
> > 
> > The changes in this version:
> > - fix some compile error
> > 
> > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > ---
> >  drivers/usb/host/r8a66597-hcd.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
> > index 9f4bf8c5f8a5..6c597c668364 100644
> > --- a/drivers/usb/host/r8a66597-hcd.c
> > +++ b/drivers/usb/host/r8a66597-hcd.c
> > @@ -2141,10 +2141,12 @@ static int r8a66597_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >  {
> >  	struct r8a66597 *r8a66597 = hcd_to_r8a66597(hcd);
> >  	int ret;
> > -	int port = (wIndex & 0x00FF) - 1;
> > -	struct r8a66597_root_hub *rh = &r8a66597->root_hub[port];
> >  	unsigned long flags;
> > +	struct r8a66597_root_hub *rh;
> > +	u32 port = wIndex & 0xFF;
> >  
> > +	port -= (port > 0);
> 
> I have no idea about this hardware, but it seems strange to me that
> calling r8a66597_hub_control with wIndex = 1 should have the same effect
> as with wIndex = 0. Is you changed backed by knowledge about the
> hardware, or is that just the most obvious way to get rid of the UB
> warning?
> 
> Having said that, I think
> 
> 	port -= (port > 0);
> 
> is hard to read compared to:
> 
> 	if (port > 0)
> 		port--;

Zhang:

Why not just copy the code that's already in ehci-hub.c?

	/*
	 * Avoid out-of-bounds values while calculating the port index
	 * from wIndex.  The compiler doesn't like pointers to invalid
	 * addresses, even if they are never used.
	 */
	port = (wIndex - 1) & 0xff;
	if (port >= r8a66597->max_root_hub)
		port = 0;
	rh = &r8a66597->root_hub[port];

Also, I see that in the ClearPortFeature, SetPortStatus, and 
SetPortFeature cases in this routine, the code doesn't check for wIndex 
== 0.  That's a bug -- a real one, not just a UBSAN issue.


Uwe:

wIndex should never be == 0 or > max_root_hub in the cases where rh gets 
used; such values would be meaningless.  But we don't control the value 
of wIndex, because it can come from userspace.  So we can't simply 
assume it will always be valid; it has to be checked.

That being understood, the changes Zhang is making here are meant mostly 
to prevent UBSAN and the compiler from complaining or making false 
assumptions.  The actual checks on wIndex occur later in the subroutine.

Alan Stern
