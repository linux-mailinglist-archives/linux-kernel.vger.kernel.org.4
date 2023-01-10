Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A756643FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjAJPDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjAJPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:03:24 -0500
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 07:03:07 PST
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1574F102;
        Tue, 10 Jan 2023 07:03:06 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id 94710FBF999;
        Tue, 10 Jan 2023 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673362466;
        s=s1; d=tuta.io;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=4FnHMSoDG+UwWAFI0bQdg+tPEV4Pse/8h0+mQ/LOzUw=;
        b=oC42p0+E3mdwVzXD4vM7LJqoRBTfAMDaZjHxXojVR9BKs39Zu5bBoqALQ9WRTpHZ
        EdrgBIGxqa+7BWM/iLQFy2GQ6e/y6YkiPqib8vkqBIShWGuuNpPjxT27BEtrHRzsOae
        jWolVarxOzc7T/K0d+43NlRAEaFWncmjSZ36T2YFtX+YRqJ/zadL6hCYYmgnJAPRGlw
        KWiu/JOnHc6rzqf9WpF01XLExRnyJslDCBMeJOphZC54F4tUyRB5qFdZqDu4AT5TLG4
        LnJ5CrWl08XNRJXLnWr0X+DugidK/SniT3eGpSP+yg4YTqROwTOgkX0C04PzD0SG3Ay
        d3wkOqSAcw==
Date:   Tue, 10 Jan 2023 15:54:26 +0100 (CET)
From:   marco.rodolfi@tuta.io
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Marco Rodolfi <marco.rodolfi@tuta.io>
Message-ID: <NLR9TEh--3-9@tuta.io>
Subject: [PATCH] HID: Ignore battery for Elan touchscreen on Asus TP420IA
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This device has a touchscreen thats report a battery even if it doesn't=20
have one.=20
Ask Linux to ignore the battery so it will not always report it as low.=20
=20
Signed-off-by: Marco Rodolfi <marco.rodolfi@tuta.io>=20
---=20
 drivers/hid/hid-ids.h =C2=A0=C2=A0| 1 +=20
 drivers/hid/hid-input.c | 2 ++=20
 2 files changed, 3 insertions(+)=20
=20
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h=20
index 8f58c3c1bec3..0f525b946cd1 100644=20
--- a/drivers/hid/hid-ids.h=20
+++ b/drivers/hid/hid-ids.h=20
@@ -413,6 +413,7 @@=20
 #define I2C_DEVICE_ID_HP_ENVY_X360_15 =C2=A00x2d05=20
 #define I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100 =C2=A0=C2=A00x29CF=20
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_15 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x2817=20
+#define I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN 0x2BC8=20
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN 0x2544=20
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN =C2=A0=C2=A00x2706=20
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN =C2=A0=C2=A00x261A=20
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c=20
index 859aeb07542e..54e2d4066d9b 100644=20
--- a/drivers/hid/hid-input.c=20
+++ b/drivers/hid/hid-input.c=20
@@ -369,6 +369,8 @@ static const struct hid_device_id hid_battery_quirks[] =
=3D {=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ HID_BLUETOOTH_DEVICE(USB_VENDO=
R_ID_LOGITECH,=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD),=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HID_BATTERY_QUIRK_IG=
NORE },=20
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, =
I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN)
,=20
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HID_BATTERY_QUIRK_IGNORE =
},=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ HID_USB_DEVICE(USB_VENDOR_ID_E=
LAN, USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN),=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HID_BATTERY_QUIRK_IG=
NORE },=20
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ HID_USB_DEVICE(USB_VENDOR_ID_E=
LAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN)
,=20
-- =C2=A0
2.39.0=20

=20
