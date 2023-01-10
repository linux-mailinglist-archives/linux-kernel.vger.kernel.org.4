Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4064664B30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbjAJSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239573AbjAJSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:38:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54814B21;
        Tue, 10 Jan 2023 10:33:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so3519104wru.13;
        Tue, 10 Jan 2023 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgUSPgkZNi9+aw5MsL+nvvsBQhv42mqnLiL7QIKJbP8=;
        b=KeX3YHGESiG+jLtHxq1TcedaPtDcjupqtolPOvMK9w//qt6LipVt/e4gJ+5BQOK7iV
         VkcjrB29KHnRmkW8BBpZ4a29u0LWFjwaRHeVKGs1FYTVbiJ8m6G/Pc6fejlcTRm5m0Zt
         pTAzgxKiv+YZxv/1OP3//WswwqrjuFjwBwox2x4hFhVQ3ODUtVbL8ybG0jxl43INEmxu
         MI7dlSC3HzN4LtUJZSKmwNj6mtCZuP6DcKpK1QqeOcSoDLWA8Z1JYapayKWfDyx82Lt8
         DkDg9HV1gkBAE0kf6UusF9FUhV3i36kA6k0yen5dx09suTV8ezEXE0+hFA9WMfCcurN/
         wnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgUSPgkZNi9+aw5MsL+nvvsBQhv42mqnLiL7QIKJbP8=;
        b=L0l7fB5lDWv36JmXqq23egZaGnHJZOwlWhpOXri/5QwMwO42kyog5qXsnhZnL3oEJ+
         MAjnkZvL/yGOzVpsvTVOn8RQ5yimTxLO66qScKNG6qa75dnNolk/Zcc+eCIvu1++3Ga7
         DFCS9Wf8WQppGPzsIUR2LQK4AONqalm3p0fHc2EE//thi46XZB7sxmI6KGZrdqqKNkVG
         gj+tsj9VtD25+ivd4gIdE7MGphtEx+C90fNSbKlDvD1YuAUWo7Dmp8X3cfK/+9FaKRJA
         ipPZseoW/UXDb9apt02Cy9tiqgglhKbBico5G/6R8k94pfjKkUJ/aPubnKtFvPMC1ikM
         Blxg==
X-Gm-Message-State: AFqh2kpVxpSFGQJxGaIw/GhqPe4eK3o7ZGs8tywbR0iy78azZxBOGVE5
        58yt+Yo1gduyApifSHZJE4XCh9eagF0=
X-Google-Smtp-Source: AMrXdXtNjxw5eQhvyGKiiMLKo1d5Ee+OQnlYAmSeuTY7eauhBvzjQE7Cv3x1yP327iBAiRvbLxNLfQ==
X-Received: by 2002:adf:eed0:0:b0:2b5:47ab:6fa0 with SMTP id a16-20020adfeed0000000b002b547ab6fa0mr14054887wrp.38.1673375592758;
        Tue, 10 Jan 2023 10:33:12 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm19927757wmr.21.2023.01.10.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:33:12 -0800 (PST)
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
Subject: [PATCH v6 6/6] ARM: dts: qcom: fix various wrong definition for kpss-acc-v2
Date:   Tue, 10 Jan 2023 19:32:59 +0100
Message-Id: <20230110183259.19142-7-ansuelsmth@gmail.com>
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

Fix dtbs_check warning now that we have a correct kpss-acc-v2 yaml
schema.
Change acc node naming to power-controller and add missing
binding #power-domain-cells for each kpss-acc-v2 power-controller
to reflect Documentation schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 12 ++++++++----
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 12 ++++++++----
 arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 4b0d2b4f4b6a..51c5867eb950 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -353,28 +353,32 @@ saw_l2: power-controller@f9012000 {
 			regulator;
 		};
 
-		acc0: clock-controller@f9088000 {
+		acc0: power-controller@f9088000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9088000 0x1000>,
 			      <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc1: clock-controller@f9098000 {
+		acc1: power-controller@f9098000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9098000 0x1000>,
 			      <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc2: clock-controller@f90a8000 {
+		acc2: power-controller@f90a8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90a8000 0x1000>,
 			      <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc3: clock-controller@f90b8000 {
+		acc3: power-controller@f90b8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90b8000 0x1000>,
 			      <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
 		restart@fc4ab000 {
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index acb08dcf9442..ee464aedece9 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -325,24 +325,28 @@ crypto: crypto@8e3a000 {
 			status = "disabled";
 		};
 
-		acc0: clock-controller@b088000 {
+		acc0: power-controller@b088000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b088000 0x1000>, <0xb008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc1: clock-controller@b098000 {
+		acc1: power-controller@b098000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b098000 0x1000>, <0xb008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc2: clock-controller@b0a8000 {
+		acc2: power-controller@b0a8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b0a8000 0x1000>, <0xb008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc3: clock-controller@b0b8000 {
+		acc3: power-controller@b0b8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0x0b0b8000 0x1000>, <0xb008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
 		saw0: regulator@b089000 {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 4b485f5612c4..59613aa52e25 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -416,24 +416,28 @@ saw_l2: power-controller@f9012000 {
 			regulator;
 		};
 
-		acc0: clock-controller@f9088000 {
+		acc0: power-controller@f9088000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9088000 0x1000>, <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc1: clock-controller@f9098000 {
+		acc1: power-controller@f9098000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9098000 0x1000>, <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc2: clock-controller@f90a8000 {
+		acc2: power-controller@f90a8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90a8000 0x1000>, <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
-		acc3: clock-controller@f90b8000 {
+		acc3: power-controller@f90b8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90b8000 0x1000>, <0xf9008000 0x1000>;
+			#power-domain-cells = <0>;
 		};
 
 		sdhc_1: mmc@f9824900 {
-- 
2.37.2

