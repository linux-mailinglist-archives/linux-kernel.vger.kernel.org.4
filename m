Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4774B27D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGGOEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGGOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:04:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA31B6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:04:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso29240561fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688738683; x=1691330683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88gx2ArfJ8Bxr8mIoRR0FgqnPsJWgGVl+Nuwk9G+FUc=;
        b=X7O2rSaamBeFWzwtKPt/YjkNPPV0gyZQQV/pVUJtc8fPkGGKg4CMj9SsxzBeCDgrLk
         xpmDpmuhvnomweri/SOLdscmZpKZDtr+6er14XRtIbZKzoL+jsjIl8OU+jkYXFJBJanM
         2SnckLh76D96pL616RTM9Yp0sTY3/BQ/YKKd4EBFbavCli91mgXTx3x3Cn5Oyi2YKrGw
         2eZsxwxxJ7Z9bDEaBTmYuQvewd+IDLh0dG0UUtZr9Z9rMl9kU0n95rTW2Z2dKUq6tv1n
         wxV3zXcktple857v2/B0tVvdgWLfbO6zz2WHHcu1Dc6jo4hFhceXnwT2MpYXd9xIGNnK
         WWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738683; x=1691330683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88gx2ArfJ8Bxr8mIoRR0FgqnPsJWgGVl+Nuwk9G+FUc=;
        b=fFIdp5olM8mC9g2a8f/4sO1Cvfh0eTF+yDVypkLzLGZ9di9YikNYR8YpDETcxBv2VH
         tJMDIxw167Pplfep3rmHNJsqoqi82kmfUKN5ypzYhgbg9XZIEBY0HmEqkCQn58WwPtkD
         sp7Vs4N0bOo2MHEfmKEB8cz06Zsc9owKNjHGS4caRUpgVtwU354wpgLLDqt5p4Y/NwDi
         kowpkGQ9wcp6xJGjnd7aCuu5Y98awKVVWVQCsVo2UtLCqe3HmuDfpzm+3sSFHZykmt3Q
         yJ1Flc4i1mCLlN6eb5A6hKN5zu7l6+4iodmXNwBphlQ71a0RQXso2XVsP8EZhwuZTARE
         0Yyw==
X-Gm-Message-State: ABy/qLaTHnsYC3oBceKWtCCweJ0gzVlUvfJp8M66TGsBXoqGrmytzJs+
        CBTLTkIP4e6Y9NNnWsXt/XznaYmAdMDTrAKXqN8=
X-Google-Smtp-Source: APBJJlEUohzdcBzB7F6kjERo1qFuOudM/LmdQKsvUEQzjW+K1zD9P+syL6FmpFEvDc88dWDY8dTKZQ==
X-Received: by 2002:a2e:7d15:0:b0:2b6:d7a0:c27d with SMTP id y21-20020a2e7d15000000b002b6d7a0c27dmr3661211ljc.37.1688738682600;
        Fri, 07 Jul 2023 07:04:42 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id u21-20020a2e8555000000b002b6cb25e3f1sm760341ljj.108.2023.07.07.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:04:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/18] genpd: Create a genpd directory to host genpd providers
Date:   Fri,  7 Jul 2023 16:04:16 +0200
Message-Id: <20230707140434.723349-1-ulf.hansson@linaro.org>
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

There are currently ~60 users of the genpd provider interface, which
implementations are sprinkled across various subsystems. To help out with
maintenance and to gain a bit better control, let's create a new subsystem
(drivers/genpd) and move some of the providers from the soc directories in here.

Clearly some providers aren't really feasible to move - and that's perfectly
fine too. We don't need to keep all genpd providers together to improve the
situation, but keeping most of them would be nice, I think. At this point I
have walked through driver/soc and /arch/ - deferring others to later.

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
 drivers/soc/Makefile                          |  1 -
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
 107 files changed, 150 insertions(+), 116 deletions(-)
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

