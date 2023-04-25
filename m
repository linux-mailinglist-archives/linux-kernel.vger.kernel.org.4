Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2006EDDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjDYI0X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Apr 2023 04:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjDYI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:26:21 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FB5242;
        Tue, 25 Apr 2023 01:26:18 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D4CE52000F;
        Tue, 25 Apr 2023 08:26:15 +0000 (UTC)
Message-ID: <6faea48203e5fe2f4c95106dd95ffceed8c5f236.camel@hadess.net>
Subject: Re: [PATCH v3] Add rumble support to latest xbox controllers
From:   Bastien Nocera <hadess@hadess.net>
To:     Siarhei Vishniakou <svv@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Apr 2023 10:26:15 +0200
In-Reply-To: <20230425010618.2303982-1-svv@google.com>
References: <20230425010618.2303982-1-svv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-24 at 18:06 -0700, Siarhei Vishniakou wrote:
> Currently, rumble is only supported via bluetooth on a single xbox
> controller, called 'model 1708'. On the back of the device, it's named
> 'wireless controller for xbox one'. However, in 2021, Microsoft released
> a firmware update for this controller. As part of this update, the HID
> descriptor of the device changed. The product ID was also changed from
> 0x02fd to 0x0b20. On this controller, rumble was supported via
> hid-microsoft, which matched against the old product id (0x02fd). As a
> result, the firmware update broke rumble support on this controller.
> 
> The hid-microsoft driver actually supports rumble on the new firmware,
> as well. So simply adding new product id is sufficient to bring back
> this support.
> 
> After discussing further with the xbox team, it was pointed out that
> another xbox controller, xbox elite series 2, can be supported in a
> similar way.
> 
> Add rumble support for all of these devices in this patch. Two of the
> devices have received firmware updates that caused their product id's to
> change. Both old and new firmware versions of these devices were tested.
> 
> The tested controllers are:
> 
> 1. 'wireless controller for xbox one', model 1708
> 2. 'xbox wireless controller', model 1914. This is also sometimes
>    referred to as 'xbox series S|X'.
> 3. 'elite series 2', model 1797.
> 
> The tested configurations are:
> 1. model 1708, pid 0x02fd (old firmware)
> 2. model 1708, pid 0x0b20 (new firmware)
> 3. model 1914, pid 0x0b13
> 4. model 1797, pid 0x0b05 (old firmware)
> 5. model 1797, pid 0x0b22 (new firmware)
> 
> I verified rumble support on both bluetooth and usb.
> 
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Siarhei Vishniakou <svv@google.com>
> ---
>  drivers/hid/hid-ids.h       |  8 +++++++-
>  drivers/hid/hid-microsoft.c | 11 ++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 053853a891c5..5d98b2a3a5e4 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -903,7 +903,13 @@
>  #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
>  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
>  #define USB_DEVICE_ID_MS_SURFACE3_COVER                0x07de
> -#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER 0x02fd
> +// For a description of the Xbox controller models, refer to:
> +// https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary

The kernel doesn't use C++ style comments, but C-style comments.
Checking your patch with checkpatch.pl should warn about it:
https://docs.kernel.org/process/submitting-patches.html#style-check-your-changes

> +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708    0x02fd
> +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE        0x0b20

The 1708 model uses Bluetooth Classic, not Bluetooth LE.

> +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914    0x0b13
> +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797    0x0b05
> +#define USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE        0x0b22
>  #define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
>  #define USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS      0x02e0
>  
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 071fd093a5f4..9345e2bfd56e 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -446,7 +446,16 @@ static const struct hid_device_id ms_devices[] = {
>                 .driver_data = MS_PRESENTER },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
>                 .driver_data = MS_SURFACE_DIAL },
> -       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
> +
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708),
> +               .driver_data = MS_QUIRK_FF },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_BLE),
> +               .driver_data = MS_QUIRK_FF },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914),
> +               .driver_data = MS_QUIRK_FF },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797),
> +               .driver_data = MS_QUIRK_FF },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1797_BLE),
>                 .driver_data = MS_QUIRK_FF },
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
>                 .driver_data = MS_QUIRK_FF },

