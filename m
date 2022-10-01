Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01F5F1985
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiJAD0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiJADZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:25:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA5F80A0;
        Fri, 30 Sep 2022 20:17:47 -0700 (PDT)
X-UUID: ada22af4420a490c8b5301b9847080ac-20221001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=s7J4FGv4lww/S8u+a9WC27kyL5Mbg9UEfb7Zl/LRrXc=;
        b=kJ1W7yVpMBfnvc38mVWsiyQ0DDqCbuhWO9479f8dbZIBZlBudmnpBhZ0IS/7ZnfFOZyfweadtLPdr+uEVA2Mub9WIjsr5h4UqQaN8/lwM1dajxWPknBiEMD/Y9eXNM0nznjTnyIsknTkxvYX3ZFm4gfQXDNYsQF1ZcUJv7N2EyI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:3a8963d6-f38b-4146-aabb-e48f60ce40e3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:12aba107-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ada22af4420a490c8b5301b9847080ac-20221001
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1721155052; Sat, 01 Oct 2022 11:17:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 1 Oct 2022 11:17:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 1 Oct 2022 11:17:40 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v6, 0/8] Support H264 multi-core encoder on MT8195
Date:   Sat, 1 Oct 2022 11:17:29 +0800
Message-ID: <20221001031737.18266-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 has two H264 encoder hardware, named core0 and core1, this two
cores can encode two input frames separately at the same time to achieve
higher performance.

This series of patches are used to enable the two H264 encoder cores,
the difference between encoding process before and after enable two
cores is just like as below:
As-Is: Synchronous
V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> wait encoder IRQ
-->
encoding done with result --> job_finish
V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> wait encoder IRQ
-->
encoding done with result --> job_finish
...
To-Be: Asynchronous
V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> job_finish
..V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> job_finish
(venc core0 may encode done here, done the encoding result to client)
V4L2_VIDIOC_QBUF#2 --> device_run(triger encoder) --> job_finish.

There is a tast test on chromeOS can measure the encoder fps summary:
command line:
tast run $DUT_IP video.PlatformEncoding.v4l2_h264*
 +-------------+------+----------+------+----------+------+----------+
 | fps summary | 180p | 180_meet | 360p | 360_meet | 720p | 720_meet |
 +-------------+------+----------+------+----------+------+----------+
 |  w/o patch  | 1913 |   1935   | 554  |    571   | 159  |    189   |
 +-------------+------+----------+------+----------+------+----------+
 | apply patch | 2236 |   2337   | 820  |    830   | 324  |    390   |
 +-------------+------+----------+------+----------+------+----------+

changes compared with v5:
- rebase to the newer linux media_stage tree.

changes compared with v4:
- reabse to the newer linux media stage tree.
- remove "mediatek,venc-multi-core" property since sub-device can
  be probed by of_platform_populate api directly.
- some modifications for patch v4's review comments.

changes compared with v3:
- rebase to the newer linux media stage.
- add a capability to indicate scp firmware support multi-core.
- probe core0 as main device, core1 as sub-device.

changes compared with v2:
- update venc core dt-bindings, add two new properties for current
  usage.
- parse venc multi_core mode from device tree.
- rebase to the newer linux media stage.

changes compared with v1:
- of_platform_populate was used in place of the component framework.
- new yaml file for venc cores.
- some modifications for patch v1's review comments.
---

Irui Wang (8):
  dt-bindings: media: mediatek: vcodec: Adds encoder cores dt-bindings
    for mt8195
  media: mediatek: vcodec: Enable venc dual core usage
  media: mediatek: vcodec: Refactor venc power manage function
  media: mediatek: vcodec: Add more extra processing for multi-core
    encoding
  media: mediatek: vcodec: Add venc power on/off function
  media: mediatek: vcodec: Refactor encoder clock on/off function
  media: mediatek: vcodec: Add multi-core encoding process
  media: mediatek: vcodec: Return encoding result in asynchronous mode

 .../media/mediatek,vcodec-encoder-core.yaml   | 217 ++++++++++++++++++
 .../media/mediatek,vcodec-encoder.yaml        |   1 -
 .../media/platform/mediatek/vcodec/Makefile   |   4 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  27 ++-
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 113 ++++++---
 .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  11 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  44 +++-
 .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 156 +++++++++++++
 .../mediatek/vcodec/mtk_vcodec_enc_hw.h       |  34 +++
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       | 178 ++++++++++++--
 .../mediatek/vcodec/mtk_vcodec_enc_pm.h       |  11 +-
 .../mediatek/vcodec/mtk_vcodec_util.c         |  19 ++
 .../mediatek/vcodec/mtk_vcodec_util.h         |   3 +
 .../mediatek/vcodec/venc/venc_h264_if.c       | 143 +++++++++---
 .../mediatek/vcodec/venc/venc_vp8_if.c        |   3 +-
 .../platform/mediatek/vcodec/venc_drv_if.c    |  75 ++++--
 .../platform/mediatek/vcodec/venc_drv_if.h    |   6 +
 .../platform/mediatek/vcodec/venc_vpu_if.c    |  25 +-
 .../platform/mediatek/vcodec/venc_vpu_if.h    |   3 +-
 19 files changed, 958 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-core.yaml
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.h

-- 
2.18.0

