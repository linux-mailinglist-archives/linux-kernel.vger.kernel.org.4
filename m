Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CEB65293C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiLTW5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLTW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:57:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260391F2E5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:56:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so32693396ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yxqcWft59OCWANRJjSvyfqsF4e3tYjtaN8mGnqPFcrM=;
        b=HwKksefmkXM1Z0jtxl0KaOpO1Y00sA/hkiAIB8Wpd6CjmUrozXs7vT/NXfy31uZYde
         1FCcoj9YELckVnNjL240yzzcTbzFgL2L+NEGdzEvlFZ3vb1cQKK4tkvGyBoZRcFnn/60
         /ywhFDj9xRGFGQGWgl2p51VerCzEBXnXN8ygo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxqcWft59OCWANRJjSvyfqsF4e3tYjtaN8mGnqPFcrM=;
        b=KJj4+kR/pt4HXSVMxnGvphqNTMu9QkJ/PMRY0+UtM0Gd0HvAZWVFBm8Tn1MQyFGqhZ
         7m4DZ4gBX1Ho1Wz6k8CUxLtsuAUsQksbcis5fYZ9BvPaINQQrqqArEA2fVlxBxuRjqLX
         OQ1mTk4gdMm7+6WFYeniXr5xcgKjZe2fE/SNgt551Y9Vs/e72YCAIId1OQmw8BrPQ6+E
         nNZOeDD0OSoJSzo89uV9v60355erJ7C+W527htAhr7EC8ZSnQ7HonYHoJMWeS4KA3y3M
         oz5AZf2E6stxJAgrmIUwVgkCW7J+xJI616SxKt2qosqDJy8qsZauMv49lqnAu0bjOh+e
         NuKg==
X-Gm-Message-State: AFqh2krF7oUcwDE/b2cMlp8RrD2ocYJGhXKoTS1NgVe+VOWxWqG0QFZy
        8ht3R91EUtUTzGgxnFjo8GgyXg==
X-Google-Smtp-Source: AMrXdXt7nJbqWOjvERSz/X2De5muQiPY8l6Cv4NcDW8mCWLM6bENx7erv5Ztp8N+ogBJb5te6PChKA==
X-Received: by 2002:a17:906:bcd1:b0:7c0:e4b6:601d with SMTP id lw17-20020a170906bcd100b007c0e4b6601dmr3762377ejb.7.1671577017707;
        Tue, 20 Dec 2022 14:56:57 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b0078e0973d1f5sm6219658ejd.0.2022.12.20.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 14:56:57 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Dec 2022 23:56:44 +0100
Subject: [PATCH v4] media: uvcvideo: Remove void casting for the status endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221214-uvc-status-alloc-v4-0-f8e3e2994ebd@chromium.org>
To:     Yunke Cao <yunkec@chromium.org>, Max Staudt <mstaudt@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=8364; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=GLzZxhMplXLe8qPa6WyRPuVdAJ3PPq3ffZj4Q/FP2SA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjoj21qRQBOkeRbT2hKyyen551oMXpQehjq6rAKSQn
 aI9oE4yJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY6I9tQAKCRDRN9E+zzrEiNcSD/
 9jl03axlJkkvj4ZUNN3zGLW2+ELC1r705TtJ07PMqy/KYzc2SHiZQh3p9CVNQZkPRXx6Hu1SAJoXAS
 mFHmovwsB6NFJl6onobaLNsbRb3l8fnyuzgSs0bfn1NYmXIVAweSimsIp8XcPqI1wzmvY4v6WJjwW+
 NGOyxjWOGA/N76Fssruv3QwT1mQapdZVK5CtUDDJGKdJjnrrjXm78Ff7rokSaAXuRcRrgKidiYmuZH
 R0+4fNfG2D9UJVoZGJ7rmd0ySBY5ewu+ZzF+a+GLftqCJ6WBpxZEcOrWBZt+DekIxch1U8SRret7KP
 +cGq0MQd1DyKKafOa/2k33UgfHGBKnTPuKDpEk+mbByB8cFLZhQash2as9ei+DITKdCFOQiraSjw/w
 FIdWaNiEn9WLgHxp7zxeB+2nqke/Ci1nMicuhsNW51zA4xXyOWtBqCpuEBpBhx/RjB9J8sxHLG84zh
 5r4r4NIT5G0OL4iYMh8awwjb7rYOg/KBP0xFjZt0SD4j6LYbHhscZFhZOUUJzmZunzcRGZ+A5HhW8X
 PYNuMHYhjC96RP+/Lqp7cJGUoN4dnTYj2oXHcfJUGYT/7zI1Z+XN6dx3va9uTmQOLF8cBJnop/pBil
 EbajJhB+N9TRUXmzqtD9bjO+0D2dniJO3QDk/ciiL6mlWuBuOWK1UXijCnkg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more resiliant, by replacing the castings with proper
structure definitions and using offsetof() instead of open coding the
location of the data.

Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
media: uvcvideo: Code cleanup for dev->status

Lets remove all the castings and open coding of offsets for it.

To: Yunke Cao <yunkec@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Max Staudt <mstaudt@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v4:
- Fix sizeof() error.
- Keep kzalloc(). Thanks Alan, Christoph and Jonathan
- Reducing the cc: to:
- Link to v3: https://lore.kernel.org/r/20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org

Changes in v3:
- Split the patch in two
- Add linux-usb, Alan and Christoph for the allocation change.
- Link to v2: https://lore.kernel.org/r/20221214-uvc-status-alloc-v2-0-3f1cba6fc734@chromium.org

Changes in v2:
- using __aligned(), to keep the old alignment
- Adding Johnathan Cameron to:, as he has some similar experience with iio
- Adding Ming Lei, as this patch kind of revert his patch.
- Link to v1: https://lore.kernel.org/r/20221214-uvc-status-alloc-v1-0-a0098ddc7c93@chromium.org
---
 drivers/media/usb/uvc/uvc_status.c | 66 +++++++++++++-------------------------
 drivers/media/usb/uvc/uvcvideo.h   | 25 +++++++++++++--
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 7518ffce22ed..00f4036d0683 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -73,38 +73,24 @@ static void uvc_input_report_key(struct uvc_device *dev, unsigned int code,
 /* --------------------------------------------------------------------------
  * Status interrupt endpoint
  */
-struct uvc_streaming_status {
-	u8	bStatusType;
-	u8	bOriginator;
-	u8	bEvent;
-	u8	bValue[];
-} __packed;
-
-struct uvc_control_status {
-	u8	bStatusType;
-	u8	bOriginator;
-	u8	bEvent;
-	u8	bSelector;
-	u8	bAttribute;
-	u8	bValue[];
-} __packed;
-
 static void uvc_event_streaming(struct uvc_device *dev,
-				struct uvc_streaming_status *status, int len)
+				struct uvc_status *status, int len)
 {
-	if (len < 3) {
+	if (len <= offsetof(struct uvc_status, bEvent)) {
 		uvc_dbg(dev, STATUS,
 			"Invalid streaming status event received\n");
 		return;
 	}
 
 	if (status->bEvent == 0) {
-		if (len < 4)
+		if (len <= offsetof(struct uvc_status, streaming))
 			return;
+
 		uvc_dbg(dev, STATUS, "Button (intf %u) %s len %d\n",
 			status->bOriginator,
-			status->bValue[0] ? "pressed" : "released", len);
-		uvc_input_report_key(dev, KEY_CAMERA, status->bValue[0]);
+			status->streaming.button ? "pressed" : "released", len);
+		uvc_input_report_key(dev, KEY_CAMERA,
+				     status->streaming.button);
 	} else {
 		uvc_dbg(dev, STATUS, "Stream %u error event %02x len %d\n",
 			status->bOriginator, status->bEvent, len);
@@ -131,7 +117,7 @@ static struct uvc_control *uvc_event_entity_find_ctrl(struct uvc_entity *entity,
 }
 
 static struct uvc_control *uvc_event_find_ctrl(struct uvc_device *dev,
-					const struct uvc_control_status *status,
+					const struct uvc_status *status,
 					struct uvc_video_chain **chain)
 {
 	list_for_each_entry((*chain), &dev->chains, list) {
@@ -143,7 +129,7 @@ static struct uvc_control *uvc_event_find_ctrl(struct uvc_device *dev,
 				continue;
 
 			ctrl = uvc_event_entity_find_ctrl(entity,
-							  status->bSelector);
+						     status->control.bSelector);
 			if (ctrl)
 				return ctrl;
 		}
@@ -153,7 +139,7 @@ static struct uvc_control *uvc_event_find_ctrl(struct uvc_device *dev,
 }
 
 static bool uvc_event_control(struct urb *urb,
-			      const struct uvc_control_status *status, int len)
+			      const struct uvc_status *status, int len)
 {
 	static const char *attrs[] = { "value", "info", "failure", "min", "max" };
 	struct uvc_device *dev = urb->context;
@@ -161,24 +147,24 @@ static bool uvc_event_control(struct urb *urb,
 	struct uvc_control *ctrl;
 
 	if (len < 6 || status->bEvent != 0 ||
-	    status->bAttribute >= ARRAY_SIZE(attrs)) {
+	    status->control.bAttribute >= ARRAY_SIZE(attrs)) {
 		uvc_dbg(dev, STATUS, "Invalid control status event received\n");
 		return false;
 	}
 
 	uvc_dbg(dev, STATUS, "Control %u/%u %s change len %d\n",
-		status->bOriginator, status->bSelector,
-		attrs[status->bAttribute], len);
+		status->bOriginator, status->control.bSelector,
+		attrs[status->control.bAttribute], len);
 
 	/* Find the control. */
 	ctrl = uvc_event_find_ctrl(dev, status, &chain);
 	if (!ctrl)
 		return false;
 
-	switch (status->bAttribute) {
+	switch (status->control.bAttribute) {
 	case UVC_CTRL_VALUE_CHANGE:
 		return uvc_ctrl_status_event_async(urb, chain, ctrl,
-						   status->bValue);
+						   status->control.bValue);
 
 	case UVC_CTRL_INFO_CHANGE:
 	case UVC_CTRL_FAILURE_CHANGE:
@@ -214,28 +200,22 @@ static void uvc_status_complete(struct urb *urb)
 
 	len = urb->actual_length;
 	if (len > 0) {
-		switch (dev->status[0] & 0x0f) {
+		switch (dev->status->bStatusType & 0x0f) {
 		case UVC_STATUS_TYPE_CONTROL: {
-			struct uvc_control_status *status =
-				(struct uvc_control_status *)dev->status;
-
-			if (uvc_event_control(urb, status, len))
+			if (uvc_event_control(urb, dev->status, len))
 				/* The URB will be resubmitted in work context. */
 				return;
 			break;
 		}
 
 		case UVC_STATUS_TYPE_STREAMING: {
-			struct uvc_streaming_status *status =
-				(struct uvc_streaming_status *)dev->status;
-
-			uvc_event_streaming(dev, status, len);
+			uvc_event_streaming(dev, dev->status, len);
 			break;
 		}
 
 		default:
 			uvc_dbg(dev, STATUS, "Unknown status event type %u\n",
-				dev->status[0]);
+				dev->status->bStatusType);
 			break;
 		}
 	}
@@ -259,12 +239,12 @@ int uvc_status_init(struct uvc_device *dev)
 
 	uvc_input_init(dev);
 
-	dev->status = kzalloc(UVC_MAX_STATUS_SIZE, GFP_KERNEL);
-	if (dev->status == NULL)
+	dev->status = kzalloc(sizeof(*dev->status), GFP_KERNEL);
+	if (!dev->status)
 		return -ENOMEM;
 
 	dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (dev->int_urb == NULL) {
+	if (!dev->int_urb) {
 		kfree(dev->status);
 		return -ENOMEM;
 	}
@@ -281,7 +261,7 @@ int uvc_status_init(struct uvc_device *dev)
 		interval = fls(interval) - 1;
 
 	usb_fill_int_urb(dev->int_urb, dev->udev, pipe,
-		dev->status, UVC_MAX_STATUS_SIZE, uvc_status_complete,
+		dev->status, sizeof(*dev->status), uvc_status_complete,
 		dev, interval);
 
 	return 0;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..84326991ec36 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -51,8 +51,6 @@
 #define UVC_URBS		5
 /* Maximum number of packets per URB. */
 #define UVC_MAX_PACKETS		32
-/* Maximum status buffer size in bytes of interrupt URB. */
-#define UVC_MAX_STATUS_SIZE	16
 
 #define UVC_CTRL_CONTROL_TIMEOUT	5000
 #define UVC_CTRL_STREAMING_TIMEOUT	5000
@@ -527,6 +525,26 @@ struct uvc_device_info {
 	const struct uvc_control_mapping **mappings;
 };
 
+struct uvc_status_streaming {
+	u8	button;
+} __packed;
+
+struct uvc_status_control {
+	u8	bSelector;
+	u8	bAttribute;
+	u8	bValue[11];
+} __packed;
+
+struct uvc_status {
+	u8	bStatusType;
+	u8	bOriginator;
+	u8	bEvent;
+	union {
+		struct uvc_status_control control;
+		struct uvc_status_streaming streaming;
+	};
+} __packed;
+
 struct uvc_device {
 	struct usb_device *udev;
 	struct usb_interface *intf;
@@ -559,7 +577,8 @@ struct uvc_device {
 	/* Status Interrupt Endpoint */
 	struct usb_host_endpoint *int_ep;
 	struct urb *int_urb;
-	u8 *status;
+	struct uvc_status *status;
+
 	struct input_dev *input;
 	char input_phys[64];
 

---
base-commit: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
change-id: 20221214-uvc-status-alloc-93becb783898

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
