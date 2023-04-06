Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD16D9A86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbjDFOgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjDFOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC5D307;
        Thu,  6 Apr 2023 07:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D4E6489F;
        Thu,  6 Apr 2023 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4267C433A4;
        Thu,  6 Apr 2023 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680791500;
        bh=RyDWKy48TsKVtA2Ls0BtoGe0+1BDPQp9L9Bj3QXC1Dw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=uYsoSe6rpzG3pYpnJ9YlN16d6uyUzLEbXxCrE+0CsIy0bdv8jwX7gxCb6WxWa88PM
         +2PGnckzkuSJtNwmS5tDHYs9nkV8o5WP7KfI45zp6cjqKmVD8pQsdyNuYz6kUqdAW6
         WQ/TVDffFcNAi7jcAHxVw/kVzTn0fA5a75o3MNMdCGGbNJoKLpNSzlDaEyNSMdsu61
         tfh0QqHxYC4rVWD4TmAjq7+DIQ3lmUypJiMZjZJBlapp3uGkJ9WcQWCuPCY3i3Umzh
         KeiJbfn9lFfdpJWi+hDiMmXi/p8gjnwVuY24waBJk/EGVv0wM9wO+CP2dAR38mCDyf
         JLacNNxTqLLog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id B7277C77B79;
        Thu,  6 Apr 2023 14:31:40 +0000 (UTC)
From:   Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>
Date:   Thu, 06 Apr 2023 16:31:12 +0200
Subject: [PATCH RFC 3/4] media: v4l2-ctrls: add lens calibration controls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v1-3-543189a680de@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680791498; l=4774;
 i=michael.riesch@wolfvision.net; s=20230406; h=from:subject:message-id;
 bh=xh3oWCYEuxKk813VjgkzcdJVj/4p3Q2RGXeu2ehNS1Q=;
 b=HN0AoCiyPKygCIQ1I7KzCH9sjczrGs3Z2VEzTS8xEI2rqm2rc0BcDmI7b5LEd/bfAoiQQFQG6
 v4Qi5xwyoSHAGW/dEEDTTh1ZbR/9zJIz/6NBPjEsswAtcvHkITiPqH3
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

Add the controls V4L2_CID_LENS_CALIB_CONTROL and V4L2_CID_LENS_CALIB_STATUS
that facilitate the control of the lens group calibration procedure.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 35 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  6 ++++
 include/uapi/linux/v4l2-controls.h                 | 12 ++++++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index 5e34515024bd..441467a971ac 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -297,6 +297,41 @@ enum v4l2_auto_focus_range -
     (V4L2_CID_ZOOM_ABSOLUTE and V4L2_CID_ZOOM_RELATIVE). The unit is
     driver-specific. The value should be a positive integer.
 
+``V4L2_CID_LENS_CALIB_CONTROL (bitmask)``
+    Control the calibration procedure (or individual parts thereof) of the lens
+    groups. For example, this could include the mechanical range detection
+    of zoom lens motors. This is a write-only control.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_CALIB_STOP``
+      - Stop the lens calibration procedure.
+    * - ``V4L2_LENS_CALIB_START``
+      - Start the complete lens calibration procedure.
+
+``V4L2_CID_LENS_CALIB_CONTROL (bitmask)``
+    The status of the calibration procedure (or individual parts thereof) of
+    the lens groups. This is a read-only control.
+
+.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_LENS_CALIB_IDLE``
+      - Lens calibration procedure has not yet been started.
+    * - ``V4L2_LENS_CALIB_BUSY``
+      - Lens calibration procedure is in progress.
+    * - ``V4L2_LENS_CALIB_COMPLETE``
+      - Lens calibration procedure is complete.
+    * - ``V4L2_LENS_CALIB_FAILED``
+      - Lens calibration procedure has failed.
+
 ``V4L2_CID_IRIS_ABSOLUTE (integer)``
     This control sets the camera's aperture to the specified value. The
     unit is undefined. Larger values open the iris wider, smaller values
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 2c21bcccc6ee..382abf6be9de 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1048,6 +1048,8 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
 	case V4L2_CID_FOCUS_SPEED:		return "Focus, Speed";
 	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
+	case V4L2_CID_LENS_CALIB_CONTROL:	return "Lens Calibration, Control";
+	case V4L2_CID_LENS_CALIB_STATUS:	return "Lens Calibration, Status";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1594,6 +1596,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_FOCUS_RELATIVE:
 	case V4L2_CID_IRIS_RELATIVE:
 	case V4L2_CID_ZOOM_RELATIVE:
+	case V4L2_CID_LENS_CALIB_CONTROL:
 		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
 			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
 		break;
@@ -1602,6 +1605,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*type = V4L2_CTRL_TYPE_LENS_STATUS;
 		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
 		break;
+	case V4L2_CID_LENS_CALIB_STATUS:
+		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
+		break;
 	case V4L2_CID_FLASH_STROBE_STATUS:
 	case V4L2_CID_AUTO_FOCUS_STATUS:
 	case V4L2_CID_FLASH_READY:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index fecce641d0d8..34601ad1213a 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1008,6 +1008,18 @@ struct v4l2_ctrl_lens_status {
 #define V4L2_CID_FOCUS_SPEED			(V4L2_CID_CAMERA_CLASS_BASE + 39)
 #define V4L2_CID_ZOOM_SPEED			(V4L2_CID_CAMERA_CLASS_BASE + 40)
 
+#define V4L2_LENS_CALIB_STOP			(0 << 0)
+#define V4L2_LENS_CALIB_START			(1 << 0)
+
+#define V4L2_CID_LENS_CALIB_CONTROL		(V4L2_CID_CAMERA_CLASS_BASE + 41)
+
+#define V4L2_LENS_CALIB_IDLE			(0 << 0)
+#define V4L2_LENS_CALIB_BUSY			(1 << 0)
+#define V4L2_LENS_STATUS_COMPLETE		(1 << 1)
+#define V4L2_LENS_STATUS_FAILED			(1 << 2)
+
+#define V4L2_CID_LENS_CALIB_STATUS		(V4L2_CID_CAMERA_CLASS_BASE + 42)
+
 /* FM Modulator class control IDs */
 
 #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)

-- 
2.30.2

