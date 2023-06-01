Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1D7190D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjFADDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFADDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:03:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504A1B3;
        Wed, 31 May 2023 20:03:06 -0700 (PDT)
X-UUID: d1108076002811ee9cb5633481061a41-20230601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CYLsdOowmiKrG5+stxCtlfifwV95BW1Eoq5bLlyFJ4I=;
        b=fGac+bOV99SfTEkCzETooByav4McVA/nf3mXGUZ6PJCrmscMqMRoiCW1cMO+PkKnzxY1VKg57TzDE+USxso/9AJsjReO8g1IGeA4TyzVq96D8bY4T49nEIkvrgT9KjbOC+Z7QUpPZCAFpBiKHpUwge2l+yNgCv4Z0O5zU4bRi9Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:9c9f4e11-bdd1-4f97-b63b-e464682dd562,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:b772333d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: d1108076002811ee9cb5633481061a41-20230601
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 670926227; Thu, 01 Jun 2023 11:03:00 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 11:02:58 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 11:02:57 +0800
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
Subject: [PATCH 0/8] media: mediatek: vcodec: separate encoder and decoder
Date:   Thu, 1 Jun 2023 11:02:48 +0800
Message-ID: <20230601030256.29875-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
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
patch 4 remove the dependency of debug log
patch 5~6 separate mtk_vcodec_ctx and mtk_vcodec_dev
patch 7 removed unused header files
patch 8 separate encoder and decoder in different folder
---
Yunfei Dong (8):
  media: mediatek: vcodec: remove unused parameter
  mediatek: vcodec: align fw interface
  mediatek: vcodec: re-write shared interface
  mediatek: vcodec: remove the dependency of debug log
  mediatek: vcodec: separate struct mtk_vcodec_ctx
  mediatek: vcodec: separate struct mtk_vcodec_dev
  mediatek: vcodec: remove unused include header
  mediatek: vcodec: separate decoder and encoder

 .../media/platform/mediatek/vcodec/Makefile   |  55 +--
 .../mediatek/vcodec/mtk_vcodec_intr.c         |  43 --
 .../mediatek/vcodec/mtk_vcodec_util.h         |  83 ----
 .../mediatek/vcodec/video-common/Makefile     |  21 +
 .../vcodec/video-common/mtk_vcodec_com_drv.h  | 147 ++++++
 .../{ => video-common}/mtk_vcodec_dbgfs.c     |  57 ++-
 .../{ => video-common}/mtk_vcodec_dbgfs.h     |  22 +-
 .../vcodec/{ => video-common}/mtk_vcodec_fw.c |  12 +-
 .../vcodec/{ => video-common}/mtk_vcodec_fw.h |   6 +-
 .../{ => video-common}/mtk_vcodec_fw_priv.h   |  14 +-
 .../{ => video-common}/mtk_vcodec_fw_scp.c    |  16 +-
 .../{ => video-common}/mtk_vcodec_fw_vpu.c    |  43 +-
 .../vcodec/video-common/mtk_vcodec_intr.c     |  65 +++
 .../{ => video-common}/mtk_vcodec_intr.h      |   6 +-
 .../{ => video-common}/mtk_vcodec_util.c      |  77 ++--
 .../vcodec/video-common/mtk_vcodec_util.h     |  76 ++++
 .../mediatek/vcodec/video-decoder/Makefile    |  25 ++
 .../{ => video-decoder}/mtk_vcodec_dec.c      |  66 ++-
 .../{ => video-decoder}/mtk_vcodec_dec.h      |  10 +-
 .../{ => video-decoder}/mtk_vcodec_dec_drv.c  |  31 +-
 .../mtk_vcodec_dec_drv.h}                     | 424 ++++--------------
 .../{ => video-decoder}/mtk_vcodec_dec_hw.c   |  10 +-
 .../{ => video-decoder}/mtk_vcodec_dec_hw.h   |   6 +-
 .../{ => video-decoder}/mtk_vcodec_dec_pm.c   |  19 +-
 .../{ => video-decoder}/mtk_vcodec_dec_pm.h   |   6 +-
 .../mtk_vcodec_dec_stateful.c                 |  33 +-
 .../mtk_vcodec_dec_stateless.c                |  29 +-
 .../vdec/vdec_av1_req_lat_if.c                | 101 ++---
 .../{ => video-decoder}/vdec/vdec_h264_if.c   |  53 ++-
 .../vdec/vdec_h264_req_common.c               |   4 +-
 .../vdec/vdec_h264_req_common.h               |   6 +-
 .../vdec/vdec_h264_req_if.c                   |  41 +-
 .../vdec/vdec_h264_req_multi_if.c             |  75 ++--
 .../vdec/vdec_hevc_req_multi_if.c             |  71 +--
 .../{ => video-decoder}/vdec/vdec_vp8_if.c    |  57 ++-
 .../vdec/vdec_vp8_req_if.c                    |  47 +-
 .../{ => video-decoder}/vdec/vdec_vp9_if.c    | 136 +++---
 .../vdec/vdec_vp9_req_lat_if.c                |  86 ++--
 .../{ => video-decoder}/vdec_drv_base.h       |   2 +-
 .../vcodec/{ => video-decoder}/vdec_drv_if.c  |   8 +-
 .../vcodec/{ => video-decoder}/vdec_drv_if.h  |  10 +-
 .../vcodec/{ => video-decoder}/vdec_ipi_msg.h |   0
 .../{ => video-decoder}/vdec_msg_queue.c      |  12 +-
 .../{ => video-decoder}/vdec_msg_queue.h      |  12 +-
 .../vcodec/{ => video-decoder}/vdec_vpu_if.c  |  52 ++-
 .../vcodec/{ => video-decoder}/vdec_vpu_if.h  |   6 +-
 .../mediatek/vcodec/video-encoder/Makefile    |  11 +
 .../{ => video-encoder}/mtk_vcodec_enc.c      |  85 ++--
 .../{ => video-encoder}/mtk_vcodec_enc.h      |  12 +-
 .../{ => video-encoder}/mtk_vcodec_enc_drv.c  |  25 +-
 .../vcodec/video-encoder/mtk_vcodec_enc_drv.h | 245 ++++++++++
 .../{ => video-encoder}/mtk_vcodec_enc_pm.c   |   4 +-
 .../{ => video-encoder}/mtk_vcodec_enc_pm.h   |   4 +-
 .../{ => video-encoder}/venc/venc_h264_if.c   |  91 ++--
 .../{ => video-encoder}/venc/venc_vp8_if.c    |  57 ++-
 .../{ => video-encoder}/venc_drv_base.h       |   4 +-
 .../vcodec/{ => video-encoder}/venc_drv_if.c  |  10 +-
 .../vcodec/{ => video-encoder}/venc_drv_if.h  |  11 +-
 .../vcodec/{ => video-encoder}/venc_ipi_msg.h |   0
 .../vcodec/{ => video-encoder}/venc_vpu_if.c  |  57 ++-
 .../vcodec/{ => video-encoder}/venc_vpu_if.h  |   3 +-
 61 files changed, 1502 insertions(+), 1298 deletions(-)
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
 delete mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-common/Makefile
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_com_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_dbgfs.c (77%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_dbgfs.h (64%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw.c (85%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw.h (88%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw_priv.h (75%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw_scp.c (79%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_fw_vpu.c (68%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_intr.c
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_intr.h (68%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-common}/mtk_vcodec_util.c (59%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-common/mtk_vcodec_util.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-decoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec.c (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec.h (91%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_drv.c (94%)
 rename drivers/media/platform/mediatek/vcodec/{mtk_vcodec_drv.h => video-decoder/mtk_vcodec_dec_drv.h} (51%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_hw.c (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_hw.h (92%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_pm.c (90%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_pm.h (61%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_stateful.c (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/mtk_vcodec_dec_stateless.c (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_av1_req_lat_if.c (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_if.c (87%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_common.c (98%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_common.h (97%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_if.c (91%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_h264_req_multi_if.c (91%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_hevc_req_multi_if.c (93%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp8_if.c (88%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp8_req_if.c (87%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp9_if.c (87%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec/vdec_vp9_req_lat_if.c (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_drv_base.h (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_drv_if.c (90%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_drv_if.h (89%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_msg_queue.c (97%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_msg_queue.h (96%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_vpu_if.c (79%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-decoder}/vdec_vpu_if.h (97%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-encoder/Makefile
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc.c (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc.h (78%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc_drv.c (95%)
 create mode 100644 drivers/media/platform/mediatek/vcodec/video-encoder/mtk_vcodec_enc_drv.h
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc_pm.c (95%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/mtk_vcodec_enc_pm.h (78%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc/venc_h264_if.c (89%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc/venc_vp8_if.c (89%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_drv_base.h (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_drv_if.c (86%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_drv_if.h (94%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_ipi_msg.h (100%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_vpu_if.c (83%)
 rename drivers/media/platform/mediatek/vcodec/{ => video-encoder}/venc_vpu_if.h (96%)

-- 
2.25.1

