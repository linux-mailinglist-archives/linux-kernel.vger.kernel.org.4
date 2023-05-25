Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A57117C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjEYT7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbjEYT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:59:07 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DC37DD9
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:59:05 -0700 (PDT)
Received: (qmail 268043 invoked by uid 1000); 25 May 2023 15:10:27 -0400
Date:   Thu, 25 May 2023 15:10:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Roy Luo <royluo@google.com>
Cc:     raychi@google.com, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
Message-ID: <89cf2c61-a55e-4c35-93b2-35fa7ab0266b@rowland.harvard.edu>
References: <20230525173818.219633-1-royluo@google.com>
 <408575c0-2967-4cdb-92c7-1b2845038d20@rowland.harvard.edu>
 <CA+zupgwz8Mbd8=7ep7t0OU-34bbwsc9fMK4dHip0rgqD7FSd2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+zupgwz8Mbd8=7ep7t0OU-34bbwsc9fMK4dHip0rgqD7FSd2A@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:46:23AM -0700, Roy Luo wrote:
> On Thu, May 25, 2023 at 11:02 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, May 25, 2023 at 05:38:18PM +0000, Roy Luo wrote:
> > > Expose usb device state to userland as the information is useful in
> > > detecting non-compliant setups and diagnosing enumeration failures.
> > > For example:
> > > - End-to-end signal integrity issues: the device would fail port reset
> > >   repeatedly and thus be stuck in POWERED state.
> > > - Charge-only cables (missing D+/D- lines): the device would never enter
> > >   POWERED state as the HC would not see any pullup.
> > >
> > > What's the status quo?
> > > We do have error logs such as "Cannot enable. Maybe the USB cable is bad?"
> > > to flag potential setup issues, but there's no good way to expose them to
> > > userspace.
> > >
> > > Why add a sysfs entry in struct usb_port instead of struct usb_device?
> > > The struct usb_device is not device_add() to the system until it's in
> > > ADDRESS state hence we would miss the first two states. The struct
> > > usb_port is a better place to keep the information because its life
> > > cycle is longer than the struct usb_device that is attached to the port.
> > >
> > > Signed-off-by: Roy Luo <royluo@google.com>
> > > ---
> >
> > > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > > index e23833562e4f..110143568c77 100644
> > > --- a/drivers/usb/core/hub.h
> > > +++ b/drivers/usb/core/hub.h
> > > @@ -84,8 +84,10 @@ struct usb_hub {
> > >   * @peer: related usb2 and usb3 ports (share the same connector)
> > >   * @req: default pm qos request for hubs without port power control
> > >   * @connect_type: port's connect type
> > > + * @state: device state of the usb device attached to the port
> >
> > This member is essentially a duplicate of the .child member of the
> > usb_port structure.  That is, it points to the .state member of the
> > child device instead of to the child device itself, but this is pretty
> > much the same thing.  You could replace *(port_dev->state) with
> > port_dev->child->state.
> >
> Alan, thanks for the quick response!
> Yes, port_dev->state is indeed the same as port_dev->child->state. However,
> I still add port_dev->state because port_dev->child won't be assigned until
> the corresponding usb_device is in ADDRESS state.
> I wish I can assign get port_dev->child assigned earlier, but I think
> the current design - assign port_dev->child and device_add() after ADDRESS
> state - also makes sense because there are many ways that the enumeration
> could fail in the early stage. By adding port_dev->state, I can link
> usb_device->state to usb_port as soon as the usb_device is created to get
> around the limitation of port_dev->child.
> I would be very happy to hear other ideas.

Is there any real reason not to set port_dev->child as soon as the 
usb_device structure is created?  If enumeration fails, the pointer can 
be cleared.

Alan Stern
