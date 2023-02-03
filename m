Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF83688F65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBCGJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBCGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:09:04 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911470D78
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:09:02 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so1099413otj.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 22:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onrI71TD6WqFZBzvBnCt+Gild5OdRHzAV9MK+sKDnqY=;
        b=gYQw/IZoNsuFi2SH+ea5NNpnPFwmqf03PJiE7ERwjJ6xFjfgcjQ161n03LOiPIHxHk
         LjrEmv3Gw7ELY1yev4HdfoFiXyUUZpc2a9BHF4lPqVOh6VS/CFm44oayMOfNosX7z14I
         Vah3pOgiT492kV6lxqngLnplVklrplugAEi5hyHqEj1iZgqkQsisMr87qpmJDeSyeyv3
         bo5N4wpZAkI2wrOE/BvX04ejUc5vcbkoRi8OWmR+b8riJZ7hpgHH41Ikt37JnyNzspwy
         pJ0nomi+uL6C2/TDJ3KYVaI1LGEkENRaYe1SoDZE8E7LDxUb4Gu29dOoz8I7hvwu3rav
         v0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onrI71TD6WqFZBzvBnCt+Gild5OdRHzAV9MK+sKDnqY=;
        b=2yp2jI6SCP8iEXzU7gUHy6ArnYPC1FqeZg97a8drFeBwBRMoSlNaMAl++/UQbJsWnn
         MBTxtvTms3BiNC84Ppqyb9Lf99tSn9/FQzp7B5JfUcJQ/Z/WiYYI5fPmGFfDjGLdVaIR
         SWieV/UtoHaC0fXzYe9yRXiwd3KljFxX2HrnWNk8CunCr1IiTJkawtFCEVXCZuQmB8M3
         RM0ts4UZyCY7WMd3YVHfkwlwb2qtODSSJhuLBHznDrmS9CTmbr/tGjBVF7/1TFku8uXi
         xcO8ZOt2mFWp3bFRtfsP+00BjaHWzbiZwxQHd3fjPR89iWIhUrue2glz0YQ8X/WWmcew
         tg6A==
X-Gm-Message-State: AO0yUKWRCy1joq6oAsFsFfQO/IvVniPw18OpON9HiBNmnT8d6ALm4tRx
        i9L8PKdx1Y9Y9fnHfcYi2eXO2cSpi2GI6/qJxd8=
X-Google-Smtp-Source: AK7set/Eaw+FWQJ5ZOw2BxuOM6d1N0+6Zivr73NDLw4GGuMzl5IttPfbTXwzt/Dcc4KoTTjeq+aRhg==
X-Received: by 2002:a9d:148:0:b0:68d:4eb7:49d9 with SMTP id 66-20020a9d0148000000b0068d4eb749d9mr2730497otu.37.1675404541752;
        Thu, 02 Feb 2023 22:09:01 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id 88-20020a9d02e1000000b00684cbd8dd49sm692895otl.79.2023.02.02.22.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 22:09:01 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] clk: samsung: Add PM support for ARM64 Exynos chips
Date:   Fri,  3 Feb 2023 00:09:18 -0600
Message-Id: <20230203060924.8257-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for PM enablement in clk-exynos850, common PM code
was extracted from clk-exynos5433 to clk-exynos-arm64. Also some related
cleanups were done prior to that. More specifically:

  - patches #1..5: cleanups
  - patch #6: PM code extraction

During the extraction of the exynos5433_cmu_probe() content to
exynos_arm64_register_cmu_pm() some code was reworked a bit, and also
split into smaller functions. In particular:

  - cmu_data structure now contains a pointer to ctx, which is now
    allocated in samsung_clk_init()
  - cmu_data structure initialization was moved into separate function
  - code for configuring gate clocks was added (optional)

Which in turn resulted in somehow modified code of probe function:

  Original
  --------

    ...
    devm_platform_ioremap_resource(...);
    samsung_clk_init(...);
    exynos_arm64_cmu_prepare_pm(...);
    exynos_arm64_enable_bus_clk(...);
    platform_set_drvdata(...);
    ...

  Modified
  --------

    ...
    platform_set_drvdata(...);
    exynos_arm64_cmu_prepare_pm(...);
    exynos_arm64_enable_bus_clk(...);
    exynos_arm64_init_clocks(...);
    devm_platform_ioremap_resource(...);
    samsung_clk_init(...);
    ...

That shouldn't really change the logic or mode of operation. It was
preliminary tested on Exynos850 based board, with some extra patches on
top of this series (will be submitted later).

Marek, could you please test these patches on Exynos5433 platform, and
also review accordingly?

Thanks!

Sam Protsenko (6):
  clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
  clk: samsung: Remove np argument from samsung_clk_init()
  clk: samsung: Set dev in samsung_clk_init()
  clk: samsung: Extract clocks registration to common function
  clk: samsung: Extract parent clock enabling to common function
  clk: samsung: exynos5433: Extract PM support to common ARM64 layer

 drivers/clk/samsung/clk-exynos-arm64.c   | 219 +++++++++++++++++++++--
 drivers/clk/samsung/clk-exynos-arm64.h   |   3 +
 drivers/clk/samsung/clk-exynos4.c        |   6 +-
 drivers/clk/samsung/clk-exynos4412-isp.c |   3 +-
 drivers/clk/samsung/clk-exynos5250.c     |   5 +-
 drivers/clk/samsung/clk-exynos5420.c     |   5 +-
 drivers/clk/samsung/clk-exynos5433.c     | 157 +---------------
 drivers/clk/samsung/clk-pll.c            |  11 +-
 drivers/clk/samsung/clk-s3c2410.c        |   6 +-
 drivers/clk/samsung/clk-s3c2412.c        |   5 +-
 drivers/clk/samsung/clk-s3c2443.c        |   6 +-
 drivers/clk/samsung/clk-s3c64xx.c        |   4 +-
 drivers/clk/samsung/clk-s5pv210.c        |   6 +-
 drivers/clk/samsung/clk.c                |  64 ++++---
 drivers/clk/samsung/clk.h                |  10 +-
 15 files changed, 282 insertions(+), 228 deletions(-)

-- 
2.39.0

