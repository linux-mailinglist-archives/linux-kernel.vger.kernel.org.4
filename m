Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E869174A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjBJDpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjBJDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:45:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2089.outbound.protection.outlook.com [40.92.23.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1168A55E5A;
        Thu,  9 Feb 2023 19:45:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq0vh44UbwtEHAUqvSlyip6a7T1aVA9jpYGJC0+OI4rhrL7WMZTXs5qiI2v7obrC19h1D5OqO1HqhSZmUyHzO7+E5w+ENa8B34sM8HNG34iQjvgkAOilrNm2i35Gmdw9hnQo/dyzqaqctPJ5PO8981oVPxRC4Y+iDSsfj9WN8pJ+N0ShHn01x4doVZ7okpp1cHYBmhv9RxmZRbokLvoU5cpvkInjnhCoEsNfrT2uednOsEieiWoVT1ycnlYcX3FsRwCKw0VB3rEUTwetymQHZNkuv1miAg0SdcySld1c5Ri/ZcqnGINbgmZ4718r6TCzkIzb8STjzXQ2wO5ECVTJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGbaXX8RSvYbjyEeO9URTT0RTL7VsDmglSbcAradVP4=;
 b=YqLQP+CBFOUp5ldVzJ0GR3mYyxFTPFTPrWyE8P3oQb9mW8hCM7EzoFFeqC/C4C77sch4bJ9tO+YQ0ezBKIloBs7YoUds8YWy1Ia1s09zqWPGdsvFGwEhtfSfUHzVa3NIxziBLW92IPdyi34ow4rBPblCc63eckYP1OzjD0YDqtqeCQ1Ks6rDB6xntBSniBji3GVP2w0iTf0uoramLcUV8BBv8XMdWEfr4vUrwCHUu5ZXTDOMi8JqsvblY9hoWFDycAC4aV8r2TJ1YZgnRg3bJVa6zuWBLge7dvVgOmOAxxWAz6HzqE6tLF98dIlVoMlppAnppAusYwAKAwYnSWyc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGbaXX8RSvYbjyEeO9URTT0RTL7VsDmglSbcAradVP4=;
 b=gozhCjyeFpdDc42uNwLtyfZhqtijjJ5d8S4KsGfU48bMyf4uaW0e+pOAA24b+wpwMsHrW0F/r8oqt5MHqwXgRP4va5OBF1HBC17zUHBxe/6HeeMdrahNxujOPAISa8EBtnLKXSsHNLfhzBRI5gaypVDqI65RZbISyCKBMBmw4Y2Lobz+krDU6BK08JMBsOVoKWfUEFaH01nv301o+jRESBznnX+wLH6xnQHsONzIkcKTQdrF/mUilPs3fAr3KNTqGRSjkHDRa3lC/0A2secM8fWYVCEEkZa4ZTZvRoPWnyeNxQNA4PzJGvIOJ1VTxK3ZIJLE6gBm2f9bgxbOMUW1Kg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB5554.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:61::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19; Fri, 10 Feb 2023 03:45:15 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 03:45:15 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Thread-Topic: [PATCH 3/3] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Thread-Index: AQHZPQIWS64uJ4UU002DT0+XMdJmAQ==
Date:   Fri, 10 Feb 2023 03:45:15 +0000
Message-ID: <7D70F1FE-7F54-4D0A-8922-5466AA2AD364@live.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
In-Reply-To: <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [J+R67hDQf1GVocUIdVvd5qZEgysQmup0]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB5554:EE_
x-ms-office365-filtering-correlation-id: 1b2b259c-47c6-4272-63d2-08db0b1938ba
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pCShkIKLV2uTtaII1hch92VBEW9ZPomICahicj6IWQ177ceSQeOZhIbGxRskF8kFvFP+0cwROpW5FEOH8CAcXgSmdPvcp7NHcG2Gejf/TuYWtDKkpWNtKmFPYCAPiNZhfTj6wcceSW05rbnVdjuXLDPlacOpP2V/XrujLjwUjQZAOxQJkPh3KTZk03M9xV2XB1cT3p8TLDeGqn4qECwS+M+oYt+9RaObWW9St0nrqBomqKv7K+VonVu6S3zZWfZrkUPqq69Pe2+QazcLBPn1G9aDwK4VQe+gLwyoWaBSQ2O61AFduPGx+L3i6jOpe4gP+uHJh+UTSCymb7ThG3jZsHS59o0SaynPNLqnM2Kex2rPAla49aagvMev7Rsz3MC2M7SsPJ8+/ybwNTpNiY/xSsg6WVmtVxW5ulec/Szjb/h5SCSm8QOCtsLXYCGXRXfvnLLw38hHj13PEoSUUBbtcxD92X+dCqjATdCMnggH2ZOdKv+n1KGbV8OEJIefoyIF6Gff1ZXax+6v8k+m09ETQ4He66TmeZDCSHz+gh4wEqbPjzGHcfK0/5Xt6Y35ia1VL28vYgXZa6rwgZDL86cdi5cvFC3Z0lokVpSbBdmDBfw=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?13fy/mTm9oHvtXlp+tZqTrkC/nN6bBt47PPDEGPEjdJchvLt/gUqBxMSUtVB?=
 =?us-ascii?Q?UB1vpD2LQaHOyGFeExj9DQ27/lV2GY5HN4YhLVKNqRZqvJ75mWjuCPwxV1a4?=
 =?us-ascii?Q?JZtY2nwp6xyKlG6EDUvQpfgSezJGWtlGCUSiPBIfmc92lN6uHFsdWpiNzTAi?=
 =?us-ascii?Q?lB5qkO+efaWUQo0v/AQTuppCgnturcabtYl9FRVBsMaJWWct0LN30X5zRkVO?=
 =?us-ascii?Q?H08vWh6kntqPE2AgNJCXWXTYxmxzqaAf4grHYHdfj0RhtCyjxdWr/mdR/HUo?=
 =?us-ascii?Q?YK/goEumsNe7YCo0cUk+OWD29Oin8BRcXWDLktEFof+uiG1ZRhLMMUMVTebl?=
 =?us-ascii?Q?iQVUcwWeMwamU3xrGV1Eard6gsd+0bM5CNL1LGwbZePER3AfP8SnzlRR9o/c?=
 =?us-ascii?Q?lToOt0eKiTG3vOV1DpF6xKBXVo/qDYAWenJb9RO9ybutoCfQkEJiAxhbfNfR?=
 =?us-ascii?Q?j11Oa2DTb6UU5cFTf6BLTaNN1dMutG0QoMGsT04+jQO+UxIITmiI7mDQfLaa?=
 =?us-ascii?Q?YcQ8glcp32axLZhYDWYJYh07h8OPeH4qPTh6SCJ/2cP6bXLb2WEduUKpEn27?=
 =?us-ascii?Q?7TffoLxuEx+ceT68UnlqYSKsZKDYfOrkSeuTQcO4hhjNNaW+miI9joaMSVT7?=
 =?us-ascii?Q?THJ/NmfY127AHLi+KwlnPihLcojjCbNPZ7B5F+ZQvOyga2XWH/ck+u+o/GkD?=
 =?us-ascii?Q?q9XzafoFdWNS9kPjs+b85DU7H06eouElJWxw4CE/WA1PNBStkK1i8ShUqbbm?=
 =?us-ascii?Q?SrTbZ3MyfGCECB+D/h3pbw0n8ZVO68uPGgeeBSPPDZUoQsIN3PFmVuQBOBl4?=
 =?us-ascii?Q?maoTsrfJEm7+YXqZAq6dazGQR6TQzj/j+rymKnYUrqC/oGUOStgUK39YXPvc?=
 =?us-ascii?Q?Zg4jmu3BVJL5VpCllHDE44qrz9JdT1XP2r8+oLJzoMC6kJO48sMfVH0av5+i?=
 =?us-ascii?Q?Vutoe9kbihwkC2Xi/t35tHVHA2dSal7hxnw1LHm+4LVFyC7EA7FYnug12YQf?=
 =?us-ascii?Q?4UajNQ2pCj4se2bVStDG/4iS+3+IwIvbxyTW334i5f53Oh806XSXgJQ+qyrt?=
 =?us-ascii?Q?p/2jHgVMuBfEnr2I1uZHydMVEB4L2zykvE6292mKt6nk3io0f6ef2J2edQ+a?=
 =?us-ascii?Q?VYoYycE7fdPVu8rh3MGb8sw8WRGM5e7lGce9p0/4YUzg25XcEFqrU4D6+woM?=
 =?us-ascii?Q?uXJ5EYWyxuaTc0cdh8R1KMgztpXLqaFNItozOnqjPCtdsQJ0TM0BCsi+r6ke?=
 =?us-ascii?Q?oP5eOrZbBWsMbgYlwlba7CuLd4+5z9gLRG8hXm7sVg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2007E093061ACA4D85D22EC2F05BEEFA@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2b259c-47c6-4272-63d2-08db0b1938ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 03:45:15.6728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5554
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orlando Chamberlain <orlandoch.dev@gmail.com>

This driver adds support for the keyboard backlight on Intel T2 Macs
with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
Co-developed-by: Kerem Karabay <kekrby@gmail.com>
Signed-off-by: Kerem Karabay <kekrby@gmail.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 MAINTAINERS                         |   6 ++
 drivers/hid/Kconfig                 |  13 +++
 drivers/hid/Makefile                |   1 +
 drivers/hid/apple-magic-backlight.c | 143 ++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 drivers/hid/apple-magic-backlight.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb1471cb5..3319f0c3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9201,6 +9201,12 @@ F:	include/linux/pm.h
 F:	include/linux/suspend.h
 F:	kernel/power/
=20
+HID APPLE MAGIC BACKLIGHT DRIVER
+M:	Orlando Chamberlain <orlandoch.dev@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/apple-magic-backlight.c
+
 HID CORE LAYER
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4ec669267..ad4612ec5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -156,6 +156,19 @@ config HID_APPLE_TOUCHBAR
 	To compile this driver as a module, choose M here: the
 	module will be called apple-touchbar.
=20
+config HID_APPLE_MAGIC_BACKLIGHT
+	tristate "Apple Magic Keyboard Backlight"
+	depends on USB_HID
+	depends on LEDS_CLASS
+	depends on NEW_LEDS
+	help
+	Say Y here if you want support for the keyboard backlight on Macs with
+	the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note that this
+	driver is not for external magic keyboards.
+
+	To compile this driver as a module, choose M here: the
+	module will be called apple-magic-backlight.
+
 config HID_APPLEIR
 	tristate "Apple infrared receiver"
 	depends on (USB_HID)
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index c792e42fe..a961914ec 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_HID_ACRUX)		+=3D hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
 obj-$(CONFIG_HID_APPLE_IBRIDGE)	+=3D apple-ibridge.o
 obj-$(CONFIG_HID_APPLE_TOUCHBAR)	+=3D apple-touchbar.o
+obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)	+=3D apple-magic-backlight.o
 obj-$(CONFIG_HID_APPLEIR)	+=3D hid-appleir.o
 obj-$(CONFIG_HID_CREATIVE_SB0540)	+=3D hid-creative-sb0540.o
 obj-$(CONFIG_HID_ASUS)		+=3D hid-asus.o
diff --git a/drivers/hid/apple-magic-backlight.c b/drivers/hid/apple-magic-=
backlight.c
new file mode 100644
index 000000000..9b128f6df
--- /dev/null
+++ b/drivers/hid/apple-magic-backlight.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple Magic Keyboard Backlight Driver
+ *
+ * For Intel Macs with internal Magic Keyboard (MacBookPro16,1-4 and MacBo=
okAir9,1)
+ *
+ * Copyright (c) 2022 Kerem Karabay <kekrby@gmail.com>
+ * Copyright (c) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
+ */
+
+#include <linux/hid.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+#define USAGE_MAGIC_BL	0xff00000f
+
+#define APPLE_MAGIC_REPORT_ID_POWER 3
+#define APPLE_MAGIC_REPORT_ID_BRIGHTNESS 1
+
+struct apple_magic_backlight {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+	struct hid_report *brightness;
+	struct hid_report *power;
+};
+
+static void apple_magic_backlight_power_set(struct apple_magic_backlight *=
backlight,
+					   char power, char rate)
+{
+	struct hid_report *rep =3D backlight->power;
+
+	rep->field[0]->value[0] =3D power ? 1 : 0;
+	rep->field[1]->value[0] =3D 0x5e; /* Mimic Windows */
+	rep->field[1]->value[0] |=3D rate << 8;
+
+	hid_hw_request(backlight->hdev, backlight->power, HID_REQ_SET_REPORT);
+}
+
+static void apple_magic_backlight_brightness_set(struct apple_magic_backli=
ght *backlight,
+						int brightness, char rate)
+{
+	struct hid_report *rep =3D backlight->brightness;
+
+	rep->field[0]->value[0] =3D brightness;
+	rep->field[1]->value[0] =3D 0x5e; /* Mimic Windows */
+	rep->field[1]->value[0] |=3D rate << 8;
+
+	hid_hw_request(backlight->hdev, backlight->brightness, HID_REQ_SET_REPORT=
);
+}
+
+static void apple_magic_backlight_set(struct apple_magic_backlight *backli=
ght,
+				     int brightness, char rate)
+{
+	apple_magic_backlight_power_set(backlight, brightness, rate);
+	if (brightness)
+		apple_magic_backlight_brightness_set(backlight, brightness, rate);
+}
+
+static int apple_magic_backlight_led_set(struct led_classdev *led_cdev,
+					 enum led_brightness brightness)
+{
+	struct apple_magic_backlight *backlight =3D container_of(led_cdev,
+			struct apple_magic_backlight, cdev);
+
+	apple_magic_backlight_set(backlight, brightness, 1);
+	return 0;
+}
+
+static int apple_magic_backlight_probe(struct hid_device *hdev,
+				       const struct hid_device_id *id)
+{
+	struct apple_magic_backlight *backlight;
+	int rc;
+
+	rc =3D hid_parse(hdev);
+	if (rc)
+		return rc;
+
+	/* Ensure this usb endpoint is for the keyboard backlight, not touchbar
+	 * backlight.
+	 */
+	if (!(hdev->collection && hdev->collection[0].usage =3D=3D USAGE_MAGIC_BL=
))
+		return -ENODEV;
+
+	backlight =3D devm_kzalloc(&hdev->dev, sizeof(*backlight), GFP_KERNEL);
+
+	if (!backlight)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, backlight);
+
+	rc =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (rc)
+		return rc;
+
+	backlight->brightness =3D hid_register_report(hdev, HID_FEATURE_REPORT,
+			APPLE_MAGIC_REPORT_ID_BRIGHTNESS, 0);
+	backlight->power =3D hid_register_report(hdev, HID_FEATURE_REPORT,
+			APPLE_MAGIC_REPORT_ID_POWER, 0);
+
+	if (!backlight->brightness || !backlight->power) {
+		rc =3D -ENODEV;
+		goto hw_stop;
+	}
+
+	backlight->hdev =3D hdev;
+	backlight->cdev.name =3D "apple::kbd_backlight";
+	backlight->cdev.max_brightness =3D backlight->brightness->field[0]->logic=
al_maximum;
+	backlight->cdev.brightness_set_blocking =3D apple_magic_backlight_led_set=
;
+
+	apple_magic_backlight_set(backlight, 0, 0);
+
+	return devm_led_classdev_register(&hdev->dev, &backlight->cdev);
+
+hw_stop:
+	hid_hw_stop(hdev);
+	return rc;
+}
+
+static void apple_magic_backlight_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id apple_magic_backlight_hid_ids[] =3D {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLI=
GHT) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, apple_magic_backlight_hid_ids);
+
+static struct hid_driver apple_magic_backlight_hid_driver =3D {
+	.name =3D "apple-magic-backlight",
+	.id_table =3D apple_magic_backlight_hid_ids,
+	.probe =3D apple_magic_backlight_probe,
+	.remove =3D apple_magic_backlight_remove,
+};
+
+module_hid_driver(apple_magic_backlight_hid_driver);
+
+MODULE_DESCRIPTION("MacBook Magic Keyboard Backlight");
+MODULE_AUTHOR("Orlando Chamberlain <orlandoch.dev@gmail.com>");
+MODULE_LICENSE("GPL");
--=20
2.37.2

