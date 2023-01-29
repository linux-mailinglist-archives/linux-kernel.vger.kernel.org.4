Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093DF67FF95
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjA2Ojy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjA2Ojw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:39:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C518B33
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:39:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m15so6419637wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3N6vf7d9YqgQO0xbinr/8i1dp426tGC7mdRVcVYqt8=;
        b=CyQfxw6+djzwaeaWAI4+2lsyBsjZ9bKAASa/NQa24HGj7lRToYuZaZsum+kVwtHYYu
         LjkKZlffPh1fBLNHKUoT0gjy8DG6e9tFI88t+rVstd73Tum0yyZ0pIVrileH3lQNqJlH
         3Ia3wisp42rR+xEZMtiRlkjbhKDKjMylI2Db8skJYEihzL5b7IJvL9zGZXphgaIpi3he
         WWTsgK/nJrB7SZEIfHDCjgob6Z3/KUgoEDZ70dakpo30NKY25FVFUizWcStbEy0QokOm
         Hp7VdnprVcqlgkqVR42z30pkMc+fRz2eGZSYtgBh7qE9aCPWk5fjza4dtOpM1tFNOfXS
         M1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3N6vf7d9YqgQO0xbinr/8i1dp426tGC7mdRVcVYqt8=;
        b=hHV8kYOzLRkU3amYmLvYel8Atv4VsVlm+fa5hd1msrMfIr/jtJvpmOTq34b+VW7Mb9
         4PVUR60e7uMClVU8gBD5dlAaRB97Rp8jdb7oJ8owl9kICBsLsBxigHoC67ZbdCU8I4jb
         Y4ZOdjf6i9iUsiG3AYdMjlOsBAvmWqif1TY6ECjMSih5kP7LKsDWsgKq3Uw7/Uy+l3V2
         rGMn0+Gv2cjUpupWB3ewEx/2Q8G6IlSHvvfmsAcO5Hhe8Hw2cAccfNY6GwYwpyrYEAm0
         GeC7TQT9qelcscNEMHBIq+s/ed1edZtAGL9r+G18m7+SJB94IS9xeREUnGrqBLoZrY16
         uKXw==
X-Gm-Message-State: AO0yUKVfu7n+4YR3iwrAtQuAt0CqlxtYBzuDKXZ3MMdtUqa8RH6gLYpE
        qBhGyBFq2kFlwZ7FgLtNTBXIKg==
X-Google-Smtp-Source: AK7set+1gEkytHfnRrF3YhhOU6Y4o7hT6tQ6rb7HkQeDmhMhykJfZpfli4/RtuHfElnJbWJ+9tdAHw==
X-Received: by 2002:a1c:4c19:0:b0:3dc:5342:9f53 with SMTP id z25-20020a1c4c19000000b003dc53429f53mr2390597wmf.38.1675003189342;
        Sun, 29 Jan 2023 06:39:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db0bb81b6asm10477843wmb.1.2023.01.29.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:39:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/3] arm64: dts: samsung: second for v6.3
Date:   Sun, 29 Jan 2023 15:39:43 +0100
Message-Id: <20230129143944.5104-2-krzysztof.kozlowski@linaro.org>
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

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 56a14f01a54568e049e22c46ffc654602bbd01d1:

  arm64: dts: fsd: Add sound card node for Tesla FSD (2023-01-17 12:15:39 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.3-2

for you to fetch changes up to 28dd277e54ebb499bc59c166078596767bbbbdd7:

  arm64: dts: exynos: add unit address to DWC3 node wrapper in Exynos7 (2023-01-29 11:34:29 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.3, part two

Big cleanup and rework towards achieving zero-warning of dtbs_check and
dtc W=1:
 - drop or correct incorrect properties in several boards,
 - add dummy regulator supplies when necessary to fullfil bindings
   requirements,
 - use lowercase hex,
 - move non-MMIO exynos-bus nodes out of soc node,
 - add unit address to USB DWC3 nodes.

----------------------------------------------------------------
Krzysztof Kozlowski (11):
      arm64: dts: exynos: drop unsupported UFS properties in ExynosAutov9 SADK
      arm64: dts: exynos: disable non-working GPU on Exynos7 Espresso
      arm64: dts: exynos: add ADC supply on Exynos7 Espresso
      arm64: dts: exynos: correct Bluetooth LED triger on E850-96
      arm64: dts: exynos: add VPH_PWR regulator on TM2
      arm64: dts: exynos: add interrupt-controller to WM5110 on TM2
      arm64: dts: exynos: correct wlf,micd-dbtime on TM2
      arm64: dts: exynos: use lowercase hex addresses
      arm64: dts: exynos: move exynos-bus nodes out of soc in Exynos5433
      arm64: dts: exynos: add unit address to DWC3 node wrapper in Exynos5433
      arm64: dts: exynos: add unit address to DWC3 node wrapper in Exynos7

 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     |  2 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 17 ++++++++++---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 28 +++++++++++-----------
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  4 ++--
 arch/arm64/boot/dts/exynos/exynos7.dtsi            | 14 +++++------
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts   |  2 +-
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts   |  2 --
 7 files changed, 39 insertions(+), 30 deletions(-)
