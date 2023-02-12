Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E1693978
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 19:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBLS73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 13:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBLS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 13:59:27 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD011143
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 10:59:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso2152843wmo.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmOvnEkaqrRpifwEMdH8ouHFrGB+gA1HRCLLbZbkxcE=;
        b=A/A9bnKggSe4CtixJPIXg2+ocd3ky1Zf88YMRLyyctEVsVzTjAuGLCYwMqY+b1uXRF
         1b6lKDkCcNyCryVa4tNBGBZMbr5UT5fBc+O7Gpsb/yGgxOOcg7NwQanPKAfrF6EH97mB
         Y+Svm/g/09FFelQy+xYSR61uoGxlLE3WO4sRaSOGER9CqMFe5nKOl2PkVf4Z0lR53qGi
         xV26sAos0E8gn0AnkE0zFPhlZnmu8Ng+UWYeKNKOVtKNzjJfE7uiSH/RkV0MQHRA7kks
         WOVtB0PZyKUWJ5eAifKTNvF2DI6GCIC6O17Tv5daf3tVHfve7ziLPCMDxDEVzspZAcet
         Do3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmOvnEkaqrRpifwEMdH8ouHFrGB+gA1HRCLLbZbkxcE=;
        b=seDi4A1nZ38RiJHcOIMN6KVmz8Osnl2fJpCs5/ghJcxinLjy49YUWGk7hCmwqATpdd
         hAAE5mtkQw8Xz6gV62IWt98KL9eQGnQaEmYATy0YK64/DysRAD7dBhpZTR/g8hh8YHBS
         w9Ccitj6SXccwCQhqHUEdsEO+XzQzOEi3aF4jvzPhlCU+qkEGQ3zoHGHSMNQK/rqWUTd
         H2iClWHpo829rI1wbOfkMK1hH6uGggHhgKI9DtDCYUpRfVLPSv9JMhubUDJFgU0lUP5B
         jPBdL6lKOzO2aFAZ7tHJMcv3xvw5GPv3N1BBUPvDnmeAX7ONLBV0JcoX3BCJJjUaNaV2
         Slwg==
X-Gm-Message-State: AO0yUKV2N+GAowS1pBO2SE1KBIP2ZwJWGqQ1lRaG1gsCguK4lBuiwqgT
        34L6evTOujhI89rM/D6W3diacg==
X-Google-Smtp-Source: AK7set+SpidB+O2lsrnojHpqhI3WV5OLqCeRA0fDizUjdBPfOefwNNQTUyaGj7CS1grOOenVKI5CEQ==
X-Received: by 2002:a05:600c:30ca:b0:3df:c284:7e78 with SMTP id h10-20020a05600c30ca00b003dfc2847e78mr19176238wmn.38.1676228363627;
        Sun, 12 Feb 2023 10:59:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003e118684d56sm12391350wmb.45.2023.02.12.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 10:59:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <t.figa@samsung.com>,
        Mateusz Krawczuk <m.krawczuk@partner.samsung.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: exynos: correct whitespace in Midas
Date:   Sun, 12 Feb 2023 19:58:17 +0100
Message-Id: <20230212185818.43503-1-krzysztof.kozlowski@linaro.org>
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

Correct indentation and whitespace in Exynos4412 Midas board.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 763bd3441c5b..3be48de5c130 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -497,8 +497,7 @@ &fimc_is {
 	pinctrl-0 = <&fimc_is_uart>;
 	pinctrl-names = "default";
 	status = "okay";
-
-	};
+};
 
 &fimc_lite_0 {
 	status = "okay";
-- 
2.34.1

