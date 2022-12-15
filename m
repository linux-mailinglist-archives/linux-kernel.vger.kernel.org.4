Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A93464D9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiLOK5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLOK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:57:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B175A188
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:57:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x22so51318014ejs.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSkI969AHN6FFgkQLh7KNbMW382SQo147AqPdkQUANc=;
        b=Ej+zTKwJUgg4TQWirbZ4KOY/mptHTiT4TdeLugCDuxSCz4cVDU5A7S0uFZWLkjIFLe
         MP73trke32qu+WAa+tWyD75qUxpPpPPIWsra8g46CxVsOl3mo+F+Y9D4JCLZHc6xGrHm
         uyWZz9803YUAY7/RUGPaJgQWISRomX0tDn2o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSkI969AHN6FFgkQLh7KNbMW382SQo147AqPdkQUANc=;
        b=0xuuHYeEH5uzy6ld+9Y7ixE1Csnl3cW2wGiULGBEZCArVk7u2arDH1xtc266md4cnh
         XO4G2SgLbGq530CugtimJiuzMYMDZf5NKls5GkuUCQ5i8xf7b/QiiL8dTik37m98GBme
         GhfZJpXT2NNufTfG3AhYfH4vyMcg1svyeT9cd3deTGereO+Qk8/lPTwwgb0OxGaYPnBG
         IJfcw1UB8WOR1B4O27O2bvOvCsi348/voNhum3GZu58ttgG2Yg1I2GMazi01CqhgoEM9
         rgpO2sS1KlzGOm5H5NjHTIA4z+qOqgvejK4G3SKaK/KXLvb2IXt1JTCA2RW2qFSKPGyl
         1Uig==
X-Gm-Message-State: ANoB5pm7SrvxHfQDTxiLrvuGWWK3EUOrd7ripnRCQLc54BjOh+yP4HKt
        k9lEhVKSWBp8tiZxKlnEo3Uohg==
X-Google-Smtp-Source: AA0mqf6v38I0uTBudjuoFkaJOo97DQ5LXesDeT1nCRhEEV12oIN1tIBKABpbZ3jr4arFcuAd4M6rbA==
X-Received: by 2002:a17:907:2e01:b0:7c1:4785:d650 with SMTP id ig1-20020a1709072e0100b007c14785d650mr18801907ejc.26.1671101854165;
        Thu, 15 Dec 2022 02:57:34 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id e8-20020a056402148800b0046c5dda6b32sm7339381edv.31.2022.12.15.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:57:33 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 15 Dec 2022 11:57:18 +0100
Subject: [PATCH v3 1/2] media: uvcvideo: Remove void casting for the status endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221214-uvc-status-alloc-v3-1-9a67616cc549@chromium.org>
References: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
In-Reply-To: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
To:     Max Staudt <mstaudt@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=7076; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=V2rWcnBqmgk8lCWa8FIMO2ca3bxD5e+bR0IB5Ki3LKM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjmv2ZA9iSgIJW6eeXeNsSgMogcujTczALIPQC4dBK
 u/6XlqiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5r9mQAKCRDRN9E+zzrEiN0+D/
 9q/rNcfR8rRrnw7gRtOiaRPHugT7LydH2Qs8WUcTblgiq8xPuIpHb75IGmBJk0KLK9TaiWrDa+OMgY
 g+BosDK16sTsVTHS1I8z0DXtX+FyktW2ElO81FpG8i6Nogvz2khesTfuR0xL4ovuTCaQoFhYRJBIcv
 0hhUOcKo5mUczEdBwyY734g1A3Oa1CElDFqJjl3Xh6oPItJwkUNWcY508r3FPp0vZuZOT0YZvnKydL
 7CdEM3jQY+g592QUczc8KynZWs1+1QvKf1z9dsaSJUiik/hUxXH5nkfW4uSLrBLENWfSfg5ZI1uLLy
 Nyli8nBZ8w8pjjaNMh3/AQ3eRlWhWMofr3/ryCgvYAZEwYRgEzVAqMBjHYmTfSqFcA+yghWe5aj30p
 29mMmVyS7cPODNdMhM8ge/5Z+wCOpx/vGXITDUJuuHOlVDWppEd91ZkH0JWLILX79++iTTNsZWrPdk
 FjcTWX9oqSmyWc4u3/Q6DXNb72P+ZD1Baw/SSwdbqgFmooGjQQLEPntuNFUyDmJCFe6htcKhh7yR9A
 5Iym2S/PmC63IlNML2bm2VvjFZiYfJKYSf3+0I7SakJ5j1hQqo0aEdWmjfiD8nc+3krdLQx9tAyTzk
 y8eJ3P+e3h7VB+/FtelzLbCKLSPgHA6ugQci0IRxandjamYkcObdmqQxAYuA==
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

Make the code more resiliant, by replacing the castings with proper
structure definitions and using offsetof() instead of open coding the
location of the data.

Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 64 +++++++++++++-------------------------
 drivers/media/usb/uvc/uvcvideo.h   | 25 +++++++++++++--
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 7518ffce22ed..dbaa9b07d77f 100644
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
+	dev->status = kzalloc(sizeof(*dev->status), GFP_KERNEL);
 	if (dev->status == NULL)
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
+		dev->status, sizeof(dev->status), uvc_status_complete,
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
 

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
