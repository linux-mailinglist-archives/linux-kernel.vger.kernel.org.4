Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC316D9A99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjDFOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbjDFOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB137CC35;
        Thu,  6 Apr 2023 07:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23A15648A9;
        Thu,  6 Apr 2023 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6DDC4339B;
        Thu,  6 Apr 2023 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680791500;
        bh=LSwt6QH3V2tXdTONtoafJp4yQRCHGKBXLqabuQsoORw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=urg/HvWRXgJz+pvk3cbgWdkLTNo2G1ckU8HJ+j1VxKmSJr8MEGkiaEKg8ecIga6pi
         bz/CV38E3nJyEa1K3+Sf9d9PJMEFbMO3uKSOjXmd4scHlYWBxSM6S3FCIoZUD0nn4O
         phHLjPbuihFBiDrxTHhzv9TDyn6ovJzqtUCZyxmKLXaU545GajSBRrPCSlQFQ8XIQL
         29AuIB3CtwyLH9FYZkloN+ZX7gTaocryLaGi0DsCua6h0lT/X3hLQywouUXk5zYpXs
         cr7rMYEtHNJDHp1VjuafrfCTTnjDJYVdE5DlxI1avest079ECVFR57u8ct1AeyyuQU
         IQ1+uLVvyp6pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 5063DC77B79;
        Thu,  6 Apr 2023 14:31:40 +0000 (UTC)
From:   Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>
Date:   Thu, 06 Apr 2023 16:31:10 +0200
Subject: [PATCH RFC 1/4] media: v4l2-ctrls: add lens group status controls
 for zoom and focus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v1-1-543189a680de@wolfvision.net>
References: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
In-Reply-To: <20230406-feature-controls-lens-v1-0-543189a680de@wolfvision.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680791498; l=8240;
 i=michael.riesch@wolfvision.net; s=20230406; h=from:subject:message-id;
 bh=Cc1WB+yv71THXEf6l6IJIG9sr2nW0g4dbh9SFdvZUYw=;
 b=RPXxrKUDV4B/2gM4uGuCklbkYr9MQz1oymdujxBicfPUt+Nyi6Xji8UwnUaLDRL0UJUABx6xY
 XmxNSqdMpnuBaqxBpYGDfxi4kGKBeZemc6+k/TAomPmq/QGSy1UVmn9
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=G03kuYHL670EcdsWaNfVA7KnHWmkSpj98XziQm/hjbk=
X-Endpoint-Received: by B4 Relay for michael.riesch@wolfvision.net/20230406 with auth_id=38
X-Original-From: Michael Riesch <michael.riesch@wolfvision.net>
Reply-To: <michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Riesch <michael.riesch@wolfvision.net>

Add the controls V4L2_CID_FOCUS_STATUS and V4L2_CID_ZOOM_STATUS that report
the status of the zoom lens group and the focus lens group, respectively.
The returned data structure contains the current position of the lens group
as well as movement indication flags.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 48 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  9 ++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  7 ++++
 include/media/v4l2-ctrls.h                         |  2 +
 include/uapi/linux/v4l2-controls.h                 | 13 ++++++
 include/uapi/linux/videodev2.h                     |  2 +
 6 files changed, 81 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index daa4f40869f8..3a270bc63f1a 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -149,6 +149,30 @@ enum v4l2_exposure_metering -
     to the camera, negative values towards infinity. This is a
     write-only control.
 
+``V4L2_CID_FOCUS_STATUS (struct)``
+    The current status of the focus lens group. This is a read-only control.
+    The returned data structure contains the current position and movement
+    indication flags. The unit of the current position is undefined. Positive
+    values move the focus closer to the camera, negative values towards
+    infinity. The possible flags are described in the table below.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_STATUS_IDLE``
+      - Focus lens group is at rest.
+    * - ``V4L2_LENS_STATUS_BUSY``
+      - Focus lens group is moving.
+    * - ``V4L2_LENS_STATUS_REACHED``
+      - Focus lens group has reached its target position.
+    * - ``V4L2_LENS_STATUS_FAILED``
+      - Focus lens group has failed to reach its target position. The driver
+	will not transition from this state until another action is performed
+	by an application.
+
 ``V4L2_CID_FOCUS_AUTO (boolean)``
     Enables continuous automatic focus adjustments. The effect of manual
     focus adjustments while this feature is enabled is undefined,
@@ -239,6 +263,30 @@ enum v4l2_auto_focus_range -
     movement. A negative value moves the zoom lens group towards the
     wide-angle direction. The zoom speed unit is driver-specific.
 
+``V4L2_CID_ZOOM_STATUS (struct)``
+    The current status of the zoom lens group. This is a read-only control.
+    The returned data structure contains the current position and movement
+    indication flags. The unit of the current position is driver-specific and
+    its value should be a positive integer. The possible flags are described
+    in the table below.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_STATUS_IDLE``
+      - Zoom lens group is at rest.
+    * - ``V4L2_LENS_STATUS_BUSY``
+      - Zoom lens group is moving.
+    * - ``V4L2_LENS_STATUS_REACHED``
+      - Zoom lens group has reached its target position.
+    * - ``V4L2_LENS_STATUS_FAILED``
+      - Zoom lens group has failed to reach its target position. The driver will
+	not transition from this state until another action is performed by an
+	application.
+
 ``V4L2_CID_IRIS_ABSOLUTE (integer)``
     This control sets the camera's aperture to the specified value. The
     unit is undefined. Larger values open the iris wider, smaller values
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 29169170880a..f6ad30f311c5 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -350,6 +350,9 @@ void v4l2_ctrl_type_op_log(const struct v4l2_ctrl *ctrl)
 	case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
 		pr_cont("HEVC_DECODE_PARAMS");
 		break;
+	case V4L2_CTRL_TYPE_LENS_STATUS:
+		pr_cont("LENS_STATUS");
+		break;
 	default:
 		pr_cont("unknown type %d", ctrl->type);
 		break;
@@ -918,6 +921,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 			return -EINVAL;
 		break;
 
+	case V4L2_CTRL_TYPE_LENS_STATUS:
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -1605,6 +1611,9 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
 	case V4L2_CTRL_TYPE_AREA:
 		elem_size = sizeof(struct v4l2_area);
 		break;
+	case V4L2_CTRL_TYPE_LENS_STATUS:
+		elem_size = sizeof(struct v4l2_ctrl_lens_status);
+		break;
 	default:
 		if (type < V4L2_CTRL_COMPOUND_TYPES)
 			elem_size = sizeof(s32);
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 564fedee2c88..9b26a3aa9e9c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1044,6 +1044,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_CAMERA_ORIENTATION:	return "Camera Orientation";
 	case V4L2_CID_CAMERA_SENSOR_ROTATION:	return "Camera Sensor Rotation";
 	case V4L2_CID_HDR_SENSOR_MODE:		return "HDR Sensor Mode";
+	case V4L2_CID_FOCUS_STATUS:		return "Focus, Status";
+	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1593,6 +1595,11 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
 			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
 		break;
+	case V4L2_CID_FOCUS_STATUS:
+	case V4L2_CID_ZOOM_STATUS:
+		*type = V4L2_CTRL_TYPE_LENS_STATUS;
+		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
+		break;
 	case V4L2_CID_FLASH_STROBE_STATUS:
 	case V4L2_CID_AUTO_FOCUS_STATUS:
 	case V4L2_CID_FLASH_READY:
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index e59d9a234631..f7273ffc20c9 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -52,6 +52,7 @@ struct video_device;
  * @p_hdr10_cll:		Pointer to an HDR10 Content Light Level structure.
  * @p_hdr10_mastering:		Pointer to an HDR10 Mastering Display structure.
  * @p_area:			Pointer to an area.
+ * @p_lens_status:		Pointer to a lens status structure.
  * @p:				Pointer to a compound value.
  * @p_const:			Pointer to a constant compound value.
  */
@@ -81,6 +82,7 @@ union v4l2_ctrl_ptr {
 	struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;
 	struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
 	struct v4l2_area *p_area;
+	struct v4l2_ctrl_lens_status *p_lens_status;
 	void *p;
 	const void *p_const;
 };
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5e80daa4ffe0..8b037467ba9a 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -993,6 +993,19 @@ enum v4l2_auto_focus_range {
 
 #define V4L2_CID_HDR_SENSOR_MODE		(V4L2_CID_CAMERA_CLASS_BASE+36)
 
+struct v4l2_ctrl_lens_status {
+	__u32 flags;
+	__s32 current_position;
+};
+
+#define V4L2_LENS_STATUS_IDLE			(0 << 0)
+#define V4L2_LENS_STATUS_BUSY			(1 << 0)
+#define V4L2_LENS_STATUS_REACHED		(1 << 1)
+#define V4L2_LENS_STATUS_FAILED			(1 << 2)
+
+#define V4L2_CID_FOCUS_STATUS			(V4L2_CID_CAMERA_CLASS_BASE + 37)
+#define V4L2_CID_ZOOM_STATUS			(V4L2_CID_CAMERA_CLASS_BASE + 38)
+
 /* FM Modulator class control IDs */
 
 #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 17a9b975177a..256c21c68720 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1888,6 +1888,8 @@ enum v4l2_ctrl_type {
 	V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS	= 0x0272,
 	V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX	= 0x0273,
 	V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS	= 0x0274,
+
+	V4L2_CTRL_TYPE_LENS_STATUS		= 0x0300,
 };
 
 /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */

-- 
2.30.2

