Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122DB748713
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjGEO70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjGEO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:59:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FC1735
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:59:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99384a80af7so249612166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569144; x=1691161144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0VNzB+MriQ9BG4K4qokulMx9kQTLwPATV3LNvBr25cQ=;
        b=hjWKurOtmqtWXbr3mSIf/L9OQms/n9RTowc2zhmz9nsfo+HvrErke4NLYsIZiSgjlp
         o0WsUWqPzdX39GBzx+EemPZvQNYCIoAcMRiqTOv3TV70VX4z9gKe9raszFCXUq47eECZ
         Pt3YsEOOnMA+hq3XhuVVAFTHwLitjjmoUku30lkfFj/JjYrNsTwMV8MFY/Buc4/iIHIM
         37GyfNbLC+3PBUWBn8YCdHMqIAiNoAObOeby6VajYz8RGZE4d+qrnjV9JOlX0FwhMih+
         rwIGB/K+DMOFQKxuj55voB7uq8mzvZIK4LGBCCJ10yYI7wDhZ9AlOazEW1xPH1VMqBM+
         unrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569144; x=1691161144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0VNzB+MriQ9BG4K4qokulMx9kQTLwPATV3LNvBr25cQ=;
        b=E3CjbvECQlG6lvecupugqFGqfc2WlSCuTnF4VH5Mx1QCQQS9a1gGE+RpVYwOUltaKr
         uZAxKqY5bochUhdj8dRCdgCRseek/Zd5kB9UkxBKMAprHhmQj6A5iHB+gy+CJbPA5qIL
         6HWzaxgCpB0BKKurdAOGgzIGIud5f/5yCk0AzFAZYGDAUBFKOGTyvRsglh9JzCi5QQt+
         eq5cpcfScjaoWLcvkCA/CvCXogUsQC6XfoCCAzGeqy9ZrXjQMpyl1INmCQtWHzGx7wGr
         w/NXe7+Z5IcNWpYR3WiKUUhs5DVoPF+7THeMWafZQUBrl/wE0sg6g8Z3sC+zAElA5Tlo
         Y7uw==
X-Gm-Message-State: ABy/qLYf9BBgrpZtGRpnw6MFk3oLB0a+WpyVXWAFIxoyoHUHtIxm6qC7
        IsLhNDZPfHI2jRbiXTsM1M2LVw==
X-Google-Smtp-Source: APBJJlF7I2RU8dWT3drf/l5wsrLFM9ZWN+E3OqVP01I0ERAyLy6TxUsBD/Q2Yf1G9XgUJgJ2kGO81g==
X-Received: by 2002:a17:906:4e06:b0:98d:9ded:f87f with SMTP id z6-20020a1709064e0600b0098d9dedf87fmr9221656eju.10.1688569144505;
        Wed, 05 Jul 2023 07:59:04 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kt19-20020a170906aad300b009894b476310sm14786411ejb.163.2023.07.05.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:59:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: rockchip: add missing space before {
Date:   Wed,  5 Jul 2023 16:58:59 +0200
Message-Id: <20230705145859.293260-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index 4d9ed2a02736..1a60a275ddf9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -125,19 +125,19 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
-&cpu_b0{
+&cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
 
-&cpu_b1{
+&cpu_b1 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
 
-&cpu_b2{
+&cpu_b2 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
 };
 
-&cpu_b3{
+&cpu_b3 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
 };
 
-- 
2.34.1

