Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FD68E28E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBGVAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBGVAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:00:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13AE3EFEB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:00:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so38127wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 13:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlgFnyJhAjQmHhNX4qOW2pi75XTHZ1esiVbzz/8bJh8=;
        b=bDZabFBZCECGNPg9U5De6ba82qQxUaR/atFGtxl21gIUEEGRyRTy1LfVvVCLOumZKJ
         gewZ+7qQ0YFAGhuChClMRO5zhqjhtFGuu/PC4c26LDG3RuLXxAOe3b/SZhFFm9jtf9fN
         Xf5KTJazYmnMEWS8v9hGi1ko67ZA5b7SkkLE0ZZN0xFZFU9AhzoQqUxSoVuVmJcFOY4L
         lKGmZmDjB/puiyMU40TrnKQPnBJ9k48bwUM10+lM1qe1S3UjR5pleQJjYq22+eOrZKZO
         sxiRWhld9g3uDunICtlUgTWc3YBc1FYKQ+2bX15HrN7jgBz1ege7DBCP10NBpXyMoFh2
         XQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlgFnyJhAjQmHhNX4qOW2pi75XTHZ1esiVbzz/8bJh8=;
        b=BeTmbstq+AbQm4DouRHuJuUd5fowwBfDLCmu0YGo8yFuWTjxz/WVQm9kHJkhhjbl5E
         O9E9s65iBHAMn34VWioTJbJl0mkrr3p5vGOUbZNuEcwgZKrZpmBAPMmiDhtf7qo6GMJe
         aDhgcptlO4TaC80ElKxos5iIHpkyIG9UUDVCo9fLOn1NH0DjsHacJKnTEnBZiNanM6fj
         xSamae2doADK47jRsbeLuTFbFpV3F4UFzkR6kwI6bykeyX3qF8GBtCQO5L1HIy5YdKwV
         stcW0XbmPT+AW2p/13a/N0brGp5gCJq60NtZ+/rBJKCfNRWwaOl5pJ10VnMX6NuU70MI
         Rryg==
X-Gm-Message-State: AO0yUKU3K2aMAItG9lKu7uQV+9qGi18bY1iapc3irV4zQzYOnV67u5BR
        XEIVfUdwEDVPA3xrhLrGbFbKjQ==
X-Google-Smtp-Source: AK7set+dS/JlmvaqG9ve4HkmDVsmbYbnUQp+ydVCYixHgJYcC6Zp5Y8KLkqDO7o8ruo8ab8Czblr6w==
X-Received: by 2002:a05:600c:43ca:b0:3d9:a145:4d1a with SMTP id f10-20020a05600c43ca00b003d9a1454d1amr4337938wmn.34.1675803626347;
        Tue, 07 Feb 2023 13:00:26 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c44c900b003dc4fd6e624sm8041631wmo.19.2023.02.07.13.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:00:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/7] ARM: dts: exynos: Remove empty camera pinctrl configuration in Universal C210
Date:   Tue,  7 Feb 2023 22:00:15 +0100
Message-Id: <20230207210020.677007-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
References: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
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

The camera's pinctrl configuration is simply empty and not effective.
Remove it to fix dtbs_check warning:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml: camera: pinctrl-0: True is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 62bf335d5bed..20840bd0d062 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -191,9 +191,6 @@ hdmi_ddc: i2c-ddc {
 
 &camera {
 	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <>;
 };
 
 &cpu0 {
-- 
2.34.1

