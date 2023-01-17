Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E727D66E3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjAQQgv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Jan 2023 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjAQQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:36:18 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED53A5A6;
        Tue, 17 Jan 2023 08:36:04 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D3B6E2000F;
        Tue, 17 Jan 2023 16:36:01 +0000 (UTC)
Message-ID: <3dc9061bd123188ed64401d1504f919162e3dd99.camel@hadess.net>
Subject: Re: [RFC] USB: core: Add wireless_status sysfs attribute
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 17 Jan 2023 17:36:01 +0100
In-Reply-To: <Y8bJbM0+XcT6MRq9@kroah.com>
References: <d9f8b9413c10fcf067658979d16a4f5c7abe69e7.camel@hadess.net>
         <Y8bJbM0+XcT6MRq9@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 17:14 +0100, Greg Kroah-Hartman wrote:
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
> 
> Would this also include wireless keyboard/mice recievers?

This could also be used by certain keyboard or mice receivers, if the
keyboard or mouse is kept constantly connected and there's a way to
find out whether it's connected or not.

> Why is "wireless" somehow a special attribute that userspace needs to
> know about?

"wireless" isn't the attribute user-space would be interested in,
"wireless status" would be. If the headset's wireless status is
"disconnected", then the headset is unavailable. Then user-space can
route the audio accordingly.

> > The USB receivers have multiple interfaces, and independent drivers
> > for
> > each, as is wont to do for USB devices. There's usually a HID
> > interface
> > to do the custom stuff (LEDs, battery status, connection status,
> > etc.)
> > and a standard audio class interface.
> 
> This probably should be an interface attribute (as Alan points out),
> as
> it's not a device attribute (think about updating the firmware for
> one
> of these, that's on an interface for the reciever you plugged in, not
> on
> the other end of the wireless connection...)

OK, fair enough.

> > Those drivers don't know anything about each other, and getting
> > them to
> > talk to each other would be rather complicated. Additionally the
> > audio
> > interface is still somewhat functional when the headset is
> > disconnected.
> 
> Those drivers shouldn't know about each other, that's up to userspace
> to
> group and control if needed.  No kernel interactions should be
> needed.
> 
> > In the end, I came up with this new sysfs attribute that would make
> > it
> > possible for user-space (PulseAudio or Pipewire) to know whether
> > the
> > receiver is plugged in or not.
> 
> Again, should be an interface attribute, if at all.
> 
> > That allows user-space to not show the battery information for the
> > device (rather than 0 percent), not offer the headset as an output,
> > and
> > potentially automatically switch to it when the headset is powered
> > on.
> 
> Same for a keyboard/mouse, right?

Yes, although I haven't found devices where this would be useful.

I'll reimplement this as an interface attribute.

Thanks very much to you and Alan for the quick replies.

Cheers
