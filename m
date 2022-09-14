Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327C05B8EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiINSiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiINSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:38:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B574E17;
        Wed, 14 Sep 2022 11:38:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 9so18455462ljr.2;
        Wed, 14 Sep 2022 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=78CnzaAPH4z89FBxFwtTHbWcXI9P3dep9t1OMRvZpng=;
        b=AET+Preuyw0r7MANwiGVh8fhlMt2pbWqsDfNC+8RxBdroWgUIc44Ll3xSO9CYGGbau
         iTf85uuXCQtGPW36YMAlCOtBuGRrTR6e5wuJwYSP/OU5KZ/mcQcf3lssQjdti1RRqp/T
         7Dg/LeeVae0Eai9LMY6Jkaj94D+Z2i/pN54emEK5GlRjjIxl5YbbQHcuUS22IrrewlvK
         o3OgATaAbaEABHeYYMHHTVg+Ar3pRUsNx48Bp8WKYMY84RtGJJdrd4wZrh21DMB00hgL
         1T7UNa1B0zaBCiDhsa6CAAe2NxypqzBlHGzf412dArDxkzM3+tNJAR1H06OOerGoMRXN
         H4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=78CnzaAPH4z89FBxFwtTHbWcXI9P3dep9t1OMRvZpng=;
        b=RvjabqnqF4nkzrmptaJoOV+OPqmLCqbCQZ2NasSEZvD3sOzYctmYmjMovTCpAhqHJ6
         ERbhaEu09z4v9E9GGXygdtvoPsLbOu2ngW71S7kHoC7hajs4bvndmQdZtqEtFN5WgG8V
         SZx28zfyNah9LntSM5l7hh3+OEJUCZ0lthHH+K/VvmJ72ElHWwVlNu9Nvx4/yPJQ6Za0
         pHuyPry7fX8ucRqYfvDtWXiMl4ydqBzjEDNU9wsnvcFD0cm5mNX83j9DB6YUh1V1NnYH
         43ZjyTxkW5cbqWBIWqNNDGfhwDAMzDAUURKM5qhWSYb7Ug/SnUzs8tEFIdr8x6p/SpIb
         M0WQ==
X-Gm-Message-State: ACgBeo0UCc1rcvOXgvi3H3wjUGSv3N8cYP7pK7lUaCratMeFkJiLfs2/
        i1Y3bNAv3DPSReKrRV5Stko=
X-Google-Smtp-Source: AA6agR5yMPw4sfc/ilrCzNJbQpRxEsraQo4n/QorEbeHZAqQQwwLjNmj8VH5v2VxywDZ9W54idfzyg==
X-Received: by 2002:a2e:bf23:0:b0:26c:83e:b4d3 with SMTP id c35-20020a2ebf23000000b0026c083eb4d3mr4700513ljr.282.1663180688737;
        Wed, 14 Sep 2022 11:38:08 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id a6-20020a05651c010600b0026c079006bcsm2002102ljb.118.2022.09.14.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 11:38:07 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: Add driver for PhoenixRC Flight Controller
Date:   Wed, 14 Sep 2022 20:43:45 +0200
Message-Id: <20220914184345.270456-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PhoenixRC is a controller with 8 channels for use in flight
simulators.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS            |   6 +++
 drivers/hid/Kconfig    |   9 ++++
 drivers/hid/Makefile   |   1 +
 drivers/hid/hid-ids.h  |   1 +
 drivers/hid/hid-pxrc.c | 112 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 drivers/hid/hid-pxrc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..2f70b7d2b4b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8907,6 +8907,12 @@ L:	linux-input@vger.kernel.org
 S:	Supported
 F:	drivers/hid/hid-playstation.c
 
+HID PHOENIX RC FLIGHT CONTROLLER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-pxrc.c
+
 HID SENSOR HUB DRIVERS
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Jonathan Cameron <jic23@kernel.org>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 70da5931082f..8ca58141d5be 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -950,6 +950,15 @@ config PLAYSTATION_FF
 	  Say Y here if you would like to enable force feedback support for
 	  PlayStation game controllers.
 
+config HID_PXRC
+       tristate "PhoenixRC HID Flight Controller"
+       depends on HID
+       help
+       Support for PhoenixRC HID Flight Controller, a 8-axis flight controller.
+
+       To compile this driver as a module, choose M here: the
+       module will be called hid-pxrc.
+
 config HID_RAZER
 	tristate "Razer non-fully HID-compliant devices"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index cac2cbe26d11..b3748b97d5b5 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -101,6 +101,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)		+= hid-picolcd_debugfs.o
 obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
 obj-$(CONFIG_HID_PLAYSTATION)	+= hid-playstation.o
 obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
+obj-$(CONFIG_HID_PXRC)		+= hid-pxrc.o
 obj-$(CONFIG_HID_RAZER)	+= hid-razer.o
 obj-$(CONFIG_HID_REDRAGON)	+= hid-redragon.o
 obj-$(CONFIG_HID_RETRODE)	+= hid-retrode.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d9eb676abe96..30ac56cb238b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1381,6 +1381,7 @@
 
 #define USB_VENDOR_ID_MULTIPLE_1781	0x1781
 #define USB_DEVICE_ID_RAPHNET_4NES4SNES_OLD	0x0a9d
+#define USB_DEVICE_ID_PHOENIXRC        0x0898
 
 #define USB_VENDOR_ID_DRACAL_RAPHNET	0x289b
 #define USB_DEVICE_ID_RAPHNET_2NES2SNES	0x0002
diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
new file mode 100644
index 000000000000..b0e517f9cde7
--- /dev/null
+++ b/drivers/hid/hid-pxrc.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for PhoenixRC 8-axis flight controller
+ *
+ * Copyright (C) 2022 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+struct pxrc_priv {
+	u8 slider;
+	u8 dial;
+	bool alternate;
+};
+
+static __u8 pxrc_rdesc_fixed[] = {
+	0x05, 0x01,        // Usage Page (Generic Desktop Ctrls)
+	0x09, 0x04,        // Usage (Joystick)
+	0xA1, 0x01,        // Collection (Application)
+	0x09, 0x01,        //   Usage (Pointer)
+	0xA1, 0x00,        //   Collection (Physical)
+	0x09, 0x30,        //     Usage (X)
+	0x09, 0x36,        //     Usage (Slider)
+	0x09, 0x31,        //     Usage (Y)
+	0x09, 0x32,        //     Usage (Z)
+	0x09, 0x33,        //     Usage (Rx)
+	0x09, 0x34,        //     Usage (Ry)
+	0x09, 0x35,        //     Usage (Rz)
+	0x09, 0x37,        //     Usage (Dial)
+	0x15, 0x00,        //     Logical Minimum (0)
+	0x26, 0xFF, 0x00,  //     Logical Maximum (255)
+	0x35, 0x00,        //     Physical Minimum (0)
+	0x46, 0xFF, 0x00,  //     Physical Maximum (255)
+	0x75, 0x08,        //     Report Size (8)
+	0x95, 0x08,        //     Report Count (8)
+	0x81, 0x02,        //     Input (Data,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
+	0xC0,              //   End Collection
+	0xC0,              // End Collection
+};
+
+static __u8 *pxrc_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+				unsigned int *rsize)
+{
+	hid_info(hdev, "fixing up PXRC report descriptor\n");
+	*rsize = sizeof(pxrc_rdesc_fixed);
+	return pxrc_rdesc_fixed;
+}
+
+static int pxrc_raw_event(struct hid_device *hdev, struct hid_report *report,
+	 u8 *data, int size)
+{
+	struct pxrc_priv *priv = hid_get_drvdata(hdev);
+
+	if (priv->alternate)
+		priv->slider = data[7];
+	else
+		priv->dial = data[7];
+
+	data[1] = priv->slider;
+	data[7] = priv->dial;
+
+	priv->alternate = !priv->alternate;
+	return 0;
+}
+
+static int pxrc_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct pxrc_priv *priv;
+
+	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	hid_set_drvdata(hdev, priv);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct hid_device_id pxrc_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MULTIPLE_1781, USB_DEVICE_ID_PHOENIXRC) },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(hid, pxrc_devices);
+
+static struct hid_driver pxrc_driver = {
+	.name = "hid-pxrc",
+	.id_table = pxrc_devices,
+	.report_fixup = pxrc_report_fixup,
+	.probe = pxrc_probe,
+	.raw_event = pxrc_raw_event,
+};
+module_hid_driver(pxrc_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_DESCRIPTION("HID driver for PXRC 8-axis flight controller");
+MODULE_LICENSE("GPL");
-- 
2.37.1

