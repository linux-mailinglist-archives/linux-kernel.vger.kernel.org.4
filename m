Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589765C8C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbjACVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjACVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:16:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA725D4;
        Tue,  3 Jan 2023 13:16:17 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 72656108;
        Tue,  3 Jan 2023 22:16:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672780575;
        bh=gy6v97UonmWmwdEPAg8ybJu1Rzhdgd2HNXcCozwf05Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8Fa42fTFOlHOaTL/iMTpi35Q4KA36wAKoWNYpuwOQ/FGe7qMcL22Efkyq/utzmCn
         ZmNCbc1etlXtIuwArnxhezFT+99u+qn9IeLQjb8bkvtK4yk8S4d10+k6fQDPwx5++f
         me85IkGrskbPL3dAD+Py09wYU99vjtP8SDsnGS4k=
Date:   Tue, 3 Jan 2023 23:16:11 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH RESEND v2 2/8] media: uvc: Allow quirking by entity guid
Message-ID: <Y7SbG1la3tQtD6Rk@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-2-0d7978a817cc@chromium.org>
 <Y67qWROM7rKywU3s@pendragon.ideasonboard.com>
 <CANiDSCs_36D5t5FOL+XuSCSz+H8RWQmV8F2TiAqDJTQUh-K2JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCs_36D5t5FOL+XuSCSz+H8RWQmV8F2TiAqDJTQUh-K2JQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Tue, Jan 03, 2023 at 04:40:48PM +0100, Ricardo Ribalda wrote:
> On Fri, 30 Dec 2022 at 14:40, Laurent Pinchart wrote:
> > On Fri, Dec 02, 2022 at 06:02:42PM +0100, Ricardo Ribalda wrote:
> > > When an IP is shared by multiple devices its erratas will be shared by
> > > all of them. Instead of creating a long list of device quirks, or
> > > waiting for the users to report errors in their hardware lets add a
> > > routine to add quirks based on the entity guid.
> >
> > I'm not thrilled by this. An entity is not an "IP". Quirks are needed to
> > handle issues with particular firmware versions on particular devices.
> > The same entity GUID can be used by different devices running different
> > firmware versions, some that would require a quirk and some that
> > wouldn't.
> 
> Unfortunately there are ISPs that do not support firmware upgrading
> that have an error on their firmware (or in this particular case a
> different interpretation of the standard).

I recall we've discussed that. I'll stick to the non politically correct
interpretation of the issue, and call it a bug :-)

> Those ISPs are mounted in
> different boards with a VID:PID that is chosen by the module
> manufacturer.
> In those cases we cannot get a list of the devices that are broken, we
> could only get a sublist that we will keep updating indefinitely as
> users keep reporting bugs (if they do so).
> 
> We are lucky enough that SunplusIT has been very active and provided
> us a way to detect what hardware requires quirking.

Is there a guarantee that none of the newer firmware versions that do
not exhibit this bug will *not* use the same XU GUID ?

> In those
> situations where the vendor is on board and there is no upgrade
> mechanism I think that this is a good compromise.

What I'm interested in is how to prevent this kind of issues in the
future. HungNien, would you be interested in engaging with us in order
to test future ISP firmwares against Linux ? I do appreciate that you
have supported Ricardo with handling this issue. We could work on a
publicly available UVC compliance test suite. You can reply about this
privately if you would rather not discuss this topic on public mailing
lists.

> > > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_driver.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > index 9c05776f11d1..c63ecfd4617d 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -1493,6 +1493,28 @@ static int uvc_parse_control(struct uvc_device *dev)
> > >       return 0;
> > >  }
> > >
> > > +static const struct uvc_entity_quirk {
> > > +     u8 guid[16];
> > > +     u32 quirks;
> > > +} uvc_entity_quirk[] = {
> > > +};
> > > +
> > > +static void uvc_entity_quirks(struct uvc_device *dev)
> > > +{
> > > +     struct uvc_entity *entity;
> > > +     int i;
> >
> > unsigned int
> >
> > > +
> > > +     list_for_each_entry(entity, &dev->entities, list) {
> > > +             for (i = 0; i < ARRAY_SIZE(uvc_entity_quirk); i++) {
> > > +                     if (memcmp(entity->guid, uvc_entity_quirk[i].guid,
> > > +                                sizeof(entity->guid)) == 0) {
> > > +                             dev->quirks |= uvc_entity_quirk[i].quirks;
> > > +                             break;
> > > +                     }
> > > +             }
> > > +     }
> > > +}
> > > +
> > >  /* -----------------------------------------------------------------------------
> > >   * Privacy GPIO
> > >   */
> > > @@ -2452,6 +2474,9 @@ static int uvc_probe(struct usb_interface *intf,
> > >               goto error;
> > >       }
> > >
> > > +     /* Apply entity based quirks */
> > > +     uvc_entity_quirks(dev);
> > > +
> > >       dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
> > >                dev->uvc_version >> 8, dev->uvc_version & 0xff,
> > >                udev->product ? udev->product : "<unnamed>",

-- 
Regards,

Laurent Pinchart
