Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1D676CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjAVM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjAVM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:26:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762B1BD2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:26:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8798398wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMQ10RBmLGcQFRoj4Vv+LHDJlKcFXLJnPbw9MQ53bW0=;
        b=dpL32Fe0H297Vx10D2uKYUw0KIxhov0SZxFNqLMop/RPQB443mWBRf0/uXZ14h2Tnq
         4Fl1Qf/xlK/PE6LHY3iVt+gbrHdWTkrtaR9RTH5lEd9YwlSeMOJ1FvdgjhF4SEXn6zte
         9pd1tvARt9J5fHWAF2oKpFGfJaYJomEtX6uIg2xMzxo62ZOa+zsk4fAd2DewrFusd7j1
         RLJLV8ozyKonMmzYlcQFaHaaBcr+friy+4kgs3UUFK9yC6KUoxMronnuMktEJQV/O3da
         c/fB6jIdDGXQYBm4W2yKHboUMuZagF68EOX+oxaabTMHJepdSm973wpTzL9SuXtdC98C
         J+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMQ10RBmLGcQFRoj4Vv+LHDJlKcFXLJnPbw9MQ53bW0=;
        b=SaZNtXDAEVmGY+/UjZiusekMl+AMEnlOka7fCW8n1/GJ6e752odItZDdpisET1bgzc
         j5sCX3lG+EPZTyzLqh1p4yH+ujnJiYMWgtqD9771CtVBCjv+KhvXlGdm4h9OuZVlWN98
         Nm5YRV3NkBNTQnxP/uUqgr55hagniDALhvqA3sMuvGCrThHkT/0jPOzdQZjAj1rClrfY
         8sG+NAQwxClmGHawWucjziwh7Mq7zNny5LwiXg/jsc7krXTrKF8njTd120AXCUf2oNrV
         +36sjmgZy4I1eUREa7JF4fmXVbMC/4R1t0l66mlhd4IhWlwvQ3wH3fiMBhSseRQwte3K
         pSPw==
X-Gm-Message-State: AFqh2krcftN1pUV3M98PI+L9d/2HRJ/fBcuWJbNC87y7rDNo8O8MEaeL
        igzZ2/5na4M2whGIAmM/x17rDQ==
X-Google-Smtp-Source: AMrXdXthFm7tjzb2lm692mvw4lLPvhCBI7Wz1PepK28R53R6k/QxYdC87b0fNYtMjDUf+mIpbEHWcg==
X-Received: by 2002:a05:600c:1d22:b0:3d9:6bc3:b8b9 with SMTP id l34-20020a05600c1d2200b003d96bc3b8b9mr20671700wms.9.1674390371217;
        Sun, 22 Jan 2023 04:26:11 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003d9aa76dc6asm10663808wmq.0.2023.01.22.04.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 04:26:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: samsung: for v6.3
Date:   Sun, 22 Jan 2023 13:26:05 +0100
Message-Id: <20230122122605.30720-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230122122605.30720-1-krzysztof.kozlowski@linaro.org>
References: <20230122122605.30720-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tesla and Exynos ARM64 DTS.

Best regards,
Krzysztof


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.3

for you to fetch changes up to 56a14f01a54568e049e22c46ffc654602bbd01d1:

  arm64: dts: fsd: Add sound card node for Tesla FSD (2023-01-17 12:15:39 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.3

1. Add L2 cache properties (Exynos, Tesla FSD).
2. Tesla FSD: add Bosch MCAN (CAN bus), sound card (audio card with
   codec and I2S controllers), system controller nodes.
3. Tesla FSD: correct pin pull up/down properties to match
   recommendation in user manual.
4. Minor cleanups: use dedicated/specific sysreg compatibles, fix
   dtbs_check warnings, drop unsupported properties1

----------------------------------------------------------------
Krzysztof Kozlowski (6):
      arm64: dts: exynos: add dedicated SYSREG compatibles to Exynos5433
      arm64: dts: exynos: use 8-bit for SPI IR LED duty-cycle in TM2
      arm64: dts: exynos: drop pwm-names from MAX77843 haptic in TM2
      arm64: dts: exynos: drop clock-frequency from CPU nodes in TM2
      arm64: dts: exynos: correct properties of MAX98504 in TM2
      arm64: dts: exynos: drop unsupported I2C properties in Espresso

Padmanabhan Rajanbabu (4):
      arm64: dts: fsd: fix PUD values as per FSD HW UM
      arm64: dts: fsd: Add I2S DAI node for Tesla FSD
      arm64: dts: fsd: Add codec node for Tesla FSD
      arm64: dts: fsd: Add sound card node for Tesla FSD

Pierre Gondois (2):
      arm64: dts: exynos: Update cache properties
      arm64: dts: fsd: Update cache properties

Sriranjani P (3):
      arm64: dts: fsd: add sysreg device node
      arm64: dts: exynos: add dedicated SYSREG compatibles to Exynos850
      arm64: dts: exynos: add dedicated SYSREG compatibles to Exynosautov9

Vivek Yadav (1):
      arm64: dts: fsd: Add MCAN device node

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  11 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  24 ++--
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   2 -
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   2 +
 arch/arm64/boot/dts/exynos/exynos850.dtsi          |   6 +-
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |   9 +-
 arch/arm64/boot/dts/tesla/fsd-evb.dts              |  69 ++++++++++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi         |  54 ++++++++-
 arch/arm64/boot/dts/tesla/fsd.dtsi                 | 124 +++++++++++++++++++++
 9 files changed, 270 insertions(+), 31 deletions(-)
