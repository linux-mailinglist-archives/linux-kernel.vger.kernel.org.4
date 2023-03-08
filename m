Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368DD6B162B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCHXJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCHXJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:09:34 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8BE618A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:09:33 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-176d93cd0daso494203fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678316972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSUy9pqri34RafzXpduDuTiVpZ9W29iQLOdXi9MBbjc=;
        b=W8Fgv56006OYf+0vMpu9nCC7xSYySTNCf0Cq58RxoqFSqWBy3WHUMo0PhtBQmLY2Qh
         JBGa+5hpuL9dZLX2aVOx8lBr+srtTvlGXu/f5ZhjYUzyfKmBBoOY6kENHqWDKBYixMr8
         FwNqVkzrAsR9lMFG0iRbN1LRBTVvPDsVGalUcxtRqIxTbNSDYNy3TW30lH5qZ6LvztCE
         F0Y3hoAAkI8Sb108QzNayVfT7Q4aN+ra9IjCZRR4WrsD1VUETaceIp4CHoa3OyrIBt1i
         ucAL1bOZqlOnn/rLQ78+Ah6f1T48YKRJ5BG5y4Sf0bsGSjpqhaBNSD36Aa4buBlYA1O6
         X6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSUy9pqri34RafzXpduDuTiVpZ9W29iQLOdXi9MBbjc=;
        b=VL4oWmhqW5qVXy9cOXgDO9HxCi5eJPruBoj+TbOEu6AmY73N6dFlu/2mt74/9FqLlA
         E3StKBgulE8BGcIvfTo/ZGgF6tb2D5DHFcYHhkNVOj0sVDLNJpRbYzauYU2t8513BfMa
         WElR8GAOvLg7/CHI4xpcteZ8GiuT+nCKpf7+nReRdrbYD8D+jOi3eHEbF8W4GDKys2U3
         YULwdkOd4h2Y0c8vfaH42dUfO/65zdnAHYum/Ny2eUiyYOhYaKGgwP/6tAcydt0XYyp+
         I6+jqS9J7Fc4kYyx9MUtZSI4A/8bhEn5UrLKtCw08Y5Fw6Q2V3Kwsqr2ZEsnHFj5pHXv
         smuw==
X-Gm-Message-State: AO0yUKVPYLB+TNxS24lsRpUc/uc+mXQgcSzMQH0kFGbHs0CHUKWC3LmM
        TKFbBzSx6k/j5FqEwGcg1Kc91g==
X-Google-Smtp-Source: AK7set8N1gB2a3Ev0DG0ifVpKRpIm2ymT29/NKvYWTyo6j5FanN5C+/s4trt5ujy9fqa+Tgwue1MVw==
X-Received: by 2002:a05:6871:6a0:b0:172:55c5:780 with SMTP id l32-20020a05687106a000b0017255c50780mr12841967oao.23.1678316972450;
        Wed, 08 Mar 2023 15:09:32 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id h21-20020a056870d25500b0016e9308e17bsm6704527oac.52.2023.03.08.15.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:09:32 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] soc: samsung: pm_domains: Add Exynos850 support
Date:   Wed,  8 Mar 2023 17:09:25 -0600
Message-Id: <20230308230931.27261-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power Domains in Exynos850 are not really different from other Exynos
platforms. Enabling Exynos850 support in the PD driver is really just a
matter of adding:

    static const struct exynos_pm_domain_config exynos850_cfg = {
        .local_pwr_cfg = 0x1,
    };

to the driver. But in the face of recent developments, e.g. this patch:

    arm64: dts: exynos: move MIPI phy to PMU node in Exynos5433

it looked logical to rework the PD driver a bit to support its nesting
under the PMU node, while adding Exynos850 support to it. Initially I
only wanted to add syscon regmap support via some dedicated property,
but pulling PD nodes under the PMU syscon looks like more correct way.

This patch series provides next changes:

  1. Make it possible for PD nodes to be children of PMU
  2. Add Exynos850 support to PD driver
  3. A bit of refactoring in PD driver
  4. Corresponding changes to dt-bindings

Dependencies inside of the series:

  - patch #2 depends on patch #1
  - patch #6 depends on patch #1
  - patches 3,4,5,6 should be applied in the same order as in the series

Sam Protsenko (6):
  dt-bindings: power: pd-samsung: Add Exynos850 support
  dt-bindings: power: pd-samsung: Allow pd nodes to be children of PMU
  soc: samsung: pm_domains: Extract DT handling into a separate function
  soc: samsung: pm_domains: Implement proper I/O operations
  soc: samsung: pm_domains: Allow PD to be a child of PMU syscon
  soc: samsung: pm_domains: Add Exynos850 support

 .../devicetree/bindings/power/pd-samsung.yaml |  12 +-
 MAINTAINERS                                   |   1 +
 drivers/soc/samsung/Kconfig                   |   1 +
 drivers/soc/samsung/pm_domains.c              | 132 +++++++++++++++---
 .../power/samsung,exynos850-power.h           |  17 +++
 5 files changed, 142 insertions(+), 21 deletions(-)
 create mode 100644 include/dt-bindings/power/samsung,exynos850-power.h

-- 
2.39.2

