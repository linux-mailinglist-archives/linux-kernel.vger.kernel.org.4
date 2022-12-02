Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE1640939
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiLBPVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiLBPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:21:05 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE6D11EA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:21:03 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s8so7856224lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0n8g0BV6J4JcAA7y+mPLeAuofFOkUHpwPQF99DaEQ8=;
        b=WvQEbvHUFWMSd514qb2p1tmbVdJ6cQieaPoRFEuiuRgPJ0kgsJmUwC1a5zftII59Js
         xpICVE1QJp+YsscWpOSUoD6OPNemeYUI13fOTLxbQTWuoXGMKuDDfDB0H3xjhxn+vtvp
         IjnWojE/eo7JHYfX8IVD/iF3jxFPQH/Z68XmgRlTVT9ubA54t+tR+ey9MKitoQowUcLn
         ZtWULxGpyp+hAUcSntQgz6E2F6wUrQ9PIZ4mpMzUxPgYioa4asi8Sm96fcw7UqP8ahde
         xPoNsfStzByy6hGsIAC/2iDNX0IHK9kGpvZ5wYyoFn1B4T3csZCnv3/cjl12TqOfZrcu
         YzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0n8g0BV6J4JcAA7y+mPLeAuofFOkUHpwPQF99DaEQ8=;
        b=IbtVBvvdK1BEfhO11R9FHN0WLdSnQujNugSgPjrI+axqP/gRr8FCCGIfhZlb/sxFV0
         qAZemSKdc61KmcXLZPEBu631kpmL1iXjem7lszG3RaTySRFAVSKxi/BZVVc3UzCnOqGB
         Cnhp627NiYsKJKaS4MSO7n+siJX7tAmIPx6448GKEeaujQNoHJJyKzgJRrprPAp8IKSF
         C74ZOhKiBEnfdR9T6LUWxvlia2kKtIJlale+jS2WqJm/g2ALthTPGgPetM8V8DDIy1ko
         f34Zw8WYX6HQWixUjsXqaESwYIwpBFjot0SjPMNmoMG3gzoKygH0IQk58WrnHdhNYQBV
         b0Sg==
X-Gm-Message-State: ANoB5plz57uxv2EbkvKNz5XrZ7i76s7cALiC86XKZJUOxGiemM6uEmwf
        MD/cf7jFXXZoCxYJ83NIhPp/mw==
X-Google-Smtp-Source: AA0mqf4l5/IRVWXoix1LyIDKcQjUiOLc0kG1fiTfy0/h1d+Mr+9vVfAmhEe9ESsOwJXvQ+CtCZAiZw==
X-Received: by 2002:ac2:46cc:0:b0:4b4:f43d:6b4d with SMTP id p12-20020ac246cc000000b004b4f43d6b4dmr12930778lfo.251.1669994461586;
        Fri, 02 Dec 2022 07:21:01 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l16-20020ac24310000000b00498f871f33fsm1043273lfh.86.2022.12.02.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:21:01 -0800 (PST)
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
Subject: [PATCH v6 1/3] arm64: dts: qcom: sm8450: add GPR node
Date:   Fri,  2 Dec 2022 16:20:52 +0100
Message-Id: <20221202152054.357316-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202152054.357316-1-krzysztof.kozlowski@linaro.org>
References: <20221202152054.357316-1-krzysztof.kozlowski@linaro.org>
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

Changes since v5:
1. None

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

