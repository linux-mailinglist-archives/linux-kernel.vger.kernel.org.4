Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0356D604E23
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJSRHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJSRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:07:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39341C0703;
        Wed, 19 Oct 2022 10:07:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87595B82565;
        Wed, 19 Oct 2022 17:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF4C433D6;
        Wed, 19 Oct 2022 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666199255;
        bh=HOZtk4W+w1Xim3D+4yZ/unb12q6aclG13DIwl0OBJx8=;
        h=From:To:Cc:Subject:Date:From;
        b=o5kdMxIduRtb8Mzx9YssNawI1DyaXBB8MfOzqsMEeeT6zXexwhScPQLMDkvct+l+T
         rBJiQSzFP7HSq5MKNphjSYJpXdBijhnK+g21hTCNgYtOSZl63X9ynZrDQLOfm1D3SE
         qwpwZMT58udOteGG+rjOotFZRrDtCcSKSebtee43ug4tNnd5YKBgTIYbzxv0T9jPIE
         TWap46K2cZHjxuckg68p33rLCCJgHPYGPnk39z7GeA/3y2dNBJJr6D5KzzB1mJgUcq
         3vOGJuLofNC0SuBcI4+yp6aKrvlSMjhSc2M/tJVz+L9aFxtz2c3cfN5NmWrzF5hX7j
         ayW5CVQhd7lKQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv5 0/6] arm: socfpga: use clk-phase-sd-hs
Date:   Wed, 19 Oct 2022 12:06:51 -0500
Message-Id: <20221019170657.68014-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wanted to address the comments regarding the dt-bindings
document of "altr,sysmgr-syscon". I ran the 'make dt_binding_check'
after: pip3 install dtschema --upgrade and I checked to make sure I have
yamllint installed and I still don't see any warnings. I'm also confused
about whether "altr,socfpga-dw-mshc" should be a const. I see the same
usage in:

Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml

allOf:
  - $ref: "mmc-controller.yaml#"
  - if:
      properties:
        compatible:
          contains:
            const: arasan,sdhci-5.1

Please advise on how to address this comment!

Thanks,
Dinh

Dinh Nguyen (6):
  dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
  arm64: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node
  arm: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node
  mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase
  clk: socfpga: remove the setting of clk-phase for sdmmc_clk
  arm: dts: socfpga: remove "clk-phase" in sdmmc_clk

 .../bindings/mmc/synopsys-dw-mshc.yaml        | 32 ++++++++-
 arch/arm/boot/dts/socfpga.dtsi                |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi        |  2 +-
 .../boot/dts/socfpga_arria10_mercury_aa1.dtsi |  1 +
 .../boot/dts/socfpga_arria10_socdk_sdmmc.dts  |  1 +
 arch/arm/boot/dts/socfpga_arria5.dtsi         |  1 +
 arch/arm/boot/dts/socfpga_cyclone5.dtsi       |  1 +
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   |  1 +
 .../boot/dts/altera/socfpga_stratix10.dtsi    |  1 +
 .../dts/altera/socfpga_stratix10_socdk.dts    |  1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  1 +
 .../boot/dts/intel/socfpga_agilex_socdk.dts   |  1 +
 .../boot/dts/intel/socfpga_n5x_socdk.dts      |  1 +
 drivers/clk/socfpga/clk-gate-a10.c            | 68 -------------------
 drivers/clk/socfpga/clk-gate.c                | 60 ----------------
 drivers/clk/socfpga/clk.h                     |  1 -
 drivers/mmc/host/dw_mmc-pltfm.c               | 43 +++++++++++-
 17 files changed, 83 insertions(+), 135 deletions(-)

-- 
2.25.1

