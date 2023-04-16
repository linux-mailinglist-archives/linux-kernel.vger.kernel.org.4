Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB76E38B0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDPNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:35:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C71BD4;
        Sun, 16 Apr 2023 06:35:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so17407047a12.1;
        Sun, 16 Apr 2023 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681652132; x=1684244132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UynXzPPu/DGOhUY3vG4qGCml8HX6Ft9KW/3oejkLCWs=;
        b=FQNN0sb6s9yNnP/CGoXFh3igu4xyIcgaeJPp6zA3NG4A1PMVyPf1FiU2k8/tbyBysw
         FUA+sT19X6zNEqN5kLjgQN3rhf0r04wuIcsXCnlYPJ8p2jbLld2ihtpHCHBMr/sP5Ibe
         49FN7FuuJdWJWH1ofPTtGKAsLruUWcXhAgzump0LmZcFONBwW/sTiu6XJySSG2LM23+O
         ZykDfby1f6p+vgr++p6XK4BoVl6iT6q3cVnKZasmQcbnCuyYHEmh+nku5f2TeFJQ4AaU
         FTQZ0TL74Bp5teic6O3yj/gN5ZDhi3WW8RzJxiwiYN8S+nrgNDkuAtsjOqsqMvqtBRPC
         UNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681652132; x=1684244132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UynXzPPu/DGOhUY3vG4qGCml8HX6Ft9KW/3oejkLCWs=;
        b=B5qgSQsRJ7WMZ3bYn+Cmiu6XvQn3IUD64QJh+Nhsem2kpM3RkNVAecRBFgzaY4ch1Z
         Xn6xCoDKlT7nvuu+/KZ0ljfWp1ehoDlOWUMMIhngI5VNti6J2ERb+w/JXPP8i50BMPSf
         g/lV8ANRcH+yrAkJCriT9AzQqQ7cp6LJWkN4pa/kHZtz+v2Wipis1IQJBfy83oabh7xL
         QL9LTwuabmFCInRMPeNwEpQnArFcD8/VJd/U+r6oXbNYCA2TiEpiD82fyyIyE2B7DVj/
         i94MtlZkav2be+shFW7nPxVCZ8j2K/S8jT7d8sxuEnvFG2+mv5G7Kw2O7JM9s3NMEjGN
         PZoQ==
X-Gm-Message-State: AAQBX9dupZ/7spCYS3VtMlZU1s44BX3FxGX5BRVrn42Fb64nVG0owRmm
        0R+Qqq+H5004rcZJVLOhv0M=
X-Google-Smtp-Source: AKy350asygcBIZsKMBeNku99Cbv7Vlr8EwyySMjH2lM0enYA55icjSyR1KmoiXcM+WoAFrj6uaFcyQ==
X-Received: by 2002:a05:6402:254a:b0:506:771a:60d6 with SMTP id l10-20020a056402254a00b00506771a60d6mr9675333edb.1.1681652131760;
        Sun, 16 Apr 2023 06:35:31 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5122958ejc.161.2023.04.16.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:35:31 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 00/12] Re-introduce Exynos4212 support and add Samsung Galaxy Tab 3 8.0 boards
Date:   Sun, 16 Apr 2023 15:34:10 +0200
Message-Id: <20230416133422.1949-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches re-introduces the Exynos4212 platform and adds support
for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:

 - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
 - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
 - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)

What works:

 - Display and backlight
 - Touchscreen (without touchkeys)
 - GPIO buttons, hall sensor
 - WiFi and Bluetooth
 - USB, fuel gauge, charging (partial)
 - Accelerometer and magnetometer
 - WiFi model only: light sensor

Display panel bindings used by the Tab3 DTSI are added in a separate
patchset - "[PATCH 0/3] Add Samsung S6D7AA0 panel controller driver":
https://lore.kernel.org/all/20230416131632.31673-1-aweber.kernel@gmail.com/

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Changed in v2:
 - Added note about display panel bindings to cover letter and
   Tab3 DTSI commit

Artur Weber (12):
  dt-bindings: soc: samsung: add Exynos4212 PMU compatible
  dt-bindings: clock: add Exynos4212 clock compatible
  ARM: exynos: Re-introduce Exynos4212 support
  soc: samsung: Re-introduce Exynos4212 support
  clk: samsung: Add Exynos4212 compatible to CLKOUT driver
  clk: samsung: Re-add support for Exynos4212 CPU clock
  Revert "media: exynos4-is: Remove dependency on obsolete SoC support"
  Revert "phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB"
  ARM: dts: Move common Exynos4x12 definitions to exynos4x12.dtsi
  ARM: dts: Re-introduce Exynos4212 DTSI
  dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
  ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards

 .../bindings/arm/samsung/samsung-boards.yaml  |   10 +
 .../bindings/clock/samsung,exynos-clock.yaml  |    1 +
 .../bindings/soc/samsung/exynos-pmu.yaml      |    3 +
 arch/arm/boot/dts/Makefile                    |    3 +
 arch/arm/boot/dts/exynos4212-tab3-3g8.dts     |   30 +
 arch/arm/boot/dts/exynos4212-tab3-lte8.dts    |   43 +
 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts   |   25 +
 arch/arm/boot/dts/exynos4212-tab3.dtsi        | 1175 +++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi             |  157 +++
 arch/arm/boot/dts/exynos4412.dtsi             |  645 +--------
 ...2-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} |    4 +-
 arch/arm/boot/dts/exynos4x12.dtsi             |  665 ++++++++++
 arch/arm/mach-exynos/Kconfig                  |    5 +
 arch/arm/mach-exynos/common.h                 |    8 +
 arch/arm/mach-exynos/exynos.c                 |    2 +
 arch/arm/mach-exynos/firmware.c               |    8 +-
 arch/arm/mach-exynos/pm.c                     |    2 +-
 arch/arm/mach-exynos/suspend.c                |    4 +
 drivers/clk/samsung/clk-exynos-clkout.c       |    3 +
 drivers/clk/samsung/clk-exynos4.c             |   44 +-
 .../media/platform/samsung/exynos4-is/Kconfig |    2 +-
 .../platform/samsung/exynos4-is/fimc-core.c   |    2 +-
 .../platform/samsung/exynos4-is/fimc-lite.c   |    2 +-
 drivers/phy/samsung/Kconfig                   |    2 +-
 drivers/soc/samsung/exynos-pmu.c              |    9 +
 drivers/soc/samsung/exynos-pmu.h              |    2 +
 drivers/soc/samsung/exynos4-pmu.c             |   13 +-
 27 files changed, 2213 insertions(+), 656 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-3g8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-lte8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
 rename arch/arm/boot/dts/{exynos4412-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} (99%)
 create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi

-- 
2.40.0

