Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B1648F77
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 16:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLJPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 10:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiLJPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 10:35:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4BE19C37
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:34:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vp12so18040468ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2lDXemucByXxRRVZfQEDp/dp2ZeIjuHU/Ol1VQhsm4=;
        b=xftvZDhRHy8k20pFyrpXxUKKbypEgA9ZdfnpcTabZLWITx6hfI/JPdCXBrXdtCPKrh
         KskF6Lz+p8VIRMS900r2DsZ2rXblJIa+LZeMDytKflze6a1YNIR1zsZt2K98F58Lhoey
         +IornqDpNuUhhl4jtZTvyKEKE3TjJTRaBQweI8JIJ8tNAjXSUmwQi9PvQfXXf/sp2QE2
         oFUP8IQ3kS9fZoEUY/MYz5NLKMLDwM3Qi07cNAmBk1og/PuTcwF8lOWyG2nAHGe9V2t8
         k4ITqngj2Ij4ziakwr9g0j8SG6XLDs2JuuooGGLn0GtCkOpEL4xEDyO6ACR1/YvY8jUf
         /4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2lDXemucByXxRRVZfQEDp/dp2ZeIjuHU/Ol1VQhsm4=;
        b=z8l5OJIYSr8kgU4OamYbskt62o7GaeCKulRGqeWXeekornFCjUAIbvfGdwPR3KSiVU
         zOxac88gyr1oAbTdxaeUbHy90+l+dm2yjaeE6zjy35225ErcoYgF+3Ch4ZRq9xFOgKRB
         BpsdRr4y8G9dxCAfppNlNNNJBJvDAPh90hrMy0y/JSNBRmymiRfhbSb/fNM8qFHqtObx
         pv5lIr68IoN4SuXPzg1NnHtl6KTCbqgb+NN49KoBnbnJKks9D7GfrFkn7LaeHIFKdy1/
         ZHk+CbxR7bfSS7IZSBmbQUavUafQ3qXlrfjlL6pOcYdvDHZQCTBPgg0rP2303hSw1jTd
         fJog==
X-Gm-Message-State: ANoB5pn0fyNMJLefFmgn9AoUMacY3BscLm3ZL+4PAzgTw+RW4XEeSAel
        rQEv3GE9cvYoAMMXDIgctbOUATcZ/B7HIngT
X-Google-Smtp-Source: AA0mqf75LCEAzE0ddg+MH1XA/d7Mq9s0e4EqJLGCBLcSXrTTSDecbLEQuTlMzImWCf3bKFYMZT578A==
X-Received: by 2002:ac2:50da:0:b0:4b4:e438:e068 with SMTP id h26-20020ac250da000000b004b4e438e068mr2324266lfm.0.1670682328856;
        Sat, 10 Dec 2022 06:25:28 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c26-20020ac25f7a000000b004acb2adfa1fsm739912lfc.307.2022.12.10.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 06:25:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: qcom: sm8150-kumano: Add GPIO keys
Date:   Sat, 10 Dec 2022 15:25:23 +0100
Message-Id: <20221210142525.16974-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure hardware buttons (V-, Camera Shutter/Focus) on Kumano
devices.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index c958a8b16730..2352dff213fc 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -46,6 +46,40 @@ framebuffer: framebuffer@9c000000 {
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
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
+
+		key-vol-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&pm8150_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -410,6 +444,34 @@ &i2c10 {
 	/* Samsung touchscreen @ 48 */
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
2.38.1

