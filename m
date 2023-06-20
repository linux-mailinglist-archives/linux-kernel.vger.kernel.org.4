Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8526736A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjFTLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjFTLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:05:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3937210DA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b46d270ea1so41400611fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259141; x=1689851141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnfEhtDDR79cB+JFtObt/sWNnZM5L1YdVH546wXBYs8=;
        b=wU/8UQ6nXqxYFGp68FTCKcSnWpb/gYUxxrIcc9aDr0TNcWJ77k8M0UvXKKLLAYHxEP
         3+c7TZaiHOynszRfHfpALcvykypFvwaWo7ycXt9/Uy4G6xH54leb/97SsImTBfG60dXl
         QC9f89iF4xo4zfECxO9lOmdeIAHXG6cTJZvyOHQNe9hv/Q0We+RVWmigN9TU5r5J064g
         KzpOZzj0QuPwkLZzfwuHz3IXsLJerYg4kYlykkR22dkIYmZeFT0RSD0xB6Wo3arQLPTI
         R9AaGI9sqELUsOtF8F/zBneiPZqz9l4P0GTzZGXmIDaocBGCt4Z0GtxnUjK3yMdSO14L
         QOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259141; x=1689851141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnfEhtDDR79cB+JFtObt/sWNnZM5L1YdVH546wXBYs8=;
        b=O5K2ZjsZhZPnkpyt5Oa2HHIjm//2z8+G+cempU58nSJPD5M+hEDJevGrhpr6bxJzJL
         cROuZKxyu2abrqG7TYdRI2QHlPOdPcIu8HoUhGFJrCXwaIPub+0OT7Fpte9+9HS2f2TW
         mtEIumgNS60o7pLZlL6HcXwLqmMqYXDZop3riEcavTz3K1F2kHbMN3WOxTHLLIu8v8vD
         kZ6QXzKCTPDbCmMGSDlEsR47CZ5yn2/fppKTzyywhNWW8qhui9Jjs5haKx4Jhd6O9c7O
         /6MkeoQat27C5TmA0r9M7gl2KPDlGqgiEu+zJnWBZ+rNBaosT53OWg/6jwZoCkFvVOgE
         1rdw==
X-Gm-Message-State: AC+VfDwlmousaTkUqlqVVKeqpshDJ0mvRSbVayqSDqXzV69FE7lSbu30
        dntPoTnkYBaSLtTQClaglUeetA==
X-Google-Smtp-Source: ACHHUZ5z0plB70c5G+uV6as3l0ESzn6YBCngAMY2mllmoSMD9KtsOE7+Low5QUJYp2bDbucXoMEmZA==
X-Received: by 2002:a2e:b1c7:0:b0:2af:c9d8:87b4 with SMTP id e7-20020a2eb1c7000000b002afc9d887b4mr7761776lja.29.1687259141664;
        Tue, 20 Jun 2023 04:05:41 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c008b00b002ac7b0fc473sm369047ljq.38.2023.06.20.04.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:05:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:05:37 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8250-edo: Rectify gpio-keys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-edo_pinsgpiopmic-v2-4-6f90bba54c53@linaro.org>
References: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259134; l=3233;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0Nd+IdxLUHksSzQLBMfzn4JECl7I9SIpO0+ZAvt3EYc=;
 b=bc2ot/iKUegdQZ8gQDU/jocKCigfCb/6ZURQiAG07ACxdMU4T15qYmbOuuNKWjmy/XIFsODcA
 WcfqRF27u7BCtu9Rhtu6rAvMEfD7VIxpBUkWObGlF/QBdR888aZWlFr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up the corresponding GPIOs properly and add the leftover hardware
buttons to mark this piece of the puzzle complete.

Fixes: 46e14907c716 ("arm64: dts: qcom: sm8250-edo: Add hardware keys")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 10 ++++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      | 54 +++++++++++++++++++---
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index ea4571bf4fbf..58a521046f5f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -20,6 +20,8 @@ &framebuffer {
 };
 
 &gpio_keys {
+	pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
+
 	g-assist-key {
 		label = "Google Assistant Key";
 		linux,code = <KEY_LEFTMETA>;
@@ -48,6 +50,14 @@ &pm8150_gpios {
 			  "SP_ARI_PWR_ALARM",
 			  "NC",
 			  "NC"; /* GPIO_10 */
+
+	g_assist_n: g-assist-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
 };
 
 &pm8150b_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index 70da10fb9d9d..897b97db819e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -51,12 +51,26 @@ framebuffer: framebuffer@9c000000 {
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		/*
-		 * Camera focus (light press) and camera snapshot (full press)
-		 * seem not to work properly.. Adding the former one stalls the CPU
-		 * and the latter kills the volume down key for whatever reason. In any
-		 * case, they are both on &pm8150b_gpios: camera focus(2), camera snapshot(1).
-		 */
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
+		pinctrl-names = "default";
+
+		key-camera-focus {
+			label = "Camera Focus";
+			linux,code = <KEY_CAMERA_FOCUS>;
+			gpios = <&pm8150b_gpios 2 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			linux,code = <KEY_CAMERA>;
+			gpios = <&pm8150b_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
 
 		key-vol-down {
 			label = "Volume Down";
@@ -544,6 +558,34 @@ &pcie2_phy {
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
 
+&pm8150_gpios {
+	vol_down_n: vol-down-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8150b_gpios {
+	snapshot_n: snapshot-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	focus_n: focus-n-state {
+		pins = "gpio2";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };

-- 
2.41.0

