Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ACE65AE74
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjABIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjABIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:55:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2956826C3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:54:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bt23so24116186lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo+dSmvk4uNgbaNrZYJH+hsP9XGt2PPfsbofBBhoFb8=;
        b=OH7Z61lVgSE+ZnarWuQ3epo/MLoeZBEZnM2NUMw0rijhdiI35Eg635ywuabP5DKuAL
         vyhPPqtvyf6fzg1NvQQtv3qZ/8TI0MYlWfiYeHtMMd9er9LljkoGQsbWIrkfLJMq0d/L
         i3f6LSVdGXiYn7syX7Hyi+STYm0+z+7YU9SmMm4AMNX1j3xSGBoO+sBJyFsqEsaIu/XI
         3d4khdhzcMVH1IdkaHUgNMntP3wrpk+TAxdE4Qfp32qtCG/borGO2jlA8AePWiLzyRJC
         T1SdhEZ9vxqAk7VnhLSWNyhviWfsx4h1PCi4V912V1q5pxBgpmIJq850rNMp7G4UYM9Z
         Ys2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo+dSmvk4uNgbaNrZYJH+hsP9XGt2PPfsbofBBhoFb8=;
        b=SLhJx28duxFPVLsW5k3FMEAoYmzLv03Fg4HkuIMOTh0T31ZN/eHCq9E9X9jNsWpWrP
         8/zckmB3URg2rEo8xQmdBTQL9jZ59cB6yGU1sqFQJeQP+FTxuS1bEu1fdtKqconsYIL/
         tscl4nfPvWnvEdVulcPXQ8z79Yi2Q7Kkq7UX2uWfsj0ETJouvBytVUHwydFyzK/dckwY
         CY4stFjNX7gb3AArpfryOUZdtMKErHl1s9Nv6TAh3/l4sTyPV1z/rJixm1V417qWwC6q
         7EkrpiYMZZgraHsBE7hUanQ5ib+BpTWTAlnHW3tPEEdK0rkVXVR3NMgiDCwUT2BnI7W6
         ZZPA==
X-Gm-Message-State: AFqh2kqYG4YHxvjZjyqRkf5pMd7SmC7u1mUeU4zqp8qTyWXUOeWkr0zD
        IYc5AMbra5sohp7tTUGWOH8eIw==
X-Google-Smtp-Source: AMrXdXuTvoZXj6Qytn337V2IDs9CVBEew3xJwYa6ZvlzSDAP3KYXgJYno6wFvQbNd2Q+VzSiKX2bxA==
X-Received: by 2002:a05:6512:2985:b0:4a4:68b9:1a0a with SMTP id du5-20020a056512298500b004a468b91a0amr10984502lfb.50.1672649697263;
        Mon, 02 Jan 2023 00:54:57 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b004aac23e0dd6sm4408815lfb.29.2023.01.02.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:54:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8250: align PSCI domain names with DT schema
Date:   Mon,  2 Jan 2023 09:54:50 +0100
Message-Id: <20230102085452.10753-4-krzysztof.kozlowski@linaro.org>
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

  sm8250-hdk.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
    'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index ddd750591e8c..692a74eee45e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -651,55 +651,55 @@ psci {
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

