Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD81E659A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiL3QCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiL3QBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:01:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCCDE010
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z26so32235072lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/6MwD/sZXuwD9XqorBV1SsLcbThhje/vI8Bvupo1uU=;
        b=Vf8nd7lzIljcJ2kJH7EeW4TbGLDnzuMUKe7LBMhT1XNiEhuEF/o6kFQbf19vJW8Ev3
         e5hU0sGb+GQdbRCaB1tsnvf0KJQu4vEZ2LvR+l3SZMtYY6Wc0H23bOOKN7PyX5rVjvQO
         J09pxEDvT9FfSPI23LjM0Em9pxN29Y72t3QFiwGNpDjNxvxk5gJMH9k8g1hdxbdgc+1J
         2Vs6rWZLF1DfrWhkvNQ9EU77cQH+CeqF8cEjFg6wnUTyC3N/yxMGD12V0gM+B6VPsJCI
         bYMGwl30wMOaH9XY0ri2s3c1tYc4pU2dINa9Nt6szlWuq7onIspb2sh/MsCixkpEapHG
         E22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/6MwD/sZXuwD9XqorBV1SsLcbThhje/vI8Bvupo1uU=;
        b=jNYdjISLuFyeCjhCm0EXaz74qKLroOAcLVEIoMWxbocED/4FNOxHFdbHi1PhJVrS9x
         mCm2Yzg0NrpGJrvnpV7Uw/khA/4v6Eli5x+jKXixZJOZa1AaoUPJh/a8gfWLNgit/bp5
         7W3Ps3XhAHz+nwNpnKnmA4Q/7CD3bwstQUu8JVP6syuhazD1yCamZ2mSU3LHmTxPQUNY
         Vzt66MdSTSewfpF6ozsEKzF56qeTzyrOl2GNtTTUZZjGubV5Q9poQe+keADgHuAoOYdB
         KjEmRJmjDfq+iGvPqkPV1PO4zukp2PvvQXMv1yo0YQEQhPYXhquwpbwhkkdRRSvOqOeK
         AcDw==
X-Gm-Message-State: AFqh2kope/rNWhog4B70YVsu1zWP6Ynm5UEEUFIWg5pX4p3CPV+7RqDI
        JemYfG9oQS+DXAzpPH+G/31D8g==
X-Google-Smtp-Source: AMrXdXuztYjDtMAfvjWWGbUciuv5jEAdqfc/wLLbsL3HVncGhFQG7JOUVWSLhLBENfaZprCPRQDm6w==
X-Received: by 2002:ac2:59da:0:b0:4b6:ea42:de0d with SMTP id x26-20020ac259da000000b004b6ea42de0dmr8496780lfn.39.1672416107432;
        Fri, 30 Dec 2022 08:01:47 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004b15bc0ff63sm3520874lfr.277.2022.12.30.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:01:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/7] arm64: dts: qcom: sm8250: align PSCI domain names with DT schema
Date:   Fri, 30 Dec 2022 17:01:01 +0100
Message-Id: <20221230160103.250996-5-krzysztof.kozlowski@linaro.org>
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

  sm8250-hdk.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
    'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 6c7adce6c9b8..b101b7000034 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -677,55 +677,55 @@ psci {
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

