Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05E16D9A87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbjDFOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbjDFOgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782BD312;
        Thu,  6 Apr 2023 07:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A01E6648AD;
        Thu,  6 Apr 2023 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14A44C433A8;
        Thu,  6 Apr 2023 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680791501;
        bh=OFDAa/Z7jZMiGFG/RXHbhCEC4UgrQTo/IbOjvbHsdzY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=YjYf99mrj6YRqlF7UJGD8te9X3oG8AaXjxWpuEaX6fpnFXWYR7eIcc3Dj/UD95C6Y
         mNV01G2F9z1L5BDNfM5oqyrM/zXSjdpzr8za845ykEUl3u3eG8a1L7FIS9YAtUTKcs
         71tLZcSbVxm2jfPs3fXlaKQF/nkBuxWbjyERAhYYu6JAI/xlkp1bZDoOiKjc4thg7l
         sBkbx/mUhO0C0PIAulkRDrKX/9aYyU30c8WV8EUi7xE/8wZiJxuDxnT6CemV8ifISs
         hwVBcOcB/n1g0arorwZ1rDWjL1eADVBMAlh6ZbQsWe6ldKejG7RbC+J3TW0onrsHwO
         WxRCzb8R9oPRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id EC680C77B74;
        Thu,  6 Apr 2023 14:31:40 +0000 (UTC)
From:   Michael Riesch via B4 Relay 
        <devnull+michael.riesch.wolfvision.net@kernel.org>
Date:   Thu, 06 Apr 2023 16:31:13 +0200
Subject: [PATCH RFC 4/4] media: v4l2-ctrls: add controls for individual
 zoom lenses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-feature-controls-lens-v1-4-543189a680de@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680791498; l=4975;
 i=michael.riesch@wolfvision.net; s=20230406; h=from:subject:message-id;
 bh=bWxc8Ua5gbQYUJyRGSLgrVBk7cmDY97sq4ZtW5eVx8o=;
 b=FRhHgOOPeeWYPHlfi10xNaxB9EQWRcKsY/3IdhIFJJQnh6VhfwiI2bRP4HI/PTIV4h0MrUMc1
 +qwu9p8YNc9BKVePQhZXrNxF1IQWgFlFqjRPSmyvOQ8UmuHnnQTeJmn
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=G03kuYHL670EcdsWaNfVA7KnHWmkSpj98XziQm/hjbk=
X-Endpoint-Received: by B4 Relay for michael.riesch@wolfvision.net/20230406 with auth_id=38
X-Original-From: Michael Riesch <michael.riesch@wolfvision.net>
Reply-To: <michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Riesch <michael.riesch@wolfvision.net>

A zoom lens group may consist of several lenses, and in a calibration
context it may be necessary to position the lenses individually. Add a pair
of V4L2_CID_LENS_CALIB_ZOOMx_ABSOLUTE and V4L2_CID_LENS_CALIB_ZOOMx_STATUS
controls for each individual lens, where x = {1...5}.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../userspace-api/media/v4l/ext-ctrls-camera.rst          | 12 ++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 15 +++++++++++++++
 include/uapi/linux/v4l2-controls.h                        | 12 ++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index 441467a971ac..920c7be2823d 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -332,6 +332,18 @@ enum v4l2_auto_focus_range -
     * - ``V4L2_LENS_CALIB_FAILED``
       - Lens calibration procedure has failed.
 
+``V4L2_CID_LENS_CALIB_ZOOM{1...5}_ABSOLUTE`` (integer)
+    Set the absolute position of the individual lens of the zoom lens group.
+    Most likely, this is done in a calibration context. The unit is
+    driver-specific.
+
+``V4L2_CID_LENS_CALIB_ZOOM{1...5}_STATUS`` (struct)
+    The current status of the individual lens of the zoom lens group. Most
+    likely, this is done in a calibration context. This is a read-only control.
+    The returned data structure contains the current position and movement
+    indication flags. The unit of the current position is driver-specific. For
+    the description of the flags refer to V4L2_CID_ZOOM_ABSOLUTE.
+
 ``V4L2_CID_IRIS_ABSOLUTE (integer)``
     This control sets the camera's aperture to the specified value. The
     unit is undefined. Larger values open the iris wider, smaller values
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 382abf6be9de..7d1154d05102 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1050,6 +1050,16 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
 	case V4L2_CID_LENS_CALIB_CONTROL:	return "Lens Calibration, Control";
 	case V4L2_CID_LENS_CALIB_STATUS:	return "Lens Calibration, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE:	return "Zoom1, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE:	return "Zoom2, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE:	return "Zoom3, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE:	return "Zoom4, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE:	return "Zoom5, Absolute";
+	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:	return "Zoom1, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:	return "Zoom2, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:	return "Zoom3, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:	return "Zoom4, Status";
+	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:	return "Zoom5, Status";
 
 	/* FM Radio Modulator controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1602,6 +1612,11 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		break;
 	case V4L2_CID_FOCUS_STATUS:
 	case V4L2_CID_ZOOM_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:
+	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:
 		*type = V4L2_CTRL_TYPE_LENS_STATUS;
 		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
 		break;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 34601ad1213a..232e6d1d7655 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1020,6 +1020,18 @@ struct v4l2_ctrl_lens_status {
 
 #define V4L2_CID_LENS_CALIB_STATUS		(V4L2_CID_CAMERA_CLASS_BASE + 42)
 
+#define V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE + 43)
+#define V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE + 44)
+#define V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE + 45)
+#define V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE + 46)
+#define V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE + 47)
+
+#define V4L2_CID_LENS_CALIB_ZOOM1_STATUS	(V4L2_CID_CAMERA_CLASS_BASE + 48)
+#define V4L2_CID_LENS_CALIB_ZOOM2_STATUS	(V4L2_CID_CAMERA_CLASS_BASE + 49)
+#define V4L2_CID_LENS_CALIB_ZOOM3_STATUS	(V4L2_CID_CAMERA_CLASS_BASE + 50)
+#define V4L2_CID_LENS_CALIB_ZOOM4_STATUS	(V4L2_CID_CAMERA_CLASS_BASE + 51)
+#define V4L2_CID_LENS_CALIB_ZOOM5_STATUS	(V4L2_CID_CAMERA_CLASS_BASE + 52)
+
 /* FM Modulator class control IDs */
 
 #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)

-- 
2.30.2

