Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075F0725890
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbjFGIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbjFGItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:49:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D871994;
        Wed,  7 Jun 2023 01:49:19 -0700 (PDT)
X-UUID: 2db0b788051011ee9cb5633481061a41-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LxRYl1blqm4XIYa42dvrN0MGZxzxY8WUWnmpBP0cihg=;
        b=YbzvrRnNfXbpO23nSWMXSNiKJqQD6PbLbve9f1R9rJPLHVBoa9k7qweWod+VBkNzMZN22MP2q+V1cUh7LUJaXnPgl8gaXYz/zBGwlnEmoWKZzBGcKFqnssLfBg/C2ax+gsH1ohfOU4AEnBaqDbc5IE5GuIWC9S0bk8/D1cNxsjg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:a3ed38af-4e41-42d2-8e62-7d5b77b48ea7,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:6a90d93d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 2db0b788051011ee9cb5633481061a41-20230607
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 52689303; Wed, 07 Jun 2023 16:49:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 16:49:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 16:49:12 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Nathan Hebert <nhebert@chromium.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,10/10] mediatek: vcodec: separete decoder and encoder
Date:   Wed, 7 Jun 2023 16:49:01 +0800
Message-ID: <20230607084901.28021-11-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607084901.28021-1-yunfei.dong@mediatek.com>
References: <20230607084901.28021-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all decoder files to folder video-decoder.
Move all encoder files to folder video-encoder.
Move common files which shared for encoder and decoder to folder video-common.

Change include header files and Makefile to fix build error.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/platform/mediatek/vcodec/Makefile   | 55 +------------------
 .../platform/mediatek/vcodec/common/Makefile  | 21 +++++++
 .../vcodec/{ => common}/mtk_vcodec_com_drv.h  |  0
 .../vcodec/{ => common}/mtk_vcodec_dbgfs.c    |  4 +-
 .../vcodec/{ => common}/mtk_vcodec_dbgfs.h    |  0
 .../vcodec/{ => common}/mtk_vcodec_fw.c       |  4 +-
 .../vcodec/{ => common}/mtk_vcodec_fw.h       |  2 +-
 .../vcodec/{ => common}/mtk_vcodec_fw_priv.h  |  0
 .../vcodec/{ => common}/mtk_vcodec_fw_scp.c   |  4 +-
 .../vcodec/{ => common}/mtk_vcodec_fw_vpu.c   |  4 +-
 .../vcodec/{ => common}/mtk_vcodec_intr.c     |  4 +-
 .../vcodec/{ => common}/mtk_vcodec_intr.h     |  0
 .../vcodec/{ => common}/mtk_vcodec_util.c     |  6 +-
 .../vcodec/{ => common}/mtk_vcodec_util.h     |  0
 .../platform/mediatek/vcodec/decoder/Makefile | 25 +++++++++
 .../vcodec/{ => decoder}/mtk_vcodec_dec.c     |  0
 .../vcodec/{ => decoder}/mtk_vcodec_dec.h     |  0
 .../vcodec/{ => decoder}/mtk_vcodec_dec_drv.c |  2 +-
 .../vcodec/{ => decoder}/mtk_vcodec_dec_drv.h |  8 +--
 .../vcodec/{ => decoder}/mtk_vcodec_dec_hw.c  |  2 +-
 .../vcodec/{ => decoder}/mtk_vcodec_dec_hw.h  |  0
 .../vcodec/{ => decoder}/mtk_vcodec_dec_pm.c  |  0
 .../vcodec/{ => decoder}/mtk_vcodec_dec_pm.h  |  0
 .../{ => decoder}/mtk_vcodec_dec_stateful.c   |  0
 .../{ => decoder}/mtk_vcodec_dec_stateless.c  |  0
 .../{ => decoder}/vdec/vdec_av1_req_lat_if.c  |  2 +-
 .../vcodec/{ => decoder}/vdec/vdec_h264_if.c  |  2 +-
 .../{ => decoder}/vdec/vdec_h264_req_common.c |  0
 .../{ => decoder}/vdec/vdec_h264_req_common.h |  0
 .../{ => decoder}/vdec/vdec_h264_req_if.c     |  2 +-
 .../vdec/vdec_h264_req_multi_if.c             |  2 +-
 .../vdec/vdec_hevc_req_multi_if.c             |  2 +-
 .../vcodec/{ => decoder}/vdec/vdec_vp8_if.c   |  2 +-
 .../{ => decoder}/vdec/vdec_vp8_req_if.c      |  2 +-
 .../vcodec/{ => decoder}/vdec/vdec_vp9_if.c   |  2 +-
 .../{ => decoder}/vdec/vdec_vp9_req_lat_if.c  |  2 +-
 .../vcodec/{ => decoder}/vdec_drv_base.h      |  0
 .../vcodec/{ => decoder}/vdec_drv_if.c        |  0
 .../vcodec/{ => decoder}/vdec_drv_if.h        |  0
 .../vcodec/{ => decoder}/vdec_ipi_msg.h       |  0
 .../vcodec/{ => decoder}/vdec_msg_queue.c     |  0
 .../vcodec/{ => decoder}/vdec_msg_queue.h     |  0
 .../vcodec/{ => decoder}/vdec_vpu_if.c        |  0
 .../vcodec/{ => decoder}/vdec_vpu_if.h        |  0
 .../platform/mediatek/vcodec/encoder/Makefile | 11 ++++
 .../vcodec/{ => encoder}/mtk_vcodec_enc.c     |  0
 .../vcodec/{ => encoder}/mtk_vcodec_enc.h     |  0
 .../vcodec/{ => encoder}/mtk_vcodec_enc_drv.c |  2 +-
 .../vcodec/{ => encoder}/mtk_vcodec_enc_drv.h |  8 +--
 .../vcodec/{ => encoder}/mtk_vcodec_enc_pm.c  |  0
 .../vcodec/{ => encoder}/mtk_vcodec_enc_pm.h  |  0
 .../vcodec/{ => encoder}/venc/venc_h264_if.c  |  2 +-
 .../vcodec/{ => encoder}/venc/venc_vp8_if.c   |  2 +-
 .../vcodec/{ => encoder}/venc_drv_base.h      |  0
 .../vcodec/{ => encoder}/venc_drv_if.c        |  0
 .../vcodec/{ => encoder}/venc_drv_if.h        |  0
 .../vcodec/{ => encoder}/venc_ipi_msg.h       |  0
 .../vcodec/{ => encoder}/venc_vpu_if.c        |  0
 .../vcodec/{ => encoder}/venc_vpu_if.h        |  0
 59 files changed, 96 insertions(+), 88 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_com_drv.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_dbgfs.c (98%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_dbgfs.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw.c (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw.h (97%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw_priv.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw_scp.c (96%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw_vpu.c (97%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_intr.c (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_intr.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_util.c (97%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_util.h (100%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_drv.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_drv.h (98%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_hw.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_hw.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_pm.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_pm.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_stateful.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_stateless.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_av1_req_lat_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_common.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_common.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_multi_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_hevc_req_multi_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp8_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp8_req_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp9_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp9_req_lat_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_drv_base.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_drv_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_drv_if.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_msg_queue.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_msg_queue.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_vpu_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_vpu_if.h (100%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/encoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc_drv.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc_drv.h (97%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc_pm.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc_pm.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc/venc_h264_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc/venc_vp8_if.c (99%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_drv_base.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_drv_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_drv_if.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_vpu_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_vpu_if.h (100%)

diff --git a/drivers/media/platform/mediatek/vcodec/Makefile b/drivers/media/platform/mediatek/vcodec/Makefile
index 5f4c30fec85a..014abbfbd993 100644
--- a/drivers/media/platform/mediatek/vcodec/Makefile
+++ b/drivers/media/platform/mediatek/vcodec/Makefile
@@ -1,54 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
-				       mtk-vcodec-enc.o \
-				       mtk-vcodec-common.o \
-				       mtk-vcodec-dec-hw.o
-
-mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
-		vdec/vdec_vp8_if.o \
-		vdec/vdec_vp8_req_if.o \
-		vdec/vdec_vp9_if.o \
-		vdec/vdec_vp9_req_lat_if.o \
-		vdec/vdec_av1_req_lat_if.o \
-		vdec/vdec_h264_req_if.o \
-		vdec/vdec_h264_req_common.o \
-		vdec/vdec_h264_req_multi_if.o \
-		vdec/vdec_hevc_req_multi_if.o \
-		mtk_vcodec_dec_drv.o \
-		vdec_drv_if.o \
-		vdec_vpu_if.o \
-		vdec_msg_queue.o \
-		mtk_vcodec_dec.o \
-		mtk_vcodec_dec_stateful.o \
-		mtk_vcodec_dec_stateless.o \
-		mtk_vcodec_dec_pm.o \
-
-mtk-vcodec-dec-hw-y := mtk_vcodec_dec_hw.o
-
-mtk-vcodec-enc-y := venc/venc_vp8_if.o \
-		venc/venc_h264_if.o \
-		mtk_vcodec_enc.o \
-		mtk_vcodec_enc_drv.o \
-		mtk_vcodec_enc_pm.o \
-		venc_drv_if.o \
-		venc_vpu_if.o \
-
-
-mtk-vcodec-common-y := mtk_vcodec_intr.o \
-		mtk_vcodec_util.o \
-		mtk_vcodec_fw.o \
-
-ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU),)
-mtk-vcodec-common-y += mtk_vcodec_fw_vpu.o
-endif
-
-ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP),)
-mtk-vcodec-common-y += mtk_vcodec_fw_scp.o
-endif
-
-ifneq ($(CONFIG_DEBUG_FS),)
-obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dbgfs.o
-
-mtk-vcodec-dbgfs-y := mtk_vcodec_dbgfs.o
-endif
\ No newline at end of file
+obj-y += common/
+obj-y += encoder/
+obj-y += decoder/
diff --git a/drivers/media/platform/mediatek/vcodec/common/Makefile b/drivers/media/platform/mediatek/vcodec/common/Makefile
new file mode 100644
index 000000000000..d0479914dfb3
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/common/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-common.o
+
+mtk-vcodec-common-y := mtk_vcodec_intr.o \
+		mtk_vcodec_util.o \
+		mtk_vcodec_fw.o \
+
+ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_VPU),)
+mtk-vcodec-common-y += mtk_vcodec_fw_vpu.o
+endif
+
+ifneq ($(CONFIG_VIDEO_MEDIATEK_VCODEC_SCP),)
+mtk-vcodec-common-y += mtk_vcodec_fw_scp.o
+endif
+
+ifneq ($(CONFIG_DEBUG_FS),)
+obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dbgfs.o
+
+mtk-vcodec-dbgfs-y := mtk_vcodec_dbgfs.o
+endif
\ No newline at end of file
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_com_drv.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_com_drv.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
similarity index 98%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
index 7c25f6e23901..f458ad0bc17d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
@@ -7,8 +7,8 @@
 #include <linux/debugfs.h>
 
 #include "mtk_vcodec_dbgfs.h"
-#include "mtk_vcodec_dec_drv.h"
-#include "mtk_vcodec_enc_drv.h"
+#include "../decoder/mtk_vcodec_dec_drv.h"
+#include "../encoder/mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_util.h"
 
 static void mtk_vdec_dbgfs_get_format_type(struct mtk_vcodec_dec_ctx *ctx, char *buf,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.c
similarity index 95%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.c
index d87a05000002..06eb4cdc0ed5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "mtk_vcodec_dec_drv.h"
-#include "mtk_vcodec_enc_drv.h"
+#include "../decoder/mtk_vcodec_dec_drv.h"
+#include "../encoder/mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_fw_priv.h"
 
 struct mtk_vcodec_fw *mtk_vcodec_fw_select(void *priv, enum mtk_vcodec_fw_type type,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
similarity index 97%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
index 83479ab70385..300363a40158 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h
@@ -6,7 +6,7 @@
 #include <linux/remoteproc.h>
 #include <linux/remoteproc/mtk_scp.h>
 
-#include "../vpu/mtk_vpu.h"
+#include "../../vpu/mtk_vpu.h"
 
 struct mtk_vcodec_dec_dev;
 struct mtk_vcodec_enc_dev;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_priv.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_priv.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
similarity index 96%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
index 0de8d792f1a6..a608d1a66312 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "mtk_vcodec_dec_drv.h"
-#include "mtk_vcodec_enc_drv.h"
+#include "../decoder/mtk_vcodec_dec_drv.h"
+#include "../encoder/mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_fw_priv.h"
 
 static int mtk_vcodec_scp_load_firmware(struct mtk_vcodec_fw *fw)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
similarity index 97%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
index d26fe00004b9..6c3d562207fd 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "mtk_vcodec_dec_drv.h"
-#include "mtk_vcodec_enc_drv.h"
+#include "../decoder/mtk_vcodec_dec_drv.h"
+#include "../encoder/mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_fw_priv.h"
 
 static int mtk_vcodec_vpu_load_firmware(struct mtk_vcodec_fw *fw)
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.c
similarity index 95%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.c
index db6020beca39..71faf7ba26f1 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.c
@@ -7,8 +7,8 @@
 #include <linux/errno.h>
 #include <linux/wait.h>
 
-#include "mtk_vcodec_dec_drv.h"
-#include "mtk_vcodec_enc_drv.h"
+#include "../decoder/mtk_vcodec_dec_drv.h"
+#include "../encoder/mtk_vcodec_enc_drv.h"
 #include "mtk_vcodec_intr.h"
 
 int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int timeout_ms,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
similarity index 97%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index 62226b80673d..97d9de82935b 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -9,9 +9,9 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include "mtk_vcodec_dec_drv.h"
-#include "mtk_vcodec_enc_drv.h"
-#include "mtk_vcodec_dec_hw.h"
+#include "../decoder/mtk_vcodec_dec_drv.h"
+#include "../encoder/mtk_vcodec_enc_drv.h"
+#include "../decoder/mtk_vcodec_dec_hw.h"
 
 #if defined(CONFIG_DEBUG_FS)
 int mtk_vcodec_dbg;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
rename to drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/Makefile b/drivers/media/platform/mediatek/vcodec/decoder/Makefile
new file mode 100644
index 000000000000..904cd22def84
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/decoder/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
+				       mtk-vcodec-dec-hw.o
+
+mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
+		vdec/vdec_vp8_if.o \
+		vdec/vdec_vp8_req_if.o \
+		vdec/vdec_vp9_if.o \
+		vdec/vdec_vp9_req_lat_if.o \
+		vdec/vdec_av1_req_lat_if.o \
+		vdec/vdec_h264_req_if.o \
+		vdec/vdec_h264_req_common.o \
+		vdec/vdec_h264_req_multi_if.o \
+		vdec/vdec_hevc_req_multi_if.o \
+		mtk_vcodec_dec_drv.o \
+		vdec_drv_if.o \
+		vdec_vpu_if.o \
+		vdec_msg_queue.o \
+		mtk_vcodec_dec.o \
+		mtk_vcodec_dec_stateful.o \
+		mtk_vcodec_dec_stateless.o \
+		mtk_vcodec_dec_pm.o \
+
+mtk-vcodec-dec-hw-y := mtk_vcodec_dec_hw.o
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index d979018dcd20..14621e40376e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -20,7 +20,7 @@
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
-#include "mtk_vcodec_intr.h"
+#include "../common/mtk_vcodec_intr.h"
 
 static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dec_dev *dev)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
similarity index 98%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
index 1a0375dd5b6d..dce25edd13e9 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
@@ -7,10 +7,10 @@
 #ifndef _MTK_VCODEC_DEC_DRV_H_
 #define _MTK_VCODEC_DEC_DRV_H_
 
-#include "mtk_vcodec_com_drv.h"
-#include "mtk_vcodec_dbgfs.h"
-#include "mtk_vcodec_fw_priv.h"
-#include "mtk_vcodec_util.h"
+#include "../common/mtk_vcodec_com_drv.h"
+#include "../common/mtk_vcodec_dbgfs.h"
+#include "../common/mtk_vcodec_fw_priv.h"
+#include "../common/mtk_vcodec_util.h"
 #include "vdec_msg_queue.h"
 
 #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
index 8a10ad28b920..a45804697c02 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.c
@@ -15,7 +15,7 @@
 #include "mtk_vcodec_dec.h"
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_dec_pm.h"
-#include "mtk_vcodec_intr.h"
+#include "../common/mtk_vcodec_intr.h"
 
 static const struct of_device_id mtk_vdec_hw_match[] = {
 	{
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_hw.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_pm.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateful.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateful.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
rename to drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
index da1ada8a5727..cfed3877bdae 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_lat_if.c
@@ -9,7 +9,7 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
 #include "../vdec_drv_if.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
index 3ad7d41f53ba..5baa72ab1188 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_if.c
@@ -9,7 +9,7 @@
 
 #include "../vdec_drv_if.h"
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_vpu_if.h"
 #include "../vdec_drv_base.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_common.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
index 633dc1b4e8b6..a619ae759b77 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c
@@ -7,7 +7,7 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
 #include "../vdec_drv_if.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
index 16cc4e9b451f..420438fe53c0 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c
@@ -11,7 +11,7 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
 #include "../vdec_drv_if.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
index 3c58fbb6ade3..0085476eabbb 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req_multi_if.c
@@ -9,7 +9,7 @@
 #include <media/videobuf2-dma-contig.h>
 
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
 #include "../vdec_drv_if.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
index 54236a74fa13..b2e67992d3e7 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_if.c
@@ -8,7 +8,7 @@
 #include <linux/slab.h>
 #include "../vdec_drv_if.h"
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_vpu_if.h"
 #include "../vdec_drv_base.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
index 7449691d3b54..730bdb3da637 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
@@ -10,7 +10,7 @@
 #include <uapi/linux/v4l2-controls.h>
 
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
 #include "../vdec_drv_if.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
index 9d7337c61577..8a9dfebc7b35 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_if.c
@@ -12,7 +12,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
 #include "../vdec_vpu_if.h"
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
index 7a2c5ac7a196..3353e922ad1c 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
@@ -10,7 +10,7 @@
 #include <media/v4l2-vp9.h>
 
 #include "../mtk_vcodec_dec.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../vdec_drv_base.h"
 #include "../vdec_drv_if.h"
 #include "../vdec_vpu_if.h"
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_base.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_base.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_drv_if.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_ipi_msg.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_ipi_msg.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_ipi_msg.h
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_ipi_msg.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
rename to drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.h
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/Makefile b/drivers/media/platform/mediatek/vcodec/encoder/Makefile
new file mode 100644
index 000000000000..e621b5b7e5e6
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/encoder/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-enc.o
+
+mtk-vcodec-enc-y := venc/venc_vp8_if.o \
+		venc/venc_h264_if.o \
+		mtk_vcodec_enc.o \
+		mtk_vcodec_enc_drv.o \
+		mtk_vcodec_enc_pm.o \
+		venc_drv_if.o \
+		venc_vpu_if.o \
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
index 1f2b56f76931..3ab849654b5c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -18,7 +18,7 @@
 
 #include "mtk_vcodec_enc.h"
 #include "mtk_vcodec_enc_pm.h"
-#include "mtk_vcodec_intr.h"
+#include "../common/mtk_vcodec_intr.h"
 
 static const struct mtk_video_fmt mtk_video_formats_output[] = {
 	{
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
similarity index 97%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
index 4804d8531a4e..fecfd862025a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
@@ -7,10 +7,10 @@
 #ifndef _MTK_VCODEC_ENC_DRV_H_
 #define _MTK_VCODEC_ENC_DRV_H_
 
-#include "mtk_vcodec_com_drv.h"
-#include "mtk_vcodec_dbgfs.h"
-#include "mtk_vcodec_fw_priv.h"
-#include "mtk_vcodec_util.h"
+#include "../common/mtk_vcodec_com_drv.h"
+#include "../common/mtk_vcodec_dbgfs.h"
+#include "../common/mtk_vcodec_fw_priv.h"
+#include "../common/mtk_vcodec_util.h"
 
 #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
rename to drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
rename to drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
index 0d1a8c4dc27b..80ae5e883613 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_h264_if.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 
 #include "../mtk_vcodec_enc_drv.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
 #include "../mtk_vcodec_enc_pm.h"
 #include "../venc_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
similarity index 99%
rename from drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
rename to drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
index 0d5c6b0b23c8..651788256162 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc/venc_vp8_if.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 
 #include "../mtk_vcodec_enc_drv.h"
-#include "../mtk_vcodec_intr.h"
+#include "../../common/mtk_vcodec_intr.h"
 #include "../mtk_vcodec_enc.h"
 #include "../mtk_vcodec_enc_pm.h"
 #include "../venc_drv_base.h"
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_base.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_drv_base.h
rename to drivers/media/platform/mediatek/vcodec/encoder/venc_drv_base.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_drv_if.c
rename to drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_drv_if.h
rename to drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h b/drivers/media/platform/mediatek/vcodec/encoder/venc_ipi_msg.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h
rename to drivers/media/platform/mediatek/vcodec/encoder/venc_ipi_msg.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
rename to drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
rename to drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.h
-- 
2.18.0

