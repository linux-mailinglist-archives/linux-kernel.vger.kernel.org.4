Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5E16562BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiLZMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiLZMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:55:14 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75E24A;
        Mon, 26 Dec 2022 04:55:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso5076923wmb.3;
        Mon, 26 Dec 2022 04:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UNhxDSHnBv7KasoGqlSIgR8N/+eP92s5GskeMMSIno=;
        b=iupi2Ql1ztT+GKijQkUDyBSSpLvh6Axuz8njlD1jaRb7n4FJ+eSA81yPYyGH+0RgAa
         qO2qHgRNKk+tgGjE4NgCPjrsnagIrdnHFdfEItt71pr6gQ5PWxiRrxFlxW2CUoE7GhWr
         EIqpu16bO4iK2lCGJSESaowdzvfscCifSFIm5zJsB+k8PP56nBG0QBodo6/0HAbwnlUV
         aGGfc5W8HrYUTchG9tq38Y4F5l3DbyRPMBR3O4xpTQDYrhjEF+sMYS0p5deAA4DejxAi
         7rNuvdKce3AyTewI3PH8a8l117iWYh9ZdhbnvsZNkLEYpeR2fTDqR8hE/8m4iHMEhHSX
         uVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UNhxDSHnBv7KasoGqlSIgR8N/+eP92s5GskeMMSIno=;
        b=fmcb5COK8WGTpoghgxUmoB/rvRzCetpLghZXG2+JniGbe972sR4qp+fP4X5ACIpIuP
         QI5pRZk2FgezN6TpdxQON52MJzRlH5k/6GvhJtjBSSz7DVTx96MytzsAwfVIIwY8KO4r
         W/eG8Uh10mt5D9lJPk+Fm6JuQ5ogOH2uvXcxTPgxk399eFuLwhsM0i/6xqZBd2RGZA7S
         i6aLgHyyzJcHf1MDRkBbJzSRbYZDE02/uOARPBvLzRE4qe5KKRIBdzeR+rFtoCz2QTos
         qeMXNlNHbUswVifOyTg6h6djMkkiAmg97pj6AWzLC3P2MO5lZJmHw3oDzsVttJEpyS0c
         tYqA==
X-Gm-Message-State: AFqh2kp8HEf6Gww5AYI7korJt6YN4QKiVXMh/UcbOaXciOC9EnE54jFd
        R6/0sb/dZhrsxOmo1N04XYM=
X-Google-Smtp-Source: AMrXdXvaJWfXeiFUT/GZAIuSyhfEAANL0dmMiLLbQakZgfaAauFEhlxdMC7q+DzEA4RnEZMFILQ0FA==
X-Received: by 2002:a05:600c:d1:b0:3d3:4d21:704d with SMTP id u17-20020a05600c00d100b003d34d21704dmr12837213wmm.14.1672059312258;
        Mon, 26 Dec 2022 04:55:12 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm13684497wmq.25.2022.12.26.04.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:55:12 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 5/6] HID: uclogic: Add support for XP-PEN Deco Pro SW
Date:   Mon, 26 Dec 2022 13:54:53 +0100
Message-Id: <20221226125454.16106-6-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226125454.16106-1-jose.exposito89@gmail.com>
References: <20221226125454.16106-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XP-PEN Deco Pro SW is a UGEE v2 device with a frame with 8 buttons,
a bitmap dial and a mouse; however, the UCLOGIC_MOUSE_FRAME_QUIRK is
required because it reports an incorrect frame type. Its pen has 2
buttons, supports tilt and pressure.

It can be connected using a USB cable or, to use it in wireless mode,
using a USB Bluetooth dongle. When it is connected in wireless mode the
device battery is used to power it.

All the pieces to support it are already in place. Add its ID and
quirks in order to support the device.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-input.c          | 2 ++
 drivers/hid/hid-uclogic-core.c   | 3 +++
 drivers/hid/hid-uclogic-params.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 82713ef3aaa6..d8a8028761ed 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1297,6 +1297,7 @@
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO01	0x0042
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S	0x0909
+#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW	0x0933
 #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
 #define USB_DEVICE_ID_UGEE_TABLET_G5		0x0074
 #define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9b59e436df0a..c4d9a95774cc 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -376,6 +376,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100),
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 9ddb17ad0d04..cfef6f9af62d 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -542,6 +542,9 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
+				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW),
+		.driver_data = UCLOGIC_MOUSE_FRAME_QUIRK | UCLOGIC_BATTERY_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
 				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
 	{ }
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 86702c994c57..39a9259aa447 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1767,6 +1767,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L):
 	case VID_PID(USB_VENDOR_ID_UGEE,
 		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S):
+	case VID_PID(USB_VENDOR_ID_UGEE,
+		     USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW):
 		rc = uclogic_params_ugee_v2_init(&p, hdev);
 		if (rc != 0)
 			goto cleanup;
-- 
2.38.1

