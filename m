Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805996B6AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCLUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCLUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:13:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0BC1D937
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:13:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r15so13622212edq.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678651996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrwYjNV6mJ0i3LL43835L0mofvWBt6i3d7rX0R7WumA=;
        b=UWesG79Ta4OMzrEmbkUOCWmUYwaQ6B6BQNTxr6gixaKxo+3TvjuNmJU+ZUCiomC9KG
         0txVGwd55gBUFIyrflcXf8l7kaFWqPm53tz/xgHY/01759029KtNyWHtxJd4wbKlbchy
         i6yS1QZENmU+egHd4v4djuxmMNmIXfHJ7Ax2+IoDIjtG8Mue6t6t1NdFqsCcU0M7Ie02
         T+2XND2UDujYUMguBsDGF8rLl9AUFwv4SnAzjEw2tVUM6J+xeipzt1u199lvEky3SIPy
         JwC2GHNj8XAD8fdeE9M+nF35P6DqDu3k91VceyLxavF3VzetegWgJjeQuHPmtyntyOXG
         iUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrwYjNV6mJ0i3LL43835L0mofvWBt6i3d7rX0R7WumA=;
        b=K0/QRU6sZw1wYTXkioe6KPxQYkDgblPgPPZVR+Bh43IZerYJCN6OKA3gXsK9a2dIqX
         +F2gZmg2hCzBkD0MOdKcxyY+Cv9a70uMdzj1+DAm1ZXKZPI8i4ladXkMA9RJ+PQayhus
         AT64nz13EwLc4NEkIerepnivAH7sYuT61bRjo/GoGoUUBzTzbr7M4yr+0Wr2ZttcYLyF
         KDxoz9ybIXRX7KFtFfzWaDG4VN73tUT6WdcwrTKcojWQRjdgUssEHSFZyKW1TIFatphU
         V3ZkXt43k/uHn0zKg7dDwyDYA1oR1TvN9rkHblbQkjw7HnL7YjMqgU4Izoie6Cj5L/H4
         OEjA==
X-Gm-Message-State: AO0yUKUdkgR+M/qBX/Asxg5VYeccUdq1ilAFaOAPT211fq8RicEC4sIX
        hF0PzXfsGEoyu47JTdSi7V8AiA==
X-Google-Smtp-Source: AK7set+JSZFCtUqa0htp3FsDgRZ38BnXCzbKdmSD5mKvb6yERsxd9a2WRZmOUCzfMaIJJ8rQL39ZPw==
X-Received: by 2002:a17:906:99d4:b0:908:1164:6358 with SMTP id s20-20020a17090699d400b0090811646358mr38387928ejn.21.1678651996517;
        Sun, 12 Mar 2023 13:13:16 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id lu33-20020a170906fae100b008e938e98046sm2537754ejb.223.2023.03.12.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:13:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: marvell: align thermal node names with bindings
Date:   Sun, 12 Mar 2023 21:13:13 +0100
Message-Id: <20230312201313.498434-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect thermal node names to end with '-thermal':

  armada-8040-db.dtb: thermal-zones: 'ap-thermal-cpu0', ... do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 10 +++++-----
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 4e6d29ad32eb..2c920e22cec2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -317,7 +317,7 @@ ap_thermal: thermal-sensor@80 {
 	 * first one that will have a critical trip point will be chosen.
 	 */
 	thermal-zones {
-		ap_thermal_ic: ap-thermal-ic {
+		ap_thermal_ic: ap-ic-thermal {
 			polling-delay-passive = <0>; /* Interrupt driven */
 			polling-delay = <0>; /* Interrupt driven */
 
@@ -334,7 +334,7 @@ ap_crit: ap-crit {
 			cooling-maps { };
 		};
 
-		ap_thermal_cpu0: ap-thermal-cpu0 {
+		ap_thermal_cpu0: ap-cpu0-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
@@ -367,7 +367,7 @@ map0_emerg: map0-ermerg {
 			};
 		};
 
-		ap_thermal_cpu1: ap-thermal-cpu1 {
+		ap_thermal_cpu1: ap-cpu1-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
@@ -400,7 +400,7 @@ map1_emerg: map1-emerg {
 			};
 		};
 
-		ap_thermal_cpu2: ap-thermal-cpu2 {
+		ap_thermal_cpu2: ap-cpu2-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
@@ -433,7 +433,7 @@ map2_emerg: map2-emerg {
 			};
 		};
 
-		ap_thermal_cpu3: ap-thermal-cpu3 {
+		ap_thermal_cpu3: ap-cpu3-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 7d0043824f2a..0cc9ee9871e7 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -25,7 +25,7 @@ / {
 	 * The cooling maps are empty as there are no cooling devices.
 	 */
 	thermal-zones {
-		CP11X_LABEL(thermal_ic): CP11X_NODE_NAME(thermal-ic) {
+		CP11X_LABEL(thermal_ic): CP11X_NODE_NAME(ic-thermal) {
 			polling-delay-passive = <0>; /* Interrupt driven */
 			polling-delay = <0>; /* Interrupt driven */
 
-- 
2.34.1

