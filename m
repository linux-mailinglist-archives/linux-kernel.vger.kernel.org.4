Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049EF6D4DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjDCQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjDCQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:32:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CBC26BB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:31:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ew6so119604071edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680539484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=do5D8PA2Ob021tcdMPdX8DXoHHob1pEJ74k2NUfYoOw=;
        b=gvcObH+GeWNztUvTPEolF4QBTe8UBkuEhmEzaDz+0v1RlevYxGTkVez9vOJDJeO0Am
         KHj40v8o36pKjV8INTNUVi1oPRc1hYy1cRaFvexNAMox4fJokjSZi2o0kkXk15k00YO5
         3imybZCeo47YY+phMyZa3N44ep8RYqTAJL3oySNMJSDoAevdz6FKcncx1zoZXk3y1vZJ
         anvB2QLdYe/NjbdBKUZY6QPBDSg5Q9tMEudCVjpv2yLPCBxqURC1S3oeq8p5UaooSy/U
         jxMOaQ7pSU8YG4/m0pdWxtvZdeFCrE4cj+7Ramr1kJCGNlNzUGrcjuC1VkyhBB20Xx+d
         vI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=do5D8PA2Ob021tcdMPdX8DXoHHob1pEJ74k2NUfYoOw=;
        b=TzoSFeFuj+iX24O6m1mjVBfJ0ysroh4UeRQ2pEGoWLGliMNoyP5zYRylsFg+K5Bq8I
         5jik+xL6y7qOcXjR0bcvbylcT7+yK9kilNOtoewj5w4Vs0deZquDQooeIluG8DaM+uJ2
         LEe9AmmhNiPPQIenMZ3CH7y5bCp8LYoNQkPC75c8t82PJjb5uusuJa0D+2Fw1Kq9SEOp
         ZAQ0kqS43rCkKeOq7AzfDTqMAXboYAG54fu3eiqhrCC/KNcde1ZfdFdjo82OPTtOeyB5
         mJDMMbde3V+mI3h1TvPSYh73grmGxK2QzFbyS4hGO6/j4i20OIVetdxOLGV11okG6Oby
         /5AQ==
X-Gm-Message-State: AAQBX9eRAsSieL5smWIBUUWVR6pn8TxtYBJF+fhm7N/sstb3739rYEav
        OCWHVzX8B+YZG8GjA+TWAN+ixQ==
X-Google-Smtp-Source: AKy350bvrGXVzVDbeYDPijEMx72wVfks2dCFgyV4cScGu2NL13KvmMYqiVyTa6DX5gDdX/uUh/KHwQ==
X-Received: by 2002:a17:906:5856:b0:930:1391:da7c with SMTP id h22-20020a170906585600b009301391da7cmr32345440ejs.60.1680539484409;
        Mon, 03 Apr 2023 09:31:24 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b00930c7b642d0sm4755010eje.166.2023.04.03.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:31:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: drivers for v6.4
Date:   Mon,  3 Apr 2023 18:31:05 +0200
Message-Id: <20230403163106.331712-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.4

for you to fetch changes up to babb3e6a8a8e5a61a65d4463610108808139b23e:

  clk: samsung: exynos850: Make PMU_ALIVE_PCLK critical (2023-03-13 08:24:57 +0100)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.4

1. Exynos850: Add CMU_G3D clock controller for the Mali GPU.  This
   brings new PLLs and few cleanups/simplifications in core Exynos clock
   controller code, so they can be easier re-used in Exynos850 clock
   controller driver.
   New CMU_G3D clock controller needs Devicetree bindings header changes
   with clock indices which are pulled from Samsung SoC repository.

2. Extract Exynos5433 (ARM64) clock controller power management code to
   common driver parts, so later it can be re-used by other Exynos clock
   controller drivers.  This only prepares for such re-usage, which is
   expected to come later for Exynos850.

3. Exynos850: make PMU_ALIVE_PCLK clock critical, because it is needed
   for core block - Power Management Unit.

4. Cleanup: remove() callback returns void.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      Merge branch 'for-v6.4/clk-exynos850-dt-binding' into next/clk

Sam Protsenko (12):
      dt-bindings: clock: exynos850: Add Exynos850 CMU_G3D
      dt-bindings: clock: exynos850: Add AUD and HSI main gate clocks
      clk: samsung: Remove np argument from samsung_clk_init()
      clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
      clk: samsung: Set dev in samsung_clk_init()
      clk: samsung: clk-pll: Implement pll0818x PLL type
      clk: samsung: exynos850: Implement CMU_G3D domain
      clk: samsung: exynos850: Add AUD and HSI main gate clocks
      clk: samsung: Extract clocks registration to common function
      clk: samsung: Extract parent clock enabling to common function
      clk: samsung: exynos5433: Extract PM support to common ARM64 layer
      clk: samsung: exynos850: Make PMU_ALIVE_PCLK critical

Uwe Kleine-König (1):
      clk: samsung: Convert to platform remove callback returning void

 .../bindings/clock/samsung,exynos850-clock.yaml    |  19 ++
 drivers/clk/samsung/clk-exynos-arm64.c             | 229 +++++++++++++++++++--
 drivers/clk/samsung/clk-exynos-arm64.h             |   3 +
 drivers/clk/samsung/clk-exynos-audss.c             |   6 +-
 drivers/clk/samsung/clk-exynos-clkout.c            |   6 +-
 drivers/clk/samsung/clk-exynos4.c                  |   6 +-
 drivers/clk/samsung/clk-exynos4412-isp.c           |   3 +-
 drivers/clk/samsung/clk-exynos5250.c               |   5 +-
 drivers/clk/samsung/clk-exynos5420.c               |   5 +-
 drivers/clk/samsung/clk-exynos5433.c               | 157 +-------------
 drivers/clk/samsung/clk-exynos850.c                | 141 ++++++++++++-
 drivers/clk/samsung/clk-pll.c                      |  12 +-
 drivers/clk/samsung/clk-pll.h                      |   1 +
 drivers/clk/samsung/clk-s3c64xx.c                  |   4 +-
 drivers/clk/samsung/clk-s5pv210.c                  |   6 +-
 drivers/clk/samsung/clk.c                          |  64 ++++--
 drivers/clk/samsung/clk.h                          |  10 +-
 include/dt-bindings/clock/exynos850.h              |  28 ++-
 18 files changed, 475 insertions(+), 230 deletions(-)
