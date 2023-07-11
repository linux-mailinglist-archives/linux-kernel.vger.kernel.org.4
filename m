Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36F74F1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGKOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGKOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:20:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FF719B4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:20:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so94676591fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085191; x=1691677191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+CYgmHolkAync1UlJLvUE/D+63ljsKfo/5r6pC2w10=;
        b=kzjaO1c70O3pVf9l5/VSb4YqFH5O/hFrYZufjAUOMl/fuLnJpbwPfTa3QWogZMcFBD
         v126eDUW2Gwojy7ZUhGM3RMdIXPhnpCK6vvgOEFBhbDgn9aD2iCJUw95DLKmSZaho67N
         onD0Roo4deTc6N31B60tbdEI1o0WBz8//0DKct0jdQOLiQmC4BM1H2Xk/gdLSsZPWna3
         RwCorTw3OgWkwjeg81xWBFD1ICM3G+jVoOeWPOL19LW0cY4ad+nKHO+c8FZwui9CrWGK
         uULX/nFF9/+CiS5NHRJMW6MfhH6Zc/ZXIkSETVSEBW0pi8zxgcxazB/AVpEuOUfEbQn0
         RR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085191; x=1691677191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+CYgmHolkAync1UlJLvUE/D+63ljsKfo/5r6pC2w10=;
        b=R3/TLsnoaOkFHthjmDkTyBI6YJ7Id/v9qg9b3uMz4JSHV7C4wDTBqGT0WwtMXFh21l
         /T6cG3O6IRgdQwAFxqWwdPwK5q5iWpSVgflCVbOv+tysLpeaIoVKRGbwPwzhOAMaX3MI
         mRDXt5tLbC1fkM7H02/5A2N4f6RxNsIXO5zI+q6JNGXa7TtMlOq+/dx7383JdBTZhUJG
         PZ0Prk84vuGYVjsIcqRTA0IHQmsSwsR6UdPprWScv84tkD2EqT+1T7rYUexfzj69cEJo
         Fjy6wAvJY4R8v7Fdw261cSi6EsPQYg179OupeDX+LR15r+uHlo0bL7+jHhRet7PSMSDq
         vQng==
X-Gm-Message-State: ABy/qLZERTMq3oWGmr7T8Z0FGuzxKngn935EYWk8HoarFvz4OZcYPKA4
        TkfcoqxhImFPGGwWfMGDslNKqA==
X-Google-Smtp-Source: APBJJlF/LR+nllazuN13WQFZw+hmGfA3uUsTPxeq42UKREhp+GU42LRMimV76yJZk2iIMz7NF/R93g==
X-Received: by 2002:a2e:980b:0:b0:2b6:dc55:c3c7 with SMTP id a11-20020a2e980b000000b002b6dc55c3c7mr14201466ljj.20.1689085191259;
        Tue, 11 Jul 2023 07:19:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id v25-20020a2e7a19000000b002b6aebc7909sm480793ljc.81.2023.07.11.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:19:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/18] genpd: Create a genpd directory to host genpd providers
Date:   Tue, 11 Jul 2023 16:19:38 +0200
Message-Id: <20230711141938.751506-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
	- Added/updated commit messages to patch2 - > patch18.
	- Fixed the build for amlogic
	- Added a few tags for acks/reviewed by.
	- Cc all platform/soc maintainers on the cover-letter and patch1.
	- Updated the path to the git tree. The git is now created.
	- Rebased on v6.5-rc1.
	- Update the cover letter a bit.

There are currently ~60 users of the genpd provider interface, which
implementations are sprinkled across various subsystems. To help out with
maintenance and to gain a bit better control, let's create a new subsystem
(drivers/genpd) and move some of the providers from the soc directories in here.

Clearly some providers aren't really feasible to move - and that's perfectly
fine too. We don't need to keep all genpd providers together to improve the
situation, but keeping most of them would be nice, I think. At this point I
have walked through driver/soc and /arch/ - deferring others to later. Moreover,
I am intentionally leaving the Kconfig files in drivers/soc/, as I think it's
better to discuss what to with them separately.

Note that, the intention is also to host a git tree (it's not been created yet,
but should be quick if this seems reasonable to everybody), to collect and to
get the patches tested/integrated through the linux-next tree. Ideally this
should release some of the burden on the soc maintainers (Arnd/Olof/etc).

Note that, going forward - it's probably best to funnel this through the soc
tree (I can send a pull request if agreed) the I can take over in the next
release cycle at v6.6-rc1 and onwards. In that case, I will of course require
acks/reviews from the current platform/soc maintainers, hence the MAINTAINERS
are also being updated as a part of $subject series.

Does this make sense?

Kind regards
Ulf Hansson


Ulf Hansson (18):
  genpd: Create a new subsystem directory to host genpd providers
  soc: actions: Move power-domain driver to the genpd dir
  soc: amlogic: Move power-domain drivers to the genpd dir
  soc: apple: Move power-domain driver to the genpd dir
  soc: bcm: Move power-domain drivers to the genpd dir
  soc: imx: Move power-domain drivers to the genpd dir
  soc: mediatek: Move power-domain drivers to the genpd dir
  soc: qcom: Move power-domain drivers to the genpd dir
  soc: renesas: Move power-domain drivers to the genpd dir
  soc: rockchip: Mover power-domain driver to the genpd dir
  soc: samsung: Move power-domain driver to the genpd dir
  soc: starfive: Move the power-domain driver to the genpd dir
  soc: sunxi: Move power-domain driver to the genpd dir
  soc: tegra: Move powergate-bpmp driver to the genpd dir
  soc: ti: Mover power-domain drivers to the genpd dir
  soc: xilinx: Move power-domain driver to the genpd dir
  ARM: ux500: Convert power-domain code into a regular platform driver
  ARM: ux500: Move power-domain driver to the genpd dir

 MAINTAINERS                                   | 22 ++++++++++----
 arch/arm/mach-ux500/Makefile                  |  1 -
 arch/arm/mach-ux500/cpu-db8500.c              |  5 ----
 arch/arm/mach-ux500/pm_domains.h              | 17 -----------
 drivers/Makefile                              |  1 +
 drivers/genpd/Makefile                        | 16 ++++++++++
 drivers/genpd/actions/Makefile                |  2 ++
 drivers/{soc => genpd}/actions/owl-sps.c      |  0
 drivers/genpd/amlogic/Makefile                |  4 +++
 .../{soc => genpd}/amlogic/meson-ee-pwrc.c    |  0
 .../amlogic/meson-gx-pwrc-vpu.c               |  0
 .../amlogic/meson-secure-pwrc.c               |  0
 drivers/genpd/apple/Makefile                  |  2 ++
 .../apple/pmgr-pwrstate.c}                    |  0
 drivers/genpd/bcm/Makefile                    |  5 ++++
 .../{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c  |  0
 drivers/{soc => genpd}/bcm/bcm2835-power.c    |  0
 .../bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c |  0
 .../{soc => genpd}/bcm/raspberrypi-power.c    |  0
 drivers/genpd/imx/Makefile                    |  7 +++++
 drivers/{soc => genpd}/imx/gpc.c              |  0
 drivers/{soc => genpd}/imx/gpcv2.c            |  0
 drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c   |  0
 drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c  |  0
 drivers/{soc => genpd}/imx/imx93-blk-ctrl.c   |  0
 drivers/{soc => genpd}/imx/imx93-pd.c         |  0
 drivers/genpd/mediatek/Makefile               |  3 ++
 .../mediatek/mt6795-pm-domains.h              |  0
 .../mediatek/mt8167-pm-domains.h              |  0
 .../mediatek/mt8173-pm-domains.h              |  0
 .../mediatek/mt8183-pm-domains.h              |  0
 .../mediatek/mt8186-pm-domains.h              |  0
 .../mediatek/mt8188-pm-domains.h              |  0
 .../mediatek/mt8192-pm-domains.h              |  0
 .../mediatek/mt8195-pm-domains.h              |  0
 .../{soc => genpd}/mediatek/mtk-pm-domains.c  |  0
 .../{soc => genpd}/mediatek/mtk-pm-domains.h  |  0
 drivers/{soc => genpd}/mediatek/mtk-scpsys.c  |  0
 drivers/genpd/qcom/Makefile                   |  4 +++
 drivers/{soc => genpd}/qcom/cpr.c             |  0
 drivers/{soc => genpd}/qcom/rpmhpd.c          |  0
 drivers/{soc => genpd}/qcom/rpmpd.c           |  0
 drivers/genpd/renesas/Makefile                | 30 +++++++++++++++++++
 drivers/{soc => genpd}/renesas/r8a7742-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7743-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7745-sysc.c |  0
 .../{soc => genpd}/renesas/r8a77470-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774a1-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774b1-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774c0-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a774e1-sysc.c    |  0
 drivers/{soc => genpd}/renesas/r8a7779-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7790-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7791-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7792-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7794-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7795-sysc.c |  0
 drivers/{soc => genpd}/renesas/r8a7796-sysc.c |  0
 .../{soc => genpd}/renesas/r8a77965-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77970-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77980-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77990-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a77995-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a779a0-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a779f0-sysc.c    |  0
 .../{soc => genpd}/renesas/r8a779g0-sysc.c    |  0
 .../{soc => genpd}/renesas/rcar-gen4-sysc.c   |  0
 .../{soc => genpd}/renesas/rcar-gen4-sysc.h   |  0
 drivers/{soc => genpd}/renesas/rcar-sysc.c    |  0
 drivers/{soc => genpd}/renesas/rcar-sysc.h    |  0
 drivers/{soc => genpd}/renesas/rmobile-sysc.c |  0
 drivers/genpd/rockchip/Makefile               |  2 ++
 .../rockchip/pm-domains.c}                    |  0
 drivers/genpd/samsung/Makefile                |  2 ++
 .../samsung/exynos-pm-domains.c}              |  0
 drivers/genpd/st/Makefile                     |  2 ++
 .../genpd/st/ste-ux500-pm-domain.c            | 25 ++++++++++++----
 drivers/genpd/starfive/Makefile               |  2 ++
 .../starfive/jh71xx-pmu.c}                    |  0
 drivers/genpd/sunxi/Makefile                  |  2 ++
 drivers/{soc => genpd}/sunxi/sun20i-ppu.c     |  0
 drivers/genpd/tegra/Makefile                  |  2 ++
 drivers/{soc => genpd}/tegra/powergate-bpmp.c |  0
 drivers/genpd/ti/Makefile                     |  3 ++
 drivers/{soc => genpd}/ti/omap_prm.c          |  0
 drivers/{soc => genpd}/ti/ti_sci_pm_domains.c |  0
 drivers/genpd/xilinx/Makefile                 |  2 ++
 .../xilinx/zynqmp-pm-domains.c}               |  0
 drivers/soc/actions/Makefile                  |  1 -
 drivers/soc/amlogic/Makefile                  |  3 --
 drivers/soc/apple/Makefile                    |  2 --
 drivers/soc/bcm/Kconfig                       | 22 +++++++++++++-
 drivers/soc/bcm/Makefile                      |  3 --
 drivers/soc/bcm/bcm63xx/Kconfig               | 21 -------------
 drivers/soc/bcm/bcm63xx/Makefile              |  3 --
 drivers/soc/imx/Makefile                      |  7 +----
 drivers/soc/mediatek/Makefile                 |  2 --
 drivers/soc/qcom/Makefile                     |  3 --
 drivers/soc/renesas/Makefile                  | 27 -----------------
 drivers/soc/rockchip/Makefile                 |  1 -
 drivers/soc/samsung/Makefile                  |  1 -
 drivers/soc/starfive/Makefile                 |  3 --
 drivers/soc/sunxi/Makefile                    |  1 -
 drivers/soc/tegra/Makefile                    |  1 -
 drivers/soc/ti/Makefile                       |  2 --
 drivers/soc/xilinx/Makefile                   |  1 -
 106 files changed, 150 insertions(+), 115 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 drivers/genpd/Makefile
 create mode 100644 drivers/genpd/actions/Makefile
 rename drivers/{soc => genpd}/actions/owl-sps.c (100%)
 create mode 100644 drivers/genpd/amlogic/Makefile
 rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
 create mode 100644 drivers/genpd/apple/Makefile
 rename drivers/{soc/apple/apple-pmgr-pwrstate.c => genpd/apple/pmgr-pwrstate.c} (100%)
 create mode 100644 drivers/genpd/bcm/Makefile
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c (100%)
 rename drivers/{soc => genpd}/bcm/bcm2835-power.c (100%)
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c (100%)
 rename drivers/{soc => genpd}/bcm/raspberrypi-power.c (100%)
 create mode 100644 drivers/genpd/imx/Makefile
 rename drivers/{soc => genpd}/imx/gpc.c (100%)
 rename drivers/{soc => genpd}/imx/gpcv2.c (100%)
 rename drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-pd.c (100%)
 create mode 100644 drivers/genpd/mediatek/Makefile
 rename drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.c (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-scpsys.c (100%)
 create mode 100644 drivers/genpd/qcom/Makefile
 rename drivers/{soc => genpd}/qcom/cpr.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmhpd.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmpd.c (100%)
 create mode 100644 drivers/genpd/renesas/Makefile
 rename drivers/{soc => genpd}/renesas/r8a7742-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7743-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7745-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77470-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774a1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774b1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774c0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774e1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7779-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7790-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7791-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7792-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7794-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7795-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7796-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77965-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77970-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77980-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77990-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77995-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779a0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779f0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779g0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rmobile-sysc.c (100%)
 create mode 100644 drivers/genpd/rockchip/Makefile
 rename drivers/{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c} (100%)
 create mode 100644 drivers/genpd/samsung/Makefile
 rename drivers/{soc/samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c} (100%)
 create mode 100644 drivers/genpd/st/Makefile
 rename arch/arm/mach-ux500/pm_domains.c => drivers/genpd/st/ste-ux500-pm-domain.c (75%)
 create mode 100644 drivers/genpd/starfive/Makefile
 rename drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} (100%)
 create mode 100644 drivers/genpd/sunxi/Makefile
 rename drivers/{soc => genpd}/sunxi/sun20i-ppu.c (100%)
 create mode 100644 drivers/genpd/tegra/Makefile
 rename drivers/{soc => genpd}/tegra/powergate-bpmp.c (100%)
 create mode 100644 drivers/genpd/ti/Makefile
 rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
 rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (100%)
 create mode 100644 drivers/genpd/xilinx/Makefile
 rename drivers/{soc/xilinx/zynqmp_pm_domains.c => genpd/xilinx/zynqmp-pm-domains.c} (100%)
 delete mode 100644 drivers/soc/bcm/bcm63xx/Kconfig
 delete mode 100644 drivers/soc/bcm/bcm63xx/Makefile
 delete mode 100644 drivers/soc/starfive/Makefile

-- 
2.34.1

