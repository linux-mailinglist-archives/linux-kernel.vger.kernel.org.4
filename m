Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF31C6B1615
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCHXEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCHXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:03:43 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A6D37EB61
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:02:55 -0800 (PST)
Received: (qmail 516343 invoked by uid 1000); 8 Mar 2023 18:02:09 -0500
Date:   Wed, 8 Mar 2023 18:02:09 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND] media: uvcvideo: Disable autosuspend for Insta360
 Link
Message-ID: <1298c83f-695a-4356-aa2e-22b0e6629610@rowland.harvard.edu>
References: <20221101-instal-v1-0-d13d1331c4b5@chromium.org>
 <Y6z55cXTt5yXjIZj@pendragon.ideasonboard.com>
 <CANiDSCvbQ7uMgoxDsXDOphjANNZ2EuoV-Dra+wtT9LLL6USstQ@mail.gmail.com>
 <CANiDSCveK6QRbYM==XN9jggy8DHfS3QJawDWpFLy0jcmmHeduA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCveK6QRbYM==XN9jggy8DHfS3QJawDWpFLy0jcmmHeduA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:43:09PM +0100, Ricardo Ribalda wrote:
> On Wed, 1 Mar 2023 at 10:04, Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Hi Laurent
> >
> > We are back to this issue.
> >
> >
> > On Thu, 29 Dec 2022 at 03:22, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > Thank you for the patch.
> > >
> > > On Fri, Dec 02, 2022 at 05:48:52PM +0100, Ricardo Ribalda wrote:
> > > > When the device suspends, it keeps power-cycling.
> > > >
> > > > The user notices it because the LED constanct oscillate between
> > > > blue (ready) and no LED (off).

> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > media: uvcvideo: Disable autosuspend for Insta360
> > > >
> > > > The device does not handle properly the USB suspend and makes it barely usable.
> > >
> > > Isn't this best handled with a quirk in the USB core ? Autosuspend is a
> > > device feature, not an interface feature, so if the USB sound driver is
> > > loaded but uvcvideo isn't, the kernel may still attempt to autosuspend
> > > the device.
> > >
> >
> > Seems like USB_QUIRK_NO_AUTOSUSPEND was gone for a long time
> >
> > https://lore.kernel.org/lkml/20071115064457.GU19218@kroah.com/
> >
> > under the assumption that autosuspend was off by default and user
> > space should only enable autosuspend on the devices that support it
> > (if I understand it correctly).
> >
> > There are two other quirks still available: USB_QUIRK_RESET_RESUME and
> > USB_QUIRK_DISCONNECT_SUSPEND, but they do not seem to work for this
> > device (Yunke, thanks for looking into this)
> >
> > If we are explicitly enabling autosuspend on the driver, shouldn't we
> > make sure that the device supports it?
> >
> 
> Alan, Greg, any idea about what is the best way to proceed here from a
> USB perspective?

How is autosuspend getting enabled for this device?  It is disabled by 
default for non-hub USB devices.

If the uvcvideo or USB sound driver is enabling autosuspend, the driver 
should be fixed.  Perhaps by adding a quirk bit for this purpose.

If userspace is enabling autosuspend, then any misbehavior isn't the 
kernel's fault.  :-)

Alan Stern
