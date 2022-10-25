Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31C60D438
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiJYSzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJYSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:55:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F640028;
        Tue, 25 Oct 2022 11:55:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-12-207-nat.elisa-mobile.fi [85.76.12.207])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4D85E8A9;
        Tue, 25 Oct 2022 20:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666724091;
        bh=ojt4ficiai+RSRwiEz4aeo0qgLvpTF98fJ39GhQ546w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSAtmOmAnJ+cm2ZGCb5bhRDq6tw9TpAj3gOQB+ZAZ8pLx0bX+X42cXoWNWdaes36G
         UdYycFsDUJYpkoV/eVhMCe7kKxNixQ3/kZOUdNz2QX/ktwfWWEmJkikyPYeiZLVADU
         HpZt/cXxlVaKyEOVX4rB8LLppyboLmvo41y/OYKE=
Date:   Tue, 25 Oct 2022 21:54:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Pedro Guilherme Siqueira Moreira 
        <pedro.guilherme@espectro.eng.br>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: uvc_driver: fix assignment inside if
 condition
Message-ID: <Y1gw3cppUIBIbK34@pendragon.ideasonboard.com>
References: <20221025050450.1743072-1-pedro.guilherme@espectro.eng.br>
 <20221025050450.1743072-2-pedro.guilherme@espectro.eng.br>
 <CANiDSCs1pQEq73=vuNR9gymLMZFDkS3acDXRPNT=hc=eEvLzSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCs1pQEq73=vuNR9gymLMZFDkS3acDXRPNT=hc=eEvLzSA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:45:40AM +0200, Ricardo Ribalda wrote:
> On Tue, 25 Oct 2022 at 07:08, Pedro Guilherme Siqueira Moreira
> <pedro.guilherme@espectro.eng.br> wrote:
> >
> > Fixes 'do not use assignment in if condition' errors issued by
> > scripts/checkpatch.pl on drivers/media/usb/uvc/uvc_driver.c
> >
> > Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

Likewise, this looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index b591ad823c66..7b6c97ad3a41 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1174,7 +1174,8 @@ static int uvc_parse_control(struct uvc_device *dev)
> >                     buffer[1] != USB_DT_CS_INTERFACE)
> >                         goto next_descriptor;
> >
> > -               if ((ret = uvc_parse_standard_control(dev, buffer, buflen)) < 0)
> > +               ret = uvc_parse_standard_control(dev, buffer, buflen);
> > +               if (ret < 0)
> >                         return ret;
> >
> >  next_descriptor:
> > @@ -2213,7 +2214,8 @@ static int uvc_probe(struct usb_interface *intf,
> >         usb_set_intfdata(intf, dev);
> >
> >         /* Initialize the interrupt URB. */
> > -       if ((ret = uvc_status_init(dev)) < 0) {
> > +       ret = uvc_status_init(dev);
> > +       if (ret < 0) {
> >                 dev_info(&dev->udev->dev,
> >                          "Unable to initialize the status endpoint (%d), status interrupt will not be supported.\n",
> >                          ret);

-- 
Regards,

Laurent Pinchart
