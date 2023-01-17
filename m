Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156A466E2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjAQQBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAQQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:01:46 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BC76430B16
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:01:43 -0800 (PST)
Received: (qmail 170339 invoked by uid 1000); 17 Jan 2023 11:01:42 -0500
Date:   Tue, 17 Jan 2023 11:01:42 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC] USB: core: Add wireless_status sysfs attribute
Message-ID: <Y8bGZuMAvMRCTDQB@rowland.harvard.edu>
References: <d9f8b9413c10fcf067658979d16a4f5c7abe69e7.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f8b9413c10fcf067658979d16a4f5c7abe69e7.camel@hadess.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:17:23PM +0100, Bastien Nocera wrote:
> Hey,
> 
> TLDR: new sysfs attribute that makes it possible to leave receivers for
> wireless headsets plugged in. At the USB level, or at the base driver
> level?
> 
> Longer version:
> I started working on implementing support for some wireless headsets
> that use USB receivers to communicate to the headset itself.
> 
> The USB receivers have multiple interfaces, and independent drivers for
> each, as is wont to do for USB devices. There's usually a HID interface
> to do the custom stuff (LEDs, battery status, connection status, etc.)
> and a standard audio class interface.
> 
> Those drivers don't know anything about each other, and getting them to
> talk to each other would be rather complicated. Additionally the audio
> interface is still somewhat functional when the headset is
> disconnected.
> 
> In the end, I came up with this new sysfs attribute that would make it
> possible for user-space (PulseAudio or Pipewire) to know whether the
> receiver is plugged in or not.
> 
> That allows user-space to not show the battery information for the
> device (rather than 0 percent), not offer the headset as an output, and
> potentially automatically switch to it when the headset is powered on.
> 
> The question is whether this should be a USB sysfs attribute, or one at
> the base driver level. Example implementation of the USB sysfs
> attribute itself below.

Do you know of any non-USB devices using the receiver/emitter approach?

> I have a patch for a USB API as well, but I'm having some problems
> creating deferred work on a soft irq.
> 
> Cheers
> 
> ----
> Add a wireless_status sysfs attribute to USB devices to keep track of
> whether a USB device that uses a receiver/emitter combo has its
> emitter connected or disconnected.
> 
> By default, the USB device will declare not to use a receiver/emitter.

How do you plan to tell which devices do use a receiver/emitter?  Is 
this something the drivers already knowo about?

Is it conceivable that a single device might have more than one 
receiver?  If so, should the attribute belong to an interface rather 
than to the USB device?

Alan Stern
