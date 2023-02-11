Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE7692ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBKGkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBKGjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:39:52 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D312F1E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:50 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bd6so6262786oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOL/t5qBo5/69OTBXU9K1Tb25sSUsXIonQCXIzPu+54=;
        b=tHzsDq4HNF/rGckcDAHo6fj26lDoOoe8KuraYxDcWmx6Ab6WvmFZNUpMBfyQiBvqgI
         btoJcI59TQYSEby+Gk2LMtpPuYRtCCTyxoAwIEFrHLQYqOWlRBjSBY/JpZPDgVWVm/Gx
         bU9nioRCt9gDLYDPfdFzAVX8za0DNIsaDYU1T/wVrbTpaAeVEcZXDu6FzlKZgE+ONwfz
         Pb1gwRd/I6CPVImHkEIyt/+J8QRcvHsXKZ/2NNStdJMfOitEAq46X8PYgw3ERHh0n3KB
         jiD+fo6MciNYEau+57gvTTE6VfzQ8mRs099+rIlIuDXN7U2x51xcAivUl+qhuMhWx5u5
         59pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOL/t5qBo5/69OTBXU9K1Tb25sSUsXIonQCXIzPu+54=;
        b=vTMaUxBQXYPtSpOndDqfYU30SklsI7UB2LUAHNUmME66KOH4PX96d2eKJvylOnkhgI
         /wmt7dP5818DczqtoIPZqzmuxSR8V7GVRn1Pu8D+V3y4Srnc401QG7cxf5XEQ6L6e3lA
         ed5gyhogCc2Xmi4bu2oP+ArMbd+6gUS7nfb/lKcFnnT144nQSMNqHyA4tcydZ5WWgn6L
         LrPHsUryG+f+igm76VHEJ6nk0VKKXGrZEyVgV2ajmlSBE41y5BskwT9HdKK0rzvVrn7a
         VtXv5Cuu9Li1NZoLE0cLS2Nji5DVXHHWQ2gL373KQ5o9aZF4P+BFLOXySYYH6+KuAlFa
         bPmw==
X-Gm-Message-State: AO0yUKUGo75EMFxCJ0/jcL4kEkMRqGHVcjKylgXFliz+w/IrtbLSEDb5
        e7wLALVxr6LrM1bF3/nyf9YH5g==
X-Google-Smtp-Source: AK7set+HnpNlRcQyXbCbbLqOkb0wDhIY0ti/vlL9ybU+Qhg2C9bTqXY/4LfABv+YVA51snNn1EpSTg==
X-Received: by 2002:a05:6808:b13:b0:35e:d30c:e918 with SMTP id s19-20020a0568080b1300b0035ed30ce918mr8027850oij.39.1676097589646;
        Fri, 10 Feb 2023 22:39:49 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id w8-20020aca6208000000b0037832f60518sm2977541oib.14.2023.02.10.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:39:49 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Virag <virag.david003@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] clk: samsung: exynos850: Add missing clocks for PM
Date:   Sat, 11 Feb 2023 00:40:00 -0600
Message-Id: <20230211064006.14981-1-semen.protsenko@linaro.org>
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

As a part of preparation for PM enablement in Exynos850 clock driver,
this patch series implements CMU_G3D, and also main gate clocks for AUD
and HSI CMUs. The series brings corresponding changes to bindings, the
driver and SoC dts file.

Sam Protsenko (6):
  dt-bindings: clock: exynos850: Add Exynos850 CMU_G3D
  dt-bindings: clock: exynos850: Add AUD and HSI main gate clocks
  clk: samsung: clk-pll: Implement pll0818x PLL type
  clk: samsung: exynos850: Implement CMU_G3D domain
  clk: samsung: exynos850: Add AUD and HSI main gate clocks
  arm64: dts: exynos: Add CMU_G3D node for Exynos850 SoC

 .../clock/samsung,exynos850-clock.yaml        |  19 +++
 arch/arm64/boot/dts/exynos/exynos850.dtsi     |   9 ++
 drivers/clk/samsung/clk-exynos850.c           | 139 ++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 |   1 +
 drivers/clk/samsung/clk-pll.h                 |   1 +
 include/dt-bindings/clock/exynos850.h         |  28 +++-
 6 files changed, 194 insertions(+), 3 deletions(-)

-- 
2.39.1

