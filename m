Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768E16456F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLGJ7R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 04:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiLGJ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:59:10 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B00A2CC86;
        Wed,  7 Dec 2022 01:59:08 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7AECF10000E;
        Wed,  7 Dec 2022 09:59:03 +0000 (UTC)
Message-ID: <2a01f3694f683fb6fcff67555ee4106ee48eac29.camel@hadess.net>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Wed, 07 Dec 2022 10:59:03 +0100
In-Reply-To: <CAO-hwJLoAXt_uhT7bwphw1PW=4oQsOc_G3yACg-LQrerNx3yFA@mail.gmail.com>
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
         <2283816.ElGaqSPkdT@kreacher>
         <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
         <CAO-hwJLoAXt_uhT7bwphw1PW=4oQsOc_G3yACg-LQrerNx3yFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-07 at 10:48 +0100, Benjamin Tissoires wrote:
> On Wed, Dec 7, 2022 at 10:29 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Wed, 2022-12-07 at 10:12 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Evidently, Logitech Bluetooth Mouse M336/M337/M535 (0xb016) does
> > > not
> > > work when HID++ is enabled for it,
> > 
> > This needs the output of the hidpp-list-features tool mentioned
> > earlier
> > in the thread so we can avoid words like "evidently" and provide
> > concrete proof.
> > 
> > But why is it needed in this case? We purposefully try to avoid
> > blanket
> > blocklists. The lack of HID++ can be probed, so the device should
> > work
> > just as it used to (if the fallback code works).
> 
> If I read the probe function correctly, we should have the HID++
> reports present, so a static analysis will not allow us to detect
> that
> information.
> 
> However, this reminds me of the Litra Glow[0]. On this device,
> hidpp_root_get_protocol_version() also reports an error when it is
> obvious it is connected.

On the Litra Glow, the error isn't HIDPP_ERROR_RESOURCE_ERROR, but
HIDPP20_ERROR_UNSUPPORTED (0x09). I have a patch to add those constants
to the driver.

> And AFAICT, a BLE device is supposed to always be connected when it
> is
> presented to the kernel (because disconnect is handled in the BLE
> layer, in bluez).
> 
> Apparently Rafael's mouse is Bluetooth classic, so I have a doubt on
> what happens when it goes into low power.

It would probably just disconnect after a timeout. Reconnection isn't
as fast as with BLE, but it's fast enough.

> > We should only list devices that need special handling, and the
> > ones
> > that don't work once HID++ was probed unsuccessfully.
> > 
> 
> Given the current state of Rafael's mouse it goes into the second
> category. But I suspect we should be smarter in the probe's decision
> to consider if a device is connected or not.

Sure, and that's the data I'm trying to get out of the device.

> 
> Cheers,
> Benjamin
> 
> [0]
> https://lore.kernel.org/linux-input/CABfF9mO3SQZvkQGOC09H5s7EEd2UGhpE=GYB46g_zF3aEOVn=Q@mail.gmail.com/
> 

