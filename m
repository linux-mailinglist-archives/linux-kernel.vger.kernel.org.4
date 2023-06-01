Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A87190E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjFADE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFADDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:03:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D3E7F;
        Wed, 31 May 2023 20:03:15 -0700 (PDT)
X-UUID: d5e72f82002811ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kfzsVwq4kwdIaN2A+3CpUgKdzPymer9PLdgPbfm9u2c=;
        b=ipswqk/2ub/Yh7NzGw1A5jdN9S4tM2yowAayh375jN41kMxDoSgC2Ede7Yb6lnYDAOBYFrPCx023BzYdsbpyzw4a2a7S/OPDGDtuPSt4QfEvDYkZ1uzx6snYHoVSgAqojOAWVaNQMOArvXgA2sV3cdvd8R0FSrUDNE9UxIvXIMs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:c9d30a1f-162d-4e0a-9721-d4c300bb70f2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.25,REQID:c9d30a1f-162d-4e0a-9721-d4c300bb70f2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:d5b0ae3,CLOUDID:8cae023d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230601110311B41RDIPO,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: d5e72f82002811ee9cb5633481061a41-20230601
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 857799592; Thu, 01 Jun 2023 11:03:08 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 11:03:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 11:03:06 +0800
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
Subject: [PATCH 8/8] mediatek: vcodec: separate decoder and encoder
Date:   Thu, 1 Jun 2023 11:02:56 +0800
Message-ID: <20230601030256.29875-9-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601030256.29875-1-yunfei.dong@mediatek.com>
References: <20230601030256.29875-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
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
 .../mediatek/vcodec/video-common/Makefile     | 21 +++++++
 .../{ => video-common}/mtk_vcodec_com_drv.h   |  0
 .../{ => video-common}/mtk_vcodec_dbgfs.c     |  0
 .../{ => video-common}/mtk_vcodec_dbgfs.h     |  0
 .../vcodec/{ => video-common}/mtk_vcodec_fw.c |  0
 .../vcodec/{ => video-common}/mtk_vcodec_fw.h |  0
 .../{ => video-common}/mtk_vcodec_fw_priv.h   |  0
 .../{ => video-common}/mtk_vcodec_fw_scp.c    |  0
 .../{ => video-common}/mtk_vcodec_fw_vpu.c    |  0
 .../{ => video-common}/mtk_vcodec_intr.c      |  0
 .../{ => video-common}/mtk_vcodec_intr.h      |  0
 .../{ => video-common}/mtk_vcodec_util.c      |  0
 .../{ => video-common}/mtk_vcodec_util.h      |  0
 .../mediatek/vcodec/video-decoder/Makefile    | 25 +++++++++
 .../{ => video-decoder}/mtk_vcodec_dec.c      |  0
 .../{ => video-decoder}/mtk_vcodec_dec.h      |  0
 .../{ => video-decoder}/mtk_vcodec_dec_drv.c  |  0
 .../{ => video-decoder}/mtk_vcodec_dec_drv.h  |  0
 .../{ => video-decoder}/mtk_vcodec_dec_hw.c   |  0
 .../{ => video-decoder}/mtk_vcodec_dec_hw.h   |  0
 .../{ => video-decoder}/mtk_vcodec_dec_pm.c   |  0
 .../{ => video-decoder}/mtk_vcodec_dec_pm.h   |  0
 .../mtk_vcodec_dec_stateful.c                 |  0
 .../mtk_vcodec_dec_stateless.c                |  0
 .../vdec/vdec_av1_req_lat_if.c                |  0
 .../{ => video-decoder}/vdec/vdec_h264_if.c   |  0
 .../vdec/vdec_h264_req_common.c               |  0
 .../vdec/vdec_h264_req_common.h               |  0
 .../vdec/vdec_h264_req_if.c                   |  0
 .../vdec/vdec_h264_req_multi_if.c             |  0
 .../vdec/vdec_hevc_req_multi_if.c             |  0
 .../{ => video-decoder}/vdec/vdec_vp8_if.c    |  0
 .../vdec/vdec_vp8_req_if.c                    |  0
 .../{ => video-decoder}/vdec/vdec_vp9_if.c    |  0
 .../vdec/vdec_vp9_req_lat_if.c                |  0
 .../{ => video-decoder}/vdec_drv_base.h       |  0
 .../vcodec/{ => video-decoder}/vdec_drv_if.c  |  0
 .../vcodec/{ => video-decoder}/vdec_drv_if.h  |  0
 .../vcodec/{ => video-decoder}/vdec_ipi_msg.h |  0
 .../{ => video-decoder}/vdec_msg_queue.c      |  0
 .../{ => video-decoder}/vdec_msg_queue.h      |  0
 .../vcodec/{ => video-decoder}/vdec_vpu_if.c  |  0
 .../vcodec/{ => video-decoder}/vdec_vpu_if.h  |  0
 .../mediatek/vcodec/video-encoder/Makefile    | 11 ++++
 .../{ => video-encoder}/mtk_vcodec_enc.c      |  0
 .../{ => video-encoder}/mtk_vcodec_enc.h      |  0
 .../{ => video-encoder}/mtk_vcodec_enc_drv.c  |  0
 .../{ => video-encoder}/mtk_vcodec_enc_drv.h  |  0
 .../{ => video-encoder}/mtk_vcodec_enc_pm.c   |  0
 .../{ => video-encoder}/mtk_vcodec_enc_pm.h   |  0
 .../{ => video-encoder}/venc/venc_h264_if.c   |  0
 .../{ => video-encoder}/venc/venc_vp8_if.c    |  0
 .../{ => video-encoder}/venc_drv_base.h       |  0
 .../vcodec/{ => video-encoder}/venc_drv_if.c  |  0
 .../vcodec/{ => video-encoder}/venc_drv_if.h  |  0
 .../vcodec/{ => video-encoder}/venc_ipi_msg.h |  0
 .../vcodec/{ => video-encoder}/venc_vpu_if.c  |  0
 .../vcodec/{ => video-encoder}/venc_vpu_if.h  |  0
 59 files changed, 60 insertions(+), 52 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-common/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_com_drv.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_dbgfs.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_dbgfs.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw_priv.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw_scp.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw_vpu.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_intr.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_intr.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_util.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_util.h (100%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-decoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_drv.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_drv.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_hw.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_hw.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_pm.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_pm.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_stateful.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_stateless.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_av1_req_lat_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_common.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_common.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_multi_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_hevc_req_multi_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp8_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp8_req_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp9_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp9_req_lat_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_drv_base.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_drv_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_drv_if.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_msg_queue.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_msg_queue.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_vpu_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_vpu_if.h (100%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-encoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc_drv.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc_drv.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc_pm.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc_pm.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc/venc_h264_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc/venc_vp8_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_drv_base.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_drv_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_drv_if.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_vpu_if.c (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_vpu_if.h (100%)

diff --git a/drivers/media/platform/mediatek/vcodec/Makefile b/drivers/media/platform/mediatek/vcodec/Makefile
index 5f4c30fec85a..c4f032764123 100644
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
+obj-y += video-common/
+obj-y += video-encoder/
+obj-y += video-decoder/
diff --git a/drivers/media/platform/mediatek/vcodec/video-common/Makefile b/drivers/media/platform/mediatek/vcodec/video-common/Makefile
new file mode 100644
index 000000000000..d0479914dfb3
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/video-common/Makefile
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
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_com_drv.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_com_drv.h
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_com_drv.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_dbgfs.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_dbgfs.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_dbgfs.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_dbgfs.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.c
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw.h
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw_priv.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_priv.h
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw_priv.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw_scp.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_scp.c
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw_scp.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw_vpu.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_fw_vpu.c
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_fw_vpu.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_intr.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_intr.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_intr.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_intr.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_util.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_util.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_util.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
rename to drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_util.h
diff --git a/drivers/media/platform/mediatek/vcodec/video-decoder/Makefile b/drivers/media/platform/mediatek/vcodec/video-decoder/Makefile
new file mode 100644
index 000000000000..904cd22def84
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/video-decoder/Makefile
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
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_drv.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_drv.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_drv.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_drv.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_hw.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_hw.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_hw.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_hw.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_pm.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_pm.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_pm.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_pm.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_stateful.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_stateful.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_stateless.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/mtk_vcodec_dec_stateless.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_av1_req_lat_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_av1_req_lat_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_common.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_common.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_common.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_common.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_multi_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_h264_req_multi_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_hevc_req_multi_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_hevc_req_multi_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp8_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp8_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp8_req_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp8_req_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp9_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp9_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp9_req_lat_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec/vdec_vp9_req_lat_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_base.h b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_drv_base.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_drv_base.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_drv_base.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_drv_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_drv_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_drv_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_drv_if.h b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_drv_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_drv_if.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_drv_if.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_ipi_msg.h b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_ipi_msg.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_ipi_msg.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_ipi_msg.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_msg_queue.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_msg_queue.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_msg_queue.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_msg_queue.h
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_vpu_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_vpu_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h b/drivers/media/platform/mediatek/vcodec/video-decoder/vdec_vpu_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/vdec_vpu_if.h
rename to drivers/media/platform/mediatek/vcodec/video-decoder/vdec_vpu_if.h
diff --git a/drivers/media/platform/mediatek/vcodec/video-encoder/Makefile b/drivers/media/platform/mediatek/vcodec/video-encoder/Makefile
new file mode 100644
index 000000000000..e621b5b7e5e6
--- /dev/null
+++ b/drivers/media/platform/mediatek/vcodec/video-encoder/Makefile
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
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
rename to drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
rename to drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_drv.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
rename to drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_drv.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h b/drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_drv.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.h
rename to drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_drv.h
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_pm.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
rename to drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_pm.c
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_pm.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.h
rename to drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_pm.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/video-encoder/venc/venc_h264_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc/venc_h264_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mediatek/vcodec/video-encoder/venc/venc_vp8_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc/venc_vp8_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_base.h b/drivers/media/platform/mediatek/vcodec/video-encoder/venc_drv_base.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_drv_base.h
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc_drv_base.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/video-encoder/venc_drv_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_drv_if.c
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc_drv_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/video-encoder/venc_drv_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_drv_if.h
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc_drv_if.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h b/drivers/media/platform/mediatek/vcodec/video-encoder/venc_ipi_msg.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc_ipi_msg.h
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/video-encoder/venc_vpu_if.c
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc_vpu_if.c
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.h b/drivers/media/platform/mediatek/vcodec/video-encoder/venc_vpu_if.h
similarity index 100%
rename from drivers/media/platform/mediatek/vcodec/venc_vpu_if.h
rename to drivers/media/platform/mediatek/vcodec/video-encoder/venc_vpu_if.h
-- 
2.25.1

