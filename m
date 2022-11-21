Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E2632F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiKUVuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiKUVtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:49:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60964DC305;
        Mon, 21 Nov 2022 13:49:41 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.138])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6BBE8118E;
        Mon, 21 Nov 2022 22:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669067380;
        bh=MMdt6u+9LTyvz2G7DEPCLV25iBtQNUqutduLtTt254Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6JvhpSoim+6P5R/Hvvit+fKNRO2ZDXuIophDrUxCectY5mJefbkUTpHu9AIZpVS4
         rh6igve6Z5f1gVQVlPTahBNhveBO3PrLkxFmvjQe9RQmhRWr4AKKyX2y0G4dalp3GH
         f+8IsK4dtWuCIE+CZFgVWhS2U8/Q3IVyvD29m1+A=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 07/14] media: uapi: v4l2-core: Add ISP statistics output V4L2 fourcc type
Date:   Tue, 22 Nov 2022 03:17:15 +0530
Message-Id: <20221121214722.22563-8-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121214722.22563-1-umang.jain@ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naushir Patuck <naush@raspberrypi.com>

Add V4L2_META_FMT_BCM2835_ISP_STATS V4L2 format type.

This new format will be used by the bcm2835-isp device to return
out ISP statistics for 3A.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../userspace-api/media/v4l/meta-formats.rst  |  1 +
 .../v4l/pixfmt-meta-bcm2835-isp-stats.rst     | 41 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index d1ac3f3a2d8f..0c52f3df1576 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -12,6 +12,7 @@ These formats are used for the :ref:`metadata` interface only.
 .. toctree::
     :maxdepth: 1
 
+    pixfmt-meta-bcm2835-isp-stats
     pixfmt-meta-d4xx
     pixfmt-meta-intel-ipu3
     pixfmt-meta-sensor-data
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst b/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst
new file mode 100644
index 000000000000..f974774c8252
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/pixfmt-meta-bcm2835-isp-stats.rst
@@ -0,0 +1,41 @@
+.. Permission is granted to copy, distribute and/or modify this
+.. document under the terms of the GNU Free Documentation License,
+.. Version 1.1 or any later version published by the Free Software
+.. Foundation, with no Invariant Sections, no Front-Cover Texts
+.. and no Back-Cover Texts. A copy of the license is included at
+.. Documentation/media/uapi/fdl-appendix.rst.
+..
+.. TODO: replace it to GFDL-1.1-or-later WITH no-invariant-sections
+
+.. _v4l2-meta-fmt-bcm2835-isp-stats:
+
+*****************************************
+V4L2_META_FMT_BCM2835_ISP_STATS  ('BSTA')
+*****************************************
+
+BCM2835 ISP Statistics
+
+Description
+===========
+
+The BCM2835 ISP hardware calculate image statistics for an input Bayer frame.
+These statistics are obtained from the "bcm2835-isp0-capture3" device node
+using the :c:type:`v4l2_meta_format` interface. They are formatted as described
+by the :c:type:`bcm2835_isp_stats` structure below.
+
+.. code-block:: c
+
+	#define DEFAULT_AWB_REGIONS_X 16
+	#define DEFAULT_AWB_REGIONS_Y 12
+
+	#define NUM_HISTOGRAMS 2
+	#define NUM_HISTOGRAM_BINS 128
+	#define AWB_REGIONS (DEFAULT_AWB_REGIONS_X * DEFAULT_AWB_REGIONS_Y)
+	#define FLOATING_REGIONS 16
+	#define AGC_REGIONS 16
+	#define FOCUS_REGIONS 12
+
+.. kernel-doc:: include/uapi/linux/bcm2835-isp.h
+   :functions: bcm2835_isp_stats_hist bcm2835_isp_stats_region
+	             bcm2835_isp_stats_focus bcm2835_isp_stats
+
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 2680bc33f911..361e47ad6480 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1449,6 +1449,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_10BE_8L128:	descr = "10-bit NV12M (8x128 Linear, BE)"; break;
 	case V4L2_META_FMT_SENSOR_DATA:	descr = "Sensor Ancillary Metadata"; break;
+	case V4L2_META_FMT_BCM2835_ISP_STATS: descr = "BCM2835 ISP Image Statistics"; break;
 
 	default:
 		/* Compressed formats */
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 026fbc7af034..9269b45b3b64 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -807,6 +807,7 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
 #define V4L2_META_FMT_VIVID	  v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Metadata */
 #define V4L2_META_FMT_SENSOR_DATA v4l2_fourcc('S', 'E', 'N', 'S') /* Sensor Ancillary metadata */
+#define V4L2_META_FMT_BCM2835_ISP_STATS v4l2_fourcc('B', 'S', 'T', 'A') /* BCM2835 ISP image statistics output */
 
 /* Vendor specific - used for RK_ISP1 camera sub-system */
 #define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 3A Parameters */
-- 
2.37.3

