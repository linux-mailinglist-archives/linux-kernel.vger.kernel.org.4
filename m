Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51CA73A1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjFVNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFVNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:14:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98831BF5;
        Thu, 22 Jun 2023 06:14:00 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7d72:676c:e745:a6ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DD366607128;
        Thu, 22 Jun 2023 14:13:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687439639;
        bh=Gzf/ktNZ3NOcffLCLpulGdLdygvof7OsvFbMBCI7WyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMvDuxSN0D+ICceIa2k0/8ICJfyucHrHRy6tMCtP/unZ6iPcQKKAEFLkWsTfyZZKa
         tYZvz+3gLPPQgWb5r2zlBEe0pFVZEHNFtzut4Y2T929FVyI6i1VRb5DpNhpRGOljp8
         8ChyFAD7r82W9PHtPu4lrMufSVdbn+TERA+ogPra54nVT1haZrF3K6Hd5NL7Po/6jX
         mCpx047zWZHtydN5YRQypOVaHxAxXx0tJgal/ffcKkpC6Q+o3m8R3dICGjJz6aqD98
         eM0fO8vwWuZcWWfz5EyZzI2f9vUdJ0vr03/nsSOcUe3jyH+deoHQMw9RBI+u1WworB
         /9QEx87W6XWaA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as global
Date:   Thu, 22 Jun 2023 15:13:42 +0200
Message-Id: <20230622131349.144160-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After changing bufs arrays to a dynamic allocated array
VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
Remove it from the core definitions but keep it for drivers internal
needs.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c               | 2 ++
 drivers/media/platform/amphion/vdec.c                         | 1 +
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
 drivers/media/platform/qcom/venus/hfi.h                       | 2 ++
 drivers/media/platform/verisilicon/hantro_hw.h                | 2 ++
 drivers/staging/media/ipu3/ipu3-v4l2.c                        | 2 ++
 include/media/videobuf2-core.h                                | 1 -
 include/media/videobuf2-v4l2.h                                | 4 ----
 8 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 86e1e926fa45..899783f67580 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -31,6 +31,8 @@
 
 #include <trace/events/vb2.h>
 
+#define VB2_MAX_FRAME	32
+
 static int debug;
 module_param(debug, int, 0644);
 
diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 3fa1a74a2e20..b3219f6d17fa 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -28,6 +28,7 @@
 
 #define VDEC_MIN_BUFFER_CAP		8
 #define VDEC_MIN_BUFFER_OUT		8
+#define VB2_MAX_FRAME			32
 
 struct vdec_fs_info {
 	char name[8];
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index 6532a69f1fa8..a1e0f24bb91c 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -16,6 +16,8 @@
 #include "../vdec_drv_if.h"
 #include "../vdec_vpu_if.h"
 
+#define VB2_MAX_FRAME	32
+
 /* reset_frame_context defined in VP9 spec */
 #define VP9_RESET_FRAME_CONTEXT_NONE0 0
 #define VP9_RESET_FRAME_CONTEXT_NONE1 1
diff --git a/drivers/media/platform/qcom/venus/hfi.h b/drivers/media/platform/qcom/venus/hfi.h
index f25d412d6553..bd5ca5a8b945 100644
--- a/drivers/media/platform/qcom/venus/hfi.h
+++ b/drivers/media/platform/qcom/venus/hfi.h
@@ -10,6 +10,8 @@
 
 #include "hfi_helper.h"
 
+#define VB2_MAX_FRAME				32
+
 #define VIDC_SESSION_TYPE_VPE			0
 #define VIDC_SESSION_TYPE_ENC			1
 #define VIDC_SESSION_TYPE_DEC			2
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index e83f0c523a30..9e8faf7ba6fb 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -15,6 +15,8 @@
 #include <media/v4l2-vp9.h>
 #include <media/videobuf2-core.h>
 
+#define VB2_MAX_FRAME	32
+
 #define DEC_8190_ALIGN_MASK	0x07U
 
 #define MB_DIM			16
diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index e530767e80a5..6627b5c2d4d6 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -10,6 +10,8 @@
 #include "ipu3.h"
 #include "ipu3-dmamap.h"
 
+#define VB2_MAX_FRAME	32
+
 /******************** v4l2_subdev_ops ********************/
 
 #define IPU3_RUNNING_MODE_VIDEO		0
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 77921cf894ef..080b783d608d 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -20,7 +20,6 @@
 #include <media/media-request.h>
 #include <media/frame_vector.h>
 
-#define VB2_MAX_FRAME	(32)
 #define VB2_MAX_PLANES	(8)
 
 /**
diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
index 5a845887850b..88a7a565170e 100644
--- a/include/media/videobuf2-v4l2.h
+++ b/include/media/videobuf2-v4l2.h
@@ -15,10 +15,6 @@
 #include <linux/videodev2.h>
 #include <media/videobuf2-core.h>
 
-#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
-#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
-#endif
-
 #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
 #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
 #endif
-- 
2.39.2

