Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E82F645608
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLGJHp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 04:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:07:40 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635E2F4;
        Wed,  7 Dec 2022 01:07:37 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 594B3240005;
        Wed,  7 Dec 2022 09:07:34 +0000 (UTC)
Message-ID: <7fabe0c91945b61bae7825dfcdbc2f88d0f2b98c.camel@hadess.net>
Subject: Re: [Regression] Logitech BT mouse unusable after commit
 532223c8ac57 (still in 6.1-rc8)
From:   Bastien Nocera <hadess@hadess.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 10:07:33 +0100
In-Reply-To: <CAJZ5v0jBo-_XnN2m0jeVdeTi7kjr6C3OSzc1NEJgav0srD0JGQ@mail.gmail.com>
References: <2262737.ElGaqSPkdT@kreacher>
         <CAJZ5v0jBo-_XnN2m0jeVdeTi7kjr6C3OSzc1NEJgav0srD0JGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-07 at 09:58 +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 6, 2022 at 3:58 PM Rafael J. Wysocki <rjw@rjwysocki.net>
> wrote:
> > 
> > Bastien, Jiri,
> > 
> > Commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the
> > Logitech
> > Bluetooth devices") caused my Logitech Bluetooth mouse to become
> > unusable.
> > 
> > Appended is the change I need to make it work again (note that
> > adding the
> > device ID to unhandled_hidpp_devices[] doesn't help, so there must
> > be some
> > significant enough difference in how the two cases are handled in
> > the stack).
> > 
> > Here's what I get in the log without the patch below:
> > 
> > [   36.710574] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> > [   36.710592] Bluetooth: HIDP socket layer initialized
> > [   36.724644] hid-generic 0005:046D:B016.0001: unknown main item
> > tag 0x0
> > [   36.725860] input: Bluetooth Mouse M336/M337/M535 Mouse as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> > [   36.728036] input: Bluetooth Mouse M336/M337/M535 Consumer
> > Control as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> > [   36.728823] input: Bluetooth Mouse M336/M337/M535 Keyboard as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> > [   36.731550] hid-generic 0005:046D:B016.0001: input,hidraw0:
> > BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
> > 9c:b6:d0:96:8e:c8
> > [   36.833039] logitech-hidpp-device 0005:046D:B016.0001: unknown
> > main item tag 0x0
> > [   36.999064] logitech-hidpp-device 0005:046D:B016.0001: Device
> > not connected
> > 
> > and here's what I get with it:
> > 
> > [   43.642546] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> > [   43.642559] Bluetooth: HIDP socket layer initialized
> > [   43.652898] hid-generic 0005:046D:B016.0001: unknown main item
> > tag 0x0
> > [   43.653833] input: Bluetooth Mouse M336/M337/M535 Mouse as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> > [   43.655025] input: Bluetooth Mouse M336/M337/M535 Consumer
> > Control as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> > [   43.655400] input: Bluetooth Mouse M336/M337/M535 Keyboard as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> > [   43.657521] hid-generic 0005:046D:B016.0001: input,hidraw0:
> > BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
> > 9c:b6:d0:96:8e:c8
> > 
> > The only difference seems to be that in the former case the
> > logitech-hidpp
> > driver tries to bind to the device, but I guess that is expected. 
> > However,
> > when the device ID is added to unhandled_hidpp_devices[], the
> > messages look
> > exactly like in the "good" case, but the mouse still doesn't work.
> 
> Here's what happens.
> 
> - The logitech-hidpp driver is modular and is not present initially,
> so hid-generic probes first (successfully).
> 
> - logitech-hidpp is loaded which causes the device to be reporobed
> due
> to __hid_bus_driver_added().
> 
> - Because the ->match() callback in hid-generic returns 0 for the
> device now, it is unbound from the device.
> 
> - The probing of logitech-hidpp fails (due to an error in ->probe()).
> 
> - The probing of hid-generic fails due to the failing ->match().
> 
> So in order for unhandled_hidpp_devices[] in logitech-hidpp to work
> with hid-generic, __check_hid_generic() needs to be amended with a
> change to run the ->match() callback of the "specific" driver being
> tried.
> 
> I have a working patch for this that will be sent shortly.

I'm glad my belated questioning of the hid-generic fallback code was
correct ;)

My question about getting the output from the HID++ tool still stands
though.
