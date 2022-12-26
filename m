Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3B6562B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiLZMzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiLZMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:55:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F124A;
        Mon, 26 Dec 2022 04:55:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so7471859wms.2;
        Mon, 26 Dec 2022 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgO7IbDqgEqOBYZvNEQA1RHViZvpw8XhwXsdAZWfOVg=;
        b=miMOIpfNfMXQ+NapwMFztK0IUXcMuYUgnlhM5D+UQ0dviaWcQn97QZl83rmrYR2tA7
         4665vSANJGpxwmqIF+IMatTEmSbXFTCO3b0KNJi9Yidi0O/pTgP9nltBpreTyXWdYnNv
         3U+XTlUGGZ3e50+hVXBnOtBor1Q+o+F2wqm/9O+tugBeeQ8C2CJ6JUbacluwGeHal6km
         T9PAQkRBu7RZvoJu0vdcRIP6jpH1r5n+mxvaj5D4F3p+6S0PE7vKAtdua9S5otAQWU0E
         Ce7RlZT7gXT4y+ChxzeJdzlBriDYmvpOOeg8MzibU/j33UCimeo+due1LpXP9G8yP/v8
         3EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgO7IbDqgEqOBYZvNEQA1RHViZvpw8XhwXsdAZWfOVg=;
        b=ACWH+WTtI2rySybSJV4QOcncTGymVxOiBgEncNUUuK0Dk+Xk5DFEFgE6DTGzQyxo0I
         gjb5UyeBCf95LV8hBhi43CIb859mbvgWWRVjhlDusCdsw++eOZVFZY1H5K6qFbCNGR4/
         WRGw0GzO+iGOedY6WuPLEZbo0kMQczGugToIiYJmymuyAqZKXQD1oPEbqoKa1Bi16UyW
         nEAA+cu1JiLaJVIcFtAVtBmB7Q0ZY81S9Oqkp2V0S9eJ/ehYvuNSWImRbzd/dNjIJpU7
         4Dwjurbxdjp6R5ccWnIjdZsveVxyzYcZkWyhsrOzcmkGmO+NhKe+yNt9yXIjo3p7ev1G
         OwqA==
X-Gm-Message-State: AFqh2kpRICa8lP6sKXTRiQKVZ0EZUgsQmsirR+3/TyZ8goUbbednaGu+
        PZzpC4gCQNjB1gxzyDymyhM=
X-Google-Smtp-Source: AMrXdXuk/JuoZgr04mNTTCzhq56v0bwSLJ8kOkPaHxaqW7elHjXXmN0YOijxWjm/XiPmB1HNNDvTEg==
X-Received: by 2002:a05:600c:4e51:b0:3d1:e1f4:21d1 with SMTP id e17-20020a05600c4e5100b003d1e1f421d1mr15405746wmq.26.1672059309067;
        Mon, 26 Dec 2022 04:55:09 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c365800b003cf894dbc4fsm13684497wmq.25.2022.12.26.04.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:55:08 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: [PATCH 1/6] HID: uclogic: Add frame type quirk
Date:   Mon, 26 Dec 2022 13:54:49 +0100
Message-Id: <20221226125454.16106-2-jose.exposito89@gmail.com>
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

The report descriptor used to get information about UGEE v2 devices is
incorrect in the XP-PEN Deco Pro SW. It indicates that the device frame
is of type UCLOGIC_PARAMS_FRAME_BUTTONS but the device has a frame of
type UCLOGIC_PARAMS_FRAME_MOUSE.

Here is the original report descriptor:

  0x0e 0x03 0xc8 0xb3 0x34 0x65 0x08 0x00 0xff 0x1f 0xd8 0x13 0x00 0x00
                                     ^ This byte should be 2

Add a quirk to be able to fix the reported frame type.

Tested-by: Mia Kanashi <chad@redpilled.dev>
Tested-by: Andreas Grosse <andig.mail@t-online.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 20 +-------------------
 drivers/hid/hid-uclogic-params.c |  5 +++++
 drivers/hid/hid-uclogic-params.h | 23 +++++++++++++++++++++++
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 7fa6fe04f1b2..7a5480b6f046 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -22,25 +22,6 @@
 
 #include "hid-ids.h"
 
-/* Driver data */
-struct uclogic_drvdata {
-	/* Interface parameters */
-	struct uclogic_params params;
-	/* Pointer to the replacement report descriptor. NULL if none. */
-	__u8 *desc_ptr;
-	/*
-	 * Size of the replacement report descriptor.
-	 * Only valid if desc_ptr is not NULL
-	 */
-	unsigned int desc_size;
-	/* Pen input device */
-	struct input_dev *pen_input;
-	/* In-range timer */
-	struct timer_list inrange_timer;
-	/* Last rotary encoder state, or U8_MAX for none */
-	u8 re_state;
-};
-
 /**
  * uclogic_inrange_timeout - handle pen in-range state timeout.
  * Emulate input events normally generated when pen goes out of range for
@@ -202,6 +183,7 @@ static int uclogic_probe(struct hid_device *hdev,
 	}
 	timer_setup(&drvdata->inrange_timer, uclogic_inrange_timeout, 0);
 	drvdata->re_state = U8_MAX;
+	drvdata->quirks = id->driver_data;
 	hid_set_drvdata(hdev, drvdata);
 
 	/* Initialize the device and retrieve interface parameters */
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index cd1233d7e253..2d46d4d50604 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1298,6 +1298,7 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 				       struct hid_device *hdev)
 {
 	int rc = 0;
+	struct uclogic_drvdata *drvdata;
 	struct usb_interface *iface;
 	__u8 bInterfaceNumber;
 	const int str_desc_len = 12;
@@ -1316,6 +1317,7 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 		goto cleanup;
 	}
 
+	drvdata = hid_get_drvdata(hdev);
 	iface = to_usb_interface(hdev->dev.parent);
 	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 
@@ -1382,6 +1384,9 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
 
 	/* Initialize the frame interface */
+	if (drvdata->quirks & UCLOGIC_MOUSE_FRAME_QUIRK)
+		frame_type = UCLOGIC_PARAMS_FRAME_MOUSE;
+
 	switch (frame_type) {
 	case UCLOGIC_PARAMS_FRAME_DIAL:
 	case UCLOGIC_PARAMS_FRAME_MOUSE:
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index a97477c02ff8..10a05c7fd939 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -19,6 +19,8 @@
 #include <linux/usb.h>
 #include <linux/hid.h>
 
+#define UCLOGIC_MOUSE_FRAME_QUIRK	BIT(0)
+
 /* Types of pen in-range reporting */
 enum uclogic_params_pen_inrange {
 	/* Normal reports: zero - out of proximity, one - in proximity */
@@ -215,6 +217,27 @@ struct uclogic_params {
 	struct uclogic_params_frame frame_list[3];
 };
 
+/* Driver data */
+struct uclogic_drvdata {
+	/* Interface parameters */
+	struct uclogic_params params;
+	/* Pointer to the replacement report descriptor. NULL if none. */
+	__u8 *desc_ptr;
+	/*
+	 * Size of the replacement report descriptor.
+	 * Only valid if desc_ptr is not NULL
+	 */
+	unsigned int desc_size;
+	/* Pen input device */
+	struct input_dev *pen_input;
+	/* In-range timer */
+	struct timer_list inrange_timer;
+	/* Last rotary encoder state, or U8_MAX for none */
+	u8 re_state;
+	/* Device quirks */
+	unsigned long quirks;
+};
+
 /* Initialize a tablet interface and discover its parameters */
 extern int uclogic_params_init(struct uclogic_params *params,
 				struct hid_device *hdev);
-- 
2.38.1

