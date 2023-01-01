Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8304B65AA8F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 17:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjAAQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 11:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjAAQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 11:21:35 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 57834DFC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 08:21:34 -0800 (PST)
Received: (qmail 386026 invoked by uid 1000); 1 Jan 2023 11:21:33 -0500
Date:   Sun, 1 Jan 2023 11:21:33 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1] usb: gadget: add WebUSB support
Message-ID: <Y7GzDRxyH9x2Shf1@rowland.harvard.edu>
References: <7615b2ac-a849-94a7-94a5-fb1c2075d7db@wanadoo.fr>
 <Y69F/5+DLAEqujXC@jo-einhundert>
 <Y7CR30YUj2znMDm7@rowland.harvard.edu>
 <CAMUOyH29XnTGO-LbJj5Hh9nzvT6aKNZH+ykvpBfq-PqyQFwioQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMUOyH29XnTGO-LbJj5Hh9nzvT6aKNZH+ykvpBfq-PqyQFwioQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 09:26:44PM +0100, Jó Ágila Bitsch wrote:
> On Sat, Dec 31, 2022 at 8:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Dec 30, 2022 at 09:11:43PM +0100, Jó Ágila Bitsch wrote:
> > >
> > > During device enumeration, a host recognizes that the announced
> > > USB version is at least 2.01, which means, that there are BOS
> >
> > Where is this 2.01 value specified?  I don't remember seeing it in the
> > usual USBIF documents.
> 
> This is actually from the backport of BOS descriptors to USB 2
> 
> Citing Randy Aull from
> https://community.osr.com/discussion/comment/249742/#Comment_249742
> >  There is no specification called USB 2.1, however there is such a thing as a USB 2.1 device.
> > The USB 2.0 ECN for LPM introduced a new descriptor request to the enumeration process
> > for USB 2 devices (the BOS descriptor set). The problem is that software can't request a new
> > descriptor type to old devices that don't understand it without introducing compatibility issues
> > with some devices (more than you would probably expect). So, software needed a way to
> > identify whether a device could support the host requesting a BOS descriptor set. The solution
> > in this ECN was to require devices supporting the ECN to set their bcdUSB to 0x0201 (2.01).
> >
> > Now, when we created the USB 3.0 spec, we again wanted to leverage the BOS descriptor, not
> > only because we wanted to mandate USB 2 LPM in 3.0 devices when operating at high-speed,
> > but also so the device can indicate to a host that it can operate at SuperSpeed (to support
> > everyone's favorite "your device can perform faster" popup). Knowing that when operating at
> > high-speed these devices needed to report the BOS descriptor set, we knew that it couldn't
> > set the bcdUSB to 0x0200. We mistakenly wrote it down as 0x0210 instead of 0x0201 in the
> > 3.0 spec (perhaps we just said "two point one" which might have been ambiguous) when we
> > were trying to just be consistent with the requirement from the LPM ECN. So, rather than
> > changing it back to 0x0201 in the USB 3.0 spec, we just ran with it.
> >
> > So, there are USB 2.0 devices, USB 2.01 devices and USB 2.1 devices, even though the latest
> > revision of the USB 2 spec is USB 2.0. I have recommended that the USB-IF actually create a
> > USB 2.1 specification that captures all of the various errata, ECNs, etc from over the years, but
> > it hasn't happened yet.

Interesting history.  And now that you point it out, I do see at the end 
of section 3 of the USB 2.0 Link Power Management ECN:

	Devices that support the BOS descriptor must have a bcdUSB value 
	of 0201H or larger.

> Btw, configfs already includes these version codes to support Link
> Power Management (LPM) and
> the associated BOS descriptor, so I didn't add that part, I only added
> webusb as a condition as to
> when to send BOS descriptors.

Right.

> > > @@ -713,14 +714,16 @@ static int bos_desc(struct usb_composite_dev *cdev)
> > >        * A SuperSpeed device shall include the USB2.0 extension descriptor
> > >        * and shall support LPM when operating in USB2.0 HS mode.
> > >        */
> > > -     usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
> > > -     bos->bNumDeviceCaps++;
> > > -     le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
> > > -     usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
> > > -     usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
> > > -     usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
> > > -     usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
> > > -                                         USB_BESL_SUPPORT | besl);
> > > +     if (cdev->gadget->lpm_capable) {
> >
> > This change doesn't seem to be related to the purpose of this patch.
> 
> Actually, it is.
> 
> Previously, BOS descriptors would only ever be sent if the device was
> lpm_capable.
> For this reason, this descriptor was previously sent unconditionally.
> 
> With my patch in place, it could be that a device is not lpm_capable, but still
> wants to send BOS descriptors to announce its WebUSB capability,
> therefore I added
> this condition.

Okay.  It would be good to explain this in the patch description.

Alan Stern
