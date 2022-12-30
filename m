Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D0659A58
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiL3QCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiL3QBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:01:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687495A4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:45 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g13so32221098lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7CMc3jxlYPlL4vLNDYsbpTLDxeKgnmyQefRKVy3TVE=;
        b=BpTztYCadDKPQniPxBdPnIpCKYSBF0PnAg4Or9zHsEXu+LrEiZxjeFkAwa/iD9lEUa
         m1u2hHYf5HULdK7eS0om/sgB8phfixj3p0Pi7R7lJ9tmpFLZLp487X8Ns3ZGrdXWRy4K
         IB9BKag+WcFlSbLgftWi8d6azq2pkstlbbTzaptRJg63g2MBZnzWhmJmS5kQqTAi8Wzp
         V4FlP39edSv9W/pbQojair7EL5Xki/4NDNtXrokns0W36iomD2FTxkKFDGoW6OZYCeq1
         jaKHQiU4T7djXEyvTQAx2CuDkA3x0itDtpFvhtNHpfwobvINZOL+TpKRUWwycl+MKvXf
         5uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7CMc3jxlYPlL4vLNDYsbpTLDxeKgnmyQefRKVy3TVE=;
        b=4d/ZfMlgIxeAl04Gce5A5XeFmfoJNOJulFaAVOYgU2Qp4eREbLoGj8OcmcksMWXwh0
         WrG2AN3cAvgVjTrm5JNPRkfIavuI74arVkH9zgqfzjo8UnbEz9skJBI0TMlb8uAWF8RJ
         KOodBni5BRH7PtJ1X4trUkIWSo0UZsMxK7YfQFYSJa+Bo1bkjpgRj0l3TagK9e8obs4l
         gExJBjv/c+IIQQEyqUuGRJcTLYZ5QnaqvBFGeHod8Zx7KNrbzoWy2GVoiPXiybHmjpiC
         QzFPLgEnXSEP/dIdmaz4M7REtWG8C3bpFXGrLthotDTdcixn1xdalKUyAwTVhCE+h4Hy
         qqkQ==
X-Gm-Message-State: AFqh2kp62vsVmOPTeRSyh83IUl5IIfA+5VuzCdU9yyOpN5F7T/sCo1xN
        PvcS/E5M/OKw2RCs170eD0xzMg==
X-Google-Smtp-Source: AMrXdXvLxncORaA/sHKc0qxRifk/XSXnBxJHTx8MIECdOlwglYEv71fEqqFS6N3Bfl/v7gPTT5uuxA==
X-Received: by 2002:ac2:4e8b:0:b0:4b5:b4d1:e1ca with SMTP id o11-20020ac24e8b000000b004b5b4d1e1camr8420722lfr.39.1672416103484;
        Fri, 30 Dec 2022 08:01:43 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004b15bc0ff63sm3520874lfr.277.2022.12.30.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:01:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/7] arm64: dts: qcom: sc8280xp: align PSCI domain names with DT schema
Date:   Fri, 30 Dec 2022 17:00:58 +0100
Message-Id: <20221230160103.250996-2-krzysztof.kozlowski@linaro.org>
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

  sc8280xp-crd.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
    'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index d14663c9f34c..c39e51391286 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -549,55 +549,55 @@ psci {
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

