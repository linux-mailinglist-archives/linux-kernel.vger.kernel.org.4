Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7B7397EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjFVHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjFVHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:12:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6911BD3;
        Thu, 22 Jun 2023 00:12:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-988aefaa44eso612042266b.2;
        Thu, 22 Jun 2023 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687417960; x=1690009960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gmM3ZejwGC+6a07ZhZTgRTiQBNhhfo6Vw23/zoB7sk=;
        b=cDcH26/paITTZSI8ehibrO5cWG6UIxZBad7iixEvpHqtOzFS7pr8CnC81NmiQ3BPAs
         iDEkSqORwhMTjpoEPtNTSL8YhI2z9iK9K4tXU1JUfGoB28LZqnl+slY/iMfROhD/1mUz
         87Z1JDaL+x+YY/d3I+1DO5uai0I9ZXocIdV3Bfh3rgZDXkwV6muFCslLe7j19iqmP//6
         oTTxfqVEVocSII6ba6lYduwQRy9DsYkCwX5HwnxsWjB36C0pHwU6kpvI+mrTAWHC9pUK
         PvcNTyngkOlRHUFnp9AJn16Ib9V6c50qlaVm/ZR9X2AY8IQj9LQMptDVGB9uFckDZVAi
         JEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687417960; x=1690009960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gmM3ZejwGC+6a07ZhZTgRTiQBNhhfo6Vw23/zoB7sk=;
        b=LtHOmqTTcAVrEedqNjjitQMSdRGhd9S4vc8HS1lpJWtllFNbAZ3c4cycf0ls/CTpr4
         n1HQtII5ZxTwKsLjrDsaHtEKOhMhuviFjbgMwNC2in0C0svL6FoMzBwspjeI5AUkSqkP
         jmZY4R6+yMUcXXXEQ0l57qjSD6Lz+1RQe9NWU+uHWCKeH1Z0GO1qrxFgArFsNc9LO7+G
         Yp86Lxa8TT3iD0C2/LXwEp8ObkgquH0mcOmvtq3CbJUr22vvkUpY3tBihYMCwAXCqhDz
         sc4HxkaMr8i0vVUkW2D2sOgvraq3UNbscGGu8UGm0HXXF1cOqS4p1HW3Vbmv2zVxvqww
         MfbQ==
X-Gm-Message-State: AC+VfDyLz5NUzU+AtPjYn6qz7mrgXRFBF70gGt0vo5GVzUHtZ8YFcDrr
        tSbFy+Yq+2UKADHuTZe+EJE=
X-Google-Smtp-Source: ACHHUZ4D49wXTy2HY7IGzI8M9ZLBvwiGtYoqrCCRD08tjy9ejVj8lyCyXp/bNm7jzAY5s0n2Z7/OPQ==
X-Received: by 2002:a17:907:7da1:b0:98d:470d:932e with SMTP id oz33-20020a1709077da100b0098d470d932emr105051ejc.48.1687417959764;
        Thu, 22 Jun 2023 00:12:39 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id bq26-20020a170906d0da00b0096f5b48fe43sm4134923ejb.47.2023.06.22.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:12:39 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 22 Jun 2023 09:12:23 +0200
Subject: [PATCH WIP RFC v2 1/2] media: uapi: Add V4L2_CID_{V,H}TOTAL
 controls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-v4l2-vtotal-v2-1-cf29925f4517@skidata.com>
References: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
In-Reply-To: <20230609-v4l2-vtotal-v2-0-cf29925f4517@skidata.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     laurent.pinchart@ideasonboard.com, jacopo.mondi@ideasonboard.com,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Currently, V4L2_CID_{V,H}BLANK can be used to control the frame duration
of a stream. However, camera sensors usually have a register for the
total size (image data + blanking), e.g. {V,H}MAX on the imx290. As the
user space also typically wants to set a frame size, both sides
currently have to calculate with values they actually don't care about.

The dependency between format height and vertical blanking also results
to a change of the vertical blanking value and limits whenever the
format of the frame is changed and therefore makes it harder for user
space to do calculations, e.g. the frame duration.
V4L2_CID_{V,H}TOTAL do not depend on the format and therefore simplify
calculations. Additionally, they represent the hardware "better" and
therefore also simplify calculations on the driver side.

Add additional documentation about V4L2_CID_HTOTAL to have a control
which enables the user space to express its intends to the driver. The
driver can then update its controls and limits accordingly, and can do
possible re-calculations during mode switches in a defined behaviour.
This increases compatibility between different camera sensors.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v2:
- add HTOTAL
- add documentation about expectations
---
 Documentation/driver-api/media/camera-sensor.rst         | 11 +++++++++--
 .../userspace-api/media/v4l/ext-ctrls-image-source.rst   | 16 ++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                |  2 ++
 include/uapi/linux/v4l2-controls.h                       |  2 ++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/media/camera-sensor.rst b/Documentation/driver-api/media/camera-sensor.rst
index c7d4891bd24e..3ddeb0533728 100644
--- a/Documentation/driver-api/media/camera-sensor.rst
+++ b/Documentation/driver-api/media/camera-sensor.rst
@@ -85,12 +85,14 @@ a result of the configuration of a number of camera sensor implementation
 specific parameters. Luckily, these parameters tend to be the same for more or
 less all modern raw camera sensors.
 
-The frame interval is calculated using the following equation::
+The frame interval is calculated using one of the following equations::
 
 	frame interval = (analogue crop width + horizontal blanking) *
 			 (analogue crop height + vertical blanking) / pixel rate
 
-The formula is bus independent and is applicable for raw timing parameters on
+	frame interval = horizontal total size * vertical total size / pixel rate
+
+The formulas are bus independent and are applicable for raw timing parameters on
 large variety of devices beyond camera sensors. Devices that have no analogue
 crop, use the full source image size, i.e. pixel array size.
 
@@ -100,6 +102,11 @@ is pixels and the unit of the ``V4L2_CID_VBLANK`` is lines. The pixel rate in
 the sensor's **pixel array** is specified by ``V4L2_CID_PIXEL_RATE`` in the same
 sub-device. The unit of that control is pixels per second.
 
+Additionally, the horizontal and vertical total sizes are specified by
+``V4L2_CID_HTOTAL`` and ``V4L2_CID_VTOTAL``, respectively. The unit of the
+``V4L2_CID_HTOTAL`` control is pixels and the unit of the ``V4L2_CID_VTOTAL`` is
+lines, analogous to the blanking.
+
 Register list based drivers need to implement read-only sub-device nodes for the
 purpose. Devices that are not register list based need these to configure the
 device's internal processing pipeline.
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
index 71f23f131f97..5451fa0223cd 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-image-source.rst
@@ -59,6 +59,22 @@ Image Source Control IDs
     non-sensitive.
     This control is required for automatic calibration of sensors/cameras.
 
+``V4L2_CID_VTOTAL (integer)``
+    Number of total lines per frame, including data and idle lines (blanking).
+    The unit of the vertical total size is a line. Every line has length of the
+    image width plus horizontal blanking at the pixel rate defined by
+    ``V4L2_CID_PIXEL_RATE`` control in the same sub-device.
+
+``V4L2_CID_HTOTAL (integer)``
+    Number of total pixels per line, including data and idle pixels (blanking).
+    The unit of the horizontal total size is pixels. The default value of this
+    control is set to a value which allows a constant total size for every
+    supported mode of the sensor. The control can be used to indicate the driver
+    if a high frame rate (value < default) or a high exposure (value > default)
+    should be achieved. With value = default, a constant frame size across the
+    different modes is targeted. Note that the actual frame rate depends on the
+    ``V4L2_CID_PIXEL_RATE`` control, which might vary between mode switches.
+
 .. c:type:: v4l2_area
 
 .. flat-table:: struct v4l2_area
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 564fedee2c88..34e17e1faa7a 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1112,6 +1112,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_TEST_PATTERN_BLUE:	return "Blue Pixel Value";
 	case V4L2_CID_TEST_PATTERN_GREENB:	return "Green (Blue) Pixel Value";
 	case V4L2_CID_NOTIFY_GAINS:		return "Notify Gains";
+	case V4L2_CID_VTOTAL:			return "Vertical Total Size";
+	case V4L2_CID_HTOTAL:			return "Horizontal Total Size";
 
 	/* Image processing controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5e80daa4ffe0..a4bbd91b8aef 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1117,6 +1117,8 @@ enum v4l2_jpeg_chroma_subsampling {
 #define V4L2_CID_TEST_PATTERN_GREENB		(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 7)
 #define V4L2_CID_UNIT_CELL_SIZE			(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 8)
 #define V4L2_CID_NOTIFY_GAINS			(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 9)
+#define V4L2_CID_VTOTAL				(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 10)
+#define V4L2_CID_HTOTAL				(V4L2_CID_IMAGE_SOURCE_CLASS_BASE + 11)
 
 
 /* Image processing controls */

-- 
2.34.1

