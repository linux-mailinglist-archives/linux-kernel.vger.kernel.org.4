Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D277645600
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLGJEw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 04:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLGJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:04:49 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6925EB4;
        Wed,  7 Dec 2022 01:04:47 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 534291C0004;
        Wed,  7 Dec 2022 09:04:44 +0000 (UTC)
Message-ID: <1df12728a2e788788fd387588bac62023e123d16.camel@hadess.net>
Subject: Re: [Regression] Logitech BT mouse unusable after commit
 532223c8ac57 (still in 6.1-rc8)
From:   Bastien Nocera <hadess@hadess.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 10:04:43 +0100
In-Reply-To: <2262737.ElGaqSPkdT@kreacher>
References: <2262737.ElGaqSPkdT@kreacher>
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

On Tue, 2022-12-06 at 15:58 +0100, Rafael J. Wysocki wrote:
> Bastien, Jiri,
> 
> Commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the
> Logitech
> Bluetooth devices") caused my Logitech Bluetooth mouse to become
> unusable.
> 
> Appended is the change I need to make it work again (note that adding
> the
> device ID to unhandled_hidpp_devices[] doesn't help, so there must be
> some
> significant enough difference in how the two cases are handled in the
> stack).
> 
> Here's what I get in the log without the patch below:
> 
> [   36.710574] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   36.710592] Bluetooth: HIDP socket layer initialized
> [   36.724644] hid-generic 0005:046D:B016.0001: unknown main item tag
> 0x0
> [   36.725860] input: Bluetooth Mouse M336/M337/M535 Mouse as
> /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> [   36.728036] input: Bluetooth Mouse M336/M337/M535 Consumer Control
> as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> [   36.728823] input: Bluetooth Mouse M336/M337/M535 Keyboard as
> /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> [   36.731550] hid-generic 0005:046D:B016.0001: input,hidraw0:
> BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
> 9c:b6:d0:96:8e:c8
> [   36.833039] logitech-hidpp-device 0005:046D:B016.0001: unknown
> main item tag 0x0
> [   36.999064] logitech-hidpp-device 0005:046D:B016.0001: Device not
> connected
> 
> and here's what I get with it:
> 
> [   43.642546] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   43.642559] Bluetooth: HIDP socket layer initialized
> [   43.652898] hid-generic 0005:046D:B016.0001: unknown main item tag
> 0x0
> [   43.653833] input: Bluetooth Mouse M336/M337/M535 Mouse as
> /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> [   43.655025] input: Bluetooth Mouse M336/M337/M535 Consumer Control
> as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> [   43.655400] input: Bluetooth Mouse M336/M337/M535 Keyboard as
> /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-
> 7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> [   43.657521] hid-generic 0005:046D:B016.0001: input,hidraw0:
> BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on
> 9c:b6:d0:96:8e:c8
> 
> The only difference seems to be that in the former case the logitech-
> hidpp
> driver tries to bind to the device, but I guess that is expected. 

There really shouldn't be that much difference between the 2 paths,
except that hid-logitech-hidpp.c will check that the device supports
HID++ in its report descriptors, and then start talking to it to check
whether it's connected.

Maybe the device doesn't support HID++?

Can you try running src/tools/hidpp-list-features from
https://github.com/cvuchener/hidpp on the hidraw device for the mouse?

> However,
> when the device ID is added to unhandled_hidpp_devices[], the
> messages look
> exactly like in the "good" case, but the mouse still doesn't work.

Given that this should be called without ever talking to the device,
that tells me that there might be a logic bug in the hid-core that uses
->probe. Benjamin?

