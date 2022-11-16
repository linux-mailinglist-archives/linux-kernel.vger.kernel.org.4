Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820E762B772
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiKPKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiKPKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:14:02 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B870F2AC73
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:13:21 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id h12so21186593ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukq1OU31XUM1NiJzaWbXw075WRYYfPEMEB+p/dVIpHA=;
        b=WR72wIAwBjbsMXpmb6lFyYndgkyG6U18VUqYJmQcNyknd+6xzG2rAvtIY6kyjDxeJs
         32kl6I28et5aAWwZLoGzUi2Pls2JEQhW0cXFB5ic3ajfHYMM4fi3rLPpBjDza1YFS14F
         KnAn4V0A07KPd071lDY3FlOJeWKH4uiAG6lZO56sw4kynug/uEwj1NuDW6SQFcWh9KU+
         sjQk9ZPjedz/xXEqgT+dlbkmyJYWBc08FevLHOn38dXt4t0HnLEJh+YRUBQuLsjOhOar
         fc8/Q/7WxBkhq8sObqRhZKCuxg++wtln0M5Vcxy+oTNrhopZN5BZ2PIHz0HXDnZyB732
         N4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukq1OU31XUM1NiJzaWbXw075WRYYfPEMEB+p/dVIpHA=;
        b=unsOS/Fx/L4EFaYnXX5tcmBAwk66aUFiQbV0b4B4GFbOcqoQ/zpyg7ObTDF2kWFqIP
         dvcW5w/Ag0CPhrHpeEQMWHRLR6FVX5mF+fVFK8R89pSUKgG7QZJ30ydV+HVX3OwJvPsp
         kHZ+FEmv3rZgvnLmofcbuT+CdT9WCmitavj1waS2J+ayYCnZZCuiSXayyk4Zr5/ETbv5
         hnBbiWH5fz1trrL17P8+00bT+ndwoYXgez/T/+Q66FfmsSNKWCe3YF8PlEXcl+Xzhdi0
         1pPXoHz72yw5opQFC6zZYvE9/Ii9zDb3fySSMlj0EltAPoc/s2buAUhXBJf8KTTM8KEW
         jz4w==
X-Gm-Message-State: ANoB5pnKJuwEknv9FviKU7ajyySBrOnigTPbqGQ2R2Vr2wZalViIKtPB
        KcWSF5cxplJTs6Ji+Akjyuglfw==
X-Google-Smtp-Source: AA0mqf4IXpwnZwNsGxPAeEyNkDOZyMwVJ5AFgbBgfd7B3ykSvW2g5H4m9pxonROyRgDHp0wfjJRm5g==
X-Received: by 2002:a2e:9cc4:0:b0:277:4275:a837 with SMTP id g4-20020a2e9cc4000000b002774275a837mr7774174ljj.393.1668593600137;
        Wed, 16 Nov 2022 02:13:20 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512020a00b004a45f2e49b1sm2514432lfo.273.2022.11.16.02.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:13:19 -0800 (PST)
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
Subject: [PATCH v3 1/3] arm64: dts: qcom: sm8450: add GPR node
Date:   Wed, 16 Nov 2022 11:13:12 +0100
Message-Id: <20221116101314.52887-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116101314.52887-1-krzysztof.kozlowski@linaro.org>
References: <20221116101314.52887-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 46f9576f786f..4b0a1eee8bd9 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/interconnect/qcom,sm8450.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
 
@@ -2134,6 +2135,45 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
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
+						reg = <GPR_APM_MODULE_IID>;
+						compatible = "qcom,q6apm";
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
+						reg = <GPR_PRM_MODULE_IID>;
+						compatible = "qcom,q6prm";
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

