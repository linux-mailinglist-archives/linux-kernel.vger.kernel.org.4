Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9F747659
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGDQVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B9DA;
        Tue,  4 Jul 2023 09:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C25361122;
        Tue,  4 Jul 2023 16:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B172EC433C7;
        Tue,  4 Jul 2023 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688487690;
        bh=lrDEfOxpJ7GX6Fx1i997/kDOIhebon6+/gPpEyOh1VU=;
        h=From:To:Cc:Subject:Date:From;
        b=A4GsQE3q9wNnH1qOmChS4U7d2t1Mj24mXAc1u3uYIbu4RTt1PsYB7gdT9fWgx+Tno
         Ab9u3Alxto8welF2+QF1BjG6Z6kuUfFUxKm8tQR6lwp1vOUn6H9/HoBEtS5ov2mDi5
         2vgxCBhb8QXbFjz5S6GxTYMDEy6nuqSGWtFdcjDNC5RVPJue0m/mByfiWDFzxioVY8
         9nIyxC5Om+OG+1zjPwv2Itl3nKtbeGlKpkdKXxMp8cF/jA20qmLQB8wetBiEZfvMkh
         J4VawWlCXVp70hf8dzqMoUAb83WqltOnJsx5HJ0oZBZ+0Cu46aR/w8PfJEEV/rKZ+9
         9kdqzbGLQ6C+g==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] More clk changes for the merge window
Date:   Tue,  4 Jul 2023 09:21:28 -0700
Message-ID: <20230704162129.46794-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9a40506a2cb626da3f21c6d494a76879e3141d7:

  Merge branches 'clk-imx', 'clk-microchip', 'clk-cleanup', 'clk-bindings', 'clk-ti' and 'clk-kasprintf' into clk-next (2023-06-26 08:55:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to f679e89acdd3e825995a84b1b07e2ea33ea882ee:

  clk: tegra: Avoid calling an uninitialized function (2023-07-04 08:54:37 -0700)

----------------------------------------------------------------
Another set of clk driver updates and fixes for the merge window. The
driver updates needed more time to bake in linux-next.

Updates:
 - Support for more clk controllers in Qualcomm SoCs such as SM8350,
   SM8450, SDX75, SC8280XP, and IPQ9574
 - Runtime PM enablement of some more Qualcomm clk controllers
 - Various fixes to Qualcomm clk driver data to use correct clk_ops
   and to check halt bits properly
 - AT91 updates to modernize with clk_parent_data structures

Fixes:
 - Remove "syscon" from dt binding fix for ti,j721e-system-controller
 - Fix determine rate in the Tegra driver that got wrecked by the
   refactorting of muxes this merge window

----------------------------------------------------------------
Andrew Davis (1):
      dt-bindings: mfd: ti,j721e-system-controller: Remove syscon from example

Anusha Rao (1):
      clk: qcom: gcc-ipq9574: Enable crypto clocks

Arnd Bergmann (1):
      clk: qcom: gcc-ipq6018: remove duplicate initializers

Bjorn Andersson (7):
      dt-bindings: clock: qcom: Accept power-domains for GPUCC
      Merge branch '20230413-topic-lahaina_vidcc-v4-1-86c714a66a81@linaro.org' into HEAD
      Merge branch '20230524140656.7076-2-quic_tdas@quicinc.com' into HEAD
      Merge branch '20230512122347.1219-3-quic_tdas@quicinc.com' into clk-for-6.5
      Merge branch 'sm8450-sm8550-gpucc-binding' into clk-for-6.5
      Merge branch '20230526161129.1454-2-quic_anusha@quicinc.com' into clk-for-6.5
      Merge branch '20230608125315.11454-2-srinivas.kandagatla@linaro.org' into clk-for-6.5

Christian Marangi (2):
      clk: qcom: gcc-ipq6018: drop redundant F define
      clk: qcom: gcc-sdm660: drop redundant F define

Claudiu Beznea (11):
      clk: at91: clk-main: add support for parent_data/parent_hw
      clk: at91: clk-generated: add support for parent_hw
      clk: at91: clk-master: add support for parent_hw
      clk: at91: clk-peripheral: add support for parent_hw
      clk: at91: clk-programmable: add support for parent_hw
      clk: at91: clk-system: add support for parent_hw
      clk: at91: clk-utmi: add support for parent_hw
      clk: at91: clk-sam9x60-pll: add support for parent_hw
      clk: at91: sckc: switch to parent_data/parent_hw
      clk: at91: sama7g5: switch to parent_hw and parent_data
      clk: at91: sama7g5: s/ep_chg_chg_id/ep_chg_id

Devi Priya (5):
      dt-bindings: clock: qcom,ipq9574-gcc: Add maintainer
      clk: qcom: gcc-ipq9574: Clean up included headers
      clk: qcom: gcc-ipq9574: constify struct clk_init_data
      dt-bindings: clock: qcom,a53pll: add IPQ9574 compatible
      clk: qcom: apss-ipq-pll: Add support for IPQ9574

Dmitry Baryshkov (3):
      clk: qcom: mmcc-msm8974: remove oxili_ocmemgx_clk
      clk: qcom: mmcc-msm8974: use clk_rcg2_shared_ops for mdp_clk_src clock
      clk: qcom: mmcc-msm8974: fix MDSS_GDSC power flags

Imran Shaik (4):
      clk: qcom: branch: Extend the invert logic for branch2 clocks
      dt-bindings: clock: qcom: Add RPMHCC for SDX75
      clk: qcom: rpmh: Add RPMH clocks support for SDX75
      clk: qcom: Add GCC driver support for SDX75

Jagadeesh Kona (4):
      clk: qcom: clk-alpha-pll: Add support to configure PLL_TEST_CTL_U2
      dt-bindings: clock: qcom: Add SM8550 video clock controller
      clk: qcom: videocc-sm8550: Add video clock controller driver for SM8550
      clk: qcom: gpucc-sm8550: Add support for graphics clock controller

Kathiravan T (3):
      clk: qcom: gcc: ipq5332: Use floor ops for SDCC clocks
      clk: qcom: ipq5332: fix the src parameter in ftbl_gcc_apss_axi_clk_src
      clk: qcom: ipq5332: fix the order of SLEEP_CLK and XO clock

Konrad Dybcio (18):
      clk: qcom: smd-rpm: Keep one rpm handle for all clocks
      clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
      clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
      clk: qcom: smd-rpm: Make BI_TCXO_AO critical
      dt-bindings: clock: Add SM8350 VIDEOCC
      clk: qcom: Introduce SM8350 VIDEOCC
      clk: qcom: gcc-qcm2290: Mark RCGs shared where applicable
      clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling
      clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling
      clk: qcom: rcg2: Make hw_clk_ctrl toggleable
      clk: qcom: gcc-sm8450: Enable hw_clk_ctrl
      clk: qcom: Add support for SM8450 GPUCC
      clk: qcom: clk-alpha-pll: Add a way to update some bits of test_ctl(_hi)
      clk: qcom: gcc-sm6115: Add missing PLL config properties
      dt-bindings: clock: sm6375-gpucc: Add VDD_GX
      clk: qcom: gpucc-sm6375: Enable runtime pm
      clk: qcom: gpucc-sc8280xp: Add runtime PM
      clk: qcom: gcc-sc8280xp: Add runtime PM

Krzysztof Kozlowski (5):
      dt-bindings: clock: qcom,gcc-msm8953: split to separate schema
      clk: qcom: restrict drivers per ARM/ARM64
      dt-bindings: clock: qcom,gcc-sm8250: add missing bi_tcxo_ao clock
      dt-bindings: clock: qcom,gcc-sc7180: document CX power domain
      dt-bindings: clock: qcom,gcc-sc7280: document CX power domain

Luca Weiss (2):
      clk: qcom: smd-rpm: conditionally enable scaling before doing handover
      dt-bindings: clock: qcom,mmcc: define clocks/clock-names for MSM8226

Mantas Pucka (1):
      clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks

Robert Marko (2):
      clk: qcom: gcc-ipq6018: update UBI32 PLL
      clk: qcom: ipq6018: fix networking resets

Srinivas Kandagatla (2):
      clk: qcom: Add lpass clock controller driver for SC8280XP
      clk: qcom: Add lpass audio clock controller driver for SC8280XP

Stephen Boyd (3):
      Merge tag 'qcom-clk-for-6.5-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge tag 'clk-microchip-6.5-2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-microchip
      Merge branches 'clk-qcom' and 'clk-microchip' into clk-next

Taniya Das (2):
      clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
      clk: qcom: videocc-sm8450: Add video clock controller driver for SM8450

Thierry Reding (1):
      clk: tegra: Avoid calling an uninitialized function

 .../devicetree/bindings/clock/qcom,a53pll.yaml     |    1 +
 .../bindings/clock/qcom,gcc-msm8953.yaml           |   73 +
 .../devicetree/bindings/clock/qcom,gcc-other.yaml  |    1 -
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |    7 +
 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |    7 +
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |    5 +-
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |    3 +
 .../bindings/clock/qcom,ipq9574-gcc.yaml           |    1 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |   32 +-
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml      |   60 +
 .../devicetree/bindings/clock/qcom,sdx75-gcc.yaml  |   65 +
 .../bindings/clock/qcom,sm6375-gpucc.yaml          |   15 +
 .../bindings/clock/qcom,sm8350-videocc.yaml        |   68 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |   75 +
 .../bindings/clock/qcom,sm8450-videocc.yaml        |   79 +
 .../bindings/mfd/ti,j721e-system-controller.yaml   |    2 +-
 drivers/clk/at91/at91rm9200.c                      |   14 +-
 drivers/clk/at91/at91sam9260.c                     |   14 +-
 drivers/clk/at91/at91sam9g45.c                     |   16 +-
 drivers/clk/at91/at91sam9n12.c                     |   14 +-
 drivers/clk/at91/at91sam9rl.c                      |   14 +-
 drivers/clk/at91/at91sam9x5.c                      |   20 +-
 drivers/clk/at91/clk-generated.c                   |   11 +-
 drivers/clk/at91/clk-main.c                        |   32 +-
 drivers/clk/at91/clk-master.c                      |   28 +-
 drivers/clk/at91/clk-peripheral.c                  |   22 +-
 drivers/clk/at91/clk-programmable.c                |   11 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |   17 +-
 drivers/clk/at91/clk-system.c                      |   12 +-
 drivers/clk/at91/clk-utmi.c                        |   24 +-
 drivers/clk/at91/dt-compat.c                       |   23 +-
 drivers/clk/at91/pmc.h                             |   36 +-
 drivers/clk/at91/sam9x60.c                         |   20 +-
 drivers/clk/at91/sama5d2.c                         |   20 +-
 drivers/clk/at91/sama5d3.c                         |   16 +-
 drivers/clk/at91/sama5d4.c                         |   18 +-
 drivers/clk/at91/sama7g5.c                         |  796 +++---
 drivers/clk/at91/sckc.c                            |   75 +-
 drivers/clk/qcom/Kconfig                           |  132 +
 drivers/clk/qcom/Makefile                          |    7 +
 drivers/clk/qcom/apss-ipq-pll.c                    |   19 +
 drivers/clk/qcom/camcc-sc7180.c                    |   19 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |   21 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    3 +
 drivers/clk/qcom/clk-branch.c                      |    6 +-
 drivers/clk/qcom/clk-rcg.h                         |    2 +
 drivers/clk/qcom/clk-rcg2.c                        |    2 +
 drivers/clk/qcom/clk-rpmh.c                        |   19 +
 drivers/clk/qcom/clk-smd-rpm.c                     |   58 +-
 drivers/clk/qcom/dispcc-qcm2290.c                  |   12 +-
 drivers/clk/qcom/gcc-ipq5332.c                     |    6 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |   45 +-
 drivers/clk/qcom/gcc-ipq9574.c                     |  506 ++--
 drivers/clk/qcom/gcc-qcm2290.c                     |   62 +-
 drivers/clk/qcom/gcc-sc8280xp.c                    |   18 +-
 drivers/clk/qcom/gcc-sdm660.c                      |    2 -
 drivers/clk/qcom/gcc-sdx75.c                       | 2970 ++++++++++++++++++++
 drivers/clk/qcom/gcc-sm6115.c                      |    8 +
 drivers/clk/qcom/gcc-sm8450.c                      |   39 +
 drivers/clk/qcom/gpucc-sc8280xp.c                  |   19 +-
 drivers/clk/qcom/gpucc-sm6375.c                    |   19 +-
 drivers/clk/qcom/gpucc-sm8450.c                    |  766 +++++
 drivers/clk/qcom/gpucc-sm8550.c                    |  611 ++++
 drivers/clk/qcom/lpasscc-sc8280xp.c                |   87 +
 drivers/clk/qcom/mmcc-msm8974.c                    |   23 +-
 drivers/clk/qcom/videocc-sm8350.c                  |  552 ++++
 drivers/clk/qcom/videocc-sm8450.c                  |  463 +++
 drivers/clk/qcom/videocc-sm8550.c                  |  470 ++++
 drivers/clk/tegra/clk-tegra-super-cclk.c           |   15 +-
 include/dt-bindings/clock/qcom,ipq9574-gcc.h       |    4 +
 include/dt-bindings/clock/qcom,sc8280xp-lpasscc.h  |   17 +
 include/dt-bindings/clock/qcom,sdx75-gcc.h         |  193 ++
 include/dt-bindings/clock/qcom,sm8350-videocc.h    |   35 +
 include/dt-bindings/clock/qcom,sm8450-gpucc.h      |   48 +
 include/dt-bindings/clock/qcom,sm8450-videocc.h    |   38 +
 include/dt-bindings/clock/qcom,sm8550-gpucc.h      |   48 +
 include/dt-bindings/reset/qcom,ipq9574-gcc.h       |    1 +
 include/dt-bindings/reset/qcom,sm8350-videocc.h    |   18 +
 include/dt-bindings/reset/qcom,sm8450-gpucc.h      |   20 +
 80 files changed, 8275 insertions(+), 876 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-msm8953.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdx75-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sdx75.c
 create mode 100644 drivers/clk/qcom/gpucc-sm8450.c
 create mode 100644 drivers/clk/qcom/gpucc-sm8550.c
 create mode 100644 drivers/clk/qcom/lpasscc-sc8280xp.c
 create mode 100644 drivers/clk/qcom/videocc-sm8350.c
 create mode 100644 drivers/clk/qcom/videocc-sm8450.c
 create mode 100644 drivers/clk/qcom/videocc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-lpasscc.h
 create mode 100644 include/dt-bindings/clock/qcom,sdx75-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8350-videocc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8450-gpucc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8450-videocc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gpucc.h
 create mode 100644 include/dt-bindings/reset/qcom,sm8350-videocc.h
 create mode 100644 include/dt-bindings/reset/qcom,sm8450-gpucc.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
