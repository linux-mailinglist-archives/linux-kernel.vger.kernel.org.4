Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1367067896D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjAWVV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAWVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:21:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6E2B297;
        Mon, 23 Jan 2023 13:21:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so8396294wrr.9;
        Mon, 23 Jan 2023 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYl/OwSVYhi2nM0fzyTYKGS7FnBnYGULTe9gdh3BN+E=;
        b=LBlwLbDpYJ/ZZ5LQI9h/QTAaJCRPMMTdBxNt2J28hiC5BVH9cd8xULlvyAthSeYClk
         VJ5j4OsYxqUI2z78XchtG6xHopZxk4c8xZzCy/v54T2C+zCBiW8OkB0iOrmA1R34jhHF
         vQCjGPSNEJsfUOSQb62PcR/tPGpAQcDM+FktVLy/c7mUvnTgkJPEGe+0QZbTEOTBTpp6
         gS8G6yymVTD/xebMsbyUY6hH99G8F9D3z8luug9TM68+GwOtSBk77lUEmT2J4Tnrw99n
         pC8NqlkPoVV2izgI+cTeKwAXe71ydiQQ3Ou9CTvs+cjotw20zkV0mj1uJxBEEn+71gga
         87yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYl/OwSVYhi2nM0fzyTYKGS7FnBnYGULTe9gdh3BN+E=;
        b=gXcbObv66YXYc7kDkl96Tnl9GmpcgAcSXNIUOtqDYl8ca7cVxkSrPhITGFOorbIqdd
         LL+seaOGvS5znlB9LRrpZPHkwbGmFUhylBhtPPpFa5QbZsuRDe+vBXBCxNnqUnFv0cRf
         YupMhTkVf+9QtXR04ZorcDVzJV02QhI1+XiNGzmSDqLjNw9T6MaK6heMht8OOTKv7osh
         D71OvckppGMFEeFRw8cA6ZUrTf3IoW7LYlV5Ax5YFFQQURam3M7aPvxpDUi+gL/VI9k/
         FrhPP4zWZdltndcRXpNBUlRwmgV/Nvh+e4phe+WceBxixa6G1jcANu5urU9re/CH00RP
         0pqQ==
X-Gm-Message-State: AFqh2kr6sTFnqTnlI0Ao/Cu0GwoGo8OcAuIAxUSkaPFAwtEUR+NYVf/A
        AHJdZOhkAelr7STRX9HdMvX1fQnMLPo=
X-Google-Smtp-Source: AMrXdXsIrozHslvlV76Dkn4X2xlsgtn2OYZUFVeCHrH+zwQejzwxSokj/IhwzRWgvGfxiO7uSkk2Xg==
X-Received: by 2002:a5d:4842:0:b0:2bd:eccd:7ea4 with SMTP id n2-20020a5d4842000000b002bdeccd7ea4mr22943939wrs.47.1674508914454;
        Mon, 23 Jan 2023 13:21:54 -0800 (PST)
Received: from me ([78.197.158.195])
        by smtp.gmail.com with ESMTPSA id e23-20020adfa457000000b002be505ab59asm291501wra.97.2023.01.23.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:21:54 -0800 (PST)
Received: (nullmailer pid 10041 invoked by uid 1000);
        Mon, 23 Jan 2023 21:18:43 -0000
From:   Philippe Valembois <lephilousophe@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Philippe Valembois <lephilousophe@gmail.com>
Subject: [PATCH v2 1/1] HID: evision: Add preliminary support for EVision keyboards
Date:   Mon, 23 Jan 2023 22:18:43 +0100
Message-Id: <20230123211843.10028-1-lephilousophe@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com>
References: <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Valembois <lephilousophe@users.noreply.github.com>

For now only supports one model and only filters out bogus reports sent
when the keyboard has been configured through hidraw.
Without this, as events are not released, soft repeat floods userspace
with unknown key events.

Signed-off-by: Philippe Valembois <lephilousophe@users.noreply.github.com>
---
 drivers/hid/Kconfig       |  7 ++++++
 drivers/hid/Makefile      |  1 +
 drivers/hid/hid-evision.c | 53 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h     |  3 +++
 4 files changed, 64 insertions(+)
 create mode 100644 drivers/hid/hid-evision.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e2a5d30c8..35f214773 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -329,6 +329,13 @@ config HID_ELO
 	Support for the ELO USB 4000/4500 touchscreens. Note that this is for
 	different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
 
+config HID_EVISION
+	tristate "EVision Keyboards Support"
+	depends on HID
+	help
+	Support for some EVision keyboards. Note that this is needed only when
+	applying customization using userspace programs.
+
 config HID_EZKEY
 	tristate "Ezkey BTC 8193 keyboard"
 	default !EXPERT
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index e8014c1a2..bd01571dd 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_HID_EMS_FF)	+= hid-emsff.o
 obj-$(CONFIG_HID_ELAN)		+= hid-elan.o
 obj-$(CONFIG_HID_ELECOM)	+= hid-elecom.o
 obj-$(CONFIG_HID_ELO)		+= hid-elo.o
+obj-$(CONFIG_HID_EVISION)	+= hid-evision.o
 obj-$(CONFIG_HID_EZKEY)		+= hid-ezkey.o
 obj-$(CONFIG_HID_FT260)		+= hid-ft260.o
 obj-$(CONFIG_HID_GEMBIRD)	+= hid-gembird.o
diff --git a/drivers/hid/hid-evision.c b/drivers/hid/hid-evision.c
new file mode 100644
index 000000000..ef6b4b435
--- /dev/null
+++ b/drivers/hid/hid-evision.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for EVision devices
+ *  For now, only ignore bogus consumer reports
+ *  sent after the keyboard has been configured
+ *
+ *  Copyright (c) 2022 Philippe Valembois
+ */
+
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+static int evision_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
+		return 0;
+
+	/* Ignore key down event */
+	if ((usage->hid & HID_USAGE) >> 8 == 0x05)
+		return -1;
+	/* Ignore key up event */
+	if ((usage->hid & HID_USAGE) >> 8 == 0x06)
+		return -1;
+
+	switch (usage->hid & HID_USAGE) {
+	/* Ignore configuration saved event */
+	case 0x0401: return -1;
+	/* Ignore reset event */
+	case 0x0402: return -1;
+	}
+	return 0;
+}
+
+static const struct hid_device_id evision_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_EVISION, USB_DEVICE_ID_EVISION_ICL01) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, evision_devices);
+
+static struct hid_driver evision_driver = {
+	.name = "evision",
+	.id_table = evision_devices,
+	.input_mapping = evision_input_mapping,
+};
+module_hid_driver(evision_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0f8c11842..7ae89aebd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -445,6 +445,9 @@
 #define USB_VENDOR_ID_EMS		0x2006
 #define USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II 0x0118
 
+#define USB_VENDOR_ID_EVISION           0x320f
+#define USB_DEVICE_ID_EVISION_ICL01     0x5041
+
 #define USB_VENDOR_ID_FLATFROG		0x25b5
 #define USB_DEVICE_ID_MULTITOUCH_3200	0x0002
 
-- 
2.39.1

