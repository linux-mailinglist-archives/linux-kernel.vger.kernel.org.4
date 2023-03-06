Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AADC6AC242
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCFOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCFOGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:06:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C35305DE;
        Mon,  6 Mar 2023 06:05:50 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32AA6660220B;
        Mon,  6 Mar 2023 14:05:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111548;
        bh=LaDqoVAkAaDR1HZ8+z6VJEtnGMf/xzg7JVCmfrphdnI=;
        h=From:To:Cc:Subject:Date:From;
        b=dMOzcPos23SIEbeR6Fl/D/iARpH5z2vB7PNnVEcLgm5DHXNfi14Bi3sjZuHsq58z4
         Fgry+B28yOZzWWEn4oCKS0hWrtLCIYHsAen2BH/QtuJh3rAsMod2YLTXrZ2CnEvmfM
         n3ZRndnPrd2UZTscFL7VeEpfDkW0arZnhKAog4CKl+1vH7/8OkTyumr26u1y6O/232
         27aCMUBThKdxfyxld6EEx6DESct8qEVXFEVUYz5sBqkgpAD7BLrF2gI5+8ztI61Ufo
         cDCAowUfzLLPax6ycl1Y685Pf7tKK+ZsD4/16DDxWFDofzAyk96ZIgOiTzDh/mBmUq
         HWV7UNBkBN4Jw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v6 00/54] MediaTek clocks: full module build and cleanups
Date:   Mon,  6 Mar 2023 15:04:49 +0100
Message-Id: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
 - Changed order in Makefile for some clock files: specifically,
   apmixedsys goes always first, then topckgen, then anything else.
   This fixes MT8186 issues and also slightly optimizes the clock
   registration sequence, as apmixedsys and topckgen are registering
   root clocks used by all other modules.
 - MT8186 now works again!

Changes in v5:
 - Fixed typo in MODULE_DEVICE_TABLE() for clk-mt8195-vpp0/vpp1

Changes in v4:
 - Rebased over clk-next branch as of 21/02/2023
 - MT8135: Squashed removal of __initconst annotation with conversion
   to platform drivers as suggested by Chen-Yu
 - MT8135: Added mention of the introduction of the dummy clock in
   the commit description of patch [54/54]
 - Fixed Kconfig ordering issue for MT8195 IMGSYS dependant option

Changes in v3:
 - Added conversion to simple_probe for MT8135 clocks
 - Reordered added Kconfig options for MT8195, MT8186
 - Additional config options for MT8195, MT8186 are now default
   enabled if parent COMMON_CLK_MT81{95,86} is enabled
 - Added .remove() callback to MT2712 and MT7622 apmixedsys drivers
   to avoid resource leakage on unbind/removal
 - Dropped unwanted and useless change on mt7629-eth.c

Changes in v2:
 - Fixed issues on MT8183 (thanks Chen-Yu!)
 - Changed builtin_platform_driver() -> module_platform_driver() for
   MT8167 vdecsys clocks (as that was a mistake!)
 - Some patches were split, some others were reordered
 - Summarized: applied changes from Chen-Yu's review

This is part 2 of the "MediaTek clocks cleanups and improvements" series,
which was already picked.

If reading this full cover letter is too boring for you, here's a short
summary of the changes of this series:
 - Added mtk_clk_pdev_probe() for mtk-mmsys probed clocks;
 - Added divider clock support to common probe mechanism;
 - Various cleanups here and there;
 - Converted most clock drivers to platform_driver;
 - MediaTek clocks can now be built as modules.

NOTE: Applies on top of [1] and [2].


Full blurb:

This huge series adds more cleanups on top, reducing size and adding more
commonization for clock drivers probe/remove, which also includes a new
common probe mechanism for multimedia clock drivers that are usually
probed by mtk-mmsys instead of a dt clock node: thanks to this, it was
finally possible to convert almost all clock drivers to the common probe
mechanism, which *finally again* makes us able to build all these drivers
as modules!

Since this looked like being *the* way forward, I went on converting some
more drivers away from OF_CLK_DECLARE_DRIVER to full platform_driver(s),
allowing for more (actually, almost all!) drivers to be built as modules.

While at it, I also added some more consistency in macros usage by
removing all of the duplicated full macro declaration for MediaTek gate
clocks and replacing all of those with using the GATE_MTK macro instead,
producing a nice reduction in amount of lines per file but, more
importantly, improving readability and eventual future batch changes.

This amount of commonization will also, in my opinion, greatly improve
the review process for new clock drivers, as they will be mostly just a
list of clocks and won't contain much new code, as it's all going to be
handled in the common places, which also reduces chances to see new clock
driver related bugs emerging on one SoC or the other.

Since I don't own devices with all of the supported MediaTek SoCs, I
could not test some of the conversions on real hardware... but I am
confident that this will work as the drivers are *very* similar on a
per-generation basis.

This series was build-tested for all (both module and built-in build)
and was manually tested on MT6795, MT8173, MT8192, MT8195.

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=719067
[2]: https://patchwork.kernel.org/project/linux-mediatek/patch/20230207014800.7619-2-moudy.ho@mediatek.com/

AngeloGioacchino Del Regno (54):
  clk: mediatek: clk-mtk: Switch to device_get_match_data()
  clk: mediatek: clk-mtk: Introduce clk_mtk_pdev_{probe,remove}()
  clk: mediatek: Migrate to mtk_clk_pdev_probe() for multimedia clocks
  clk: mediatek: Add divider clocks to mtk_clk_simple_{probe,remove}()
  clk: mediatek: mt2712: Migrate topckgen/mcucfg to
    mtk_clk_simple_probe()
  clk: mediatek: mt2712: Compress clock arrays entries to 90 columns
  clk: mediatek: mt2712: Add error handling to
    clk_mt2712_apmixed_probe()
  clk: mediatek: mt2712: Move apmixedsys clock driver to its own file
  clk: mediatek: mt2712-apmixedsys: Add .remove() callback for module
    build
  clk: mediatek: mt2712: Change to use module_platform_driver macro
  clk: mediatek: mt8365: Move apmixedsys clock driver to its own file
  clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks
  clk: mediatek: mt8365: Join top_misc_mux_gates and top_misc_muxes
    arrays
  clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()
  clk: mediatek: mt8167: Compress GATE_TOPx macros
  clk: mediatek: mt8167: Move apmixedsys as platform_driver in new file
  clk: mediatek: mt8167: Remove __initconst annotation from arrays
  clk: mediatek: mt8167: Convert to mtk_clk_simple_{probe,remove}()
  clk: mediatek: mt8183: Move apmixedsys clock driver to its own file
  clk: mediatek: mt8183: Compress clocks arrays entries where possible
  clk: mediatek: mt8183: Convert all remaining clocks to common probe
  clk: mediatek: Consistently use GATE_MTK() macro
  clk: mediatek: mt7622: Properly use CLK_IS_CRITICAL flag
  clk: mediatek: mt7622: Move apmixedsys clock driver to its own file
  clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module
    build
  clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c
  clk: mediatek: mt7622: Convert to platform driver and simple probe
  clk: mediatek: mt8516: Move apmixedsys clock driver to its own file
  clk: mediatek: mt8516: Convert to platform driver and simple probe
  clk: mediatek: mt8516: Allow building clock drivers as modules
  clk: mediatek: Propagate struct device with
    mtk_clk_register_dividers()
  clk: mediatek: mt7986-apmixed: Use PLL_AO flag to set critical clock
  clk: mediatek: mt7986-infracfg: Migrate to common probe mechanism
  clk: mediatek: mt7986-eth: Migrate to common probe mechanism
  clk: mediatek: mt8186-mcu: Migrate to common probe mechanism
  clk: mediatek: Switch to module_platform_driver() where possible
  clk: mediatek: Add MODULE_LICENSE() where missing
  clk: mediatek: mt2712: Change Kconfig options to allow module build
  clk: mediatek: Split MT8195 clock drivers and allow module build
  clk: mediatek: Allow building MT8192 non-critical clocks as modules
  clk: mediatek: Allow MT7622 clocks to be built as modules
  clk: mediatek: Allow all MT8167 clocks to be built as modules
  clk: mediatek: Allow all MT8183 clocks to be built as modules
  clk: mediatek: Allow building most MT6765 clock drivers as modules
  clk: mediatek: Allow building most MT6797 clock drivers as modules
  clk: mediatek: Split configuration options for MT8186 clock drivers
  clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
  clk: mediatek: Kconfig: Allow module build for core mt8192 clocks
  clk: mediatek: Add MODULE_DEVICE_TABLE() where appropriate
  clk: mediatek: mt8135: Move apmixedsys to its own file
  clk: mediatek: mt8135: Properly use CLK_IS_CRITICAL flag
  clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and
    module
  clk: mediatek: mt8135: Join root_clk_alias and top_divs arrays
  clk: mediatek: mt8135: Convert to simple probe and enable module build

 drivers/clk/mediatek/Kconfig                  |  309 +++--
 drivers/clk/mediatek/Makefile                 |   55 +-
 drivers/clk/mediatek/clk-mt2701-aud.c         |   45 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c         |   25 +-
 drivers/clk/mediatek/clk-mt2701-eth.c         |   15 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c         |   15 +-
 drivers/clk/mediatek/clk-mt2701-hif.c         |   15 +-
 drivers/clk/mediatek/clk-mt2701-img.c         |   15 +-
 drivers/clk/mediatek/clk-mt2701-mm.c          |   56 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c        |   25 +-
 drivers/clk/mediatek/clk-mt2701.c             |   44 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c  |  168 +++
 drivers/clk/mediatek/clk-mt2712-bdp.c         |   15 +-
 drivers/clk/mediatek/clk-mt2712-img.c         |   15 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c      |   15 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c         |   15 +-
 drivers/clk/mediatek/clk-mt2712-mm.c          |   66 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c        |   25 +-
 drivers/clk/mediatek/clk-mt2712-venc.c        |   15 +-
 drivers/clk/mediatek/clk-mt2712.c             | 1010 +++++------------
 drivers/clk/mediatek/clk-mt6765-audio.c       |   25 +-
 drivers/clk/mediatek/clk-mt6765-cam.c         |   15 +-
 drivers/clk/mediatek/clk-mt6765-img.c         |   15 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c      |   15 +-
 drivers/clk/mediatek/clk-mt6765-mm.c          |   15 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c      |   15 +-
 drivers/clk/mediatek/clk-mt6765.c             |   82 +-
 drivers/clk/mediatek/clk-mt6779-aud.c         |    1 +
 drivers/clk/mediatek/clk-mt6779-cam.c         |    1 +
 drivers/clk/mediatek/clk-mt6779-img.c         |    1 +
 drivers/clk/mediatek/clk-mt6779-ipe.c         |    1 +
 drivers/clk/mediatek/clk-mt6779-mfg.c         |    1 +
 drivers/clk/mediatek/clk-mt6779-mm.c          |   25 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c        |    1 +
 drivers/clk/mediatek/clk-mt6779-venc.c        |    1 +
 drivers/clk/mediatek/clk-mt6779.c             |    1 +
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c  |    1 +
 drivers/clk/mediatek/clk-mt6795-infracfg.c    |    1 +
 drivers/clk/mediatek/clk-mt6795-mfg.c         |    1 +
 drivers/clk/mediatek/clk-mt6795-mm.c          |   56 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c     |    1 +
 drivers/clk/mediatek/clk-mt6795-topckgen.c    |    1 +
 drivers/clk/mediatek/clk-mt6795-vdecsys.c     |    1 +
 drivers/clk/mediatek/clk-mt6795-vencsys.c     |    1 +
 drivers/clk/mediatek/clk-mt6797-img.c         |   15 +-
 drivers/clk/mediatek/clk-mt6797-mm.c          |   56 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c        |   25 +-
 drivers/clk/mediatek/clk-mt6797-venc.c        |   15 +-
 drivers/clk/mediatek/clk-mt6797.c             |   44 +-
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c  |  152 +++
 drivers/clk/mediatek/clk-mt7622-aud.c         |   45 +-
 drivers/clk/mediatek/clk-mt7622-eth.c         |   25 +-
 drivers/clk/mediatek/clk-mt7622-hif.c         |   25 +-
 drivers/clk/mediatek/clk-mt7622-infracfg.c    |  128 +++
 drivers/clk/mediatek/clk-mt7622.c             |  371 +-----
 drivers/clk/mediatek/clk-mt7629-eth.c         |   22 +-
 drivers/clk/mediatek/clk-mt7629-hif.c         |   25 +-
 drivers/clk/mediatek/clk-mt7629.c             |   42 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c     |    2 +
 drivers/clk/mediatek/clk-mt7981-eth.c         |    3 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c    |    4 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c    |    4 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c     |    8 +-
 drivers/clk/mediatek/clk-mt7986-eth.c         |  112 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c    |   90 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c    |    4 +-
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c  |  105 ++
 drivers/clk/mediatek/clk-mt8135.c             |  268 ++---
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c  |  145 +++
 drivers/clk/mediatek/clk-mt8167-aud.c         |   46 +-
 drivers/clk/mediatek/clk-mt8167-img.c         |   50 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c      |   50 +-
 drivers/clk/mediatek/clk-mt8167-mm.c          |   69 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c        |   57 +-
 drivers/clk/mediatek/clk-mt8167.c             |  382 ++-----
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c  |    1 +
 drivers/clk/mediatek/clk-mt8173-img.c         |    1 +
 drivers/clk/mediatek/clk-mt8173-infracfg.c    |    1 +
 drivers/clk/mediatek/clk-mt8173-mm.c          |   82 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c     |    1 +
 drivers/clk/mediatek/clk-mt8173-topckgen.c    |    1 +
 drivers/clk/mediatek/clk-mt8173-vdecsys.c     |    1 +
 drivers/clk/mediatek/clk-mt8173-vencsys.c     |    1 +
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c  |  195 ++++
 drivers/clk/mediatek/clk-mt8183-audio.c       |    5 +-
 drivers/clk/mediatek/clk-mt8183-cam.c         |    5 +-
 drivers/clk/mediatek/clk-mt8183-img.c         |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c        |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c        |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c     |    5 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c    |    5 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c      |    5 +-
 drivers/clk/mediatek/clk-mt8183-mm.c          |   29 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c        |    5 +-
 drivers/clk/mediatek/clk-mt8183-venc.c        |    5 +-
 drivers/clk/mediatek/clk-mt8183.c             |  771 +++----------
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c  |    4 +-
 drivers/clk/mediatek/clk-mt8186-cam.c         |    4 +-
 drivers/clk/mediatek/clk-mt8186-img.c         |    4 +-
 .../clk/mediatek/clk-mt8186-imp_iic_wrap.c    |    4 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c    |    4 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c         |    4 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c         |   69 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c         |    4 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c         |    4 +-
 drivers/clk/mediatek/clk-mt8186-mm.c          |   59 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c    |    4 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c        |    4 +-
 drivers/clk/mediatek/clk-mt8186-venc.c        |    4 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c         |    4 +-
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c  |  215 ++++
 drivers/clk/mediatek/clk-mt8192-aud.c         |    5 +-
 drivers/clk/mediatek/clk-mt8192-cam.c         |    5 +-
 drivers/clk/mediatek/clk-mt8192-img.c         |    5 +-
 .../clk/mediatek/clk-mt8192-imp_iic_wrap.c    |    5 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c         |    5 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c         |    5 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c         |    5 +-
 drivers/clk/mediatek/clk-mt8192-mm.c          |   34 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c        |    5 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c    |    5 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c        |    5 +-
 drivers/clk/mediatek/clk-mt8192-venc.c        |    5 +-
 drivers/clk/mediatek/clk-mt8192.c             |  223 +---
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c  |    4 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c  |    4 +-
 drivers/clk/mediatek/clk-mt8195-cam.c         |    4 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c         |    4 +-
 drivers/clk/mediatek/clk-mt8195-img.c         |    4 +-
 .../clk/mediatek/clk-mt8195-imp_iic_wrap.c    |    4 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |    4 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c         |    4 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c         |    4 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c     |    4 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c    |    4 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c    |    4 +-
 drivers/clk/mediatek/clk-mt8195-vdec.c        |    4 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c        |   59 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c        |   61 +-
 drivers/clk/mediatek/clk-mt8195-venc.c        |    4 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c        |   58 +-
 drivers/clk/mediatek/clk-mt8195-vpp1.c        |   58 +-
 drivers/clk/mediatek/clk-mt8195-wpe.c         |    4 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c  |  166 +++
 drivers/clk/mediatek/clk-mt8365-apu.c         |    3 +-
 drivers/clk/mediatek/clk-mt8365-cam.c         |    3 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c         |    3 +-
 drivers/clk/mediatek/clk-mt8365-mm.c          |   42 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c        |    3 +-
 drivers/clk/mediatek/clk-mt8365-venc.c        |    3 +-
 drivers/clk/mediatek/clk-mt8365.c             |  606 +++-------
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c  |  122 ++
 drivers/clk/mediatek/clk-mt8516-aud.c         |   46 +-
 drivers/clk/mediatek/clk-mt8516.c             |  240 +---
 drivers/clk/mediatek/clk-mtk.c                |   82 +-
 drivers/clk/mediatek/clk-mtk.h                |    7 +-
 156 files changed, 3479 insertions(+), 4610 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt2712-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt7622-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt7622-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8135-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8192-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8516-apmixedsys.c

-- 
2.39.2

