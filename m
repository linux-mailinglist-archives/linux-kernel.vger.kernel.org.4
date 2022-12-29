Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF8658BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiL2Kcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiL2KcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:32:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE6BE18
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 1so26965622lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHanGwSynG3aJ8MgOjQFcgeBuUBWc0OK0AqB0H99D9A=;
        b=a4XC2KdC6rbpuiEOnN+0RJCv+E9FxYdvUUialvoSNzL8JrAGBDd4ACwvu8BHudLBSQ
         GFKX3NyYL+BERBoOqv3ui4G3q85Z7Mcdvoj54HRgg6X7OUXLiXRV2q7+8zC34cidQoXj
         RQD2N7lXX8hJ5z9ybrQgSPvkhNJtq++4l8ia+uxTsFy/DEac/MG1pJIKrPUocEfO4h5f
         QmNLeVDynGSxkeAUMJ2jT00iYEJo/gfrI8hhJT3kLAdmiENN7hoLZ5MA9nn/LcLIMS0e
         f0W9sVFLsC42f4/KPlx0fp8kOWwCKTecVytKHqDewAqj4wXmESleiggT9BXFm8zbnTzm
         xRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHanGwSynG3aJ8MgOjQFcgeBuUBWc0OK0AqB0H99D9A=;
        b=rinihP58cA1Na1vwplVmAvXNteYxUpvbHTSPprHd+3t2qRDlfFRyCJZFRhWiRmB5wu
         tk1JQwkg4ZMvJ1/PDwAME6zKmtHoNLRYZ8OWWjE5e0t5Js0jFcAOy139pz0T4Wk2eQ+q
         Q4bMKq/anNHGGuktNU1bw0wCUldkzTM1PS8/joiGaQXMUicE4ijkRC+xMhS7h5sRNwkd
         UFuorbC+M4M3eaOpwrG0o9YbQelR6l0Ue/j8hypj6AECrqb0XeKzVBfckLiez6782tOz
         b+VL+JsrHnYX8UD6IhMb08FZVt1nKIZOZGHK2Sr9EDq7HAxeEBIQpUSXBC+3VztJB19M
         ERiQ==
X-Gm-Message-State: AFqh2krDCYtRXZDBtezUzjihd92NfcaWSzvRRknGD2vXBrWOIu017TZv
        47JhgwO9v3QpsRK19lBXC41vcA==
X-Google-Smtp-Source: AMrXdXtVXdRTpK+WQir2fyof5eRgo02ErS5v+LPeOfFaEcuNT+U/2NI5en98FaoeZ6nOI3Rt8FWxhQ==
X-Received: by 2002:a05:6512:398c:b0:4b5:7a91:70f5 with SMTP id j12-20020a056512398c00b004b57a9170f5mr9076858lfu.63.1672309940348;
        Thu, 29 Dec 2022 02:32:20 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b004a478c2f4desm2993526lfg.163.2022.12.29.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:32:20 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] arm64: dts: qcom: sm8450-nagara: Add GPIO keys
Date:   Thu, 29 Dec 2022 11:32:09 +0100
Message-Id: <20221229103212.984324-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229103212.984324-1-konrad.dybcio@linaro.org>
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
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

With PMIC GPIOs now available, set up required pin settings and add
gpio-keys.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- gpio-key,wakeup -> wakeup-source

 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 8e128efcb128..0e139921b3e3 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -27,6 +27,41 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
+
+		key-camera-focus {
+			label = "Camera Focus";
+			linux,code = <KEY_CAMERA_FOCUS>;
+			gpios = <&pm8350b_gpios 8 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			linux,code = <KEY_CAMERA>;
+			gpios = <&pm8350b_gpios 5 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
 	reserved-memory {
 		adsp_mem: memory@85700000 {
 			reg = <0x0 0x85700000 0x0 0x2800000>;
@@ -562,6 +597,32 @@ &pm8350_gpios {
 			  "NC",
 			  "NC",
 			  "PM8350_OPTION"; /* GPIO_10 */
+
+	vol_down_n: vol-down-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8350b_gpios {
+	snapshot_n: snapshot-n-state {
+		pins = "gpio5";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	focus_n: focus-n-state {
+		pins = "gpio8";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
 };
 
 &pm8450_gpios {
-- 
2.39.0

