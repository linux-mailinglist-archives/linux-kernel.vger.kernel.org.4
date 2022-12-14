Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618A664C7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiLNLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiLNLYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:24:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690592496E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:24:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk9so43772305ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRQpccloQiMZN4saRLUHMMeZBeRRnRn5nkbaL4W4GdU=;
        b=mwASJg7dtkUG02UasdQmC3cun9vteqzuLzNZuEfl5IFp8nZSRnBiOd2AN6o8Ptgw2Z
         pvT8LqBY7JcJpyJZ3CWH4+kS+eUEgoIus89lWz+D4dTLTttUEKVTq+tXpyvgqRSojCb8
         sQCo88l4SCYGUDiORZXAAU5iWOUKxfJEMKTds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRQpccloQiMZN4saRLUHMMeZBeRRnRn5nkbaL4W4GdU=;
        b=zJADkflvAZkDE/+m9gsYbqR4mYbGBsWYXEhE7R9B1QXXaquoHHUcTFJrlTlYXNm8nI
         lrQTNqOD+dt4razoqloR93C+Ltu2HIZRvFZZuHCZMK6UFflbYYEeZe9V+C67qM0C+Kzw
         TunXil8f3RCfY8nipKH7hxc/5ltYzesNqKmtDAIGD26iy+KyhIgdwELxksH3LtSy/7/o
         l2w41RxsP3eKLCMP2w70QtvidUoz34tDhwlHONlIKu2fo/qbzOumlRtMZubWtyZKeykO
         +zKxDI3PKiOH6QmfYyFicTQkVlI+KHHv+h2H8qLrVw+CEOKfXP10+hPfZ/pI7zF+S0No
         Wl1w==
X-Gm-Message-State: ANoB5pneR+5rYVfkGCsHHEoHy2euwVAl/eYRDjMxsNfkI0no/VDj35/u
        yc13zdVJ/P+Zag+J92C4zsyVxA==
X-Google-Smtp-Source: AA0mqf7Lbg5q0PavkIILmyF6Ukl4kk1jJdlArz22SF/saRlUTu0DIqR+15W2gUVLdypqucYC97XfNg==
X-Received: by 2002:a17:907:9208:b0:7c0:d605:fe42 with SMTP id ka8-20020a170907920800b007c0d605fe42mr15215915ejb.18.1671017044038;
        Wed, 14 Dec 2022 03:24:04 -0800 (PST)
Received: from alco.roam.corp.google.com ([100.104.168.209])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b007c17b3a4163sm3034995eja.15.2022.12.14.03.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:24:03 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 14 Dec 2022 12:23:41 +0100
Subject: [PATCH] media: uvcvideo: Do not alloc dev->status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221214-uvc-status-alloc-v1-0-a0098ddc7c93@chromium.org>
To:     Yunke Cao <yunkec@chromium.org>, Max Staudt <mstaudt@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=7349; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=bxfPn7ndbrz/ZOaMZwhhHYT3BZ1JIWXtS1bv+cB42RY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjmbJQXMjwj6w6yc+iZ1CWllvZyH9AaydNC98PtykB
 ra5QDDKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5myUAAKCRDRN9E+zzrEiONRD/
 43kbS55hMa3GJ7Jutk+c5+EU78NyNML+a4CXq9Huq08vGgih7ggyMFEr3dJDFQIfBOFczn6DqTrRYG
 dsVnh8fE3AIcrdWVIWzWJ/7UgnpIpE8wrgh5rcxzJszqO59nV35qvhDdsloNjyHHckjg3G6dgMf1W2
 Z+N0D+rMdfu6xSshXNiL/ZAKEZ3XfDDDKC/HKBq0gJ7Iaw6ibp69bisc6Bp9RNnKl9Ja9nCvyel76D
 Ax8/rWkAHDSK2C/gZNaHWJBu/vSdHGXA6jD/piT12K+7yn0CuPC2EOZkleK27kBLY5VLxzpF1B8wVs
 l6Fu5km8y8kY90ArYa3RdxF4qdGqw9/jAP1P0PyDKOfoGaudHYVkj6lIsWAvRMC4eVl/X3FAOWOFnj
 BSMlj7tTpa1AZMyKI2E1iZKMqZd9s8X6dsUdrdlkiuQBNEMn5INoxuPyQgUJaS6zOR4q7B2AsmiMkz
 u2y+0WOkkttPdUg+UKS53lDx/bZSOKAHBDZcbqPgxBtfCiwC3lfqfZhBQ3WO0bot/pZ/ePg3TiGmzj
 9+mGNddSlv1f25g7CNrzaLSQOkqH8GpQfH+Kbtiq5VGUc7HR/rdVflbC3b81d4mgPeH6IljEP2jsR3
 U8x57f8bZiNEB5Vx4dTfvxy2F/Z7LohL+5I4RmZA9WfbLlWwV6HGXAl4TEFA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UVC_MAX_STATUS_SIZE is 16, simplify the code by inlining dev->status.

Now that we are at it, remove all the castings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Yunke Cao <yunkec@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Max Staudt <mstaudt@google.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/media/usb/uvc/uvc_status.c | 69 ++++++++++++--------------------------
 drivers/media/usb/uvc/uvcvideo.h   | 22 +++++++++++-
 2 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 7518ffce22ed..adf63e7616c9 100644
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
+		switch (dev->status.bStatusType & 0x0f) {
 		case UVC_STATUS_TYPE_CONTROL: {
-			struct uvc_control_status *status =
-				(struct uvc_control_status *)dev->status;
-
-			if (uvc_event_control(urb, status, len))
+			if (uvc_event_control(urb, &dev->status, len))
 				/* The URB will be resubmitted in work context. */
 				return;
 			break;
 		}
 
 		case UVC_STATUS_TYPE_STREAMING: {
-			struct uvc_streaming_status *status =
-				(struct uvc_streaming_status *)dev->status;
-
-			uvc_event_streaming(dev, status, len);
+			uvc_event_streaming(dev, &dev->status, len);
 			break;
 		}
 
 		default:
 			uvc_dbg(dev, STATUS, "Unknown status event type %u\n",
-				dev->status[0]);
+				dev->status.bStatusType);
 			break;
 		}
 	}
@@ -259,15 +239,9 @@ int uvc_status_init(struct uvc_device *dev)
 
 	uvc_input_init(dev);
 
-	dev->status = kzalloc(UVC_MAX_STATUS_SIZE, GFP_KERNEL);
-	if (dev->status == NULL)
-		return -ENOMEM;
-
 	dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (dev->int_urb == NULL) {
-		kfree(dev->status);
+	if (!dev->int_urb)
 		return -ENOMEM;
-	}
 
 	pipe = usb_rcvintpipe(dev->udev, ep->desc.bEndpointAddress);
 
@@ -281,7 +255,7 @@ int uvc_status_init(struct uvc_device *dev)
 		interval = fls(interval) - 1;
 
 	usb_fill_int_urb(dev->int_urb, dev->udev, pipe,
-		dev->status, UVC_MAX_STATUS_SIZE, uvc_status_complete,
+		&dev->status, sizeof(dev->status), uvc_status_complete,
 		dev, interval);
 
 	return 0;
@@ -296,7 +270,6 @@ void uvc_status_unregister(struct uvc_device *dev)
 void uvc_status_cleanup(struct uvc_device *dev)
 {
 	usb_free_urb(dev->int_urb);
-	kfree(dev->status);
 }
 
 int uvc_status_start(struct uvc_device *dev, gfp_t flags)
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..cdd2e328acc2 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -527,6 +527,26 @@ struct uvc_device_info {
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
@@ -559,7 +579,7 @@ struct uvc_device {
 	/* Status Interrupt Endpoint */
 	struct usb_host_endpoint *int_ep;
 	struct urb *int_urb;
-	u8 *status;
+	struct uvc_status status;
 	struct input_dev *input;
 	char input_phys[64];
 

---
base-commit: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
change-id: 20221214-uvc-status-alloc-93becb783898

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
