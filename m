Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16AC74C86F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGIVoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGIVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:44:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB158120
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 14:44:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-991da766865so493893866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688939059; x=1691531059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLBPTGIRRZL4Ylu+WFvXgWeD0585RDTLrEZBxvUOODs=;
        b=fo2xCzkmq0iHLOhwjkufT6OYNQoZyTm814B16zlA0tIdAR5+YmrbZmBmiC2ktxt3KZ
         CgaRAhLQYIUXDm/6cj4F11BNdLdZZs53OlqcjyJ0552k1tFp5arInROJjraIwRXcX4+X
         lDmw5S1cP0JsB0XuXEMA16sH66/tj3gvqpR+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688939059; x=1691531059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLBPTGIRRZL4Ylu+WFvXgWeD0585RDTLrEZBxvUOODs=;
        b=b4TniT79vJbIP2cHY6vZT7PCc0nFyUm8prkKinwhBb9Ud62JX6ZTMQOl58zokSkB4D
         qjOjBmENVr9WDD4NkBJB6RL9a0g6yWxJnGhJzzaei3Zg94z/bQs0oJwiiRzEKwUJtezE
         tcy8tZz1PhGo/UcCGFjolkKVaLYje5Ti/rNnDlNeiCiUSmmrytLZsc73fQouBXT0LcaI
         aqwIl+flqV3CjBakx05pTmFivi4HXovZpEbJ9VsLp/V75px0y3NO/ixdmNfmusAi8+KS
         4u3vdelDzfF/s9t2TbeswHkv8x632Ucv+uAbzKkkIu8EuKilElJforBuj4TO+l960EJU
         gBKw==
X-Gm-Message-State: ABy/qLam9yE3zYsZRlyxhffMR1W1QIIVTzwejhDA7t3kU+5mGh5fGCt5
        c7c3bSPD+Q5+3/4De/XtmdidfQ==
X-Google-Smtp-Source: APBJJlG6GZZU7697CE3q54o1/ILkVyVnjECA2JEBJe1AtsS5d3z8etkcjLYavrN9MCJ+4vF9s86RPQ==
X-Received: by 2002:a17:906:73d8:b0:993:d47f:3c7d with SMTP id n24-20020a17090673d800b00993d47f3c7dmr8040070ejl.6.1688939059080;
        Sun, 09 Jul 2023 14:44:19 -0700 (PDT)
Received: from balto.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id i21-20020a1709061cd500b00988b8ff849csm5195357ejh.108.2023.07.09.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 14:44:18 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v3] HID: hid-google-stadiaff: add support for Stadia force feedback
Date:   Sun,  9 Jul 2023 21:44:10 +0000
Message-ID: <20230709214410.3676224-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hid-stadiaff module to support rumble based force feedback on the
Google Stadia controller. This works using the HID output endpoint
exposed on both the USB and BLE interface.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---

Hi, this adds rumble support to the stadia controller using the input
interface. Up to now this has only been implemented at application level
using hidraw:

https://source.chromium.org/chromium/chromium/src/+/main:device/gamepad/hid_haptic_gamepad.cc

Tested with fftest, works both over USB and BLE.

Changes from v2:
- check stadiaff_init value at probe time and fail the probe if init
  fails

Changes from v1:
- renamed the module to hid-google-stadiaff.c
- added locking for passing the state to the worker code
- added a module removed check to prevent the work from rescheduling

 drivers/hid/Kconfig               |   7 ++
 drivers/hid/Makefile              |   1 +
 drivers/hid/hid-google-stadiaff.c | 158 ++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h             |   1 +
 4 files changed, 167 insertions(+)
 create mode 100644 drivers/hid/hid-google-stadiaff.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 4ce012f83253..ea1646384b20 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -412,6 +412,13 @@ config HID_GOOGLE_HAMMER
 	help
 	Say Y here if you have a Google Hammer device.
 
+config HID_GOOGLE_STADIA_FF
+	tristate "Google Stadia force feedback"
+	select INPUT_FF_MEMLESS
+	help
+	Say Y here if you want to enable force feedback support for the Google
+	Stadia controller.
+
 config HID_VIVALDI
 	tristate "Vivaldi Keyboard"
 	select HID_VIVALDI_COMMON
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 5d37cacbde33..18e9a3afecab 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_HID_GFRM)		+= hid-gfrm.o
 obj-$(CONFIG_HID_GLORIOUS)  += hid-glorious.o
 obj-$(CONFIG_HID_VIVALDI_COMMON) += hid-vivaldi-common.o
 obj-$(CONFIG_HID_GOOGLE_HAMMER)	+= hid-google-hammer.o
+obj-$(CONFIG_HID_GOOGLE_STADIA_FF)	+= hid-google-stadiaff.o
 obj-$(CONFIG_HID_VIVALDI)	+= hid-vivaldi.o
 obj-$(CONFIG_HID_GT683R)	+= hid-gt683r.o
 obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
diff --git a/drivers/hid/hid-google-stadiaff.c b/drivers/hid/hid-google-stadiaff.c
new file mode 100644
index 000000000000..f8ca7209917d
--- /dev/null
+++ b/drivers/hid/hid-google-stadiaff.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Stadia controller rumble support.
+ *
+ * Copyright 2023 Google LLC
+ */
+
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include "hid-ids.h"
+
+#define STADIA_FF_REPORT_ID 5
+
+struct stadiaff_device {
+	struct hid_device *hid;
+	struct hid_report *report;
+	spinlock_t lock;
+	bool removed;
+	uint16_t strong_magnitude;
+	uint16_t weak_magnitude;
+	struct work_struct work;
+};
+
+static void stadiaff_work(struct work_struct *work)
+{
+	struct stadiaff_device *stadiaff =
+		container_of(work, struct stadiaff_device, work);
+	struct hid_field *rumble_field = stadiaff->report->field[0];
+	unsigned long flags;
+
+	spin_lock_irqsave(&stadiaff->lock, flags);
+	rumble_field->value[0] = stadiaff->strong_magnitude;
+	rumble_field->value[1] = stadiaff->weak_magnitude;
+	spin_unlock_irqrestore(&stadiaff->lock, flags);
+
+	hid_hw_request(stadiaff->hid, stadiaff->report, HID_REQ_SET_REPORT);
+}
+
+static int stadiaff_play(struct input_dev *dev, void *data,
+			 struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
+	unsigned long flags;
+
+	spin_lock_irqsave(&stadiaff->lock, flags);
+	if (!stadiaff->removed) {
+		stadiaff->strong_magnitude = effect->u.rumble.strong_magnitude;
+		stadiaff->weak_magnitude = effect->u.rumble.weak_magnitude;
+		schedule_work(&stadiaff->work);
+	}
+	spin_unlock_irqrestore(&stadiaff->lock, flags);
+
+	return 0;
+}
+
+static int stadiaff_init(struct hid_device *hid)
+{
+	struct stadiaff_device *stadiaff;
+	struct hid_report *report;
+	struct hid_input *hidinput;
+	struct input_dev *dev;
+	int error;
+
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	dev = hidinput->input;
+
+	report = hid_validate_values(hid, HID_OUTPUT_REPORT,
+				     STADIA_FF_REPORT_ID, 0, 2);
+	if (!report)
+		return -ENODEV;
+
+	stadiaff = devm_kzalloc(&hid->dev, sizeof(struct stadiaff_device),
+				GFP_KERNEL);
+	if (!stadiaff)
+		return -ENOMEM;
+
+	hid_set_drvdata(hid, stadiaff);
+
+	input_set_capability(dev, EV_FF, FF_RUMBLE);
+
+	error = input_ff_create_memless(dev, NULL, stadiaff_play);
+	if (error)
+		return error;
+
+	stadiaff->removed = false;
+	stadiaff->hid = hid;
+	stadiaff->report = report;
+	INIT_WORK(&stadiaff->work, stadiaff_work);
+	spin_lock_init(&stadiaff->lock);
+
+	hid_info(hid, "Force Feedback for Google Stadia controller\n");
+
+	return 0;
+}
+
+static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	ret = stadiaff_init(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "force feedback init failed\n");
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void stadia_remove(struct hid_device *hid)
+{
+	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
+	unsigned long flags;
+
+	spin_lock_irqsave(&stadiaff->lock, flags);
+	stadiaff->removed = true;
+	spin_unlock_irqrestore(&stadiaff->lock, flags);
+
+	cancel_work_sync(&stadiaff->work);
+	hid_hw_stop(hid);
+}
+
+static const struct hid_device_id stadia_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, stadia_devices);
+
+static struct hid_driver stadia_driver = {
+	.name = "stadia",
+	.id_table = stadia_devices,
+	.probe = stadia_probe,
+	.remove = stadia_remove,
+};
+module_hid_driver(stadia_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d79e946acdcb..366c95904e4f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -529,6 +529,7 @@
 #define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
+#define USB_DEVICE_ID_GOOGLE_STADIA	0x9400
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.41.0.255.g8b1d071c50-goog

