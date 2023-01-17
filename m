Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC08366E338
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjAQQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjAQQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:14:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475C13E62C;
        Tue, 17 Jan 2023 08:14:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7415B81889;
        Tue, 17 Jan 2023 16:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D661C433EF;
        Tue, 17 Jan 2023 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673972078;
        bh=+onl2tpFkqXG6O+TgImNUgWo6QrOd0ZCO4JWbyipcO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vke+Xo1PYfQ4YRIsSQ1G/z6dWmbesojPwzwgjZ11fPCScwrdIaWyb2CSGO7d+ICRs
         S9/ZPcaQNNdsrS58Zj+SSULmWgUI+vZMaIowMuC2UCXIg/OSljUsOxICo4gWHuT//+
         21pQh50ChDM6xpvjPwbmvXT3/XJYdWHv/rPFvO4w=
Date:   Tue, 17 Jan 2023 17:14:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC] USB: core: Add wireless_status sysfs attribute
Message-ID: <Y8bJbM0+XcT6MRq9@kroah.com>
References: <d9f8b9413c10fcf067658979d16a4f5c7abe69e7.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f8b9413c10fcf067658979d16a4f5c7abe69e7.camel@hadess.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Would this also include wireless keyboard/mice recievers?

Why is "wireless" somehow a special attribute that userspace needs to
know about?

> The USB receivers have multiple interfaces, and independent drivers for
> each, as is wont to do for USB devices. There's usually a HID interface
> to do the custom stuff (LEDs, battery status, connection status, etc.)
> and a standard audio class interface.

This probably should be an interface attribute (as Alan points out), as
it's not a device attribute (think about updating the firmware for one
of these, that's on an interface for the reciever you plugged in, not on
the other end of the wireless connection...)

> Those drivers don't know anything about each other, and getting them to
> talk to each other would be rather complicated. Additionally the audio
> interface is still somewhat functional when the headset is
> disconnected.

Those drivers shouldn't know about each other, that's up to userspace to
group and control if needed.  No kernel interactions should be needed.

> In the end, I came up with this new sysfs attribute that would make it
> possible for user-space (PulseAudio or Pipewire) to know whether the
> receiver is plugged in or not.

Again, should be an interface attribute, if at all.

> That allows user-space to not show the battery information for the
> device (rather than 0 percent), not offer the headset as an output, and
> potentially automatically switch to it when the headset is powered on.

Same for a keyboard/mouse, right?

thanks,

greg k-h
