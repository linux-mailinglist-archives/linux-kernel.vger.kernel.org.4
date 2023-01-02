Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B919A65AE75
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjABIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjABIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:55:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1462ACA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:55:01 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so40770491lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xd4pU6bNJXAmA0DRMKbQh8++iQzAoVOYwtwMn3h+yQ=;
        b=HSduBPi6SnT0EJdkWTEwds2p7S+I5laQ6jab5j/hZ9qZSa9MVsVd8OncWrFQo67YCj
         VA7yJMnZxmJlPVGAniDfNDwMMf/QNOuUCQMmbmhg4ZiuDu9mnIyc6+r040pIjZL3KiXK
         Xl/wqpcdlNf5E69kxsnT5v5/VVH4SsRYLWpshWOsxP2RVPHyC4iWB2Fhms2onsUAvmiV
         YPrJlh/3NhTXpkXTpml/iPO1bEqS4/I6nWW2R7Ot6pK9ODMvMYwdHP9qA/MnCfiY700D
         6+JlWEte7lO/NU87OJ7IuTTPuzQWWxKjYcPXnYvur0q3HCuaiifxPQQDVaF+C0M42x3A
         8EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xd4pU6bNJXAmA0DRMKbQh8++iQzAoVOYwtwMn3h+yQ=;
        b=soNLQHrMQZu+sK+CpE2quFxLNopug863EVPQYGftna1JzgBCdrjmxIuVsDiUM7LAtM
         nbVX2ubamrQKaTVV2RYNCPcXhLq4sGeMZrqF8qrPnDVtZfOpY43xozGagVZA4unN0I+4
         cHd9SOkxEJmMY5FjL/JsMkUWhDiLj9i7cgOi7+k62Fg0Y6rNaWb4z/cjAaObC76TVOit
         McKcYD9dSGRQvmSVxiO7auenJqVnMbW4LQdnjTZC/a99OjZ3OG8CPqPxIgys1mEKsfbn
         fk7oIM+X1NPKIa6M0GZOi++X3KOV1YLpBO58EWnOV9gtQxjbehg5oeyCpsuHENRT/fc7
         EojQ==
X-Gm-Message-State: AFqh2kqmVJwskd5cuCfP/fLOhCq4edtdakFFMQdY4r/j2O/QU1axJvqV
        JJfdr07WzsoL63LsN0G3THDA1A==
X-Google-Smtp-Source: AMrXdXuhL0542tuDQfgRQDDyiAxKhZETN6HWCegQdVorrthr90sRPjxVKD8rdU1HgmNdHyk2RacDCg==
X-Received: by 2002:a05:6512:3fa7:b0:4b5:cda:44cf with SMTP id x39-20020a0565123fa700b004b50cda44cfmr13568210lfa.67.1672649699420;
        Mon, 02 Jan 2023 00:54:59 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b004aac23e0dd6sm4408815lfb.29.2023.01.02.00.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:54:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 6/6] arm64: dts: qcom: sm8450: align PSCI domain names with DT schema
Date:   Mon,  2 Jan 2023 09:54:52 +0100
Message-Id: <20230102085452.10753-6-krzysztof.kozlowski@linaro.org>
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

  sm8450-qrd.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
    'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9f6b689c0edd..61575f6fab0b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -302,55 +302,55 @@ psci {
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
 			domain-idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
 		};
-- 
2.34.1

