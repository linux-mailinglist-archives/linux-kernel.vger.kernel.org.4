Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26B7655141
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiLWORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLWORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:17:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE681EAF4;
        Fri, 23 Dec 2022 06:17:50 -0800 (PST)
Received: from whitebuilder.lan (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6EDC46602C63;
        Fri, 23 Dec 2022 14:17:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671805068;
        bh=kNVQbxn69+Njf/SzKoCvE7MwgqiKoIbf3XHvNZ9lSLw=;
        h=From:To:Cc:Subject:Date:From;
        b=GgOM9L6ePc7sRxS8r2hgqspVcNc7fqE/xxiM2ZsVezUO7bZ+rt/GX5VBc93zPYQni
         zXq/cWnKu+GZegtF2D/Ksve5af/HRznz4DlHGKlRtORLpvqIZR04dor4ly2sDOdbPW
         606hFFP9PcYLmOSMdzYP7I/QHRwQ5nB+z00UVQ5wzlsM7nMsT73kJYGu+fo27RnJBt
         8l1apl4MASqPQ8ibMzqNJFoQfSYhd0Jvlu1Wt7vKCjN3UPXFkc2fQu8wpCJrbMDjUI
         mKGYn89Oiyyy7TNAE3roKUJwFHjaXmr1EV2lfCABfQECDtfb6zy5pfcoDt8LyqVMoJ
         dD6slQj+YND/Q==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Robert Mader <robert.mader@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hantro: Fix JPEG encoder ENUM_FRAMESIZE on RK3399
Date:   Fri, 23 Dec 2022 09:16:44 -0500
Message-Id: <20221223141644.703088-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The frmsize structure was left initialize to 0, as side effect, the driver was
reporting an invalid frmsize.

  Size: Stepwise 0x0 - 0x0 with step 0/0

Fix this by replicating the constraints in the raw formats too. This fixes
taking picture in Gnome Cheese Software, or any software using GSteamer
encodebin feature.

Fixes: 775fec69008d30 ("media: add Rockchip VPU JPEG encoder driver")
Reported-by: Robert Mader <robert.mader@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../platform/verisilicon/rockchip_vpu_hw.c    | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 8de6fd2e8eefa..7e65b5c3aa03c 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -21,40 +21,46 @@
  * Supported formats.
  */
 
+#define ROCKCHIP_VPU_JPEG_ENC_FRMSIZE {\
+                        .min_width = 96, \
+                        .max_width = 8192,\
+                        .step_width = MB_DIM, \
+                        .min_height = 32, \
+                        .max_height = 8192,\
+                        .step_height = MB_DIM, \
+		     }
+
 static const struct hantro_fmt rockchip_vpu_enc_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_YUV420M,
 		.codec_mode = HANTRO_MODE_NONE,
 		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420P,
+		.frmsize = ROCKCHIP_VPU_JPEG_ENC_FRMSIZE,
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_NV12M,
 		.codec_mode = HANTRO_MODE_NONE,
 		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420SP,
+		.frmsize = ROCKCHIP_VPU_JPEG_ENC_FRMSIZE,
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_YUYV,
 		.codec_mode = HANTRO_MODE_NONE,
 		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUYV422,
+		.frmsize = ROCKCHIP_VPU_JPEG_ENC_FRMSIZE,
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_UYVY,
 		.codec_mode = HANTRO_MODE_NONE,
 		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_UYVY422,
+		.frmsize = ROCKCHIP_VPU_JPEG_ENC_FRMSIZE,
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_JPEG,
 		.codec_mode = HANTRO_MODE_JPEG_ENC,
 		.max_depth = 2,
 		.header_size = JPEG_HEADER_SIZE,
-		.frmsize = {
-			.min_width = 96,
-			.max_width = 8192,
-			.step_width = MB_DIM,
-			.min_height = 32,
-			.max_height = 8192,
-			.step_height = MB_DIM,
-		},
+		.frmsize = ROCKCHIP_VPU_JPEG_ENC_FRMSIZE,
 	},
 };
 
-- 
2.38.1

