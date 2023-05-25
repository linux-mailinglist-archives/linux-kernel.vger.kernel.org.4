Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C2710419
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjEYEkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEYEki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:40:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FFB2;
        Wed, 24 May 2023 21:40:30 -0700 (PDT)
X-UUID: 43ebfe18fab611edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0/SjOfKS0RJghE7tHsn2QoAKeD2KyPO3CaFHVaU0PTk=;
        b=nGJ7O/fAJfxEQo2DQWp98NxNb6JOkoveol66r2Eb2reYwr/K6gvo/xAUMKZexhRtqD+Qte8KfdU1dXs22i1lQIZg458l2OVcWN8S++1c07M/GSxHu8CJDaWWxijKyX51PLbpqrCUve2MtIP90s0Wr0wFg7xjGnJ3mxVYuqECK8M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:5ec8d0cf-f46f-44e9-98a6-9e2f572ad809,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:ae40f16c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 43ebfe18fab611edb20a276fd37b9834-20230525
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1495481923; Thu, 25 May 2023 12:40:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id
 15.2.1118.7; Thu, 25 May 2023 04:40:14 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 09:40:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 09:40:10 +0800
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
Subject: [PATCH v4,0/4] media: mediatek: vcodec: Fix decoder under flow and plt test fails randomly 
Date:   Thu, 25 May 2023 09:40:05 +0800
Message-ID: <20230525014009.23345-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1: Getting decoder under flow error randomly when do stress test with youtube;
2: Video display black when do plt test with one night.

patch 1 avoid unneeded error logging.
patch 2 using decoder status instead of core work count.
patch 3 move core context from device to each instance.
patch 4 using empty lat buffer as the last one to flush decoder.
---
changed with v3:
- rebase to the top of hevc patch and fix patch 3 build error.

changed with v2:
- fix build error for patch 4

changed with v1:
- re-write commit messgage for patch 1
- squash v1 patch 2 to v1 patch 3 for patch 2
- squash v1 patch 4 to v1 patch 6 for patch 4
---
Yunfei Dong (4):
  media: mediatek: vcodec: Avoid unneeded error logging
  media: mediatek: vcodec: using decoder status instead of core work
    count
  media: mediatek: vcodec: move core context from device to each
    instance
  media: mediatek: vcodec: using empty lat buffer as the last one

 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   1 -
 .../vcodec/mtk_vcodec_dec_stateless.c         |   2 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   2 -
 .../vcodec/vdec/vdec_h264_req_multi_if.c      |   6 +-
 .../vcodec/vdec/vdec_hevc_req_multi_if.c      |   4 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |   4 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 105 ++++++++----------
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  28 ++++-
 8 files changed, 76 insertions(+), 76 deletions(-)

-- 
2.18.0

