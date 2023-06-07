Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8537C72587F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjFGItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbjFGItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:49:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79641712;
        Wed,  7 Jun 2023 01:49:09 -0700 (PDT)
X-UUID: 2859bfc8051011ee9cb5633481061a41-20230607
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=N/QtUDwIB9GpM63PU5VvYzv4uHhRC7pDbtBXgfjMiU8=;
        b=bf7aWbW41wK8qJTjT1yw5XJ99lE1f9D5G/Nbs+0GzWI7g47wBgBYOyI76kX9bEeByOSuGITpCjQkyoDnfNhCek5t+uxyxKVBQYxKzYYy3+XvMi70XdwYrPTAKbQdbPVb1YejttUyQcHwkYwX/FSj+iTkkpnNvuUi6urRqjJgdDA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:1d81a4f2-e2f9-4fe2-81b0-2aeae018030b,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:158fd93d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 2859bfc8051011ee9cb5633481061a41-20230607
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 914780105; Wed, 07 Jun 2023 16:49:04 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 16:49:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 16:49:02 +0800
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
Subject: [PATCH v2,0/10] media: mediatek: vcodec: separate encoder and decoder
Date:   Wed, 7 Jun 2023 16:48:51 +0800
Message-ID: <20230607084901.28021-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

With the driver more and more complex, encoder and decoder need to add more parameter
in shared struct 'mtk_vcodec_ctx' and 'mtk_vcodec_dev'. Encoder use about 40% and
decoder use 60% parameter. Need to allocate extra unused memory when encoder and decoder
working.

Separate encoder and decoder in different folder and use independent data struct.

patch 1 remove unused parameter.
patch 2~3 align fw and interrupt related interface.
patch 4~5 remove the dependency of debug log
patch 6~7 separate mtk_vcodec_ctx and mtk_vcodec_dev
patch 8 fix unreasonable parameter
patch 9 removed unused header files
patch 10 separate encoder and decoder in different folder
---
Changed from v1:
- Change pr_dbg to dev_dbg for mtk_v4l2_level and mtk_vcodec_dbg for patch 4.
- Change pr_err to dev_err for mtk_v4l2_err and mtk_vcodec_err for patch 5.
- Fix unreasonable parameter for patch 8.
---
Yunfei Dong (10):
  media: mediatek: vcodec: remove unused parameter
  media: mediatek: vcodec: align fw interface
  media: mediatek: vcodec: re-write shared interface
  media: mediatek: vcodec: remove the dependency of debug log
  mediatek: vcodec: replace pr_* with dev_* for v4l2 debug message
  mediatek: vcodec: separate struct mtk_vcodec_ctx
  mediatek: vcodec: separate struct mtk_vcodec_dev
  mediatek: vcodec: fix unreasonable parameter definition and style
  mediatek: vcodec: remove unused include header
  mediatek: vcodec: separete decoder and encoder

 .../media/platform/mediatek/vcodec/Makefile   |  55 +-
 .../platform/mediatek/vcodec/common/Makefile  |  21 +
 .../vcodec/common/mtk_vcodec_com_drv.h        | 147 +++++
 .../vcodec/{ => common}/mtk_vcodec_dbgfs.c    |  57 +-
 .../vcodec/{ => common}/mtk_vcodec_dbgfs.h    |  24 +-
 .../vcodec/{ => common}/mtk_vcodec_fw.c       |  21 +-
 .../vcodec/{ => common}/mtk_vcodec_fw.h       |   8 +-
 .../vcodec/{ => common}/mtk_vcodec_fw_priv.h  |  14 +-
 .../vcodec/{ => common}/mtk_vcodec_fw_scp.c   |  26 +-
 .../vcodec/{ => common}/mtk_vcodec_fw_vpu.c   |  64 +-
 .../mediatek/vcodec/common/mtk_vcodec_intr.c  |  68 +++
 .../vcodec/{ => common}/mtk_vcodec_intr.h     |   6 +-
 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 165 ++++++
 .../mediatek/vcodec/common/mtk_vcodec_util.h  |  77 +++
 .../platform/mediatek/vcodec/decoder/Makefile |  25 +
 .../vcodec/{ => decoder}/mtk_vcodec_dec.c     | 179 +++---
 .../vcodec/{ => decoder}/mtk_vcodec_dec.h     |  10 +-
 .../vcodec/{ => decoder}/mtk_vcodec_dec_drv.c |  85 ++-
 .../vcodec/decoder/mtk_vcodec_dec_drv.h       | 306 ++++++++++
 .../vcodec/{ => decoder}/mtk_vcodec_dec_hw.c  |  16 +-
 .../vcodec/{ => decoder}/mtk_vcodec_dec_hw.h  |   6 +-
 .../vcodec/{ => decoder}/mtk_vcodec_dec_pm.c  |  43 +-
 .../vcodec/{ => decoder}/mtk_vcodec_dec_pm.h  |   6 +-
 .../{ => decoder}/mtk_vcodec_dec_stateful.c   | 118 ++--
 .../{ => decoder}/mtk_vcodec_dec_stateless.c  |  77 +--
 .../{ => decoder}/vdec/vdec_av1_req_lat_if.c  | 152 +++--
 .../vcodec/{ => decoder}/vdec/vdec_h264_if.c  |  71 ++-
 .../{ => decoder}/vdec/vdec_h264_req_common.c |   4 +-
 .../{ => decoder}/vdec/vdec_h264_req_common.h |   6 +-
 .../{ => decoder}/vdec/vdec_h264_req_if.c     |  54 +-
 .../vdec/vdec_h264_req_multi_if.c             | 102 ++--
 .../vdec/vdec_hevc_req_multi_if.c             |  90 +--
 .../vcodec/{ => decoder}/vdec/vdec_vp8_if.c   |  82 +--
 .../{ => decoder}/vdec/vdec_vp8_req_if.c      |  59 +-
 .../vcodec/{ => decoder}/vdec/vdec_vp9_if.c   | 162 +++---
 .../{ => decoder}/vdec/vdec_vp9_req_lat_if.c  | 105 ++--
 .../vcodec/{ => decoder}/vdec_drv_base.h      |   2 +-
 .../vcodec/{ => decoder}/vdec_drv_if.c        |  13 +-
 .../vcodec/{ => decoder}/vdec_drv_if.h        |  10 +-
 .../vcodec/{ => decoder}/vdec_ipi_msg.h       |   0
 .../vcodec/{ => decoder}/vdec_msg_queue.c     |  49 +-
 .../vcodec/{ => decoder}/vdec_msg_queue.h     |  12 +-
 .../vcodec/{ => decoder}/vdec_vpu_if.c        |  66 ++-
 .../vcodec/{ => decoder}/vdec_vpu_if.h        |   6 +-
 .../platform/mediatek/vcodec/encoder/Makefile |  11 +
 .../vcodec/{ => encoder}/mtk_vcodec_enc.c     | 278 +++++----
 .../vcodec/{ => encoder}/mtk_vcodec_enc.h     |  12 +-
 .../vcodec/{ => encoder}/mtk_vcodec_enc_drv.c |  68 +--
 .../vcodec/encoder/mtk_vcodec_enc_drv.h       | 245 ++++++++
 .../vcodec/{ => encoder}/mtk_vcodec_enc_pm.c  |  17 +-
 .../vcodec/{ => encoder}/mtk_vcodec_enc_pm.h  |   4 +-
 .../vcodec/{ => encoder}/venc/venc_h264_if.c  | 106 ++--
 .../vcodec/{ => encoder}/venc/venc_vp8_if.c   |  64 +-
 .../vcodec/{ => encoder}/venc_drv_base.h      |   4 +-
 .../vcodec/{ => encoder}/venc_drv_if.c        |  10 +-
 .../vcodec/{ => encoder}/venc_drv_if.h        |  11 +-
 .../vcodec/{ => encoder}/venc_ipi_msg.h       |   0
 .../vcodec/{ => encoder}/venc_vpu_if.c        |  67 ++-
 .../vcodec/{ => encoder}/venc_vpu_if.h        |   3 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 548 ------------------
 .../mediatek/vcodec/mtk_vcodec_intr.c         |  43 --
 .../mediatek/vcodec/mtk_vcodec_util.c         | 143 -----
 .../mediatek/vcodec/mtk_vcodec_util.h         |  83 ---
 63 files changed, 2400 insertions(+), 1986 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/Makefile
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_com_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_dbgfs.c (76%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_dbgfs.h (62%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw.c (75%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw.h (86%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw_priv.h (75%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw_scp.c (70%)
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_fw_vpu.c (58%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_intr.c
 rename drivers/media/platform/mediatek/vcodec/{ => common}/mtk_vcodec_intr.h (68%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec.c (83%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec.h (91%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_drv.c (83%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_hw.c (92%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_hw.h (92%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_pm.c (78%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_pm.h (61%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_stateful.c (79%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/mtk_vcodec_dec_stateless.c (85%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_av1_req_lat_if.c (92%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_if.c (82%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_common.c (98%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_common.h (97%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_if.c (87%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_h264_req_multi_if.c (87%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_hevc_req_multi_if.c (91%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp8_if.c (83%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp8_req_if.c (83%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp9_if.c (82%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec/vdec_vp9_req_lat_if.c (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_drv_base.h (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_drv_if.c (85%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_drv_if.h (89%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_msg_queue.c (85%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_msg_queue.h (96%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_vpu_if.c (71%)
 rename drivers/media/platform/mediatek/vcodec/{ => decoder}/vdec_vpu_if.h (97%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/encoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc.c (82%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc.h (78%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc_drv.c (87%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc_pm.c (77%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/mtk_vcodec_enc_pm.h (78%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc/venc_h264_if.c (85%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc/venc_vp8_if.c (84%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_drv_base.h (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_drv_if.c (86%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_drv_if.h (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_vpu_if.c (77%)
 rename drivers/media/platform/mediatek/vcodec/{ => encoder}/venc_vpu_if.h (96%)
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h

-- 
2.18.0

