Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC2700C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbjELQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjELQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:05:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0026BF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:05:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9659e9bbff5so1860504866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683907501; x=1686499501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0PYOudo3P+JObhGAcVuidrG1Rb2PsNeOuDCShvwBdM=;
        b=JUtVKq5Krnb6A19hxU2smnPX5rjDEKnJ2/NB8aUU71UHi87917K++0BW7h9vg33KHx
         HXf1iNcnXkFMyGeh7lSc0+swaiXQmZWJsVN/xboyeusLosYnwYfuymqKsTwZ8pZifGtC
         SjwVGBqhsfDE5pOzBrgZu61BCA/dp7iTAq/R1qREfuIINlWxIVa3xQpJrjW6jkAbHuaR
         p5/HnujJf9cYjh5X8qAf4JU29L4UcwNWnSMKl1fOqSQXaEV+j7Wg2Vhk20Dx078mZqlo
         2sA8Ghl7JoGP/q8ZhNa2ilJ8BFWLH0X24+LU3+7vbgDITnZTlqJl2Mnu5qiFCSCGzBYQ
         hylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683907501; x=1686499501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0PYOudo3P+JObhGAcVuidrG1Rb2PsNeOuDCShvwBdM=;
        b=dlyNIGh0miwU7Cc4ugK7csPHjAIkQIH65Xf1Xn/EoPzV29K5t1um5/MwueIJ/TwPxt
         LuEibr84o6GPqyxJMOjJeO9GzfbCjzilmBKOmkmPXEvG1FxS/Rmi6WwX/BXdiPtyeifv
         dUJHNJ61q7UeQFIbU/bflFs0UIvIw3LeojMz4OlkCObOOmpT1xhd2VB8ILiEgpN7iuHv
         8PLfUBaHbdziyKVjKHFY3oYkbycYhIuZyzjke3l7brqWxrCb5rpMDXRUe4e0CRr6wl2y
         o976oJzw9Ci2YMtakJOCeBnwV+ToeaDY218p1oVv3zI6xuMcHwpWe8fvtDzC2xblyXaS
         BkPQ==
X-Gm-Message-State: AC+VfDyTq5KSgndXjD6odUtHJ5BM0FU95XciwYXAa3RlJpUhMNGNc2t/
        pUmplTq18/Z3GeAJZdA/uryTHg==
X-Google-Smtp-Source: ACHHUZ4nQh48nD9diogVXknvtWR0ykPVeneEFht9Gt2ECiN4OYr+m21HACXFlFlkcpqL3sIuO5PivQ==
X-Received: by 2002:a17:907:1b24:b0:94e:5c28:1c19 with SMTP id mp36-20020a1709071b2400b0094e5c281c19mr24930056ejc.5.1683907500702;
        Fri, 12 May 2023 09:05:00 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id d5-20020a50fe85000000b004fbf6b35a56sm4224935edt.76.2023.05.12.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:04:59 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: add WCD9385 audio-codec
Date:   Fri, 12 May 2023 18:04:52 +0200
Message-Id: <20230512160452.206585-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512160452.206585-1-krzysztof.kozlowski@linaro.org>
References: <20230512160452.206585-1-krzysztof.kozlowski@linaro.org>
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

Add Qualcomm Aqstic WCD9385 audio codec on two Soundwire interfaces: RX
and TX.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested and not really verified against schematics (no access).
MTP added based on downstream DTS.

Cc: Patrick Lai <quic_plai@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index af0381acac25..905a5d3aa400 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
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
@@ -535,6 +561,28 @@ &sleep_clk {
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
 
@@ -565,6 +613,14 @@ sde_te_suspend: sde-te-suspend-state {
 		drive-strength = <2>;
 		bias-pull-down;
 	};
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

