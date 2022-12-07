Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03464582F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLGKvI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 05:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:51:04 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6045A0F;
        Wed,  7 Dec 2022 02:51:01 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8B944240003;
        Wed,  7 Dec 2022 10:50:58 +0000 (UTC)
Message-ID: <cd8b2a2160f5d36d1b73bc0567cd0f6e7e5751c4.camel@hadess.net>
Subject: Re: [Regression] Logitech BT mouse unusable after commit
 532223c8ac57 (still in 6.1-rc8)
From:   Bastien Nocera <hadess@hadess.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 11:50:57 +0100
In-Reply-To: <CAJZ5v0gjAGZFS6ap+NAbsi96hq7y9MRGE0h_A-n6xfB1CMs=2g@mail.gmail.com>
References: <2262737.ElGaqSPkdT@kreacher>
         <1df12728a2e788788fd387588bac62023e123d16.camel@hadess.net>
         <2145955.irdbgypaU6@kreacher>
         <CAJZ5v0ic+pm+NWD8g4O2MwQEvi+xuB-W9Wpd6c1RhprhoxuK1g@mail.gmail.com>
         <8281ddcc16cc950f9cde4b196cf208adcc798319.camel@hadess.net>
         <CAJZ5v0gjAGZFS6ap+NAbsi96hq7y9MRGE0h_A-n6xfB1CMs=2g@mail.gmail.com>
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

On Wed, 2022-12-07 at 11:07 +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 7, 2022 at 10:59 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Wed, 2022-12-07 at 10:36 +0100, Rafael J. Wysocki wrote:
> > > On Wed, Dec 7, 2022 at 10:16 AM Rafael J. Wysocki
> > > <rjw@rjwysocki.net>
> > > wrote:
> > > > 
> > > > On Wednesday, December 7, 2022 10:04:43 AM CET Bastien Nocera
> > > > wrote:
> > > > > On Tue, 2022-12-06 at 15:58 +0100, Rafael J. Wysocki wrote:
> > > > > > Bastien, Jiri,
> > > > > > 
> > > > > > Commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for
> > > > > > all
> > > > > > the
> > > > > > Logitech
> > > > > > Bluetooth devices") caused my Logitech Bluetooth mouse to
> > > > > > become
> > > > > > unusable.
> > > > > > 
> > > > > > Appended is the change I need to make it work again (note
> > > > > > that
> > > > > > adding
> > > > > > the
> > > > > > device ID to unhandled_hidpp_devices[] doesn't help, so
> > > > > > there
> > > > > > must be
> > > > > > some
> > > > > > significant enough difference in how the two cases are
> > > > > > handled
> > > > > > in the
> > > > > > stack).
> > > > > > 
> > > > > > Here's what I get in the log without the patch below:
> > > > > > 
> > > > > > [   36.710574] Bluetooth: HIDP (Human Interface Emulation)
> > > > > > ver
> > > > > > 1.2
> > > > > > [   36.710592] Bluetooth: HIDP socket layer initialized
> > > > > > [   36.724644] hid-generic 0005:046D:B016.0001: unknown
> > > > > > main
> > > > > > item tag
> > > > > > 0x0
> > > > > > [   36.725860] input: Bluetooth Mouse M336/M337/M535 Mouse
> > > > > > as
> > > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input
> > > > > > 14
> > > > > > [   36.728036] input: Bluetooth Mouse M336/M337/M535
> > > > > > Consumer
> > > > > > Control
> > > > > > as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input
> > > > > > 15
> > > > > > [   36.728823] input: Bluetooth Mouse M336/M337/M535
> > > > > > Keyboard
> > > > > > as
> > > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input
> > > > > > 18
> > > > > > [   36.731550] hid-generic 0005:046D:B016.0001:
> > > > > > input,hidraw0:
> > > > > > BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535]
> > > > > > on
> > > > > > 9c:b6:d0:96:8e:c8
> > > > > > [   36.833039] logitech-hidpp-device 0005:046D:B016.0001:
> > > > > > unknown
> > > > > > main item tag 0x0
> > > > > > [   36.999064] logitech-hidpp-device 0005:046D:B016.0001:
> > > > > > Device not
> > > > > > connected
> > > > > > 
> > > > > > and here's what I get with it:
> > > > > > 
> > > > > > [   43.642546] Bluetooth: HIDP (Human Interface Emulation)
> > > > > > ver
> > > > > > 1.2
> > > > > > [   43.642559] Bluetooth: HIDP socket layer initialized
> > > > > > [   43.652898] hid-generic 0005:046D:B016.0001: unknown
> > > > > > main
> > > > > > item tag
> > > > > > 0x0
> > > > > > [   43.653833] input: Bluetooth Mouse M336/M337/M535 Mouse
> > > > > > as
> > > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input
> > > > > > 14
> > > > > > [   43.655025] input: Bluetooth Mouse M336/M337/M535
> > > > > > Consumer
> > > > > > Control
> > > > > > as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input
> > > > > > 15
> > > > > > [   43.655400] input: Bluetooth Mouse M336/M337/M535
> > > > > > Keyboard
> > > > > > as
> > > > > > /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> > > > > > 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input
> > > > > > 18
> > > > > > [   43.657521] hid-generic 0005:046D:B016.0001:
> > > > > > input,hidraw0:
> > > > > > BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535]
> > > > > > on
> > > > > > 9c:b6:d0:96:8e:c8
> > > > > > 
> > > > > > The only difference seems to be that in the former case the
> > > > > > logitech-
> > > > > > hidpp
> > > > > > driver tries to bind to the device, but I guess that is
> > > > > > expected.
> > > > > 
> > > > > There really shouldn't be that much difference between the 2
> > > > > paths,
> > > > > except that hid-logitech-hidpp.c will check that the device
> > > > > supports
> > > > > HID++ in its report descriptors, and then start talking to it
> > > > > to
> > > > > check
> > > > > whether it's connected.
> > > > > 
> > > > > Maybe the device doesn't support HID++?
> > > > 
> > > > Quite possibly.
> > > > 
> > > > > Can you try running src/tools/hidpp-list-features from
> > > > > https://github.com/cvuchener/hidpp on the hidraw device for
> > > > > the
> > > > > mouse?
> > > > 
> > > > OK, I'll do that.
> > > 
> > > Well, I would if I had a binary.
> > > 
> > > Otherwise, I have cmake 3.17 which apparently is too old, sorry.
> > 
> > Revert 308f240585380dd0af4d9f5bbec5eb01e103deca and it will just
> > require 3.12.
> 
> OK
> 
> It says:
> 
> /dev/hidraw0 (device 0): Bluetooth Mouse M336/M337/M535 (046d:b016)
> HID++ 4.5

This is hidpp-list-devices, not hidpp-list-features.

Which of the 3 models above is it?

For comparison, this is what happens on my (newer Bluetooth LE/Bolt
mouse):
$ sudo ./_build/src/tools/hidpp-list-features /dev/hidraw5
Logitech Signature M650 Mouse (046d:b02a) is a HID++ 4.5 device
Feature 0x01: [0x0001] Feature set
Feature 0x02: [0x0003] Device FW version
Feature 0x03: [0x0005] Device name
Feature 0x04: [0x1d4b] Wireless device status
Feature 0x05: [0x0020] Reset
Feature 0x06: [0x0007] Device Friendly Name
Feature 0x07: [0x1004] ?
Feature 0x08: [0x1b04] Reprog controls v4
Feature 0x09: [0x1815] Hosts info
Feature 0x0a: [0x2250] ?
Feature 0x0b: [0x2130] Low-res wheel
Feature 0x0c: [0x2201] Adjustable dpi
Feature 0x0d: [0x00c3] ?
Feature 0x0e: [0x1802] Device reset (hidden, internal)
Feature 0x0f: [0x1803] ? (hidden, internal)
Feature 0x10: [0x1806] Configurable device properties (hidden,
internal)
Feature 0x11: [0x1816] ? (hidden, internal)
Feature 0x12: [0x1805] OOBState (hidden, internal)
Feature 0x13: [0x1830] ? (hidden, internal)
Feature 0x14: [0x1891] ? (hidden, internal)
Feature 0x15: [0x18a1] ? (hidden, internal)
Feature 0x16: [0x1e00] Enable hidden features (hidden)
Feature 0x17: [0x1e02] ? (hidden, internal)
Feature 0x18: [0x1e22] ? (hidden, internal)
Feature 0x19: [0x1602] ?
Feature 0x1a: [0x1eb0] ? (hidden, internal)
Feature 0x1b: [0x1861] ? (hidden, internal)
Feature 0x1c: [0x18b1] ? (hidden, internal)
Feature 0x1d: [0x920a] ? (hidden, internal)

