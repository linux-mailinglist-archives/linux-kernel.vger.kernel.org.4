Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785EB6B16B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCHXjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCHXii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:38:38 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCF65C61
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:38:34 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17683b570b8so508696fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678318713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59RnUUeXUSnsMfT51jFg2QQnLPiQn/N+3fHwfoGuKl0=;
        b=pF1RglZCkn5XIyOdWnyrmL8yTgBs1+95aNqxPg2mjlZQLm4EI99ZyCF4ldmppwfY7m
         SasK2e3cl9aIuv9zdQTbmuso94/gVRjDw6jWdUERQkAAXL9apO+VWMzkOrgFIqE1R/oE
         HcAp8jLvUWFPE/I744zd/Yaq51nSaZC413gL8BSvdQ6+2Eva13dMptuK2LvPsvaYj3dm
         BCdH/rGisBSwjztRqyj4WqXu+hr9/dQJXBye8LZ7PES1L0heGNKxMfQmQTU8wdhJF23J
         M1E0z2xB2rnNkGoTqMTTkeXqAsMtWXKmzeTV79if8Cnj3q6Nv6LAk4YxntEpCsXyPbZi
         pOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59RnUUeXUSnsMfT51jFg2QQnLPiQn/N+3fHwfoGuKl0=;
        b=CNxOIJ4xehZSazN4a4+4rFhRAGn1GjqPskUwOvxSHb9jk5yFAnFWMmz1jc5Aq5PFv2
         d0KHpwzQ6/RHKZ7uTJgsM92eFFZU1FdZgJ3d4icZ9foUQmFECZUP35YOFlaKee9tM49c
         PgROheVEkh73zSWhsRz+D6GaY1/GwV8ZJRGFZx6crs1suBrUxCnyGIKBy83FaG/1a5vm
         TcQC6bkPx+ae6hFyeKhPR9bpTElsBtBLxqS0HcbsSnQZjYzGFTKFpGSD6BR5Exed7WX+
         vl0EcDVxeFaqzF72GUjbdXRMYHxH/+qVvN0+YrKAAVjkt5Y+nlWPrL1+0p/lX4ZV6M4c
         O+Lg==
X-Gm-Message-State: AO0yUKU0yM1l4iHB3RFkByC6X99U8DurKe1oA79h/sI2QqeodqQ+35Ai
        zcEppnfQBYl0oIcM+lF91C+2Pg==
X-Google-Smtp-Source: AK7set8plTEasFR06vuaD6t4Lm3l0XcW1Bwx+tNAfbenG0REitnea0SJSCX6JNlqc4IDv6vB7Dd2Mg==
X-Received: by 2002:a05:6870:d1c3:b0:172:36ce:91d0 with SMTP id b3-20020a056870d1c300b0017236ce91d0mr2341540oac.38.1678318713251;
        Wed, 08 Mar 2023 15:38:33 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id ax39-20020a05687c022700b0016b0369f08fsm6735660oac.15.2023.03.08.15.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:38:32 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: exynos: Remove clock from Exynos850 pmu_system_controller
Date:   Wed,  8 Mar 2023 17:38:22 -0600
Message-Id: <20230308233822.31180-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308233822.31180-1-semen.protsenko@linaro.org>
References: <20230308233822.31180-1-semen.protsenko@linaro.org>
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

As described in the corresponding binding documentation for
"samsung,exynos850-pmu", the "clocks" property should be used for
specifying CLKOUT mux inputs. Therefore, the clock provided to exynos850
pmu_system_controller is incorrect and should be removed. Instead of
making syscon regmap keep that clock running for PMU accesses, it should
be made always running in the clock driver, because the kernel is not
the only software accessing PMU registers on Exynos850 platform.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index d67e98120313..aa077008b3be 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -200,7 +200,6 @@ gic: interrupt-controller@12a01000 {
 		pmu_system_controller: system-controller@11860000 {
 			compatible = "samsung,exynos850-pmu", "syscon";
 			reg = <0x11860000 0x10000>;
-			clocks = <&cmu_apm CLK_GOUT_PMU_ALIVE_PCLK>;
 
 			reboot: syscon-reboot {
 				compatible = "syscon-reboot";
-- 
2.39.2

