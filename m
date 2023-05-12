Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04123700C87
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbjELQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbjELQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:05:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4130CB
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:04:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso18550731a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683907498; x=1686499498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aTITtva9ESnDWPsfvxoiIyGYO4jGWyqhVk7CK7KuwE0=;
        b=Ng6V89v7bBqoSRsfmCWvon9AUTLZHk4wNVGxXsFgRD+mJL4BQcjTMvFYSCpqU4okTL
         avOT6qcoaDtdu94YYp+0vhMO8ynK8cBdHdAw5XN4y16xVP0zXzhNe0p1WfyTducF7qR3
         ysPl0aqOXA9Fswk9vjjxF+ExqLzMWTkv+8zEqaf9CIpW5QQ+2RtOstJy1phyA8EzEGPv
         7G5jQtSykd8q8/IuoLHM3KFIjxTzImYzYKbMOE1Kw+mD4tv+1Ov0WKzZov56g6V8W9WW
         iVKLdJhfn0ETFWSRUISYXjuANY9Qg0FL+NpbEEKqg0uWhy05dHwJILqfzzWwV4dicFXh
         ezdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683907498; x=1686499498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTITtva9ESnDWPsfvxoiIyGYO4jGWyqhVk7CK7KuwE0=;
        b=XB9AzNO1Or6BUWPgP0giU1W2aNx9m++uA6gP8PgKpCFnPqdXPaf9aTymucXcqffG0x
         csMlKskoiiEBpS10/H44A3lOdMv0cL7QMWnIfKyj/+s52nXGeozi7sd7XNwcZglh2EEJ
         pFg+UlSECrFkZBw7rLSfi7ue2joVay+VQfVYd3x1HEZ1zyZyPbC7e4QaUjVTvjdGwLPL
         K0nhBhS4nf+9zFZA4FOtcuTl3T3Il5xlvNFhwI8ZHr/lHG5u0364xYaEvwzGBGsIN15Z
         F2Yoec1x9c55S6flnbZiqV2T55t2TE+uc15Pxw2RzTyI5lQ4bwQ/WWImMt3vMhapaRMw
         Qilg==
X-Gm-Message-State: AC+VfDyKnWP+l3Sr50qvodqQoXpbNjuiiQMPNHy9y0qHMCs2qoUlbbae
        mWc5mfuYFCPdjfZcMtLQHP+BYA==
X-Google-Smtp-Source: ACHHUZ4l6y4L1Co/q9xMiAqUbhWQLBl5/9kwT6gnhMbGxPJrO0k2itQKwxGbquiPqzWGqLtq9JoTiQ==
X-Received: by 2002:aa7:d64d:0:b0:50c:3dc:2262 with SMTP id v13-20020aa7d64d000000b0050c03dc2262mr18851543edr.39.1683907498385;
        Fri, 12 May 2023 09:04:58 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id d5-20020a50fe85000000b004fbf6b35a56sm4224935edt.76.2023.05.12.09.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:04:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add WCD9385 audio-codec
Date:   Fri, 12 May 2023 18:04:51 +0200
Message-Id: <20230512160452.206585-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Qualcomm Aqstic WCD9385 audio codec on two Soundwire interfaces: RX
and TX.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Patrick Lai <quic_plai@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index d5a645ee2a61..ccc58e6b45bd 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -23,6 +23,32 @@ aliases {
 		serial0 = &uart7;
 	};
 
+	wcd938x: audio-codec {
+		compatible = "qcom,wcd9385-codec";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		reset-gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_l15b_1p8>;
+		vdd-rxtx-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob1>;
+
+		#sound-dai-cells = <1>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -385,8 +411,38 @@ &sleep_clk {
 	clock-frequency = <32000>;
 };
 
+&swr1 {
+	status = "okay";
+
+	/* WCD9385 RX */
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	/* WCD9385 TX */
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
+
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio108";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
 };
 
 &uart7 {
-- 
2.34.1

