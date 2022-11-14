Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C038B6283C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiKNPVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiKNPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:21:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BFF201B6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:21:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id r12so19833424lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjhZ9MEeglzsQ2bcky4g3TTffUyDa0flXvW2nHAxvv4=;
        b=b2pm7YlDH6UxHHsHH78plJxWFwDGPSoneGRU/2fLafIdJJ36u34MPf9qf2GIL9EgqA
         jaF+iYnFJfH82G1qiqlI7ut7qKJu8nK5O4UO4irXdSlNr/48QO1VN60mo8lkMNbid9Cc
         n09bbiEZgauaDET1oCQkn3ODm2HhYLKruYOQ4uDZRnlvOf9c6ayg+ckvUkXii3+GWFAF
         dQ3kLm9P4TJo3nHQXy604Q+ZpNWrErZKC0wcbwm+XM67XXqWHTxknZR3zZ1s/7XyWHXP
         98KuPc9lgiLfJ8kKseFJU2DYHrDFOo9In0BSLBz5CQ6mju+bDi374CnmD7//2NFJ1spz
         lW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjhZ9MEeglzsQ2bcky4g3TTffUyDa0flXvW2nHAxvv4=;
        b=PHH/ON2hss0KXOAhUPQ+lW4DcbAT6uhP3kwOKkbEGKlskOuX/qXqWtiFt6ngVzz8NT
         75Hz7cSLObPhPLdbNxOuX9nSvlysHLVvW02x7n7lye2g1KhBD2VZ8NSBpz+hxQtA9K2m
         fTTZXi0bAMT1IJgYqub0b9V/ui5QXz78Oj/uDoRZ2hcsThR2Sp1ycxZ4/71RiSi4cBlw
         BL4K6p9PTM5vj0CvcMfDwA0Qw0LFYGxRB6gli9JZ+dMWxOU/TnN5A9W3mmbaBc/9CQb5
         DxVz7vCn2RH6do4HeJOdTwF/peTLHbTi5dX4JOHsmstrdVQEtna3VRQhhtQkhvUf09LP
         MjEQ==
X-Gm-Message-State: ANoB5plc/AXqxJYNAvdjlyy/Ykqe5Ke/JXK5/nniwYg52aHMUgefOt6C
        //hufbQ2hxthMVFtt+HSlEMfvA==
X-Google-Smtp-Source: AA0mqf4vywHCW4LlpFFdE6kAHCo/1hwKQbK4HFVyjvb4UNaOf4TVPQuDHWIXcPKHV/XYLpmn/dd4KA==
X-Received: by 2002:a05:6512:77:b0:4af:cd2:f8df with SMTP id i23-20020a056512007700b004af0cd2f8dfmr4126539lfo.586.1668439295857;
        Mon, 14 Nov 2022 07:21:35 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512388500b00492ea54beeasm1854268lft.306.2022.11.14.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 07:21:35 -0800 (PST)
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
Subject: [PATCH 1/3] arm64: dts: qcom: sm8450: add GPR node
Date:   Mon, 14 Nov 2022 16:21:28 +0100
Message-Id: <20221114152130.385871-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
References: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add Generic Packet Router (GPR) device node with ADSP services.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

