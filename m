Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5527E5B9539
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIOHZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIOHZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:25:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD924BE2;
        Thu, 15 Sep 2022 00:25:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CF156601DF0;
        Thu, 15 Sep 2022 08:25:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663226706;
        bh=a+lCOJ/80w6m9TrGmjBOngO6PqvgZD5vkbSZRABzuHs=;
        h=From:To:Cc:Subject:Date:From;
        b=m92GeU9AJ0IIef3fA/hpdN3AO8FwC683FHWJGrPzEfD7OmlydHQ4hqnCks25LqfmY
         EcjqhNfbojc28VKIc+P16+j8hChbITg/+hyKTLh5teMrOgUjL+Gg6zPQMBC/PtFdTP
         +biVR4X/fBNWHOl00rP2qgjrfW927Hkq3suf0Tm0qD7bwc+dAtQ455T9Mn2G0PaopD
         JC2a8ZvmS3Z4Lj6VFbEdZFNC++ShEcRKEvtlTvfAZxkrYQKbE+bR++Ojeu4g/tbXYt
         F3+DKBxQdvXBWSWlw94Tspnjl3HwK4rJSo+p5fWJSBelZXVujREIVE3khz1thUowv2
         tAFRurVuXk/GA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 00/10] MediaTek SoC safe clock muxing and GPU clocks
Date:   Thu, 15 Sep 2022 09:24:48 +0200
Message-Id: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

This series adds a clock notifier for MediaTek clock muxes, required
in order to achieve stability for GPU DVFS.

The GPU frequency scaling mechanism requires us to switch the GPU
mux clock to a safe parent which frequency is always less or equal
to the "current" GPU frequency before reprogramming its dedicated
"MFG" PLL.
This is needed because the PLL needs time to reconfigure for its
output to stabilize (so, for the PLL to lock again): failing to do
so will lead to instabilities such as glitches, GPU lockups and/or
full system lockups.

While at it, reparenting of some GPU clocks was also performed, as
the clock tree was slightly incorrect.

This series was tested, along with mtk-regulator-coupler [1], on
Chromebooks with different SoCs (MT8183, MT8192, MT8195*), resulting
in fully working GPU DVFS with the Panfrost driver.

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220628120224.81180-1-angelogioacchino.delregno@collabora.com/

* MT8195 does not require mtk-regulator-coupler. This series, along
  with [1], are required to perform GPU DVFS also on non-Chromebook SoCs.

Changes in v2:
 - Added comment in clk-mt8195-topckgen to keep the mfg parents
   documented after removal, as suggested by Chen-Yu

AngeloGioacchino Del Regno (6):
  clk: mediatek: clk-mt8195-mfg: Reparent mfg_bg3d and propagate rate
    changes
  clk: mediatek: clk-mt8195-topckgen: Register mfg_ck_fast_ref as
    generic mux
  clk: mediatek: clk-mt8195-topckgen: Add GPU clock mux notifier
  clk: mediatek: clk-mt8195-topckgen: Drop univplls from mfg mux parents
  clk: mediatek: clk-mt8192-mfg: Propagate rate changes to parent
  clk: mediatek: clk-mt8192: Add clock mux notifier for mfg_pll_sel

Chen-Yu Tsai (4):
  arm64: dts: mt8183: Fix Mali GPU clock
  clk: mediatek: mt8183: mfgcfg: Propagate rate changes to parent
  clk: mediatek: mux: add clk notifier functions
  clk: mediatek: mt8183: Add clk mux notifier for MFG mux

 arch/arm64/boot/dts/mediatek/mt8183.dtsi   |  2 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c   |  6 +--
 drivers/clk/mediatek/clk-mt8183.c          | 28 +++++++++++++
 drivers/clk/mediatek/clk-mt8192-mfg.c      |  6 ++-
 drivers/clk/mediatek/clk-mt8192.c          | 28 +++++++++++++
 drivers/clk/mediatek/clk-mt8195-mfg.c      |  6 ++-
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 46 +++++++++++++++-------
 drivers/clk/mediatek/clk-mux.c             | 38 ++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h             | 15 +++++++
 9 files changed, 153 insertions(+), 22 deletions(-)

-- 
2.37.2

