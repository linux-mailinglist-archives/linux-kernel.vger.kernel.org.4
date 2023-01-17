Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E273966E3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjAQQgp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Jan 2023 11:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjAQQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:36:14 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94603303CD;
        Tue, 17 Jan 2023 08:36:02 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 1570D24000B;
        Tue, 17 Jan 2023 16:35:58 +0000 (UTC)
Message-ID: <83d8a06403d098f90760c199674ed585ca725b13.camel@hadess.net>
Subject: Re: [RFC] USB: core: Add wireless_status sysfs attribute
From:   Bastien Nocera <hadess@hadess.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 17 Jan 2023 17:35:58 +0100
In-Reply-To: <Y8bGZuMAvMRCTDQB@rowland.harvard.edu>
References: <d9f8b9413c10fcf067658979d16a4f5c7abe69e7.camel@hadess.net>
         <Y8bGZuMAvMRCTDQB@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 11:01 -0500, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 04:17:23PM +0100, Bastien Nocera wrote:
> > Hey,
> > 
> > TLDR: new sysfs attribute that makes it possible to leave receivers
> > for
> > wireless headsets plugged in. At the USB level, or at the base
> > driver
> > level?
> > 
> > Longer version:
> > I started working on implementing support for some wireless
> > headsets
> > that use USB receivers to communicate to the headset itself.
> > 
> > The USB receivers have multiple interfaces, and independent drivers
> > for
> > each, as is wont to do for USB devices. There's usually a HID
> > interface
> > to do the custom stuff (LEDs, battery status, connection status,
> > etc.)
> > and a standard audio class interface.
> > 
> > Those drivers don't know anything about each other, and getting
> > them to
> > talk to each other would be rather complicated. Additionally the
> > audio
> > interface is still somewhat functional when the headset is
> > disconnected.
> > 
> > In the end, I came up with this new sysfs attribute that would make
> > it
> > possible for user-space (PulseAudio or Pipewire) to know whether
> > the
> > receiver is plugged in or not.
> > 
> > That allows user-space to not show the battery information for the
> > device (rather than 0 percent), not offer the headset as an output,
> > and
> > potentially automatically switch to it when the headset is powered
> > on.
> > 
> > The question is whether this should be a USB sysfs attribute, or
> > one at
> > the base driver level. Example implementation of the USB sysfs
> > attribute itself below.
> 
> Do you know of any non-USB devices using the receiver/emitter
> approach?

I don't know of any.

> 
> > I have a patch for a USB API as well, but I'm having some problems
> > creating deferred work on a soft irq.
> > 
> > Cheers
> > 
> > ----
> > Add a wireless_status sysfs attribute to USB devices to keep track
> > of
> > whether a USB device that uses a receiver/emitter combo has its
> > emitter connected or disconnected.
> > 
> > By default, the USB device will declare not to use a
> > receiver/emitter.
> 
> How do you plan to tell which devices do use a receiver/emitter?  Is 
> this something the drivers already knowo about?

This is something that will need to be done on a device-by-device
basis. For example, I have some patches to the hid-logitech-hidpp
driver to set the wireless status when the headset is turned on.

This would allow leaving the receiver plugged in, and user-space would
know when the headset was actually available.

> 
> Is it conceivable that a single device might have more than one 
> receiver?  If so, should the attribute belong to an interface rather 
> than to the USB device?

The USB device is usually (always?) the receiver, so this kind of setup
wouldn't make much sense to me.

We could have it at the interface level, certainly, as Greg mentioned.
That's probably the path I will take.
