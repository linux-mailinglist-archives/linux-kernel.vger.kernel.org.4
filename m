Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198EA67FF94
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjA2Ojw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2Ojv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:39:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A94583E0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:39:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l35-20020a05600c1d2300b003dc4634a466so2375125wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/xwwbOs7efGaQMD0UIaeGQeP0AwlUSs0l695B7gQqs=;
        b=H37AxqvpkcQPDY31nuqRg2AOOocJfGxNxKC58KcEuQOl088wgsSKto7c4b2NNC+yWW
         KBf01la7BInnT9ieP8DrFMYnPnL0AT34srYjpVYDIC25GsL9Vzku0u/EOGjyIDg5Vgsb
         sG/IIs9loCETu/2kyIPrhK0fH0Ag+7CH2p+0LQNnflIWziqg2Jr91jfir9JvuL+gsLM4
         bUslMG33lFQxVjyxIQprAF2nETIUxBFx9byKCH0PxkA+7R21ul+fkgvaPepETkdnamQ8
         JyxXajHCJvmF86109hiJRXXAfd7y/4uk+kYUFMlg3zcz5KAVkoP8GWB1l/mlY9wro37N
         O6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/xwwbOs7efGaQMD0UIaeGQeP0AwlUSs0l695B7gQqs=;
        b=Be5h8frfrM60rLAxNRoJX4uoETLj//aDuUf1sClNXNGszyi7UzbmG3ovOn5ViOuXsH
         xpGCss6SozgSQEfkBKFSzo3iaLUwqWF4mSEMO+UaM2u4v54RJaJbiWAcM1LbYaH1mQ9l
         VY2ElA/tAH9LRf0U+Ffowkl8ga8Dm5zcPWqVbdzMm4Ip7zPgD8Hs9I7zUsqfdNMtWGIT
         LMtKcVxM49Cx4jyDg1DH9TMlaNgqFp6onjJQFQjglaiXcelgNS6CtPOW4oNEIN+pRDxG
         F3vxdhNKvzMH2Pusa2ReTi/BNs7eFKsY0m1a3IeoaDyokk8XXqHyCdDMwGyHUZu47MVr
         EJZQ==
X-Gm-Message-State: AO0yUKXJG9T208FibZsT82nIeNuKmsp3TOakxRUIDTfT9OelUvB2WCyC
        tkFpNpi3ocv0Qgf+YaXeJ48LTgLX9TzSsQCI
X-Google-Smtp-Source: AK7set82BeaboxstGi6b9jRgXk4CsYI4beNgiDWOusTguSgRBlIDNkQyRbiYOh9/lkWhcJL+jDkl7g==
X-Received: by 2002:a05:600c:4f93:b0:3dc:2b62:ee9f with SMTP id n19-20020a05600c4f9300b003dc2b62ee9fmr12897820wmq.3.1675003188063;
        Sun, 29 Jan 2023 06:39:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db0bb81b6asm10477843wmb.1.2023.01.29.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:39:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/3] ARM: dts: samsung: exynos for v6.3
Date:   Sun, 29 Jan 2023 15:39:42 +0100
Message-Id: <20230129143944.5104-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-6.3

for you to fetch changes up to 27be20e3b9d125f2c1b066d1d238c67bf5b89dc3:

  ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos54xx (2023-01-29 11:34:12 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v6.3

1. Big cleanup and rework towards achieving zero-warning of dtbs_check
   and dtc W=1:
    - align node names with the bindings,
    - drop or correct incorrect properties in several boards,
    - correct HDMI bridge ports nodes on Exynos4412 Midas,
    - add dummy regulator supplies when necessary to fullfil bindings
      requirements,
    - use lowercase hex,
    - move non-MMIO exynos-bus nodes out of soc node,
    - add unit address to USB DWC3 nodes.

2. Correct Exynos5420 MIPI DSI and phy compatibles.
3. Correct Exynos4210 and Exynos4412 HDMI phy compatibles.
4. Add Samsung Galaxy S5 (SM-G900H) board.

----------------------------------------------------------------
Krzysztof Kozlowski (23):
      ARM: dts: exynos: drop unused pinctrl-names from Galaxy Tab
      ARM: dts: exynos: align OPP table names with DT schema
      ARM: dts: exynos: drop incorrect power-supplies in P4 Note
      ARM: dts: exynos: correct wr-active property in Exynos3250 Rinato
      ARM: dts: exynos: drop unsupported desc-num in Exynos3250
      ARM: dts: exynos: correct cd-gpios property in Exynos4412 Itop Elite
      ARM: dts: exynos: align pin node names in Exynos4412
      ARM: dts: exynos: add ports in HDMI bridge in Exynos4412 Midas
      ARM: dts: exynos: add panel supply in Tiny4412
      ARM: dts: exynos: add backlight supply in P4 Note
      ARM: dts: exynos: align HSOTG/USB node names
      ARM: dts: exynos: correct SATA clocks in Exynos5250
      ARM: dts: exynos: correct HS200 property in Exynos5260
      ARM: dts: exynos: correct HSI2C properties in Exynos5410 Odroid XU
      ARM: dts: exynos: correct HDMI phy compatible in Exynos4
      ARM: dts: exynos: use generic node names for phy
      ARM: dts: exynos: use lowercase hex addresses
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos5420
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos3250
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos4210
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos4412
      ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos5250
      ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos54xx

Markuss Broks (4):
      ARM: dts: exynos: Use Exynos5420 compatible for the MIPI video phy
      ARM: dts: exynos: Use Exynos5422 compatible for the DSI controller
      dt-bindings: arm: samsung: Add compatible for Samsung Galaxy S5 (SM-G900H)
      ARM: dts: exynos: Add Samsung Galaxy S5 (SM-G900H) board

 .../bindings/arm/samsung/samsung-boards.yaml       |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos-syscon-restart.dtsi       |   2 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |   3 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   5 +-
 arch/arm/boot/dts/exynos3250.dtsi                  | 386 ++++++------
 arch/arm/boot/dts/exynos4.dtsi                     |  66 +-
 arch/arm/boot/dts/exynos4210.dtsi                  | 326 +++++-----
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |   2 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |   2 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |  15 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |   2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |   2 +-
 arch/arm/boot/dts/exynos4412-p4note.dtsi           |   7 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          |   2 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |   8 +
 arch/arm/boot/dts/exynos4412.dtsi                  | 381 ++++++------
 arch/arm/boot/dts/exynos5.dtsi                     |  22 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |  84 +--
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   2 +-
 arch/arm/boot/dts/exynos5260.dtsi                  |  36 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |   3 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   2 +-
 .../arm/boot/dts/exynos5420-galaxy-tab-common.dtsi |   1 -
 arch/arm/boot/dts/exynos5420.dtsi                  | 299 +++++----
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  34 +-
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts       | 674 +++++++++++++++++++++
 arch/arm/boot/dts/exynos54xx.dtsi                  |  16 +-
 arch/arm/boot/dts/exynos5800.dtsi                  |   4 +
 32 files changed, 1541 insertions(+), 853 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-samsung-k3g.dts
