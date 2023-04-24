Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD666EC5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjDXGDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 02:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjDXGCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:02:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCB3ABD;
        Sun, 23 Apr 2023 23:01:39 -0700 (PDT)
X-UUID: 7756e33ae26511eda9a90f0bb45854f4-20230424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=F9nWENbaoddeCEQmK41Shlyp+67804jRjcfJoDk7On8=;
        b=DpKqQceMsuw4CPxUewbIky3biwCuY15WUk8UZ0Wd/bC+WSqVvLPgxBd8GpEA6DLAnTotCOev0Mq/CNzlxUoLmcqAoTSwdOdwVlzeLsDdop6Oh39oMOASvE3DXi+9DA4YABpjnPuwO5bxizlZL5dlX94tFo5+zKQaolod59cjhK0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:55d27a15-bdca-4626-9472-e8817399799a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.22,REQID:55d27a15-bdca-4626-9472-e8817399799a,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:120426c,CLOUDID:10d80485-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230424140135U3ATWUZ0,BulkQuantity:1,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 7756e33ae26511eda9a90f0bb45854f4-20230424
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 856612823; Mon, 24 Apr 2023 14:01:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Apr 2023 14:01:32 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Apr 2023 14:01:31 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3,0/4] media: mediatek: vcodec: Fix decoder under flow and plt test fails randomly 
Date:   Mon, 24 Apr 2023 14:01:26 +0800
Message-ID: <20230424060130.18395-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
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
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |   4 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c | 105 ++++++++----------
 .../platform/mediatek/vcodec/vdec_msg_queue.h |  28 ++++-
 7 files changed, 74 insertions(+), 74 deletions(-)

-- 
2.18.0

