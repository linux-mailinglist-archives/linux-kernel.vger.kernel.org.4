Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC7655A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiLXMX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLXMXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:23:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5EB1091;
        Sat, 24 Dec 2022 04:23:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ja17so5144871wmb.3;
        Sat, 24 Dec 2022 04:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2S1dkWMH2t8XNV8Vg+f4RD4SanApn5isURvMS7ChuXg=;
        b=mA9w7fHVTV2cOvOsiMudKxcORu092PQplPjLa3fCtnRlnIcdS0i2H/QIaU3AF4vehh
         c6zs5SiKUBNLk58W1evCBPFWCgWU7cACw+b2qm488wE7AUrmuE7MOmnKxK0sEs2oEx1c
         A27Ofg3/hKxW1kdmq3KU+Ld3Fok8TZRbZnMyPe85fw6gGbD1i9uMlKy/GMSIkudC1e+W
         8F327OrERd+ACeOCgjf9VxWrlp23Afdq0PIRMl2tfNitCPlUkK4AiErMBbb63MKHvtjB
         VU0Pi9hJ62Lc3inoMYtKwz74JWCu/FvV1kZGhPfpzaNlcGu9vKFDK7jFCpD2KJrZwpuY
         /wLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2S1dkWMH2t8XNV8Vg+f4RD4SanApn5isURvMS7ChuXg=;
        b=orhvCBHNa2DHJA4bVxH81SH73jf5Py1kXOkqEn6fRoqRoOS08tERSJtjhXZTScrz4w
         iaLeXh/WCLQe5lsenGYpj5qvJLN+PddE+S749DCm/WW8uhneIaIZRcrH3hkXPYkSeAqT
         oyC8YFrD30WtM3KrUqNcAi9dOQhvbQqhrdtGGtghWIU6YzIFJSiwGEkjOrxOftSqD+Qc
         yi1uS0JE44/eu0KchismCdxWGeEenDQetPgin0GstGPXHDSuAaEvTLPEZF+14jOysVIG
         d1WfuhKm1RCLlBKyHtBc3/k3Aay3HSFgRu2lh8l7yskzSAoonBe7t3KdCOTe55a9jSWe
         zyZQ==
X-Gm-Message-State: AFqh2kr+1oXvn082s5XHHG/5xryFC0+mmwJGJkbtr7Ku3nc7H/DN71Av
        /7m2TDxQC2igK/ZVXc75K60=
X-Google-Smtp-Source: AMrXdXvbLSYZz4HJkZP514MF5lF0IinERliCny3myc981bStgcRuqm8vT+D713mBscYTNNSYUcfbcA==
X-Received: by 2002:a05:600c:5008:b0:3cf:6f4d:c25d with SMTP id n8-20020a05600c500800b003cf6f4dc25dmr9573239wmr.21.1671884632749;
        Sat, 24 Dec 2022 04:23:52 -0800 (PST)
Received: from me ([78.197.158.195])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b003cf37c5ddc0sm8444029wmq.22.2022.12.24.04.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 04:23:52 -0800 (PST)
Received: (nullmailer pid 11724 invoked by uid 1000);
        Sat, 24 Dec 2022 12:21:09 -0000
From:   Philippe Valembois <lephilousophe@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Philippe Valembois <lephilousophe@gmail.com>
Subject: [PATCH 1/1] HID: evision: Add preliminary support for EVision keyboards
Date:   Sat, 24 Dec 2022 13:18:14 +0100
Message-Id: <20221224121814.11709-1-lephilousophe@gmail.com>
X-Mailer: git-send-email 2.38.2
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
 drivers/hid/Kconfig       |  7 ++++
 drivers/hid/Makefile      |  1 +
 drivers/hid/hid-evision.c | 79 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/hid/hid-evision.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e2a5d30c8..1320ea75c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -329,6 +329,13 @@ config HID_ELO
 	Support for the ELO USB 4000/4500 touchscreens. Note that this is for
 	different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
 
+config HID_EVISION
+	tristate "EVision Keyboards Support"
+	depends on USB_HID
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
index 000000000..6ea331575
--- /dev/null
+++ b/drivers/hid/hid-evision.c
@@ -0,0 +1,79 @@
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
+#include <linux/usb.h>
+
+
+#define USB_VENDOR_ID_EVISION       0x320f
+#define USB_DEVICE_ID_EVISION_ICL01 0x5041
+
+static int evision_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_CONSUMER)
+		return 0;
+
+	// Ignore key down event
+	if ((usage->hid & HID_USAGE) >> 8 == 0x05)
+		return -1;
+	// Ignore key up event
+	if ((usage->hid & HID_USAGE) >> 8 == 0x06)
+		return -1;
+
+	switch (usage->hid & HID_USAGE) {
+	// Ignore configuration saved event
+	case 0x0401: return -1;
+	// Ignore reset event
+	case 0x0402: return -1;
+	}
+	return 0;
+}
+
+static int evision_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	if (!hid_is_usb(hdev))
+		return -EINVAL;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "EVision hid parse failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "EVision hw start failed: %d\n", ret);
+		return ret;
+	}
+
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
+	.probe = evision_probe,
+};
+module_hid_driver(evision_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.38.2

