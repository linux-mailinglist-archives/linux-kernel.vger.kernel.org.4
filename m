Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CE6456F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLGJ7W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 04:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiLGJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:59:17 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FF13B9F8;
        Wed,  7 Dec 2022 01:59:15 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 70A2560016;
        Wed,  7 Dec 2022 09:59:11 +0000 (UTC)
Message-ID: <148b349e89b5795fa01ce13ffde7ace9fbd8d59c.camel@hadess.net>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
From:   Bastien Nocera <hadess@hadess.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 10:59:10 +0100
In-Reply-To: <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
         <2283816.ElGaqSPkdT@kreacher>
         <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
         <CAJZ5v0ibpzoBLXKiqzciYv1Htks0=4+4_XGLvpH7MCyFoYJiDg@mail.gmail.com>
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

On Wed, 2022-12-07 at 10:47 +0100, Rafael J. Wysocki wrote:
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
> 
> Well, so point me to a binary of this, please.
> 
> > But why is it needed in this case?
> 
> Because it doesn't work otherwise.
> 
> > We purposefully try to avoid blanket
> > blocklists. The lack of HID++ can be probed, so the device should
> > work
> > just as it used to (if the fallback code works).
> 
> No, because the hid-generic driver has no way to check that the probe
> function of your driver fails for this particular device.  The
> probing
> of hid-generic will fail so long as the device matches the device ID
> list of any specific HID driver.  With patch [1/2] from this series
> applied this is unless that specific driver has a ->match() callback
> rejecting the given device.
> 
> You'd need a list of drivers that have been tried and failed
> somewhere
> for that and AFAICS no such list is present in the code.

This code will start the generic HID stack if the device doesn't
support HID++:
        hidpp->supported_reports = hidpp_validate_device(hdev);

        if (!hidpp->supported_reports) {
                hid_set_drvdata(hdev, NULL);
                devm_kfree(&hdev->dev, hidpp);
                return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
        }

But in your case the device supports HID++ enough to go past that, but
fails to get the HID++ version, which makes the driver think it's not
connected, and just bails.

> So a minimum fix for 6.1 that actually works for me is to add the
> non-working device to the blocklist.  More sophisticated stuff can be
> done later.
> 
> > We should only list devices that need special handling, and the
> > ones
> > that don't work once HID++ was probed unsuccessfully.
> > 
> > >  so add it to the list of devices
> > > that are not handled by logitech-hidpp.
> > > 
> > > Fixes: 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all
> > > the
> > > Logitech Bluetooth devices")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > Index: linux-pm/drivers/hid/hid-logitech-hidpp.c
> > > =================================================================
> > > ==
> > > --- linux-pm.orig/drivers/hid/hid-logitech-hidpp.c
> > > +++ linux-pm/drivers/hid/hid-logitech-hidpp.c
> > > @@ -4274,6 +4274,7 @@ static const struct hid_device_id unhand
> > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
> > >         /* Handled in hid-generic */
> > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD) },
> > > +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb016) },
> > >         {}
> > >  };

