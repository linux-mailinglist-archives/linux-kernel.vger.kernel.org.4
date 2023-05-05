Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB96F801B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjEEJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjEEJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:37:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762A191ED;
        Fri,  5 May 2023 02:37:40 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B4BB6605706;
        Fri,  5 May 2023 10:37:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683279459;
        bh=2X87NpkY0kngumn5SP2qMhUGTOWwMEU1tsdm96Xs+Qc=;
        h=From:To:Cc:Subject:Date:From;
        b=jc0ROQF8wNtaLgrgqX7OM6NQV+eYU4AKHFRtcExzOJ5AUIdKbpH53zuEjh6S3nSy9
         yw23cMeavsUgZ5ivOb+/QgOnpi1eb++Vp3GC9X/MRsoSLEjxnsU5gWaOiGf+Q3kbFZ
         4UQh4uMevZhkFEtdZkltxpt466VoLzu2WJzhfalun4iq+R44v+UZ2rl+sWJwBw7sZG
         qIT0JksKrai685xRuXpd8CH1kH6rTVyruISZjAA6QcRVRj9Xa84+nfmb7l+rBcXj/S
         qkpZwIEAkQysZWOO7e1e4axSzi1yo1AhTKh+eEPKRrVrwVHhGItnnpUtyZ02OJmMX2
         4FS/MXyfdihxA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, mandyjh.liu@mediatek.com,
        miles.chen@mediatek.com, zhaojh329@gmail.com,
        daniel@makrotopia.org, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, Garmin.Chang@mediatek.com,
        msp@baylibre.com, yangyingliang@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/2] clk/mediatek: Adjustments for MSDC rate accuracy
Date:   Fri,  5 May 2023 11:37:31 +0200
Message-Id: <20230505093733.221922-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series stops unconditionally forcing CLK_SET_RATE_PARENT on
MediaTek muxes, as that should be set in the clock driver for each
clock requiring it, and removes CLK_SET_PARENT from all MSDC core
clocks to allow mtk-sd to select the right clock parent when doing
mclk setting, improving the rate accuracy and avoiding both under
and overclocks of the eMMC/SD/SDIO card, both improving performance
and stability of the attached storage.

This series was successfully tested on MT8173, MT8192, MT8195.

AngeloGioacchino Del Regno (2):
  clk: mediatek: mux: Stop forcing CLK_SET_RATE_PARENT flag
  clk: mediatek: Remove CLK_SET_PARENT from all MSDC core clocks

 drivers/clk/mediatek/clk-mt6765.c          | 20 +++++-----
 drivers/clk/mediatek/clk-mt6779.c          | 24 +++++------
 drivers/clk/mediatek/clk-mt7981-topckgen.c | 12 +++---
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 12 +++---
 drivers/clk/mediatek/clk-mt8173-topckgen.c | 24 +++++------
 drivers/clk/mediatek/clk-mt8183.c          | 22 ++++++-----
 drivers/clk/mediatek/clk-mt8186-topckgen.c | 24 +++++------
 drivers/clk/mediatek/clk-mt8188-topckgen.c | 40 +++++++++++--------
 drivers/clk/mediatek/clk-mt8192.c          | 23 +++++------
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 46 +++++++++++++---------
 drivers/clk/mediatek/clk-mux.c             |  2 +-
 11 files changed, 136 insertions(+), 113 deletions(-)

-- 
2.40.1

