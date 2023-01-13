Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5666951D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbjAMLNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjAMLMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C657F3F11D;
        Fri, 13 Jan 2023 03:07:01 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAB486602A65;
        Fri, 13 Jan 2023 11:06:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673608020;
        bh=PgoihfgU6taTf/JhLvwXD2i4x5G3Nh1XQM1nx4ffeeA=;
        h=From:To:Cc:Subject:Date:From;
        b=V583u9fscHA+x4xZoEg+TVoqNjjoG7riaz83eThZo5p1MrR+vI5DutnPFWWICe7Fn
         arZLRBKMIhdoHhwFA0Wdaky+3fDYuGDqa1A0RqS07qky76HxnVH/PvFUaXD1R4hA45
         LPuwaOMyi+YCJ+cluL6B40qp6bkdtzNvTBvgUfg9gGRHpESoT4kWmIVBg90abVCGLV
         BIT5Wa+lrDVtsGX2KlHW81wlqKq4NNrbQVq4osZ5rphJlJQHR7itxVKV7GYvNcd+Ax
         8uaXBC8OYQAebgNMqT73Dm+s9mAU968h5ywzusUURDmSoqQWcAnSjx/ySEQ4K+pIB9
         9N3S/q8LyL6Iw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 00/23] MediaTek clocks cleanups and improvements
Date:   Fri, 13 Jan 2023 12:05:53 +0100
Message-Id: <20230113110616.111001-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
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

Changes in v3:
 - Moved struct device pointer as first member in all commits
   adding propagation of it
 - Fixed some indentation issues as pointed out by strict checkpatch
 - Tested again to make sure that nothing went wrong in the
   process :-)

Changes in v2:
 - Moved dt-bindings CLK_DUMMY to clk-mtk.h instead


This series performs cleanups and improvements on MediaTek clock
drivers, greatly reducing code duplication (hence also reducing
kernel size).

There would be a lot to say about it, but summarizing:

* Propagates struct device where possible in order to introduce the
  possibility of using Runtime PM on clock drivers as needed,
  possibly enhancing reliability of some platforms (obviously, this
  will do nothing unless power-domains are added to devicetree);

* Cleans up some duplicated clock(s) registration attempt(s): on
  some platforms the 26M fixed factor clock is registered early,
  but then upon platform_driver probe, an attempt to re-register
  that clock was performed;

* Removes some early clock registration where possible, moving
  everything to platform_driver clock probe;

* Breaks down the big MT8173 clock driver in multiple ones, as it's
  already done with the others, cleans it up and adds possibility
  possibility to compile non-boot-critical clock drivers (for 8173)
  as modules;

* Extends the common mtk_clk_simple_probe() function to be able to
  register multiple MediaTek clock types;

* Removes duplicated [...]_probe functions from multiple MediaTek SoC
  clock drivers, migrating almost everything to the common functions
  mtk_clk_simple_probe();

* Adds a .remove() callback, pointing to the common mtk_clk_simple_remove()
  function to all clock drivers that were migrated to the common probe;

* Some more spare cleanups here and there.

All of this was manually tested on various Chromebooks (with different MTK
SoCs) and no regression was detected.

Cheers!

AngeloGioacchino Del Regno (23):
  clk: mediatek: mt8192: Correctly unregister and free clocks on failure
  clk: mediatek: mt8192: Propagate struct device for gate clocks
  clk: mediatek: clk-gate: Propagate struct device with
    mtk_clk_register_gates()
  clk: mediatek: cpumux: Propagate struct device where possible
  clk: mediatek: clk-mtk: Propagate struct device for composites
  clk: mediatek: clk-mux: Propagate struct device for mtk-mux
  clk: mediatek: clk-mtk: Add dummy clock ops
  clk: mediatek: mt8173: Migrate to platform driver and common probe
  clk: mediatek: mt8173: Remove mtk_clk_enable_critical()
  clk: mediatek: mt8173: Break down clock drivers and allow module build
  clk: mediatek: Switch to mtk_clk_simple_probe() where possible
  clk: mediatek: clk-mtk: Extend mtk_clk_simple_probe()
  clk: mediatek: mt8173: Migrate pericfg/topckgen to
    mtk_clk_simple_probe()
  clk: mediatek: clk-mt8192: Move CLK_TOP_CSW_F26M_D2 in top_divs
  clk: mediatek: mt8192: Join top_adj_divs and top_muxes
  clk: mediatek: mt8186: Join top_adj_div and top_muxes
  clk: mediatek: clk-mt8183: Join top_aud_muxes and top_aud_divs
  clk: mediatek: clk-mtk: Register MFG notifier in
    mtk_clk_simple_probe()
  clk: mediatek: clk-mt8192: Migrate topckgen to mtk_clk_simple_probe()
  clk: mediatek: clk-mt8186-topckgen: Migrate to mtk_clk_simple_probe()
  clk: mediatek: clk-mt6795-topckgen: Migrate to mtk_clk_simple_probe()
  clk: mediatek: clk-mt7986-topckgen: Properly keep some clocks enabled
  clk: mediatek: clk-mt7986-topckgen: Migrate to mtk_clk_simple_probe()

 drivers/clk/mediatek/Kconfig                 |   32 +-
 drivers/clk/mediatek/Makefile                |    6 +-
 drivers/clk/mediatek/clk-cpumux.c            |    8 +-
 drivers/clk/mediatek/clk-cpumux.h            |    2 +-
 drivers/clk/mediatek/clk-gate.c              |   23 +-
 drivers/clk/mediatek/clk-gate.h              |    7 +-
 drivers/clk/mediatek/clk-mt2701-aud.c        |   31 +-
 drivers/clk/mediatek/clk-mt2701-eth.c        |   36 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c        |   56 +-
 drivers/clk/mediatek/clk-mt2701-hif.c        |   38 +-
 drivers/clk/mediatek/clk-mt2701-mm.c         |    4 +-
 drivers/clk/mediatek/clk-mt2701.c            |   24 +-
 drivers/clk/mediatek/clk-mt2712-mm.c         |    4 +-
 drivers/clk/mediatek/clk-mt2712.c            |   99 +-
 drivers/clk/mediatek/clk-mt6765.c            |   13 +-
 drivers/clk/mediatek/clk-mt6779-mm.c         |    4 +-
 drivers/clk/mediatek/clk-mt6779.c            |   59 +-
 drivers/clk/mediatek/clk-mt6795-infracfg.c   |    6 +-
 drivers/clk/mediatek/clk-mt6795-mm.c         |    3 +-
 drivers/clk/mediatek/clk-mt6795-pericfg.c    |    6 +-
 drivers/clk/mediatek/clk-mt6795-topckgen.c   |   84 +-
 drivers/clk/mediatek/clk-mt6797-mm.c         |    4 +-
 drivers/clk/mediatek/clk-mt6797.c            |    7 +-
 drivers/clk/mediatek/clk-mt7622-aud.c        |   54 +-
 drivers/clk/mediatek/clk-mt7622-eth.c        |   82 +-
 drivers/clk/mediatek/clk-mt7622-hif.c        |   85 +-
 drivers/clk/mediatek/clk-mt7622.c            |   26 +-
 drivers/clk/mediatek/clk-mt7629-eth.c        |    7 +-
 drivers/clk/mediatek/clk-mt7629-hif.c        |   85 +-
 drivers/clk/mediatek/clk-mt7629.c            |   22 +-
 drivers/clk/mediatek/clk-mt7986-eth.c        |   10 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c   |    7 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c   |  100 +-
 drivers/clk/mediatek/clk-mt8135.c            |   18 +-
 drivers/clk/mediatek/clk-mt8167-aud.c        |    2 +-
 drivers/clk/mediatek/clk-mt8167-img.c        |    2 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |    2 +-
 drivers/clk/mediatek/clk-mt8167-mm.c         |    4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c       |    3 +-
 drivers/clk/mediatek/clk-mt8167.c            |   12 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c |  157 +++
 drivers/clk/mediatek/clk-mt8173-img.c        |   55 +
 drivers/clk/mediatek/clk-mt8173-infracfg.c   |  155 +++
 drivers/clk/mediatek/clk-mt8173-mm.c         |   22 +-
 drivers/clk/mediatek/clk-mt8173-pericfg.c    |  122 ++
 drivers/clk/mediatek/clk-mt8173-topckgen.c   |  653 ++++++++++
 drivers/clk/mediatek/clk-mt8173-vdecsys.c    |   57 +
 drivers/clk/mediatek/clk-mt8173-vencsys.c    |   64 +
 drivers/clk/mediatek/clk-mt8173.c            | 1125 ------------------
 drivers/clk/mediatek/clk-mt8183-audio.c      |   27 +-
 drivers/clk/mediatek/clk-mt8183-mm.c         |    4 +-
 drivers/clk/mediatek/clk-mt8183.c            |  130 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c        |    3 +-
 drivers/clk/mediatek/clk-mt8186-mm.c         |    3 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c   |  112 +-
 drivers/clk/mediatek/clk-mt8192-aud.c        |   30 +-
 drivers/clk/mediatek/clk-mt8192-mm.c         |    3 +-
 drivers/clk/mediatek/clk-mt8192.c            |  182 +--
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |    3 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |    9 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |    3 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |    3 +-
 drivers/clk/mediatek/clk-mt8365-mm.c         |    5 +-
 drivers/clk/mediatek/clk-mt8365.c            |   14 +-
 drivers/clk/mediatek/clk-mt8516-aud.c        |    2 +-
 drivers/clk/mediatek/clk-mt8516.c            |   12 +-
 drivers/clk/mediatek/clk-mtk.c               |  135 ++-
 drivers/clk/mediatek/clk-mtk.h               |   35 +-
 drivers/clk/mediatek/clk-mux.c               |   14 +-
 drivers/clk/mediatek/clk-mux.h               |    3 +-
 70 files changed, 2040 insertions(+), 2179 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8173-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-vencsys.c
 delete mode 100644 drivers/clk/mediatek/clk-mt8173.c

-- 
2.39.0

