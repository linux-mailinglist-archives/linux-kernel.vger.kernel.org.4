Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1544C64567C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiLGJ3i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 04:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLGJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:29:31 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218C23D93B;
        Wed,  7 Dec 2022 01:29:21 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 99A352000C;
        Wed,  7 Dec 2022 09:29:16 +0000 (UTC)
Message-ID: <e7eb0e0c9aea30c0e3205b2f3d96b74a52283b40.camel@hadess.net>
Subject: Re: [PATCH v1 2/2] HID: logitech-hidpp: Add Bluetooth Mouse
 M336/M337/M535 to unhandled_hidpp_devices[]
From:   Bastien Nocera <hadess@hadess.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Date:   Wed, 07 Dec 2022 10:29:16 +0100
In-Reply-To: <2283816.ElGaqSPkdT@kreacher>
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
         <2283816.ElGaqSPkdT@kreacher>
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

On Wed, 2022-12-07 at 10:12 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Evidently, Logitech Bluetooth Mouse M336/M337/M535 (0xb016) does not
> work when HID++ is enabled for it,

This needs the output of the hidpp-list-features tool mentioned earlier
in the thread so we can avoid words like "evidently" and provide
concrete proof.

But why is it needed in this case? We purposefully try to avoid blanket
blocklists. The lack of HID++ can be probed, so the device should work
just as it used to (if the fallback code works).

We should only list devices that need special handling, and the ones
that don't work once HID++ was probed unsuccessfully.

>  so add it to the list of devices
> that are not handled by logitech-hidpp.
> 
> Fixes: 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the
> Logitech Bluetooth devices")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-pm/drivers/hid/hid-logitech-hidpp.c
> ===================================================================
> --- linux-pm.orig/drivers/hid/hid-logitech-hidpp.c
> +++ linux-pm/drivers/hid/hid-logitech-hidpp.c
> @@ -4274,6 +4274,7 @@ static const struct hid_device_id unhand
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
>         /* Handled in hid-generic */
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb016) },
>         {}
>  };
>  
> 
> 
> 

