Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73365AE76
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjABIzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjABIy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:54:59 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3D26FD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:54:57 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so40760621lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMPfn340nzNGe8ZPc6CnT3KeIL/qofNelrHMtr3dvVU=;
        b=LLP3feXwcBaeuXhWUAXjtxbKt8rO8CFseXzbqR2+L2rEHjxugA1vUcOpI/vp6XitfH
         nQ7tHZxwV30q0DyBPdmrkCD94lS6G2rC74T4rDu9QqSC1McA/vOELvy6o0ec6aYVu1bU
         SwWO5oqCdGCwkODeGseQIuD2jmVxPpv2k1IxLnjaY2d4u3pGkA97IowMJPUcgJ/IQTZB
         4+Qm7tRktHw7L0krX78smmt/pUbiphm5GV+u8nT/zz2grOM1IGsNkR+OkZ2BElqXyFF5
         1pU/RivJesLG/bBNcu/0KdYgNIBJcRGd/X8fB4z818ChvyM+1BRe3kX7v2tmPlx3NP43
         fcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMPfn340nzNGe8ZPc6CnT3KeIL/qofNelrHMtr3dvVU=;
        b=qLxW0r3KLlmBa86SiYpKQXrMMfTTDEJIi34QGYzn97VP44rnavuFgLm3FnUKNUEG96
         k5cw1P3vEzfSBSGgW4vWGx8CDfRgjugcV0vY6ns/I+CbTkehy9RR4nyeim8lSLv0NvLz
         gxNew4P3D2X4niFN+LJpR6MRXQMX0ojGKN75IVSXV/rIj5SmPbnYGnsrl3QIxlnO13qc
         Q3iVcPFkceeEq2oliCm9ePN4d+4g24NfIuj2vc7kYbIlJEcZ0+qk/KNSaJDsJjdvKwmD
         zbQknHqPFjwV5r4Qjht6LNIb3TZ+YNRTpGAsZLga851S0K/m1AVKlqoFpp2wTNjGXqy2
         iGuw==
X-Gm-Message-State: AFqh2kp8uEzZWsa+ubRKPNpF+ZsYQxWlO+zlwx+VaVqa0grZ2QchFUng
        VWq62KA/hzzkclcIMjXeStMEBQ==
X-Google-Smtp-Source: AMrXdXskOay5luz5spkWKWFi7TzbvK5E7zalE4DJn81msa93xN8seH3CeFRkTtanOZ9lbtR0W4vrfA==
X-Received: by 2002:a05:6512:2399:b0:4b5:b7a7:ebf1 with SMTP id c25-20020a056512239900b004b5b7a7ebf1mr18607416lfv.12.1672649696247;
        Mon, 02 Jan 2023 00:54:56 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b004aac23e0dd6sm4408815lfb.29.2023.01.02.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:54:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/6] arm64: dts: qcom: sm8150: align PSCI domain names with DT schema
Date:   Mon,  2 Jan 2023 09:54:49 +0100
Message-Id: <20230102085452.10753-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102085452.10753-1-krzysztof.kozlowski@linaro.org>
References: <20230102085452.10753-1-krzysztof.kozlowski@linaro.org>
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

  sm8150-hdk.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
    'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a0c57fb798d3..be7af974b6b2 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -600,55 +600,55 @@ psci {
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

