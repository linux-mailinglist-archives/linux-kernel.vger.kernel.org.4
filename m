Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C46672B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjALM5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjALM4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:56:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B75F46;
        Thu, 12 Jan 2023 04:56:33 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D0E86602DB9;
        Thu, 12 Jan 2023 12:56:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528192;
        bh=w39uQHzOIPIO90WhRE4IjTj/4vTR7fwhKBVkNmGEQWM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NBGxuiJVU2ZpQxkVaZeH5CCCS70AGYjTI2usSFgDYvqxG8S1aMWZyj8I5xBnf+XQa
         A9xd20BDkGD/y+dweWOYWDuG/iqx0M4ZSAXqhbiY4PCZp2ss/gdd6Cfi/J+h4/z0mV
         2v1arb4yPppKzNsKyLOPG3o05bVXUVQcqv1Nv8By09CsEXEW/82QCkhHyC9Qjii4UP
         9k1B/ZiCjsBeXmpBEtrf/CDIH6uVBePNk2JZ2P1sc1NheN7/vGI+tEkhYTAIWkht+T
         G1O14WBe3J1zzQFR6kwGybsbOWqEmRYVBqU4PCivCWju4bfEF1fAjb/HVCPDSdYg89
         bVDiRKaYnQPaw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:16 +0100
Subject: [PATCH v2 01/12] media: v4l2: Add NV15 pixel format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-1-fa1897efac14@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=6437;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=uy2g9GPcP+lRwPYfgkcuiU1U/soD1j3DQtWijfz/vHI=;
 b=/pxqbPJRJoRG0ZRyvRot/+yIY4H7+UpAZVlvL+UZ7AKc8JtwF17tqhJfcI1anbbRdRkx4HIuWV2Q
 xDA5Hg6pCybcCwPBMeJzHeOj63Bav5GFBGgjC+fTds/GMfujTawu
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

Add the NV15 pixel format used by the Rockchip Video Decoder for 10-bit buffers.

NV15 is a packed 10-bit 4:2:0 Y/CbCr format similar to P010 and P210 but has no
padding between components. Instead, luminance and chrominance samples are grouped
into 4s so that each group is packed into an integer number of bytes:

YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes

The '15' suffix refers to the optimum effective bits per pixel
which is achieved when the total number of luminance samples is a multiple
of 8 for NV15.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  | 75 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c              |  2 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
 include/uapi/linux/videodev2.h                     |  1 +
 4 files changed, 79 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index f1d5bb7b806d..7d8d228f8063 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -79,6 +79,13 @@ All components are stored with the same number of bits per component.
       - Cr, Cb
       - Yes
       - Linear
+    * - V4L2_PIX_FMT_NV15
+      - 'NV15'
+      - 15
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - Linear
     * - V4L2_PIX_FMT_NV12M
       - 'NM12'
       - 8
@@ -183,6 +190,7 @@ horizontally.
 
 .. _V4L2-PIX-FMT-NV12:
 .. _V4L2-PIX-FMT-NV21:
+.. _V4L2-PIX-FMT-NV15:
 .. _V4L2-PIX-FMT-NV12M:
 .. _V4L2-PIX-FMT-NV21M:
 .. _V4L2-PIX-FMT-P010:
@@ -586,6 +594,73 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
       - Cb\ :sub:`11`
       - Cr\ :sub:`11`
 
+.. _V4L2_PIX_FMT_NV15:
+
+NV15
+----
+
+Similar to P010, a semi-planar 10-bit Y/CbCr format, but all components are
+packed without any padding between each other. As a side-effect, each group of
+4 components are stored over 5 bytes (YYYY or UVUV = 4 * 10 bits = 40 bits = 5
+bytes).
+
+.. flat-table:: Sample 4x4 NV15 Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start + 8:
+      - Y'\ :sub:`04`
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+    * - start + 16:
+      - Y'\ :sub:`13`
+      - Y'\ :sub:`14`
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+    * - start + 24:
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+      - Y'\ :sub:`24`
+      - Y'\ :sub:`30`
+    * - start + 32:
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+      - Y'\ :sub:`34`
+
+    * - start + 0:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start + 8:
+      - Cb\ :sub:`02`
+      - Cr\ :sub:`02`
+      - Cb\ :sub:`03`
+      - Cr\ :sub:`03`
+    * - start + 16:
+      - Cb\ :sub:`04`
+      - Cr\ :sub:`04`
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+    * - start + 24:
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+      - Cb\ :sub:`12`
+      - Cr\ :sub:`12`
+    * - start + 32:
+      - Cb\ :sub:`13`
+      - Cr\ :sub:`13`
+      - Cb\ :sub:`14`
+      - Cr\ :sub:`14`
+
+.. raw:: latex
 
 Fully Planar YUV Formats
 ========================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 40f56e044640..be23e319fb3a 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -262,6 +262,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		/* YUV planar formats */
 		{ .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_NV21,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,
+		  .block_w = { 4, 2, 0, 0 }, .block_h = { 1, 1, 0, 0 } },
 		{ .format = V4L2_PIX_FMT_NV16,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 8e0a0ff62a70..1c80ad78ef00 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/UV 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/VU 4:2:0"; break;
+	case V4L2_PIX_FMT_NV15:		descr = "10-bit Y/UV 4:2:0 (Packed)"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/UV 4:2:2"; break;
 	case V4L2_PIX_FMT_NV61:		descr = "Y/VU 4:2:2"; break;
 	case V4L2_PIX_FMT_NV24:		descr = "Y/UV 4:4:4"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1befd181a4cc..e9731286dc77 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -621,6 +621,7 @@ struct v4l2_pix_format {
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
 #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/CrCb 4:2:0  */
+#define V4L2_PIX_FMT_NV15    v4l2_fourcc('N', 'V', '1', '5') /* 15  Y/CbCr 4:2:0 10-bit packed */
 #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/CbCr 4:2:2  */
 #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
 #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */

-- 
2.25.1
