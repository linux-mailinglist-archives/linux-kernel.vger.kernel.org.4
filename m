Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C476B79C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCMOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjCMN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D116F4BF;
        Mon, 13 Mar 2023 06:59:28 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7a7b:d0cc:67e9:4297])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A4FA66030DE;
        Mon, 13 Mar 2023 13:59:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678715967;
        bh=MTvegXhMpPXwPhoNdwtKrByhIzVdZZIQRvTrqjWmlRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chTWqyXASFpt6tnIK/8K9JTWlQI4YkXIJ6ZvZZ+ygtTEj5OvN1vIJDUQW4e0kv1Xv
         CQfqtkjrYr5fWDOOaQAHSwUZ5iB3yOEdGjr7sZAuXGkrhkf3dsFGfHNxcCmT5/lomU
         lHn5c4e7S/Poq6kx8qmp6tmwq+w9E1d3ZZcNuDQv99bPnW867GbL9QbsFHteS2OqOZ
         bsJCB/ylaxG02Ug/9LFyxpkwUBgjZqV4ERSlN/1JLJJpPyCuGCEpPF445ePH8Gg6uI
         B6DyrEcEQJ0PJZQJiTc4YpSdHnZOaMZ1d2G68CwklT8WMoW1BmgmHTp+msHyeJXE4k
         KcYAHeGlf6vmg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jerbel@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [RFC 4/4] media: videobuf2: Stop define VB2_MAX_FRAME as global
Date:   Mon, 13 Mar 2023 14:59:16 +0100
Message-Id: <20230313135916.862852-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
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

After changing bufs arrays to a list VB2_MAX_FRAME doesn't mean
anything for videobuf2 core.
Remove it from the core definitions but keep it for drivers internal
needs.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c               | 2 ++
 drivers/media/platform/amphion/vdec.c                         | 1 +
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
 drivers/media/platform/qcom/venus/hfi.h                       | 2 ++
 drivers/media/platform/verisilicon/hantro_hw.h                | 2 ++
 include/media/videobuf2-core.h                                | 1 -
 include/media/videobuf2-v4l2.h                                | 4 ----
 7 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 3554811ec06a..754570ab23b3 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -31,6 +31,8 @@
 
 #include <trace/events/vb2.h>
 
+#define VB2_MAX_FRAME	32
+
 static int debug;
 module_param(debug, int, 0644);
 
diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 87f9f8e90ab1..bef0c1b869be 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -28,6 +28,7 @@
 
 #define VDEC_MIN_BUFFER_CAP		8
 #define VDEC_MIN_BUFFER_OUT		8
+#define VB2_MAX_FRAME			32
 
 struct vdec_fs_info {
 	char name[8];
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index f5958b6d834a..ba208caf3043 100644
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
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 4fddc6ae9f20..92f5b5e16003 100644
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
2.34.1

