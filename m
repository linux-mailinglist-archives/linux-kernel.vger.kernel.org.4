Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D567EE7C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjA0Tmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjA0Tmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:42:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE074A40
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r2so5895030wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=laJbzm3hNFvKVQdtgilxX5HQETMASKmZLxjfb/658O4=;
        b=nI6Ug6W8ctMCQtI1vVqDWj8MpjBhnWeeT31JylQQfqpiYHv2PIYko9EILdTGUMfHun
         BV7C4e6AAanGxKd7QxFGz+11XVELz2+slWa28dZ+PhwvPC/xB38end1xN7C1jAPghC+4
         Ti3PlMCgNRCz8JK07atg7xAtsDuCaG5gGwiS8rR8UrN7WYRAYQOTSAkwiHWviWYP0iKa
         5ClGwzCxxtcm3FdBL4Mh03InXChGiUDmVL0UzT0vnUkKiZQEFCibj37cuwbirsQhDbX9
         WNxhw85wenI0Fhc3ler070sioGpH0o+6Yamb5V/OORturTxwSie1BBaAInjRQ6lAASUJ
         gF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laJbzm3hNFvKVQdtgilxX5HQETMASKmZLxjfb/658O4=;
        b=otRDeiyscr1lHYlN6Ppk3SUPSBthEXZze9R7Cg5WE+iuw3uWFJnZo/o/yKzL41oifn
         7ZNLZKNlC/LOi0i4nmJ/AlGMSWIV5jDfH2WR3+0AtwrYrqwzEdQ+8ApB55h5xzET/zZs
         g+xvOi+ZOi9B08G4v38eQPlQ0bp6H7TwEKioxYcHFUxfxatg6XZ/PqyLBNFlTZx5DGxh
         lkyiCiBZsK58TiLrfGlpp/xYL2J4DRGkVCta6zpUTeXQNEL8CF8wdPySQk1jHVcuCfNt
         AyX0Yc8/28NYrV/JJcgC3BfMqzun9MlvIjBdecFlB5fXo+SWos6CfJ7Gyhht6hjHkOwm
         JPWg==
X-Gm-Message-State: AO0yUKVf6rzWhBg9piy4DFlnZqW/iC2PsIcJIsAuc9nW9QqaKNBP03Cw
        v0x5mTmonuHvj+ouIeQRmCn6gw==
X-Google-Smtp-Source: AK7set8N28+EX6KUi96o3PeCOm9vKAuOFZYK3aIRSmt7I8LzRlQeQ5HFryKL/vW3McfrcWRpm4j0NA==
X-Received: by 2002:a5d:658d:0:b0:2bf:ae43:108d with SMTP id q13-20020a5d658d000000b002bfae43108dmr14352920wru.28.1674848466678;
        Fri, 27 Jan 2023 11:41:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b002238ea5750csm5822417wrr.72.2023.01.27.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:41:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/8] dt-bindings: phy/samsung: move MIPI and DP phys under PMU
Date:   Fri, 27 Jan 2023 20:40:49 +0100
Message-Id: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The MIPI and DisplayPort phys are actually part of the Power Management
Unit system controller, thus allow them as its children, instead of
specifying as separate device nodes with syscon phandle.

Dependencies
============
If entire patchset is okay, then it can go via separate trees:
A. I will take first soc patch.
B. phy patches #2-#5 are independent and can go via phy tree.
C. DTS patches depend on (B above), thus they will wait one cycle and get
   applied later.

Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  dt-bindings: soc: samsung: exynos-pmu: allow phys as child
  dt-bindings: phy: samsung,dp-video-phy: deprecate syscon phandle
  dt-bindings: phy: samsung,mipi-video-phy: deprecate syscon phandle
  phy: samsung,dp-video-phy: deprecate syscon phandle
  phy: samsung,mipi-video-phy: deprecate syscon phandle
  ARM: dts: exynos: move DP and MIPI phys to PMU node in Exynos5420
  ARM: dts: exynos: move DP and MIPI phys to PMU node in Exynos5250
  arm64: dts: exynos: move MIPI phy to PMU node in Exynos5433

 .../bindings/phy/samsung,dp-video-phy.yaml    |  5 +-
 .../bindings/phy/samsung,mipi-video-phy.yaml  | 11 ++-
 .../bindings/soc/samsung/exynos-pmu.yaml      | 71 +++++++++++++++----
 arch/arm/boot/dts/exynos5250.dtsi             | 24 +++----
 arch/arm/boot/dts/exynos5420.dtsi             | 24 +++----
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 19 +++--
 drivers/phy/samsung/phy-exynos-dp-video.c     |  7 +-
 drivers/phy/samsung/phy-exynos-mipi-video.c   |  7 +-
 8 files changed, 105 insertions(+), 63 deletions(-)

-- 
2.34.1

