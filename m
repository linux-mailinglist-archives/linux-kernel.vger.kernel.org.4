Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038F56F388B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjEATzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjEATzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:55:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB892107;
        Mon,  1 May 2023 12:55:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so42675000a12.0;
        Mon, 01 May 2023 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970930; x=1685562930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R11iQvyL03GOSrYQIrHHw/DmH/A/XUw7XINQmYhJ5NI=;
        b=peWCZZYGT1AxSPcYux7QrLuiRkQhYXkjUJi2FuQArobYQoTn9v/kN8dB6TUmneJdcv
         /J+B22IzwHKPMifbMPXags92ZjQ/27VqZZxuChSpgYst6yJIFxKWVMlLTy9qjyU3RuRK
         QPgU0Y4ClZhElCWA39agtUqu85kBdch4q3q5V6LnioZG+lUY5vdcvqtx6dCLfiYJC0rj
         OwSm2gxKMNsZvzsh3OW5dQuMJCiUsE7/uqN9e2rNUigdFX61s/2viP/+Bl0LF19hRR7o
         OywWxt9pKI63y636RxrmssOcsqxlaNP4czqX4Fi/IicxU7Xt0mS0IA1A31rAmOinGYc0
         qc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970930; x=1685562930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R11iQvyL03GOSrYQIrHHw/DmH/A/XUw7XINQmYhJ5NI=;
        b=Qwzmvqy048MOOD7f5radSzJhSlTXhhFdLeX8n3UCHKJcGo/9FHeV6QZQIIZpO7F00T
         NvBelyxE1zwxSFLoeMLfK/xh9Nek6rKgdtga/On9IzH+i7mXN5suew9rKHZ4kgFNdvUI
         Y37GSe7mcmcXQz7rNSPtm5mSar4GGbdLK7q1dZkdkp0Aqh5K0Yde0np6cZtnP+YTAr2H
         aO/aelL53cdP2LZ/uZPw90fCHoJIv9z6P/ec0OJziRpcUivmXwBIsu1iYxbg+NKf11GD
         2kk62H7yONN8Yf+kdUS7pWR2eTQzpWYrJmk9uOzmiHNLtK4RDq8jANS0tH0aNkc46+Dl
         IoTA==
X-Gm-Message-State: AC+VfDyPhiJCKetZvNAWl29Ggn1DbmwIaMWGtdh7vLs/PBDCAZq5+3cE
        VCHl4u8y1PLgA14mWh9PHKg=
X-Google-Smtp-Source: ACHHUZ4IveGs8ii8zhWZnuM7WomrlcQtno4lmtlx1/IanE/Cp9xLGFa/d5MzJoharVEa0KYhmSCi9A==
X-Received: by 2002:a17:907:9285:b0:95f:969e:dc5a with SMTP id bw5-20020a170907928500b0095f969edc5amr15852297ejc.30.1682970930448;
        Mon, 01 May 2023 12:55:30 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:29 -0700 (PDT)
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
Subject: [PATCH v3 00/13] Re-introduce Exynos4212 support and add Samsung Galaxy Tab 3 8.0 boards
Date:   Mon,  1 May 2023 21:55:12 +0200
Message-Id: <20230501195525.6268-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
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
 - USB, fuel gauge, charging
 - Accelerometer and magnetometer
 - WiFi model only: light sensor

Display panel bindings used by the Tab3 DTSI are added in a separate
patchset - "[PATCH 0/3] Add Samsung S6D7AA0 panel controller driver":
https://lore.kernel.org/all/20230501185103.25939-1-aweber.kernel@gmail.com/

LP855X binding updates used by the Tab3 DTSI are added in a separate
patchset - "[PATCH 0/4] video: backlight: lp855x: modernize bindings":
https://lore.kernel.org/all/20230429104534.28943-1-aweber.kernel@gmail.com/

Changed in v2:
 - Added note about display panel bindings to cover letter and
   Tab3 DTSI commit

Changed in v3:
 - Addressed review comments
 - Tab3 DTS tweaks (remove broken RTC, add CPU thermal node)
 - Fixed typos in Exynos DTSIs

Artur Weber (13):
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
  ARM: dts: exynos: Fix some typos in comments
  dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
  ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards

 .../bindings/arm/samsung/samsung-boards.yaml  |   10 +
 .../bindings/clock/samsung,exynos-clock.yaml  |    1 +
 .../bindings/soc/samsung/exynos-pmu.yaml      |    5 +
 arch/arm/boot/dts/Makefile                    |    3 +
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi     |    4 +-
 arch/arm/boot/dts/exynos3250.dtsi             |    2 +-
 arch/arm/boot/dts/exynos4.dtsi                |    2 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi     |    4 +-
 arch/arm/boot/dts/exynos4212-tab3-3g8.dts     |   29 +
 arch/arm/boot/dts/exynos4212-tab3-lte8.dts    |   44 +
 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts   |   26 +
 arch/arm/boot/dts/exynos4212-tab3.dtsi        | 1171 +++++++++++++++++
 arch/arm/boot/dts/exynos4212.dtsi             |  157 +++
 arch/arm/boot/dts/exynos4412.dtsi             |  646 +--------
 ...2-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} |    6 +-
 .../dts/{exynos4412.dtsi => exynos4x12.dtsi}  |  165 +--
 arch/arm/boot/dts/exynos5.dtsi                |    2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi     |    4 +-
 arch/arm/boot/dts/exynos5250.dtsi             |    2 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi     |    2 +-
 arch/arm/boot/dts/exynos5410.dtsi             |    2 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi     |    2 +-
 arch/arm/boot/dts/exynos5420.dtsi             |    2 +-
 arch/arm/boot/dts/exynos5800.dtsi             |    2 +-
 arch/arm/boot/dts/s3c6400.dtsi                |    2 +-
 arch/arm/boot/dts/s3c6410.dtsi                |    2 +-
 arch/arm/boot/dts/s3c64xx.dtsi                |    2 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi        |    2 +-
 arch/arm/boot/dts/s5pv210.dtsi                |    2 +-
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
 44 files changed, 1534 insertions(+), 837 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-3g8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-lte8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3-wifi8.dts
 create mode 100644 arch/arm/boot/dts/exynos4212-tab3.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
 rename arch/arm/boot/dts/{exynos4412-pinctrl.dtsi => exynos4x12-pinctrl.dtsi} (99%)
 copy arch/arm/boot/dts/{exynos4412.dtsi => exynos4x12.dtsi} (81%)


base-commit: e154a338e16cc3b3bbd54c891253319d22383746
-- 
2.40.1

