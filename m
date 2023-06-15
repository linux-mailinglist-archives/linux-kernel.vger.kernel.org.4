Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6744973139D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjFOJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbjFOJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:22:16 -0400
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0CD2726;
        Thu, 15 Jun 2023 02:22:10 -0700 (PDT)
Received: from W388ANL (10.12.12.26) by S035ANL.actianordic.se (10.12.31.116)
 with Microsoft SMTP Server id 15.1.2507.23; Thu, 15 Jun 2023 11:22:07 +0200
Date:   Thu, 15 Jun 2023 11:22:05 +0200
From:   Jonas Blixt <jonas.blixt@actia.se>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <shuah@kernel.org>, <valentina.manea.m@gmail.com>,
        <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: usbip: fix stub_dev hub disconnect
Message-ID: <20230615092205.GA1212960@W388ANL>
References: <20230613092918.4191895-1-jonas.blixt@actia.se>
 <2023061347-reverse-staleness-e4f3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023061347-reverse-staleness-e4f3@gregkh>
X-Originating-IP: [10.12.12.26]
X-EsetResult: clean, is OK
X-EsetId: 37303A294A191A536D7367
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 11:50:31AM +0200, Greg KH wrote:
> On Tue, Jun 13, 2023 at 11:29:18AM +0200, Jonas Blixt wrote:
> > If a hub is disconnected that has device(s) that's attached to the usbip layer
> > the disconnect function might fail because it tries to release the port
> > on an already disconnected hub.
> > 
> > Fixes: 6080cd0e9239 ("staging: usbip: claim ports used by shared devices")
> > Signed-off-by: Jonas Blixt <jonas.blixt@actia.se>
> > ---
> >  drivers/usb/usbip/stub_dev.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
> > index 2305d425e6c9..257861787cdf 100644
> > --- a/drivers/usb/usbip/stub_dev.c
> > +++ b/drivers/usb/usbip/stub_dev.c
> > @@ -427,8 +427,12 @@ static void stub_disconnect(struct usb_device *udev)
> >  	/* release port */
> >  	rc = usb_hub_release_port(udev->parent, udev->portnum,
> >  				  (struct usb_dev_state *) udev);
> > -	if (rc) {
> > -		dev_dbg(&udev->dev, "unable to release port\n");
> > +	/*
> > +	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
> > +	 * device usb_hub_release_port will return -ENODEV.
> 
> How about adding, "so we can safely ignore that error here."
> 
> thanks,
> 
> greg k-h

Yes, I'll update the comment and prepare a V2 patch.

Jonas
