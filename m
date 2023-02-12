Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FC69397C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBLS7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 13:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBLS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 13:59:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759B011155
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 10:59:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so7529383wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 10:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxsfSwHbOtBhE136UHyiflGoE9pv5nsKma/ie2thAmo=;
        b=hgvKISWvwS4GNqbqJsW+uQe774YtfRNissNK+A6njsoOQpJ6PWAsE394OpVkoBZVZH
         lc1Uku9MrrmWDvRBldCo2f61zaH0MwBuesvuV38M2z0LX4yJkQdKCLc7Vn5V0IqVlauN
         grVeco8UVwvplZpETcs74Cv1VfCGaJkFt0g8YryTytBh231lFYnkH4FSTQaJxfLk4Rz1
         0Uf2jX2Q44szhoKiqVwnPMxQxlXvUEBALT738bB/sN8U+Azl2GJzGhL7cx1JRqY3BYDF
         tAR8jGfsRElrhWiglNPXI9/dt+99y7kqmma+KbQGJDtWEWCC9X17eu6EAvXbdMXuldm1
         BgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxsfSwHbOtBhE136UHyiflGoE9pv5nsKma/ie2thAmo=;
        b=PevFf8NYvVeLwSLd4S770ADkewUmWIpVvY67jE3KiR3O1mmSZ6qxKAEX6D7b+jbJTf
         I/31Qp3oc52o26Y03mwIBJDga49JpPeTKlLO4jl4blastV+LAViCurBHQq4Gvac30kmg
         goc7R/JuutnK/Wf/InajTNmeOxfstYU86z2bSHtbEjuFO1jBfy2WQPKFu5MUa03O+SXx
         j0SWkJOTXL2fuX7XQ1Hmc6GbPgAfB2ls4nzF0gPz55pjonRaAqxhL0IsXjbrJa9rtCf6
         h9XQOG9cOlhSbYSNGRzfmwJ88kEdz1fnFE/8Ao0xjCNrvnE3LjDfnfcD0h1okTHTH7k+
         oPoQ==
X-Gm-Message-State: AO0yUKUqeW3huBcpGvBkuF7Jw1rQpEhPj0MuoHAT3Wisp9VdGV5vUzcP
        3a2nAFMtr+YhpW5jNeqP3BjRCQ==
X-Google-Smtp-Source: AK7set/tKwv3pLiy7+ExTr5MSsGOqwEuYr/xqMWaWQmTb0IULnTrLs3ml6AcGAA+dql0fLFr7cd+2Q==
X-Received: by 2002:a05:600c:1656:b0:3e0:fda8:7e26 with SMTP id o22-20020a05600c165600b003e0fda87e26mr13729914wmn.33.1676228371111;
        Sun, 12 Feb 2023 10:59:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003e118684d56sm12391350wmb.45.2023.02.12.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 10:59:30 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: s5pv210: correct MIPI CSIS clock name
Date:   Sun, 12 Feb 2023 19:58:18 +0100
Message-Id: <20230212185818.43503-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230212185818.43503-1-krzysztof.kozlowski@linaro.org>
References: <20230212185818.43503-1-krzysztof.kozlowski@linaro.org>
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

The Samsung S5P/Exynos MIPI CSIS bindings and Linux driver expect first
clock name to be "csis".  Otherwise the driver fails to probe.

Fixes: 94ad0f6d9278 ("ARM: dts: Add Device tree for s5pv210 SoC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 5cf75cccd088..cbc108217483 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -566,7 +566,7 @@ csis0: csis@fa600000 {
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";
-- 
2.34.1

