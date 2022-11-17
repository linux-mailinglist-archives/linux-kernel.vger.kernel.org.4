Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DDF62D6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiKQJZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiKQJZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:25:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC565FC;
        Thu, 17 Nov 2022 01:25:05 -0800 (PST)
X-UUID: be9fe30af4d34b8197ca220056917c3a-20221117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JAFS2SBfo8VzxEGJ0pjZndI5mpC53oii67xvJ1Ckkts=;
        b=YCESVN2LnQxhnjyaz+Q8WDAdJIeCS3HYH/zQsAQCKgq8rnCK5wcsbdonzWlwmIn5KQyXrLKLH3iD81XXQZ8LWJoneCRk8wNOUkiqNEmfHB1AaEfP6SKxdK7qBGNx2ij0CEptajqxdAJCYXfuGYPtp4Uho0x0GtS0jkd/DImdJQg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:223438b7-c0c9-425d-ba82-e96a07c9c98f,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.12,REQID:223438b7-c0c9-425d-ba82-e96a07c9c98f,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:62cd327,CLOUDID:2a340c2f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221117172459WF6E6G21,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: be9fe30af4d34b8197ca220056917c3a-20221117
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1960576712; Thu, 17 Nov 2022 17:24:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 17 Nov 2022 17:24:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 17 Nov 2022 17:24:54 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2,0/5] media: mediatek: vcodec: Fix decode random crash for PLT test
Date:   Thu, 17 Nov 2022 17:24:48 +0800
Message-ID: <20221117092453.31366-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decoder may decode timeout or error when PLT test, fix some error
condition not reasonable.

patch 1 fix getting dst buffer NULL.
patch 2 fix inner racing mode fail condition.
patch 3 fix h264 crash.
patch 4 fix vp9 crash.
patch 5 fix core thread empty list.
---
changed with v1:
- add Fix tag for patch 1.
- fix comments for patch 3.
---
Yunfei Dong (5):
  media: mediatek: vcodec: Fix getting NULL pointer for dst buffer
  media: mediatek: vcodec: Can't set dst buffer to done when lat decode
    error
  media: mediatek: vcodec: Fix h264 set lat buffer error
  media: mediatek: vcodec: Setting lat buf to lat_list when lat decode
    error
  media: mediatek: vcodec: Core thread depends on core_list

 .../vcodec/mtk_vcodec_dec_stateless.c         | 13 +++++----
 .../vcodec/vdec/vdec_h264_req_multi_if.c      | 28 +++++++++++--------
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         | 15 ++++++----
 .../platform/mediatek/vcodec/vdec_msg_queue.c |  2 +-
 4 files changed, 36 insertions(+), 22 deletions(-)

-- 
2.18.0

