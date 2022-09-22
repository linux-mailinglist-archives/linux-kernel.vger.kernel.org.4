Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3B65E5E54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiIVJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiIVJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:19:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E07D01F4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:19:00 -0700 (PDT)
X-UUID: 56bc1c146364425b812206a75827565c-20220922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=b7eFIZlUIZNAXMcqsU5cqB9C2FReZfJrF2+WaffT5ZE=;
        b=K9R4GkRPm8iL1KErBaSO1vq3yacXse9zuony2wQrcgi/cMo4adyQt2mJrIi338RrWyjqs3jcaFpxQA2nYSLwYDzLJkEsK5Kef2w7sH56tgsOmoYC/hCKZNx4bHLj2nLW1SX11BGNm/ocm5l93EyLO8PBDSAQRB5qAoOYZe+EG2s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:eabb1c02-f4fe-4908-8776-505de33a9c0f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:eabb1c02-f4fe-4908-8776-505de33a9c0f,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:005db9a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:2209221718565RI3TUN4,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 56bc1c146364425b812206a75827565c-20220922
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 157448630; Thu, 22 Sep 2022 17:18:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Sep 2022 17:18:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Sep 2022 17:18:52 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 0/7] clk: mediatek: use mtk_clk_simple_probe to simplify
Date:   Thu, 22 Sep 2022 17:18:28 +0800
Message-ID: <20220922091841.4099-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
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

Hi everyone,

This is v3 patches to use mtk_clk_simple_probe to simplify driver. It is almost
a RESEND patch, the only difference is adding reviewed-by tags and a tested-by tag
to the commit messages.

I tested the series on MT8192 and MT6779.
This patch is based on next-20220921 and [1].

Change since v1:
- Angelo's patch [1] already exported mtk_clk_simple_probe and mtk_clk_simple_remove,
so drop this part from my v1 and depends on [1].
- add a reviewed-by tag

Change since v2:
- add reviewed-by tags and a tested-by tag

mtk_clk_simple_probe() was introduced by Chun-Jie in commit
c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers")
and mtk_clk_simple_remove() was added in commit
commit 2204d96b1919 ("clk: mediatek: Add mtk_clk_simple_remove()")

With mtk_clk_simple_probe and mtk_clk_simple_remove,
we can get rid of defining the same probe function in clk drivers.
mtk_clk_simple_probe and mtk_clk_simple_remove are used in new platforms
now, let's apply them to old SoCs.

The process is quite straightforward: 
a. Look up probe functions which can be replaced by mtk_clk_simple_probe()
b. Add mtk_clk_desc and add .data
c. Replace the probe function with mtk_clk_simple_probe and mtk_clk_simple_remove

Thanks,
Miles

[1] https://lore.kernel.org/lkml/20220921091455.41327-1-angelogioacchino.delregno@collabora.com/



Miles Chen (7):
  clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver
  clk: mediatek: mt2712: use mtk_clk_simple_probe to simplify driver
  clk: mediatek: mt6765: use mtk_clk_simple_probe to simplify driver
  clk: mediatek: mt6779: use mtk_clk_simple_probe to simplify driver
  clk: mediatek: mt6797: use mtk_clk_simple_probe to simplify driver
  clk: mediatek: mt8183: use mtk_clk_simple_probe to simplify driver
  clk: mediatek: mt8192: add mtk_clk_simple_remove

 drivers/clk/mediatek/clk-mt2701-bdp.c         | 36 +++++++------------
 drivers/clk/mediatek/clk-mt2701-img.c         | 36 +++++++------------
 drivers/clk/mediatek/clk-mt2701-vdec.c        | 36 +++++++------------
 drivers/clk/mediatek/clk-mt2712-bdp.c         | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt2712-img.c         | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt2712-jpgdec.c      | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt2712-mfg.c         | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt2712-vdec.c        | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt2712-venc.c        | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt6765-audio.c       | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt6765-cam.c         | 33 +++++++----------
 drivers/clk/mediatek/clk-mt6765-img.c         | 33 +++++++----------
 drivers/clk/mediatek/clk-mt6765-mipi0a.c      | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt6765-mm.c          | 33 +++++++----------
 drivers/clk/mediatek/clk-mt6765-vcodec.c      | 34 +++++++-----------
 drivers/clk/mediatek/clk-mt6779-aud.c         | 29 +++++++--------
 drivers/clk/mediatek/clk-mt6779-cam.c         | 29 +++++++--------
 drivers/clk/mediatek/clk-mt6779-img.c         | 29 +++++++--------
 drivers/clk/mediatek/clk-mt6779-ipe.c         | 29 +++++++--------
 drivers/clk/mediatek/clk-mt6779-mfg.c         | 27 +++++++-------
 drivers/clk/mediatek/clk-mt6779-vdec.c        | 29 +++++++--------
 drivers/clk/mediatek/clk-mt6779-venc.c        | 29 +++++++--------
 drivers/clk/mediatek/clk-mt6797-img.c         | 36 +++++++------------
 drivers/clk/mediatek/clk-mt6797-vdec.c        | 36 +++++++------------
 drivers/clk/mediatek/clk-mt6797-venc.c        | 36 +++++++------------
 drivers/clk/mediatek/clk-mt8183-cam.c         | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8183-img.c         | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8183-ipu0.c        | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8183-ipu1.c        | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c     | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c    | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c      | 29 +++++++--------
 drivers/clk/mediatek/clk-mt8183-vdec.c        | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8183-venc.c        | 27 +++++++-------
 drivers/clk/mediatek/clk-mt8192-cam.c         |  1 +
 drivers/clk/mediatek/clk-mt8192-img.c         |  1 +
 .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |  1 +
 drivers/clk/mediatek/clk-mt8192-ipe.c         |  1 +
 drivers/clk/mediatek/clk-mt8192-mdp.c         |  1 +
 drivers/clk/mediatek/clk-mt8192-mfg.c         |  1 +
 drivers/clk/mediatek/clk-mt8192-msdc.c        |  1 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |  1 +
 drivers/clk/mediatek/clk-mt8192-vdec.c        |  1 +
 drivers/clk/mediatek/clk-mt8192-venc.c        |  1 +
 44 files changed, 430 insertions(+), 647 deletions(-)

-- 
2.18.0

