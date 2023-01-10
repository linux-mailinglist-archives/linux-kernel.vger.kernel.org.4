Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D3664B26
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbjAJSjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjAJSh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:37:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3366E136;
        Tue, 10 Jan 2023 10:33:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ja17so9473194wmb.3;
        Tue, 10 Jan 2023 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Y1nMwWnnzoIU66WxhIxzkUN8go5QhinLrg0UAABFHI=;
        b=fXnO/ed1z90y8H+xIsqtGdGttUPNzWoN0/ovP55BMzWC/h02ytTLEtl+TNdgxNhCaI
         KlBSrZdkj2qzkcD4MpKX++YC8FGxqGaIqBHfFJ5M5hEVrxFkQmewwG+pdNBBRhnmVG5y
         dPxkY9AxCHwna8dTAQ3mgSNKcg4VvcXHAFwZLZVLKtYs5hJdvx8gSUfgbvP1K7/Cacd8
         QF3MuwOWWrT3jTsjvTHWYsGNyuy9l3KAOb8kt7teYTuERasVqkMg2un2vImlwIHhTceM
         4JBZ7iLtXX67ov1e2YiEq+luW26oD2jjPaHG9zURN3p4WxL3BgOCkl/jmkB+lP0YCjZM
         YUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y1nMwWnnzoIU66WxhIxzkUN8go5QhinLrg0UAABFHI=;
        b=FzLEj1YOuU/h4bXH/ARxmdETr/mhaMQUFukWyBwmpgYQcnSZjVnc46jU18ite4v3Hs
         84Dnl8B9IbgRTlhGhi4RqY8meDp/cPlISUqjC7lhJN3LOOI3fzDC3n1TG/iapSPaUgpn
         joQFs5QDDJsYN2NLVbD0x440MsYtWRUBz8eK9SFY5U4lv5nZ0B49exWI4PP8E9cjaINR
         D1iv+IYzplflarvkQudwUmg9xev7AHkUFmo1i49D5yHbmwmP6LBuqexfL3xgp+vebVxT
         MSEkzGYNEw5qY61HK5XRSBgBRFX7ZxjYm3g7B5HILzGNqzPQfvJNDXw4joeeU8X010DD
         SzbA==
X-Gm-Message-State: AFqh2kob9rATAOJmE1jFS8Cd5rhbMuZVW6b+whNNKsfZ64C2yWekmqhT
        2fOikTkAgFwczDIHFHqSTIY=
X-Google-Smtp-Source: AMrXdXssL+Xd7EON7O9ZwXSQ3T04sO1h1rLKbXPj4KYCCXjhO8SCErenxjjtXToa5xWdYFWmse8itw==
X-Received: by 2002:a05:600c:556f:b0:3d2:2a74:3a90 with SMTP id ja15-20020a05600c556f00b003d22a743a90mr52551528wmb.22.1673375590657;
        Tue, 10 Jan 2023 10:33:10 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm19927757wmr.21.2023.01.10.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:33:10 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 4/6] ARM: dts: qcom: fix various wrong definition for kpss-gcc node
Date:   Tue, 10 Jan 2023 19:32:57 +0100
Message-Id: <20230110183259.19142-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230110183259.19142-1-ansuelsmth@gmail.com>
References: <20230110183259.19142-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtbs_check warning now that we have a correct kpss-gcc yaml
schema. Add additional qcom,kpss-gcc compatible to differentiate
devices where kpss-gcc should provide a clk and where kpss-gcc should
just provide the registers and the syscon phandle.
Add missing #clock-cells and remove useless clock-output-names for
ipq806x.
Add missing bindings for msm8960 and apq8064 kpss-gcc node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 5 ++++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 5 ++++-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1f3e0aa9ab0c..1e68b42acb91 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -880,8 +880,11 @@ mmcc: clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-apq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		rpm: rpm@108000 {
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 7e784b0995da..de87fcaaa836 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -570,11 +570,11 @@ IRQ_TYPE_EDGE_RISING)>,
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
-			clock-output-names = "acpu_l2_aux";
+			#clock-cells = <0>;
 		};
 
 		acc0: clock-controller@2088000 {
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index b0fe1d95d88f..61dfec3b9037 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -116,7 +116,7 @@ lcc: clock-controller@28000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 86f76d0feff4..f601b40ebcf4 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -473,7 +473,7 @@ pm8058_led133: led@133 {
 		};
 
 		l2cc: clock-controller@2082000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-msm8660", "qcom,kpss-gcc", "syscon";
 			reg = <0x02082000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 7debf9db7cb1..3bd07cac315b 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -183,8 +183,11 @@ clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-msm8960", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+			clock-names = "pll8_vote", "pxo";
+			#clock-cells = <0>;
 		};
 
 		rpm: rpm@108000 {
-- 
2.37.2

