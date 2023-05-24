Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5070F031
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjEXIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbjEXIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:07:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E16135;
        Wed, 24 May 2023 01:07:47 -0700 (PDT)
X-UUID: 0ee95122fa0a11ed9cb5633481061a41-20230524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zcBxf2JopgBE0/qefhNOXKZs3dhHmLYOk2K3RwkLF5k=;
        b=uerNzmrFlA4034mRp3mKfUr7D9bQ3UxtQmBe8+oFYEpiZ+qTWBINipS+da1GTlwHJyiQ27zcLSHjYqGbYL9T94krlb5o8eTsCMk7/VFCv6QUyZTb/SbFTR9+e76JocyI+JdhnQBwfnD7LzQ638xrba3dXSUqUg3kFNWSNOR7ewU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:9eb73153-1f49-476b-ac03-5d2f496705d0,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:4cabd76c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0ee95122fa0a11ed9cb5633481061a41-20230524
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1115863944; Wed, 24 May 2023 16:07:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 May 2023 16:07:41 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 May 2023 16:07:40 +0800
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
Subject: [PATCH v7,0/2] media: mediatek: vcodec: add hevc stateless decoder driver in MT8195
Date:   Wed, 24 May 2023 16:07:37 +0800
Message-ID: <20230524080739.17264-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hevc stateless decoder driver to support hardware decode in MT8195, and the driver
need num_delta_pocs_of_ref_rps_idx value to parse slice header short_term_ref_pic_set().

patch 1 add num_delta_pocs_of_ref_rps_idx field.
patch 2 add hevc stateless decoder driver.
---
Changed from v6:
- fix AngeloGioacchino's suggestion.

Changed from v5:
- checkpatch/kernel-doc pass/build pass.
- fix warning: struct vdec_av1_slice_fb -> struct vdec_hevc_slice_fb.
- fix warning: remove unused comment for param "trans_start" and "trans_end"

Changed from v4:
- fix some comments according to Nathan's suggestion.

Changed from v3:
- add the dependency patch to this patch series for patch 1.

Changed from v2:
- fix one build warning.
- add the dependency patch link.

Changed from v1:
- fix build error when build 32bit system.
- hevc fluster test result: 132/147 (not support: 10bit => 11 and resolution => 4).
---
Benjamin Gaignard (1):
  media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field

Yunfei Dong (1):
  media: mediatek: vcodec: support stateless hevc decoder

 .../media/v4l/ext-ctrls-codec-stateless.rst   |    7 +
 .../media/platform/mediatek/vcodec/Makefile   |    1 +
 .../vcodec/mtk_vcodec_dec_stateless.c         |   59 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |    1 +
 .../vcodec/vdec/vdec_hevc_req_multi_if.c      | 1097 +++++++++++++++++
 .../platform/mediatek/vcodec/vdec_drv_if.c    |    4 +
 .../platform/mediatek/vcodec/vdec_drv_if.h    |    1 +
 include/uapi/linux/v4l2-controls.h            |    6 +-
 8 files changed, 1174 insertions(+), 2 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c

-- 
2.25.1

