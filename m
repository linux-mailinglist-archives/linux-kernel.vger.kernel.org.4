Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595E068FB4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBHXnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBHXm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:42:59 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7711C32B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:42:55 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16346330067so585058fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 15:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPRKUBkUjV6wErAx3u8efIWgE+89/8Yagam/BSRsddc=;
        b=NGdRV36I9Pmjsg7qklEDkH7KWTaGRQvWLZJW+B6/6sDuE7a6dDALvB4Z/zvXerxC+z
         G6hY+aC6J9HIcBlk6nPwIJ6wByDwZ/uRhwST/yYGsksOfcKEKVP61S/+CaKZrytXKJXV
         buC3dxifomOE6CdmjhFaEO9qWvAQodMXggTCUYbE3x0D5BFbE88jB8/9DcrDpxZo4RXF
         us44TTC5KvsAlhq2RYtKvKLF+dEqMD2B3COTp2dEEh/aK6gQviOMF70leFfsIErdK5ZW
         vzaYydJ2Z5a0ax3qVgDxG0vqvbYYGmqkI/yYzqZWBGQaNyQpLaHTpr/AZWCbW+g06ZoS
         NMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPRKUBkUjV6wErAx3u8efIWgE+89/8Yagam/BSRsddc=;
        b=YO4Va0td4K9mlYeZvuYk5z3ObGMQwFT7cVmi1dWXqmC4TLt1Whxn+dyHHif3iu2CoV
         s1hR5uHkUBm8Ciq3I222fPI1QecsFJdCqtDsXURtdHCD4gmiZVjJeRV+JRWhpdLU6dZh
         859D7zGYBSvAcfWOLSCW6LZ1pRNrRyWqKbs3sxDdb3Q6hLSaqzY7Jff+26/kcXsPZWZy
         LJfpOWPglHVGLUDzGAJU2+LaUkuBXfYMTcTAdfrRmViewRjGt2Rag/gx48ccARoJtAq8
         MtMnzczVnJmXdqBtJcHLV0d/256RuDcz32Tf3ZhuhH3qrhYNSDnGgDp1DUSQxCwBidmj
         v6Yg==
X-Gm-Message-State: AO0yUKV0UB5x6PGMqPzjwG3n6l0gOn/kKWwTI4vx6dXEkCGEs0zNpgYC
        uJwbl7CEaGeUiuLjxQ4q2pAB9Q==
X-Google-Smtp-Source: AK7set/xUGnr4PVr2mHLS7wLYAUv16g/wlzX0BozlphTymJTxqGCSIGniRLpKsCk3wC5dyZuCKPROw==
X-Received: by 2002:a05:6870:b486:b0:16a:3f0:7178 with SMTP id y6-20020a056870b48600b0016a03f07178mr1378380oap.0.1675899775194;
        Wed, 08 Feb 2023 15:42:55 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id l22-20020a056870d4d600b001636786f7absm7394069oai.43.2023.02.08.15.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:42:54 -0800 (PST)
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
Subject: [PATCH v2 0/6] clk: samsung: Add PM support for ARM64 Exynos chips
Date:   Wed,  8 Feb 2023 17:43:07 -0600
Message-Id: <20230208234313.23863-1-semen.protsenko@linaro.org>
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

 drivers/clk/samsung/clk-exynos-arm64.c   | 218 +++++++++++++++++++++--
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
 12 files changed, 274 insertions(+), 218 deletions(-)

-- 
2.39.1

