Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920AB66568D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjAKIxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjAKIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:52:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A7101E3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so19267724pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTHdzY+haQl3YSErVpjNiQcb5OOOoU8CyxSOtErrOF4=;
        b=WkzbApP16X3bCYi53z4UGsBOhusmco9/jYDdOFjVdHdImlUXPFTyBqHGZpM1Fh9u7l
         ioU6f5BrEdVz/5HtCGmbSc7e9cHXg5QcSYckOvFuTopjca3B/0sv/nhbCknnVWAY1NaD
         VT9bIsjw4T0b7OA211xXUQhUQ+EX84TyW7KWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTHdzY+haQl3YSErVpjNiQcb5OOOoU8CyxSOtErrOF4=;
        b=ePe9p3x01mIECyoyIluPnJ2sjba1Et386A7MvOwUsx9qpAicIq5mpzbJ1m7D4afrw8
         YvfZU+rqrjudBpQPhhUQtonRtfZndB3cov+SS0d2OszaaaRPXi8euEYADL6oJSc5siXW
         8TwgEitmFylaFm+vhRZYHsq3bgYflr7zHTS/59zLQhiFme9zrAXnx6SUihfafTA/ueIc
         CW2EotY5axy2AHdUgzfIUEvAJdDvyYRP2VQEvKNTxZeFsHNyfK3pWZJHEtFgm/+5qlid
         VGpsvutiRzCnZTvZYSqPUCDEJ7ZNcVtWl3zGnkyDxvDSbGVvY47R+9xDg+e1GMrpB0LW
         Wa4A==
X-Gm-Message-State: AFqh2koqzZzsva7PzWLARoc8ztawmmX8b+w0zJ90hDc+uEO0RVv7EuNf
        JbokPSchssTw9pnuClgqfTIyFw==
X-Google-Smtp-Source: AMrXdXvNIRHCM9j4azJteWrFqyCqcReBTsGupYNxtfPx5U97OEkhALrlmhAMSj1bUSwP70nUYSk2ZA==
X-Received: by 2002:a17:902:c2d4:b0:193:d12:f892 with SMTP id c20-20020a170902c2d400b001930d12f892mr2314171pla.0.1673427168406;
        Wed, 11 Jan 2023 00:52:48 -0800 (PST)
Received: from yunkec1.tok.corp.google.com ([2401:fa00:8f:203:c84:581:fd3a:b32b])
        by smtp.gmail.com with ESMTPSA id ik9-20020a170902ab0900b00183c67844aesm9566612plb.22.2023.01.11.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:52:48 -0800 (PST)
From:   Yunke Cao <yunkec@chromium.org>
Date:   Wed, 11 Jan 2023 17:52:40 +0900
Subject: [PATCH RFC 3/3] media: uvcvideo: reimplement privacy GPIO as a separate
 subdevice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230111-uvc_privacy_subdev-v1-3-f859ac9a01e3@chromium.org>
References: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
In-Reply-To: <20230111-uvc_privacy_subdev-v1-0-f859ac9a01e3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Yunke Cao <yunkec@chromium.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-4d321
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement privacy GPIO as a v4l2 subdev with a volatile privacy control.
A v4l2 control event is sent in irq when privacy control value changes.

The behavior matches the original implementation, except that the
control is of a separate subdevice.

V4L2 control kAPI is used for simplicity.

Signed-off-by: Yunke Cao <yunkec@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 44 +++-------------------
 drivers/media/usb/uvc/uvc_entity.c | 76 ++++++++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   | 19 +++++++---
 3 files changed, 94 insertions(+), 45 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e4bcb5011360..25848f4dbce0 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1209,43 +1209,6 @@ static int uvc_parse_control(struct uvc_device *dev)
  * Privacy GPIO
  */
 
-static void uvc_gpio_event(struct uvc_device *dev)
-{
-	struct uvc_entity *unit = dev->gpio_unit;
-	struct uvc_video_chain *chain;
-	u8 new_val;
-
-	if (!unit)
-		return;
-
-	new_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
-
-	/* GPIO entities are always on the first chain. */
-	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
-	uvc_ctrl_status_event(chain, unit->controls, &new_val);
-}
-
-static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
-			    u8 cs, void *data, u16 size)
-{
-	if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
-		return -EINVAL;
-
-	*(u8 *)data = gpiod_get_value_cansleep(entity->gpio.gpio_privacy);
-
-	return 0;
-}
-
-static int uvc_gpio_get_info(struct uvc_device *dev, struct uvc_entity *entity,
-			     u8 cs, u8 *caps)
-{
-	if (cs != UVC_CT_PRIVACY_CONTROL)
-		return -EINVAL;
-
-	*caps = UVC_CONTROL_CAP_GET | UVC_CONTROL_CAP_AUTOUPDATE;
-	return 0;
-}
-
 static irqreturn_t uvc_gpio_irq(int irq, void *data)
 {
 	struct uvc_device *dev = data;
@@ -1279,8 +1242,6 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 	unit->gpio.bControlSize = 1;
 	unit->gpio.bmControls = (u8 *)unit + sizeof(*unit);
 	unit->gpio.bmControls[0] = 1;
-	unit->get_cur = uvc_gpio_get_cur;
-	unit->get_info = uvc_gpio_get_info;
 	strscpy(unit->name, "GPIO", sizeof(unit->name));
 
 	list_add_tail(&unit->list, &dev->entities);
@@ -2202,6 +2163,11 @@ static int uvc_probe(struct usb_interface *intf,
 	if (media_device_register(&dev->mdev) < 0)
 		goto error;
 #endif
+
+	/* Expose all subdev's nodes*/
+	if (v4l2_device_register_subdev_nodes(&dev->vdev) < 0)
+		goto error;
+
 	/* Save our data pointer in the interface data. */
 	usb_set_intfdata(intf, dev);
 
diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 7c4d2f93d351..c8e41b42ffd8 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -56,17 +56,90 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 	return 0;
 }
 
+static const struct v4l2_subdev_core_ops uvc_subdev_core_ops = {
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
 static const struct v4l2_subdev_ops uvc_subdev_ops = {
+	.core = &uvc_subdev_core_ops,
 };
 
 void uvc_mc_cleanup_entity(struct uvc_entity *entity)
 {
+	if (UVC_ENTITY_TYPE(entity) == UVC_EXT_GPIO_UNIT)
+		v4l2_ctrl_handler_free(&entity->gpio.hdl);
+
 	if (UVC_ENTITY_TYPE(entity) != UVC_TT_STREAMING)
 		media_entity_cleanup(&entity->subdev.entity);
 	else if (entity->vdev != NULL)
 		media_entity_cleanup(&entity->vdev->entity);
 }
 
+static int uvc_gpio_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct uvc_gpio *gpio =
+		container_of(ctrl->handler, struct uvc_gpio, hdl);
+
+	ctrl->cur.val = gpiod_get_value_cansleep(gpio->gpio_privacy);
+
+	return 0;
+}
+
+static const struct v4l2_ctrl_ops uvc_gpio_ctrl_ops = {
+	.g_volatile_ctrl = uvc_gpio_g_volatile_ctrl,
+};
+
+void uvc_gpio_event(struct uvc_device *dev)
+{
+	struct uvc_entity *unit = dev->gpio_unit;
+	struct v4l2_ctrl *ctrl;
+	struct v4l2_event ev;
+	s32 old_val;
+	int ret;
+
+	if (!unit)
+		return;
+
+	ctrl = unit->gpio.privacy_ctrl;
+	old_val = ctrl->cur.val;
+
+	v4l2_ctrl_lock(ctrl);
+
+	ret = uvc_gpio_g_volatile_ctrl(ctrl);
+	if (ret < 0 || old_val == ctrl->cur.val) {
+		v4l2_ctrl_unlock(ctrl);
+		return;
+	}
+
+	v4l2_ctrl_fill_event(&ev, ctrl, V4L2_EVENT_CTRL_CH_VALUE);
+	v4l2_ctrl_unlock(ctrl);
+
+	v4l2_event_queue(unit->subdev.devnode, &ev);
+}
+
+static void uvc_gpio_init_ctrl(struct uvc_entity *entity)
+{
+	struct v4l2_ctrl *ctrl;
+	struct v4l2_ctrl_handler *hdl = &entity->gpio.hdl;
+
+	entity->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE |
+			       V4L2_SUBDEV_FL_HAS_EVENTS;
+
+	v4l2_ctrl_handler_init(hdl, 1);
+	entity->subdev.ctrl_handler = hdl;
+	ctrl = v4l2_ctrl_new_std(hdl, &uvc_gpio_ctrl_ops, V4L2_CID_PRIVACY,
+				 0, 1, 1, 0);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE |
+			       V4L2_CTRL_FLAG_READ_ONLY;
+
+	/* Read GPIO value to initialize the control. */
+	uvc_gpio_g_volatile_ctrl(ctrl);
+
+	entity->gpio.privacy_ctrl = ctrl;
+}
+
 static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 			      struct uvc_entity *entity)
 {
@@ -113,6 +186,9 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 
 		entity->subdev.entity.function = function;
 
+		if (UVC_ENTITY_TYPE(entity) == UVC_EXT_GPIO_UNIT)
+			uvc_gpio_init_ctrl(entity);
+
 		ret = media_entity_pads_init(&entity->subdev.entity,
 					entity->num_pads, entity->pads);
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..19ca2896c398 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -15,6 +15,7 @@
 #include <linux/videodev2.h>
 #include <linux/workqueue.h>
 #include <media/media-device.h>
+#include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-fh.h>
@@ -163,6 +164,15 @@ struct uvc_control {
 
 #define UVC_ENTITY_FLAG_DEFAULT		(1 << 0)
 
+struct uvc_gpio {
+	u8  bControlSize;
+	u8  *bmControls;
+	struct gpio_desc *gpio_privacy;
+	int irq;
+	struct v4l2_ctrl_handler hdl;
+	struct v4l2_ctrl *privacy_ctrl;
+};
+
 struct uvc_entity {
 	struct list_head list;		/* Entity as part of a UVC device. */
 	struct list_head chain;		/* Entity as part of a video device chain. */
@@ -221,12 +231,7 @@ struct uvc_entity {
 			u8  *bmControlsType;
 		} extension;
 
-		struct {
-			u8  bControlSize;
-			u8  *bmControls;
-			struct gpio_desc *gpio_privacy;
-			int irq;
-		} gpio;
+		struct uvc_gpio gpio;
 	};
 
 	u8 bNrInPins;
@@ -766,6 +771,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
 
+void uvc_gpio_event(struct uvc_device *dev);
+
 /* Utility functions */
 struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
 					    u8 epaddr);

-- 
b4 0.11.0-dev-4d321
