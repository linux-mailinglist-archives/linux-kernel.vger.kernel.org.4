Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDE6C0EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCTK2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCTK2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:28:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008DC14A;
        Mon, 20 Mar 2023 03:28:43 -0700 (PDT)
X-UUID: fc0b7b08c70911ed91027fb02e0f1d65-20230320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=44gwnn6etR42gJ4ly/JUnLCZiquXaAUZTr3W/QViEQ8=;
        b=Z5br3u9jkP6hEhnnUKsl/CEYr67C81mQGwjXWZ2uDrlIlzWiMoNHAoDCNH9g1ql+G2gGiiI8WE/0Zr7oLQW4EWNvif6/R4t4O7nmcFtHiI9hsJlqVv+Cw7f2XAx5YYAaZP5wssh/9IUjy5vVXaEbR6ClE6XlKjbq18yiPGgkSBw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:10e2b800-5f86-4ade-a4ef-4d3cee37c054,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:1195e728-564d-42d9-9875-7c868ee415ec,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: fc0b7b08c70911ed91027fb02e0f1d65-20230320
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1109516221; Mon, 20 Mar 2023 18:28:41 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 20 Mar 2023 18:28:40 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 18:28:39 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 0/6 RESEND] media: mediatek: vcodec: Add debugfs file for decode and encode
Date:   Mon, 20 Mar 2023 18:28:32 +0800
Message-ID: <20230320102838.8313-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to change kernel driver to open decode and encode debug log at current period,
it's very unreasonable. Adding debugfs common interface to support decode and encode,
using echo command to control debug log level and getting useful information for each
instance.

patch 1 add debugfs common interface.
patch 2~4 support decode.
patch 5~6 support encode
---
Yunfei Dong (6):
  media: mediatek: vcodec: Add debugfs interface to get debug
    information
  media: mediatek: vcodec: Add debug params to control different log
    level
  media: mediatek: vcodec: Add a debugfs file to get different useful
    information
  media: mediatek: vcodec: Get get each instance format type
  media: mediatek: vcodec: Change dbgfs interface to support encode
  media: mediatek: vcodec: Add encode to support dbgfs

 .../media/platform/mediatek/vcodec/Makefile   |   6 +
 .../mediatek/vcodec/mtk_vcodec_dbgfs.c        | 157 ++++++++++++++++++
 .../mediatek/vcodec/mtk_vcodec_dbgfs.h        |  48 ++++++
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |   4 +
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   4 +
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |   2 +
 .../mediatek/vcodec/mtk_vcodec_util.c         |   8 +
 .../mediatek/vcodec/mtk_vcodec_util.h         |  25 ++-
 8 files changed, 251 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs.h

-- 
2.25.1

