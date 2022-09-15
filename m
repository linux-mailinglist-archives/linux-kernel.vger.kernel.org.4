Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2891B5B94A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIOGoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIOGoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:44:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107A7F130;
        Wed, 14 Sep 2022 23:43:59 -0700 (PDT)
X-UUID: 208cd36b0169413bbd8dd68a0a65e59f-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UJig6Hn+pxF/Q9LBQcdh8AZu3N3p8nsJHjnE4n5J38Q=;
        b=Zc6Xm/01TSzafqo3N3U+B03JaWl+F0n6ziCRtmZJrQy0lWGHezzPurDTRQSI5+fV1wravF/EZwE/w+CnV+TjzksBDwvbSiv07YXHzB7FbKdMOHP9AfuSFLBCSMf2e1SBZs1VdHpxUduNwd/GfTJrnXiZ841J+RdMHE4wlNles2I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d6e1f8db-cf4a-4c69-b56b-39b1f5616001,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:538db67b-ea28-4199-b57e-003c7d60873a,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 208cd36b0169413bbd8dd68a0a65e59f-20220915
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2034781939; Thu, 15 Sep 2022 14:43:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 14:43:52 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 15 Sep 2022 14:43:49 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>
Subject: [V14,0/15] Enable jpeg enc & dec multi-hardwares for MT8195
Date:   Thu, 15 Sep 2022 14:43:28 +0800
Message-ID: <20220915064337.2686-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

This series adds support for multi hardwares jpeg enc & dec,
by first adding use of_platform_populate to manage each hardware
information:interrupt, clock, register bases and power.
Secondly add jpeg enc & dec work queue to deal with the encoding
or decoding requests of multi-hardwares at the same time.
Lastly, add output picture reorder function interface to
eliminate the out of order images.

This series has been tested with MT8195 Gstreamer.
Encoding and decoding worked for this chip.

Patches 1 Adds jpeg encoder dt-bindings for mt8195

Patches 2 jpeg encoder builds two module for using Multi-HW,
export some functions to make them visible by other modules.

Patches 3 use devm_of_platform_populate to manage multi-hardware.

Patch 4 add jpeg encoding timeout function to judge hardware timeout.

Patch 5 add encoding work queue to deal with multi-hardware encoding
at the same time.

Patch 6 add output picture reorder function to order images.

Patch 7 add stop cmd function to deal with EOS operation.

Patch 8 Adds jpeg decoder dt-bindings for mt8195

Patches 9 jpeg decoder builds three module for using Multi-HW,
export some functions to make them visible by other modules.

Patch 10 use of_platform_populate to manage multi-hardware.

Patch 11 add jpeg decoding timeout function to judge hardware timeout.

Patch 12 add decoding work queue to deal with multi-hardware decoding
at the same time.

Patch 13 add output picture reorder function to order images.

Patch 14 refactor jpegdec func interface for HW working.

Patch 15 add stop cmd function to deal with EOS operation.

---
This series patches dependent on:
media_stage tree:
[1]
https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4

patch1 new jpegdec dt-bindings included files
[2] MM IOMMU binding:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/

[3] MT8195 power domain:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579

Changes compared with v13:
- some modifications for patch v13's review comments.
- fix kernel robot check errors.
- fix kernel-doc check warns.
- fix sparse check warns.
- combine jpeg encoder series with decoder series into
  one single series.

Changes compared with v12:
- some modifications for patch v12's review comments.

Changes compared with v11:
- some modifications for patch v11's review comments.
- fix yaml file check errors.

Changes compared with v10:
- some modifications for patch v10's review comments.
- fix Gstreamer test errors.

Changes compared with v9:
- some modifications for patch v9's review comments.

Changes compared with v8:
- some modifications for patch v8's review comments.
- add stop cmd function.

Changes compared with v7:
- some modifications for patch v6's review comments.

Changes compared with v6:
- new yaml file for mt8195 jpeg encoder.
- some modifications for patch v5's review comments.

Changes compared with v5:
- use of_platform_populate to replace component framework to
  manage multi-hardware in patch 2.

Changes compared with v4:
- No change compaered with v4

Changes compared with v3:
- Structure patches for consistency, non-backward
  compatible and do not break any existing functionality

Changes compared with v2:
- Split the last two patches into several patches
  to enhance readability
- Correct some syntax errors
- Explain why the component framework is used

Changes compared with v1:
- Add jpeg encoder dt-bindings for MT8195
- Use component framework to manage jpegenc HW
- Add jpegenc output pic reorder function interface

kyrie wu (15):
  dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
  mtk-jpegenc: export jpeg encoder functions
  mtk-jpegenc: support jpegenc multi-hardware
  mtk-jpegenc: add jpegenc timeout func interface
  mtk-jpegenc: add jpeg encode worker interface
  mtk-jpegenc: add output pic reorder interface
  mtk-jpegenc: add stop cmd interface for jpgenc
  dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
  media: mtk-jpegdec: export jpeg decoder functions
  media: mtk-jpegdec: support jpegdec multi-hardware
  media: mtk-jpegdec: add jpegdec timeout func interface
  media: mtk-jpegdec: add jpeg decode worker interface
  media: mtk-jpegdec: add output pic reorder interface
  media: mtk-jpegdec: refactor jpegdec func interface
  mtk-jpegdec: add stop cmd interface for jpgdec

 .../media/mediatek,mt8195-jpegdec.yaml        | 169 ++++++
 .../media/mediatek,mt8195-jpegenc.yaml        | 147 ++++++
 drivers/media/platform/mediatek/jpeg/Makefile |  14 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 490 ++++++++++++++++--
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    | 169 +++++-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 315 ++++++++++-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   6 +-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |   1 +
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 255 +++++++++
 9 files changed, 1483 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml

-- 
2.18.0

