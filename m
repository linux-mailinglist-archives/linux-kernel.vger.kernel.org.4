Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0067FF97
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjA2Oj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjA2Ojx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:39:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436A83E0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:39:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l8so6426725wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vwCDrwzwASozRbMEd2/FLEyNdaiBVfiRFqS2U6PKXc=;
        b=Pm/FTmbEWjDAnrrTHvkJVTaTJjIiy6wc94E/+NvkP7UiES9qVlY1UDn/S4jZUOgLPc
         ORM+hKN5n7ic3IX7LIct5rfgeMWPC7SlNLrJxFW9agNNMoq6Ii0fNPghKcfpOvDWD7CQ
         tFYnO4LYjrvm/9vV6C7DRptNJBns+X78TUdIVXgaqW78KtqFNCT02Jmg29P823rJUUUM
         GqkYzTA5UPv1PrZEAuYNLgGDJMDUHwtgzfYOBc3+KIG7BqtR8p+2xegMO26EYLAPdHwG
         bHv4VYbWWMYDGcBRMnfbWkt1wh0nURzpaImp+O1RmZbz9QWhgmsuKwduc82U0qU+C3f7
         sXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vwCDrwzwASozRbMEd2/FLEyNdaiBVfiRFqS2U6PKXc=;
        b=YTrDKn3REkvrumJkn3Er9Iy9EQ/LnvO3lxFkmXjxTMzYvBfHiqbOb2iX4apjNqTWoE
         i/crPNTKZipaa5uju0XB64vHAAa6aWfAsDZQrZ58Zosp5l1HaQj7YF6YJvQmalfwbLZV
         Ovn3AUP2ggs03sloioxaPl6UDOPwfQwS+lXa5PoIPqkc19bV78rSll8IptSbYuK2CyFg
         TudOvIIHjMYxNthrsX48DYhu228nuceX1wjsYUjY0QD0gT86zQfUtpvp9ujcPkRChEer
         A28i07rkbq9134gGOWvpEKQ31dFe/p8scRZoDZQJoVupS2jEyPmSQUoMkPRao/m/JzUN
         vIeA==
X-Gm-Message-State: AFqh2koVc4PrToXRM1sQ+3g/HJ+Ps50yP9ONwlM546LSArbSvcpAagdo
        Q1lGcIxVVgOrE/hpfUX4OgWcsw==
X-Google-Smtp-Source: AMrXdXv3fE5FTTFWA26uLIOONUJtpIGmWATa5HWqBPiG3vrqxwsYYqapa5akPDlv2UDeILCfAmhVYw==
X-Received: by 2002:a05:600c:c05:b0:3db:2252:e50e with SMTP id fm5-20020a05600c0c0500b003db2252e50emr38909020wmb.24.1675003190556;
        Sun, 29 Jan 2023 06:39:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db0bb81b6asm10477843wmb.1.2023.01.29.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:39:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/3] ARM: samsung: pull for v6.3
Date:   Sun, 29 Jan 2023 15:39:44 +0100
Message-Id: <20230129143944.5104-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230129143944.5104-1-krzysztof.kozlowski@linaro.org>
References: <20230129143944.5104-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-6.3

for you to fetch changes up to fe6a952b567f6a771d087d2e969914f31574d6ab:

  dt-bindings: soc: samsung: exynos-pmu: allow phys as child (2023-01-29 11:36:10 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v6.3

1. Correct s3c64xx_set_timer_source() prototype.
2. Re-work MIPI and DP phys as children of Exynos PMU system controller.
   This both better reflects actual device hierarchy and allows to
   remove later few warnings from dtc W=1 and dtbs_check.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: s3c: fix s3c64xx_set_timer_source prototype

Krzysztof Kozlowski (1):
      dt-bindings: soc: samsung: exynos-pmu: allow phys as child

 .../bindings/soc/samsung/exynos-pmu.yaml           | 71 +++++++++++++++++-----
 arch/arm/mach-s3c/s3c64xx.c                        |  3 +-
 2 files changed, 59 insertions(+), 15 deletions(-)
