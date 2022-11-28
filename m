Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6263A8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiK1NK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiK1NKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:10:22 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03D31B1CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:10:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id c1so17235038lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io1oIDr6QzpJ0cxoJPVwXJRJH17or5F5V6Z/tc/VINw=;
        b=Y18LohRlpM/lfsw6NlB8x4jMp9FGzuR2TV64IuZJethvKMicv10T4qZwJW0eGOgAlW
         iDv1Xjm8wZL7cMCfchefTHbVtFXGnT4nogz3w1iMynSGBHRNGdnxRAsCuQRF5QvcGPHZ
         GYwX274KYvCfPAex7/YeGbT+C8/8MEyP3RMjcjnvKd4EfJtoiy+Q+AuJS0yRhfb7777d
         GkLJfaDXK/Kix5ynjoE0Sud48yuzqoYey8iXBE8LKHewY7uQ6bqzEQ3d9ZwG1as0toiy
         Cmgp9Vs8wWIWpRiTrQ8EsfN9BJLujutn6Zy2YAcaqr1PxTLJpJ/vF2QAWlsJmj7HZdwc
         hPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io1oIDr6QzpJ0cxoJPVwXJRJH17or5F5V6Z/tc/VINw=;
        b=xLu+dp8AJZwQVVKTv8cLe+0mTpUFoXgMA7+gCIkCYHSR22/w4fb3W9muQDo7NDLE0s
         MpkkESUAYIgvl430lN9V1kMCxl49QCWUrDxaIfHkfzdBv9o2HlQjOrXEhnF2KD5baBb2
         /EWZaqSjDnKQPe6msCqZ0ALbvNGpp/tLyT7e1iSOPtFFHCxR65eoa/sYc7330AO+aer0
         4qdF1IuCOsF4eSHg9VTPTWPqocdu0/zgfuTuNgK9cJsjmh2V0VdSSW1AKlPB3iQ4ay0j
         ZS8B9mY1Cn46syd2+3Loz6Mvq1po2TfVLafKMyWm7A3YBO3in0OA1OcjImYoHtgn4wcE
         3uLg==
X-Gm-Message-State: ANoB5plHwK73iUiLed3lXkq874W8zXQMkOhBrN4wsyWguConyT1mQRJs
        aciqPYA0KEX1oH9KJQ/VDdod/Q==
X-Google-Smtp-Source: AA0mqf4vd6UbZ8J3Ebxgt5xOJwIq8fO+FYv5iyf1fhtgIQt/SC97iOb5c8fLiTlgPYq/r7Co38IF9Q==
X-Received: by 2002:a05:6512:c21:b0:4a4:5e42:ea06 with SMTP id z33-20020a0565120c2100b004a45e42ea06mr16153873lfu.408.1669641020251;
        Mon, 28 Nov 2022 05:10:20 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512028c00b004b40c1f1c70sm1725340lfp.212.2022.11.28.05.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:10:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] arm64: dts: qcom: sm8450: add GPR node
Date:   Mon, 28 Nov 2022 14:10:14 +0100
Message-Id: <20221128131016.127860-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128131016.127860-1-krzysztof.kozlowski@linaro.org>
References: <20221128131016.127860-1-krzysztof.kozlowski@linaro.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add Generic Packet Router (GPR) device node with ADSP services.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v4:
1. None

Changes since v3:
1. Re-order reg.
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index f20db5456765..7b63c56ff2f4 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/interconnect/qcom,sm8450.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -2127,6 +2128,45 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x1801 0x0>;
+						};
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
-- 
2.34.1

