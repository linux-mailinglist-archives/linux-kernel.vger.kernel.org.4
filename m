Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F85667B20B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjAYLwu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Jan 2023 06:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjAYLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:52:47 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBEA5FC5;
        Wed, 25 Jan 2023 03:52:44 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id C3A8EE0005;
        Wed, 25 Jan 2023 11:52:41 +0000 (UTC)
Message-ID: <39fcf3b6b0954873d5e7cdcabcd26a63178619b8.camel@hadess.net>
Subject: Re: [PATCH 2/3] HID: logitech-hidpp: Don't restart communication if
 not necessary
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Date:   Wed, 25 Jan 2023 12:52:41 +0100
In-Reply-To: <CAO-hwJJb+hkCpqbiF0Zw8Ot4aCJDpgvMXpVS6rCoMe7QWkhiCg@mail.gmail.com>
References: <20221220092207.428640-1-hadess@hadess.net>
         <20221220092207.428640-2-hadess@hadess.net>
         <a75e34efce22ab1de8f0a2e247294a441e710193.camel@hadess.net>
         <CAO-hwJJb+hkCpqbiF0Zw8Ot4aCJDpgvMXpVS6rCoMe7QWkhiCg@mail.gmail.com>
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

On Wed, 2023-01-25 at 11:18 +0100, Benjamin Tissoires wrote:
> On Tue, Jan 24, 2023 at 6:20 PM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Tue, 2022-12-20 at 10:22 +0100, Bastien Nocera wrote:
> > > Don't stop and restart communication with the device unless we
> > > need
> > > to
> > > modify the connect flags used because of a device quirk.
> > 
> > FIWW, Andreas Bergmeier told me off-list that this fixed their
> > problem
> > with the Litra Glow not connecting properly.
> > 
> > Would be great to have reviews on this and my other HID++ patches.
> 
> Sigh. I reviewed the patches just now (well, v2 at least), and
> thought
> I better give a shot at it before merging, and it turns out that this
> patch breaks the Unifying receivers.
> 
> Without it, each device presented to the user space has a proper
> name:
> 
> logitech-hidpp-device 0003:046D:4041.001C: input,hidraw15: USB HID
> v1.11 Keyboard [Logitech MX Master] on usb-0000:01:00.0-4/input2:5
> 
> But with it, I get:
> 
> logitech-hidpp-device 0003:046D:4041.0024: input,hidraw8: USB HID
> v1.11 Keyboard [Logitech Wireless Device PID:4041] on
> usb-0000:00:14.0-8.2.4/input2:5
> 
> This is because we present the device to the userspace before being
> able to fetch the name from the receiver.
> 
> I think we should make that connect/disconnect a special case of the
> receivers too. Or maybe if the bus is not Bluetooth or USB, do the
> disconnect/reconnect.

From what I can tell, this would mean restarting the connection in case
hidpp_unifying_init() did anything, right?

I'll test this out and update the patch.

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4547e9580101..e0c28257f598 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4392,8 +4392,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
        /* Allow incoming packets */
        hid_device_io_start(hdev);
 
-       if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
-               hidpp_unifying_init(hidpp);
+       if (hidpp->quirks & HIDPP_QUIRK_UNIFYING) {
+               if (hidpp_unifying_init(hidpp) == 0)
+                       will_restart = true;
+       }
 
        connected = hidpp_root_get_protocol_version(hidpp) == 0;
        atomic_set(&hidpp->connected, connected);

