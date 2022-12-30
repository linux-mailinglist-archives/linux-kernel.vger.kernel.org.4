Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8F659A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbiL3QCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiL3QBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:01:51 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4720DE0B9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bt23so15584925lfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k95saGKNV3oo8L8imXQdteC3frkkr+UuodEJidAAnPY=;
        b=jCQ6iDRcZXPpDvREglDNCm2qTsAZ0ppEMBGyG0+pt7tgDRhQygJVHx8rZdW6L4o8eO
         rBR/HRdiqO9SimTy6VgPs8K7ZfPshNj1IIud9wlUVDk0yQtTnOCbowNewATq1qyRaJvk
         ffS43mwb1XCWmxqAAGrnybs6VE4UHY9xWObn6do2aT/w+Av2JIr8m1vg+IG5RQinxCxu
         GsicuUkxyucqoQKXRsCBoPcCylCRRbK25qBVL4JxdS2cZT3rSb0xLwDOMbGg2jFpKlDe
         W5ZG6dNAFNza+7DgbQxbapZjmcwuIn0EG4E5ShnZtGZp0r8J1qBWznFYuVATybVNz6sC
         hg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k95saGKNV3oo8L8imXQdteC3frkkr+UuodEJidAAnPY=;
        b=K0pCK1Wj/ATyN/EP2nwB7YUngw+pwelIzt42L8pkO8vTok+kK8E53gnWTkWtiWYmPV
         SvcIvo8wn+L8cBaMWPC54SLm4n7AC7DVKpJPl7MMa37YOck4MBULd8DCXFfa1zcohsrW
         8flDwpEf6Ruims25h/PMMB1P1fGn4Xk04Fcu5TRyuY7MCYtBElhalsORk5J8X7fE2twK
         QbzrDcdtaGeaLoVRjQDXavdF0AgTlwdCT8/f3TZaKQ0SoG8mW8Tr5uukBjpMesw9JM+M
         LMtZIMkMFFD6Kj8JZHViUkOFMuIGmw/8Dx6boHtBQy4YFPs804xFdfX+sqWsTLitNgPE
         m3iw==
X-Gm-Message-State: AFqh2kpmHvEtTrDzzLLSog7WEvAcD5Tofokw01qFG4frWIUO0k+HMYyq
        CPS2fiU3ryUXYchqdwg6Nx2G4A==
X-Google-Smtp-Source: AMrXdXuOmD/Br2iqoEI+Dq2lOSKeLA40AVIW5Ewkqr1aDH2KTyyWrxrGkqsJR2bHJ0WgIHEP3Q+ebw==
X-Received: by 2002:a05:6512:258b:b0:4b5:b85a:5ba6 with SMTP id bf11-20020a056512258b00b004b5b85a5ba6mr9989453lfb.20.1672416108662;
        Fri, 30 Dec 2022 08:01:48 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004b15bc0ff63sm3520874lfr.277.2022.12.30.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:01:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/7] arm64: dts: qcom: sm8350: align PSCI domain names with DT schema
Date:   Fri, 30 Dec 2022 17:01:02 +0100
Message-Id: <20221230160103.250996-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
References: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect power domains to follow generic naming pattern:

  sm8350-hdk.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
    'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a7da48b7e788..743ca0c80ac3 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -297,55 +297,55 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: cpu0 {
+		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
 		};
 
-		CPU_PD1: cpu1 {
+		CPU_PD1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
 		};
 
-		CPU_PD2: cpu2 {
+		CPU_PD2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
 		};
 
-		CPU_PD3: cpu3 {
+		CPU_PD3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
 		};
 
-		CPU_PD4: cpu4 {
+		CPU_PD4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&BIG_CPU_SLEEP_0>;
 		};
 
-		CPU_PD5: cpu5 {
+		CPU_PD5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&BIG_CPU_SLEEP_0>;
 		};
 
-		CPU_PD6: cpu6 {
+		CPU_PD6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&BIG_CPU_SLEEP_0>;
 		};
 
-		CPU_PD7: cpu7 {
+		CPU_PD7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&BIG_CPU_SLEEP_0>;
 		};
 
-		CLUSTER_PD: cpu-cluster0 {
+		CLUSTER_PD: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&CLUSTER_SLEEP_0>;
 		};
-- 
2.34.1

