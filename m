Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3558D64CB72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiLNNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiLNNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:37:51 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190A26116
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:37:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a16so22523775edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9/0oiXeJdIwrXeoL75luu/HKQ258x1rh0eJuFU+umA=;
        b=NRphMd/0+abY72b4CCGlqCM4N7nM95gQZCDRMy0tP9hg6392lI9BupwI/TAwZxkmVA
         /2JbVbO0s+IQZsPGFcqkM6577YQO7xrpGKdg9q3yvpXsGIYB6qFl7+Ap3sXpZ6VbtNjU
         N8yD+DvpCNOfYGuBDsWiSmqhLR0bGnVslkiU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9/0oiXeJdIwrXeoL75luu/HKQ258x1rh0eJuFU+umA=;
        b=leKq08EA4eUHW3N5aruorMG8YGMdAFUYIuprdpAS1O7zRvp6GDK+ZF5YjEIjWpUW8w
         xfZ2ZPHIJVtGoI+xdZUtXNrtj8fAT/wpfir+pX/e4BHrbSAD5365Ei+kcJFgY2akZ0O/
         5HSXEOPXBJ2pttfV54RGYEiglfJM2lL850gEiVOovK82Y3ZagTht0mWlJ0/DN18h13wO
         LzNLxoiw6wcemUJJn80By+7LfHOFEW/Y91oMUbmI4l945Jln0NF3AfHSYI0bPV7re2KN
         CZ4IvuyZfQB3M5IvXbywVm9/HpmUWTbIkmLTuqJhMG8WXKvaeCdQ9HFz1XushQil003Y
         13gg==
X-Gm-Message-State: ANoB5plmbtgjJZiAaVrJ1UFnU4DlqGchHTZfd+psi6iY/YXlH4anAzmU
        SIdT7hXFasAEz/aQPeO/W8FoHQ==
X-Google-Smtp-Source: AA0mqf6Tr94coAd6aLZ7nPqCKKIJS9SO/yDXVII3qTlYTCC4QpDXaJWQY+txK4scM/SEw+d4mA5Wlw==
X-Received: by 2002:a05:6402:3899:b0:468:260e:ad53 with SMTP id fd25-20020a056402389900b00468260ead53mr20652549edb.10.1671025068613;
        Wed, 14 Dec 2022 05:37:48 -0800 (PST)
Received: from alco.roam.corp.google.com ([100.104.168.209])
        by smtp.gmail.com with ESMTPSA id y15-20020a056402134f00b0046b531fcf9fsm6313681edw.59.2022.12.14.05.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 05:37:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 14 Dec 2022 14:37:19 +0100
Subject: [PATCH v2] media: uvcvideo: Do not alloc dev->status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221214-uvc-status-alloc-v2-0-3f1cba6fc734@chromium.org>
To:     Yunke Cao <yunkec@chromium.org>, Ming Lei <tom.leiming@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Staudt <mstaudt@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=8229; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=rQaxX08b7d4sBKDdgbVA4UZdlk7CIYYRcmxDrdE+484=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjmdGgkthMMZpqD4la7aYb5mcZolzQMzvUZj+YGNZy
 rnAJ34mJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5nRoAAKCRDRN9E+zzrEiBr1D/
 wLfPHW5fYi7vBZBnJqLPKyHoYDszGgIT2x4JlkScUYTHtkTP5cKRUwTWpIuCVVnlSpCieA8fxlSeJi
 E0aG9RikVhrMDoQHr2m+bj09trUKiBb7nu3QKTdpkAlQzrYK3Z/n1khPR3TE89qBIHnkZ67nK39OVJ
 eY0VI/g+WC5WB1sX+dJk6Unrsqly4wsL7QtuwOlJ7BfixM55IXsbbNASCCYj6VCwKRBPu43xKPFnrp
 hCOMUQlNyv1oD6HOTTb1OXFREcPn4yATcWvJ3yBbTjsyIpb3hhoPdpm1UqMoNROkG93artRSv+PIsu
 OoASVBEtVPIiyyAekHVplKeirsjUtWhUEm4JXhj1BJOs/37uYit0uA5xld9F4wwfLyJVGiLyCPA925
 kus3ZR7ogETphwt7It3qDGRabT57dIMRKMMcPYjwedeb4gxWa5k3sXVAguRQmrKT9L2npx8rAxnVA6
 0HT43Iuql1OZSxa0n0r8AvhYK8bC5RND63P276+Ij5H5NJovYii62KwMRnYJAKj//ur7JVRdkNQkdu
 rRQ9DDRdXAbA5bZX5Hy8JiiB/w5Gy4iJoumerEDNCSjyBYOO3bXUctGBvFu0LF0DHel3Tq9+DbuQ4l
 lYWOOv1LvrnFTAacctecjg1GkRnZXb+wW9rpHVfq7y6xmPgZ+WPHUaBrzx1g==
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

UVC_MAX_STATUS_SIZE is 16 bytes, simplify the code by inlining dev->status.

Now that we are at it, remove all the castings.

To avoid issues with non-coherent DMAs, give the memory the same
allocation as kmalloc.

This patch kind of reverts:
Fixes: a31a4055473b ("V4L/DVB:usbvideo:don't use part of buffer for USB transfer #4"

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Ming Lei <tom.leiming@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yunke Cao <yunkec@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Max Staudt <mstaudt@google.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- using __aligned(), to keep the old alignment
- Adding Johnathan Cameron to:, as he has some similar experience with iio
- Adding Ming Lei, as this patch kind of revert his patch
- Link to v1: https://lore.kernel.org/r/20221214-uvc-status-alloc-v1-0-a0098ddc7c93@chromium.org
---
 drivers/media/usb/uvc/uvc_status.c | 69 ++++++++++++--------------------------
 drivers/media/usb/uvc/uvcvideo.h   | 28 +++++++++++++++-
 2 files changed, 48 insertions(+), 49 deletions(-)

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
index df93db259312..5dfc2896ce88 100644
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
+
 	struct input_dev *input;
 	char input_phys[64];
 
@@ -572,6 +592,12 @@ struct uvc_device {
 	} async_ctrl;
 
 	struct uvc_entity *gpio_unit;
+
+	/*
+	 * Ensure that status is aligned, making it safe to use with
+	 * non-coherent DMA.
+	 */
+	struct uvc_status status __aligned(ARCH_KMALLOC_MINALIGN);
 };
 
 enum uvc_handle_state {

---
base-commit: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
change-id: 20221214-uvc-status-alloc-93becb783898

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
