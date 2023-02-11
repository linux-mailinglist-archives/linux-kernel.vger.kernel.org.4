Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D92692EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 07:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBKGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 01:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBKGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 01:39:57 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2014015CB5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:56 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15fe106c7c7so9385455fac.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTv8boWiXl3Q8qm/+aQVqDvix+KsA9tTjnV3RAm1YEo=;
        b=P+Oe5a1pah+Zr4CuFWfmfhGPerI7RTROI4usQQ2as0MnIS9p+f6YgVRk3NgRFqS9Xh
         eWf8bjcqxRlb2VDSvKosj6dA3lU6PrnwDQQJLvWOFv7Xg5S//x42J65AWr8Hu5iEFj0c
         L4JKGZrSXTKj5Llrg56gIgyr++/EEdJ0awwxN1IbcMglmp303lVfpjUhRb9s3GIBqOCQ
         hk6wOO0mPvIx+e2tZuAdLkvGOhPS3CTdyluXRAhS/0Gv8LkG4BDl8C5/0vXWMUsTqETg
         l1mb1a/etj+ePFvFMkIKnuesZWjDSZr/cVBT10IO90OGuv7MkxIE8KksHv8H3lPBPRVI
         OWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTv8boWiXl3Q8qm/+aQVqDvix+KsA9tTjnV3RAm1YEo=;
        b=2xBD/Th4SxY5M8GeU50c9+3rBgsUzHpo4voGg5nEybcUgpLlyzhS7ou775KIWtUirm
         NhI35wCdlLaC5HkWGiHPz3vTUyYer8EO85DUeBZyw2Abrrs+bRzw6cX3p259s/0bdqCg
         9H1j8UaMxYilq3KzqhfILDzAzGGLJhFkh2aFuqs9YLpXnp8alIM30+kAyUZJuhtrwNkr
         sVa01PpY2yZhUY2Ip6ijsQSZfN2CabUbAUwSari78zsJDkLsIPAXVixGvN3+JNgAzHSH
         fkRJBFTly5Q57KM8ZbMVlW97NCZLtEpqPY4Y8ocxFkf8yOSBMDLBPyLYG+7dBKs8uxjW
         JYHw==
X-Gm-Message-State: AO0yUKWLzkYKn8aH6J7vXD8VPA1NdfcVF0QTILn7cgyLQMiYFx4w5EcS
        Ed07s+Au7Nd8+H0HmKSChwzKng==
X-Google-Smtp-Source: AK7set9uzrsntw631tV4DP3rQ7Jj6aGuIrMBBqtNYlcwRR5cuwwLS0QTP9SXjkJTUM56WsqM07CgcQ==
X-Received: by 2002:a05:6870:8a21:b0:16a:a457:655d with SMTP id p33-20020a0568708a2100b0016aa457655dmr6828806oaq.5.1676097595431;
        Fri, 10 Feb 2023 22:39:55 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id ed52-20020a056870b7b400b0016b7fe3be05sm1734264oab.39.2023.02.10.22.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:39:55 -0800 (PST)
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
Subject: [PATCH 6/6] arm64: dts: exynos: Add CMU_G3D node for Exynos850 SoC
Date:   Sat, 11 Feb 2023 00:40:06 -0600
Message-Id: <20230211064006.14981-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211064006.14981-1-semen.protsenko@linaro.org>
References: <20230211064006.14981-1-semen.protsenko@linaro.org>
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

Add missing G3D clock domain to Exynos850 SoC device tree.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index a38fe5129937..d67e98120313 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -245,6 +245,15 @@ cmu_peri: clock-controller@10030000 {
 				      "dout_peri_uart", "dout_peri_ip";
 		};
 
+		cmu_g3d: clock-controller@11400000 {
+			compatible = "samsung,exynos850-cmu-g3d";
+			reg = <0x11400000 0x8000>;
+			#clock-cells = <1>;
+
+			clocks = <&oscclk>, <&cmu_top CLK_DOUT_G3D_SWITCH>;
+			clock-names = "oscclk", "dout_g3d_switch";
+		};
+
 		cmu_apm: clock-controller@11800000 {
 			compatible = "samsung,exynos850-cmu-apm";
 			reg = <0x11800000 0x8000>;
-- 
2.39.1

