Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A98C675B94
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjATRb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjATRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:31:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81E3D0DBE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso6335080wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNZuiGjzke67hV6Lxm3BYZSDSICDR3sdl8479uBb2FE=;
        b=wjRY7BWgBUyNxOIRJcTEf3K80ZyLGvewsJb3OSxVmAinjXchfzWhwYY6CZ4Ugic4ei
         6ckkluQJaX8LCFckNjg8LhZMOxThpIToRxlovxoz0ihgIKbazjclAnsS+an9Yqqxphye
         MYAYOWMYvIE7gOy8ejh5MyOqwtPXsR4a0M7h6bcFqOCnUEVFwgQYGd1D7goUR2TeA42p
         jSJnuCuePfpOUxu0vCxgietinQuEAYjaaDHO/wIziZ6app+bSI4A4T9qBFcu4an4D+OG
         WNPc/TC83yD6R2dEPPwBHLFn1aI9Sr+qb8OHIMoYUOHiwPy0M3KitOyy7a+/ZSzEr54K
         XA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNZuiGjzke67hV6Lxm3BYZSDSICDR3sdl8479uBb2FE=;
        b=n8dXTlveF40D5YpoYjNTAj3yHzdyQ1/GG5XMkxVHmJN98sBeZSHwJDtny420CIVQfB
         DJYxInMCT58O9kJZwE1C4xOEplOJBnZepkVt6l+pWI6vS1K5BVUpTcKwtOdeI1yC6ywB
         B2gtGLXm2zYcd+KeFVa5mKsGpN9gjvkBi0mMdXSS9+lC1Ex0HssiyzC+Qd2SawHfN2Gh
         dDU8b8fGoQNT91yErAKImTjYIfeUNNzarLgwZZiIXQFsPXzoGbUk54jfR74SI8dls1e9
         LoqdxNCt/LxnOw3e7zfaRa7sD+85xxu4LrZIwo5WcLDOAQNc7lukJvMqR+SXG7Itxy16
         SK2Q==
X-Gm-Message-State: AFqh2krX5OMxpH5QGeJDQ3Hnm9qu6gb+Z9iwYVVDYsk2yTCCEoqqb595
        PPgo2C+FfZi8CAlw0R7L5qYYAQ==
X-Google-Smtp-Source: AMrXdXtxqK17XhvXhGUs3RZf0sxHooxHOu6YL480CvpwaldjdG4B6niCLsiRAkJcqRWKfPIXOx3Jyg==
X-Received: by 2002:a05:600c:1d8a:b0:3db:f0a:cfa1 with SMTP id p10-20020a05600c1d8a00b003db0f0acfa1mr11661996wms.9.1674235886188;
        Fri, 20 Jan 2023 09:31:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003db0dbbea53sm2819179wmb.30.2023.01.20.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:31:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] arm64: dts: exynos: add interrupt-controller to WM5110 on TM2
Date:   Fri, 20 Jan 2023 18:31:15 +0100
Message-Id: <20230120173116.341270-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
References: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
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

The WM5110 bindings expect node to be interrupt controller:

  exynos5433-tm2.dtb: audio-codec@0: 'interrupt-controller' is a required property
  exynos5433-tm2.dtb: audio-codec@0: '#interrupt-cells' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 3785a6580bdf..5124027d7541 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1285,6 +1285,8 @@ wm5110: audio-codec@0 {
 
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 
 		wlf,micd-detect-debounce = <300>;
 		wlf,micd-bias-start-time = <0x1>;
-- 
2.34.1

