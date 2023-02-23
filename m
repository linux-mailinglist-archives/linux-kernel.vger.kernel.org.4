Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740A76A01C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjBWETb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjBWETY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:19:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E31EFF4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:19:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bh20so10059728oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GdxaKoTsSLP7s69yzl5MFSFO0xh3sG9vl0I5PlfZgA=;
        b=L060XF2JHZaQo/1P9bDtUd8szWmjr+L/uu10po6C3Ua07A2E7XF/eEXkrmN0dfZdOo
         0FxisqRxwwIziSvejSkdpt9UkptXsd/Qd4N4ao7M//pLLYku0cmWc/ZcW+SGDgeTZWqb
         AvjeS+TeIFADd355oAcF3IZSZjbHrOpJ93XquBrMxMNjbdsKldcsExLUNM3AxRutY/hf
         dL0X6BBkARzjfqIvJMpK8W+T4/vMM0wRoEzwPrePDop5l0OEwbMMaRb3BvFC7RpwQqbE
         LbNXcocFOCQeYawAXnpu3nF0gysdvp0ifnrIHWbww+D21oxHFj6QOeBlOnK/kXX2+4ZS
         4WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GdxaKoTsSLP7s69yzl5MFSFO0xh3sG9vl0I5PlfZgA=;
        b=hSJzHRrtdX/yR9zhAuf+ZtnsS2PWcgf9HDSp9vBsHvmvWreQ3jHTP6aDf5WhFdT1OF
         8Wciq7k2vf4LzO+fskSvepcFNXXXZuRIrgi8POHjbXJen1toU7Y3lP2Vegm+W9HVPL/U
         6JW2XXNz5lnIVuHOKnMk3bd5W5SFzwUzEOBwV23vMBFbsdIQ/4YQ0oOUiTc1edWRSdtd
         yAGNPnK7U0MQYMCw9LpsImSsLFDuhhR8xdve/TFz6pcjr+vM6buKseKEHvyO8hgEzmAF
         sYjKORJ9EXblEtSp1z+j3FUVGulL5iZ6jm9fqu9EzenEwztOwtHSxWzzDOcHIRGQg3mU
         MCvQ==
X-Gm-Message-State: AO0yUKWfcY0D6OC7F1TN045aPjupaqNwV8nHrU9gz773ifjIBGGn9xGn
        HqUhdXRn+uI5J1z9Qx1ggrbjVg==
X-Google-Smtp-Source: AK7set9p9xq+PeGY4ZcGiASMF4xWg2W2iFsNpHOOC0FeFFPXBpHnPphw3bmxQC/4XgnC2+KvvrxH9A==
X-Received: by 2002:a05:6808:246:b0:383:ce81:c055 with SMTP id m6-20020a056808024600b00383ce81c055mr1645916oie.47.1677125963121;
        Wed, 22 Feb 2023 20:19:23 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id n4-20020acaef04000000b00383c7709f7esm1758178oih.21.2023.02.22.20.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:19:22 -0800 (PST)
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
Subject: [PATCH v3 0/6] clk: samsung: Add PM support for ARM64 Exynos chips
Date:   Wed, 22 Feb 2023 22:19:32 -0600
Message-Id: <20230223041938.22732-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Changes in v3:
  - Rebased on the most recent soc/for-next tree
  - Added A-b tags from Marek
  - Added Marek's authorship to clk-exynos-arm64.c

Changes in v2:
  - Rebased all patches on top of the latest soc/for-next tree
  - Added Tested-by tag from Marek
  - Addressed comments from the review

Sam Protsenko (6):
  clk: samsung: Don't pass reg_base to samsung_clk_register_pll()
  clk: samsung: Remove np argument from samsung_clk_init()
  clk: samsung: Set dev in samsung_clk_init()
  clk: samsung: Extract clocks registration to common function
  clk: samsung: Extract parent clock enabling to common function
  clk: samsung: exynos5433: Extract PM support to common ARM64 layer

 drivers/clk/samsung/clk-exynos-arm64.c   | 220 +++++++++++++++++++++--
 drivers/clk/samsung/clk-exynos-arm64.h   |   3 +
 drivers/clk/samsung/clk-exynos4.c        |   6 +-
 drivers/clk/samsung/clk-exynos4412-isp.c |   3 +-
 drivers/clk/samsung/clk-exynos5250.c     |   5 +-
 drivers/clk/samsung/clk-exynos5420.c     |   5 +-
 drivers/clk/samsung/clk-exynos5433.c     | 157 +---------------
 drivers/clk/samsung/clk-pll.c            |  11 +-
 drivers/clk/samsung/clk-s3c64xx.c        |   4 +-
 drivers/clk/samsung/clk-s5pv210.c        |   6 +-
 drivers/clk/samsung/clk.c                |  64 ++++---
 drivers/clk/samsung/clk.h                |  10 +-
 12 files changed, 276 insertions(+), 218 deletions(-)

-- 
2.39.1

