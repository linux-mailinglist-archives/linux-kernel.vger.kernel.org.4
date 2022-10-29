Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B037D6124B4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJ2RfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJ2Re4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:34:56 -0400
Received: from redpilled.dev (redpilled.dev [IPv6:2a01:4f8:1c1c:f8e2::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EC10FCC;
        Sat, 29 Oct 2022 10:34:51 -0700 (PDT)
Date:   Sat, 29 Oct 2022 20:34:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redpilled.dev;
        s=mail; t=1667064889;
        bh=h3mGwizRktjW9xsjaOG3vg/Kh6l2SlXpVsNYlVEB6Ig=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=WCmOSJPh1IPrj1M5MhGQU5TNW+qJCtok//7gmFlCbO5VfR7HK1d8GYcoTfMwt/CCZ
         oVmCXpBkPXAD+fyZVCU2GY34tiYxXQSpJVV+fSjZMQpQ/F/9c2NgJkH076HHcMcuVx
         tVVaWybV1gNA0TUkSTa8L7MFPIthVY7Erdl9AVZ4=
From:   Mia Kanashi <chad@redpilled.dev>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
CC:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] HID: input: do not query XP-PEN Deco LW battery
In-Reply-To: <20221029161240.15548-2-jose.exposito89@gmail.com>
References: <20221029161240.15548-1-jose.exposito89@gmail.com> <20221029161240.15548-2-jose.exposito89@gmail.com>
Message-ID: <1701DB3A-5538-4B58-8232-E6705B9C70DF@redpilled.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 October 2022 19:12:39 EEST, "Jos=C3=A9 Exp=C3=B3sito" <jose=2Eexposit=
o89@gmail=2Ecom> wrote:
>The XP-PEN Deco LW drawing tablet can be connected by USB cable or using
>a USB Bluetooth dongle=2E When it is connected using the dongle, there
>might be a small delay until the tablet is paired with the dongle=2E
>
>Fetching the device battery during this delay results in random battery
>percentage values=2E
>
>Add a quirk to avoid actively querying the battery percentage and wait
>for the device to report it on its own=2E
>
>Reported-by: Mia Kanashi <chad@redpilled=2Edev>
>Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose=2Eexposito89@gmail=2Ecom>
>---
> drivers/hid/hid-input=2Ec | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/hid/hid-input=2Ec b/drivers/hid/hid-input=2Ec
>index 859aeb07542e=2E=2Ed728a94c642e 100644
>--- a/drivers/hid/hid-input=2Ec
>+++ b/drivers/hid/hid-input=2Ec
>@@ -340,6 +340,7 @@ static enum power_supply_property hidinput_battery_pr=
ops[] =3D {
> #define HID_BATTERY_QUIRK_PERCENT	(1 << 0) /* always reports percent */
> #define HID_BATTERY_QUIRK_FEATURE	(1 << 1) /* ask for feature report */
> #define HID_BATTERY_QUIRK_IGNORE	(1 << 2) /* completely ignore the batte=
ry */
>+#define HID_BATTERY_QUIRK_AVOID_QUERY	(1 << 3) /* do not query the batte=
ry */
>=20
> static const struct hid_device_id hid_battery_quirks[] =3D {
> 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>@@ -373,6 +374,8 @@ static const struct hid_device_id hid_battery_quirks[=
] =3D {
> 	  HID_BATTERY_QUIRK_IGNORE },
> 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSC=
REEN),
> 	  HID_BATTERY_QUIRK_IGNORE },
>+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DE=
CO_L),
>+	  HID_BATTERY_QUIRK_AVOID_QUERY },
> 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15),
> 	  HID_BATTERY_QUIRK_IGNORE },
> 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15T_DR1=
00),
>@@ -554,6 +557,9 @@ static int hidinput_setup_battery(struct hid_device *=
dev, unsigned report_type,
> 	dev->battery_avoid_query =3D report_type =3D=3D HID_INPUT_REPORT &&
> 				   field->physical =3D=3D HID_DG_STYLUS;
>=20
>+	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
>+		dev->battery_avoid_query =3D true;
>+
> 	dev->battery =3D power_supply_register(&dev->dev, psy_desc, &psy_cfg);
> 	if (IS_ERR(dev->battery)) {
> 		error =3D PTR_ERR(dev->battery);

I've tested this patch and now power supply status is correctly set to Unk=
nown and capacity is set to 0 initially=2E

Just a note that that issue occured not only with the dongle, but a cable =
also=2E
It seems that tablet just doesn't respond to the query=2E

Thank you for the work!
