Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7B6B6825
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCLQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCLQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:17:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4F84FF12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:16:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-0007ne-Qq; Sun, 12 Mar 2023 17:15:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLu-003f1Q-OX; Sun, 12 Mar 2023 17:15:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLt-004K82-SG; Sun, 12 Mar 2023 17:15:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 00/30] clk: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:42 +0100
Message-Id: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12722; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jEZJnYWtfk7vegzrpMfq7GOJ196G8jvqX57CAPZ3iLs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfoRCG0Wyura3TxaQuw3cux0jAyL9llKLY77P 7TVq8P1y0uJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36EQAKCRDB/BR4rcrs CSrbB/0eTnnVnWWyRB+p1/djaWfBVCMXK5yG1M9edyo+3DajyEVRFBHCH7ZUu83CV2dgxo7UJIX E8j559eX1I4Xs7CdWM9g3txmTi89gR8mxPpItCyvzeKDeWNpfH6erYcPHetwR5J4VWYNcUaWJ0p guxIAwoDLonXH9LYLTC44CGLsV9wADqd5cml++KFj/Ni1gEDhM6G/lZzSFby2cBPgN+CjT5p/nP 4gAmE8S5gn4UAI78Nej7/lg/7IaUXBaAP1F4+eAxzRSmWDNilyzosmJlF9qcslx8qrHPp/n49b2 1O6n4b7iRwP+oZOCuNqzV27cseb7a/H3t2oDUeBeFjdz4z8o
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch series adapts the platform drivers below drivers/clk
to use the .remove_new() callback. Compared to the traditional .remove()
callback .remove_new() returns no value. This is a good thing because
the driver core doesn't (and cannot) cope for errors during remove. The
only effect of a non-zero return value in .remove() is that the driver
core emits a warning. The device is removed anyhow and an early return
from .remove() usually yields a resource leak.

There were three drivers that did such an early error return in their
remove callback. Two of them are fixed, the tegra one is more
complicated. I only converted it to return zero (which only suppresses
the duplicated warning by the driver core, but doesn't make the resource
leak better or worse.) This needs some more attention by someone who
understands the driver in question.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later
which prevents that such programming errors are introduced in the first
place.

Note that this series depends on commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") which is included in v6.3-rc1.

Uwe Kleine-König (30):
  clk: mediatek: Make mtk_clk_simple_remove() return void
  clk: tegra: Don't warn three times about failure to unregister
  clk: xilinx: Drop if block with always false condition
  clk: axs10x: Convert to platform remove callback returning void
  clk: bcm: Convert to platform remove callback returning void
  clk: axi-clkgen: Convert to platform remove callback returning void
  clk: axm5516: Convert to platform remove callback returning void
  clk: fixed-factor: Convert to platform remove callback returning void
  clk: fixed-mmio: Convert to platform remove callback returning void
  clk: fixed-rate: Convert to platform remove callback returning void
  clk: hsdk-pll: Convert to platform remove callback returning void
  clk: palmas: Convert to platform remove callback returning void
  clk: pwm: Convert to platform remove callback returning void
  clk: s2mps11: Convert to platform remove callback returning void
  clk: scpi: Convert to platform remove callback returning void
  clk: stm32mp1: Convert to platform remove callback returning void
  clk: hisilicon: Convert to platform remove callback returning void
  clk: keystone: Convert to platform remove callback returning void
  clk: mediatek: Convert to platform remove callback returning void
  clk: mmp: Convert to platform remove callback returning void
  clk: mvebu: Convert to platform remove callback returning void
  clk: qcom: Convert to platform remove callback returning void
  clk: renesas: Convert to platform remove callback returning void
  clk: samsung: Convert to platform remove callback returning void
  clk: stm32: Convert to platform remove callback returning void
  clk: tegra: Convert to platform remove callback returning void
  clk: ti: Convert to platform remove callback returning void
  clk: uniphier: Convert to platform remove callback returning void
  clk: x86: Convert to platform remove callback returning void
  clk: xilinx: Convert to platform remove callback returning void

 drivers/clk/axs10x/i2s_pll_clock.c             |  5 ++---
 drivers/clk/axs10x/pll_clock.c                 |  5 ++---
 drivers/clk/bcm/clk-bcm2711-dvp.c              |  6 ++----
 drivers/clk/bcm/clk-bcm63xx-gate.c             |  6 ++----
 drivers/clk/bcm/clk-raspberrypi.c              |  6 ++----
 drivers/clk/clk-axi-clkgen.c                   |  6 ++----
 drivers/clk/clk-axm5516.c                      |  5 ++---
 drivers/clk/clk-fixed-factor.c                 |  6 ++----
 drivers/clk/clk-fixed-mmio.c                   |  6 ++----
 drivers/clk/clk-fixed-rate.c                   |  6 ++----
 drivers/clk/clk-hsdk-pll.c                     |  5 ++---
 drivers/clk/clk-palmas.c                       |  5 ++---
 drivers/clk/clk-pwm.c                          |  6 ++----
 drivers/clk/clk-s2mps11.c                      |  6 ++----
 drivers/clk/clk-scpi.c                         |  5 ++---
 drivers/clk/clk-stm32mp1.c                     |  6 ++----
 drivers/clk/hisilicon/clk-hi3519.c             |  5 ++---
 drivers/clk/hisilicon/clk-hi3559a.c            |  5 ++---
 drivers/clk/hisilicon/crg-hi3516cv300.c        |  5 ++---
 drivers/clk/hisilicon/crg-hi3798cv200.c        |  5 ++---
 drivers/clk/keystone/sci-clk.c                 |  6 ++----
 drivers/clk/mediatek/clk-mt2701-aud.c          |  6 +++---
 drivers/clk/mediatek/clk-mt2701-bdp.c          |  2 +-
 drivers/clk/mediatek/clk-mt2701-eth.c          |  2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c          |  2 +-
 drivers/clk/mediatek/clk-mt2701-hif.c          |  2 +-
 drivers/clk/mediatek/clk-mt2701-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt2712-bdp.c          |  2 +-
 drivers/clk/mediatek/clk-mt2712-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c       |  2 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c          |  2 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt2712-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mt2712.c              |  2 +-
 drivers/clk/mediatek/clk-mt6765-audio.c        |  2 +-
 drivers/clk/mediatek/clk-mt6765-cam.c          |  2 +-
 drivers/clk/mediatek/clk-mt6765-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c       |  2 +-
 drivers/clk/mediatek/clk-mt6765-mm.c           |  2 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c       |  2 +-
 drivers/clk/mediatek/clk-mt6779-aud.c          |  2 +-
 drivers/clk/mediatek/clk-mt6779-cam.c          |  2 +-
 drivers/clk/mediatek/clk-mt6779-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c          |  2 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c          |  2 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt6779-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mt6779.c              |  2 +-
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c   |  6 ++----
 drivers/clk/mediatek/clk-mt6795-infracfg.c     |  6 ++----
 drivers/clk/mediatek/clk-mt6795-mfg.c          |  2 +-
 drivers/clk/mediatek/clk-mt6795-mm.c           |  6 ++----
 drivers/clk/mediatek/clk-mt6795-pericfg.c      |  6 ++----
 drivers/clk/mediatek/clk-mt6795-topckgen.c     |  2 +-
 drivers/clk/mediatek/clk-mt6795-vdecsys.c      |  2 +-
 drivers/clk/mediatek/clk-mt6795-vencsys.c      |  2 +-
 drivers/clk/mediatek/clk-mt6797-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt6797-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mt7622-aud.c          |  6 +++---
 drivers/clk/mediatek/clk-mt7622-eth.c          |  2 +-
 drivers/clk/mediatek/clk-mt7622-hif.c          |  2 +-
 drivers/clk/mediatek/clk-mt7629-hif.c          |  2 +-
 drivers/clk/mediatek/clk-mt7981-eth.c          |  2 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c     |  2 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c     |  2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c     |  2 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c   |  6 ++----
 drivers/clk/mediatek/clk-mt8173-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt8173-infracfg.c     |  6 ++----
 drivers/clk/mediatek/clk-mt8173-mm.c           |  6 ++----
 drivers/clk/mediatek/clk-mt8173-pericfg.c      |  2 +-
 drivers/clk/mediatek/clk-mt8173-topckgen.c     |  2 +-
 drivers/clk/mediatek/clk-mt8173-vdecsys.c      |  2 +-
 drivers/clk/mediatek/clk-mt8173-vencsys.c      |  2 +-
 drivers/clk/mediatek/clk-mt8183-audio.c        |  6 +++---
 drivers/clk/mediatek/clk-mt8183-cam.c          |  2 +-
 drivers/clk/mediatek/clk-mt8183-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c         |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c         |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c      |  2 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c     |  2 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c       |  2 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt8183-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mt8183.c              |  2 +-
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c   |  6 ++----
 drivers/clk/mediatek/clk-mt8186-cam.c          |  2 +-
 drivers/clk/mediatek/clk-mt8186-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c |  2 +-
 drivers/clk/mediatek/clk-mt8186-infra_ao.c     |  2 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c          |  2 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c          |  6 ++----
 drivers/clk/mediatek/clk-mt8186-mdp.c          |  2 +-
 drivers/clk/mediatek/clk-mt8186-mfg.c          |  2 +-
 drivers/clk/mediatek/clk-mt8186-mm.c           |  6 ++----
 drivers/clk/mediatek/clk-mt8186-topckgen.c     |  2 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt8186-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-aud.c          |  6 +++---
 drivers/clk/mediatek/clk-mt8192-cam.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c |  2 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c          |  2 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c         |  2 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c     |  2 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt8192-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mt8192.c              |  2 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c   |  6 ++----
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c   |  6 ++----
 drivers/clk/mediatek/clk-mt8195-cam.c          |  2 +-
 drivers/clk/mediatek/clk-mt8195-ccu.c          |  2 +-
 drivers/clk/mediatek/clk-mt8195-img.c          |  2 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c |  2 +-
 drivers/clk/mediatek/clk-mt8195-infra_ao.c     |  2 +-
 drivers/clk/mediatek/clk-mt8195-ipe.c          |  2 +-
 drivers/clk/mediatek/clk-mt8195-mfg.c          |  2 +-
 drivers/clk/mediatek/clk-mt8195-peri_ao.c      |  2 +-
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c     |  2 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c     |  6 ++----
 drivers/clk/mediatek/clk-mt8195-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c         |  6 ++----
 drivers/clk/mediatek/clk-mt8195-vdo1.c         |  6 ++----
 drivers/clk/mediatek/clk-mt8195-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mt8195-vpp0.c         |  6 ++----
 drivers/clk/mediatek/clk-mt8195-vpp1.c         |  6 ++----
 drivers/clk/mediatek/clk-mt8195-wpe.c          |  2 +-
 drivers/clk/mediatek/clk-mt8365-apu.c          |  2 +-
 drivers/clk/mediatek/clk-mt8365-cam.c          |  2 +-
 drivers/clk/mediatek/clk-mt8365-mfg.c          |  2 +-
 drivers/clk/mediatek/clk-mt8365-vdec.c         |  2 +-
 drivers/clk/mediatek/clk-mt8365-venc.c         |  2 +-
 drivers/clk/mediatek/clk-mtk.c                 |  4 +---
 drivers/clk/mediatek/clk-mtk.h                 |  2 +-
 drivers/clk/mmp/clk-audio.c                    |  6 ++----
 drivers/clk/mvebu/armada-37xx-periph.c         |  6 ++----
 drivers/clk/mvebu/armada-37xx-tbg.c            |  6 ++----
 drivers/clk/mvebu/armada-37xx-xtal.c           |  6 ++----
 drivers/clk/qcom/apcs-msm8916.c                |  6 ++----
 drivers/clk/qcom/apcs-sdx55.c                  |  6 ++----
 drivers/clk/qcom/clk-rpm.c                     |  5 ++---
 drivers/clk/qcom/gcc-msm8960.c                 |  6 ++----
 drivers/clk/renesas/rcar-usb2-clock-sel.c      |  6 ++----
 drivers/clk/samsung/clk-exynos-audss.c         |  6 ++----
 drivers/clk/samsung/clk-exynos-clkout.c        |  6 ++----
 drivers/clk/stm32/clk-stm32mp13.c              |  6 ++----
 drivers/clk/tegra/clk-dfll.c                   |  5 ++++-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c     | 17 ++++++++---------
 drivers/clk/ti/adpll.c                         |  6 ++----
 drivers/clk/uniphier/clk-uniphier-core.c       |  6 ++----
 drivers/clk/x86/clk-fch.c                      |  7 +++----
 drivers/clk/x86/clk-pmc-atom.c                 |  5 ++---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c     |  6 ++----
 drivers/clk/xilinx/xlnx_vcu.c                  |  8 ++------
 159 files changed, 234 insertions(+), 335 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.1

