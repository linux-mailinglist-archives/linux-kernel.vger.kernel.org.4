Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4B6E3716
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjDPKSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDPKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:18:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B01991;
        Sun, 16 Apr 2023 03:18:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xi5so56795845ejb.13;
        Sun, 16 Apr 2023 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640286; x=1684232286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMKv1eC7oXKgQg7kmPBpEEYkcLgFu/zreUxyQ3hjVRU=;
        b=XY2jm6IUO7nOh7iJmLWXmOyrQaQ2zXMn6pKvFRann89LpKvUgmwOJ4vPQxCYYtgl/r
         VHL5qEdKbz4cEa32T3mijCoxrubeICJTC1oz9/SCZMyviJQLMi2owVoreb9Buhr4/On6
         +o2yhR4LpvZkgSUrbVIEN6JQCj+xh2qQYpvQOaE/rBhfkuXWUlon8FcmuFiI9DUUPlfq
         GSxXv2IZ3AKkBNmIGQ1qMt92cC07eFOt0Ask8D23d61JCAwY7jtB1ylHQUY+4l+MsSZ6
         xPDpywU+Y4gJRduqySkVW4gkcY+GLnvnZArfwxLArMPu+F8KS2LsXiVjNmbrJDBY73Id
         5njQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640286; x=1684232286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMKv1eC7oXKgQg7kmPBpEEYkcLgFu/zreUxyQ3hjVRU=;
        b=DvNs5F6KnRBflBSlj7p/58V+YA30RZ5muGwdj1rgHBUPjyhNLhGC7XqArpG8hxdydU
         8BMElQ5bBr2RCu66Bawy/Smd2Pignf9fYXBzAgyhcil4AjFcb6CmJ42zeq71kKA0Bzp0
         oBPtsp5dNaAq+3OWk0kuSAIZYgUozNaA7Uu0en8jxMiCyIRabikIT/YDeapVdaVPiEWk
         Hj5+G2ANr531ixN0+UKl4s5g93OBO/F0TuLLVlZnjq24Njavc05Epi/0IS3oTG2h5Bm7
         9w57w0H+WAUr4hARobmduIbOJk+D0SOScK2bplPjMSJ4/xsrd5qC9usEdmDjQ6mJgArU
         Hf/g==
X-Gm-Message-State: AAQBX9fBX2YyNbk263WN+xArFaJoMhP3GBCfWH+9RJKKO8RrFy9+A6+E
        2RWce2J3dKpxO9o9I+qLpss=
X-Google-Smtp-Source: AKy350aFxJm7/QXCtBcZGPfDmRrIsMdjN4hcBIIu5aXI7tPRyjlAly8QSDd0d6aOaUWrFr4Ex5a1Pg==
X-Received: by 2002:a17:906:3454:b0:94e:8431:4767 with SMTP id d20-20020a170906345400b0094e84314767mr4666485ejb.38.1681640286211;
        Sun, 16 Apr 2023 03:18:06 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:05 -0700 (PDT)
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
Subject: [PATCH 00/12] Re-introduce Exynos4212 support and add Samsung Galaxy Tab 3 8.0 boards
Date:   Sun, 16 Apr 2023 12:16:12 +0200
Message-Id: <20230416101624.15866-1-aweber.kernel@gmail.com>
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

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

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

