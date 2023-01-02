Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5805565AE72
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjABIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjABIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:54:57 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6726E2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:54:56 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id bn6so18625513ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGwgXmV3VaBz7unD+8G142VMyXF8G8Ae25NrkRAv4+Q=;
        b=dX2jd4huhfinzllSevBVkB2mFPFv4S7eUTvRt5SryDu5HFpSk5IUpSV7xD9qTU7dwS
         Zo6nxmY3wHn1XzFnqBmj5PjScwp15HKbskMNT3f71QmssdF6BwfFfMPPk/i38HUHs5wL
         r2+41CMdbrRhOREEytkTZYhn9UA4r+9lYrczrgLLD70WTnWLnAtr8QLoeX9NMVvLwMou
         VCmKB1Hbiq7jOqqeRUCthHIiaB29i+19+jJVmRFrjPgt31DDusygFRTdJ/rJStaY7Bi+
         eSiKNwT72QEh10sSxUA7aG7nwANUyiWm5lqtqCYU6jZ8oWUWcY3fLKrsxVyTuUxewXcj
         xn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGwgXmV3VaBz7unD+8G142VMyXF8G8Ae25NrkRAv4+Q=;
        b=3x5HoJynmMKaoY/FasKBtymlUtsqc+oDGJoyWYXl6VcSjnpB1chKq6bmpiim1KBtWg
         uyEk4y2pZjCLSLaJ/tSNpnCKf1lyZxt9T6Q+D6kztOaGyG5/QwT6Aj6j/9oGSbM7HSvv
         iKDdP03M/6S2f184kF1drfUc7udHZjsKJMmIqGwYBexsjfiYJANtJEcBguITSeO4RMoX
         Pg+6oZhQf+hgz2yT7SUluavXwgG5LeNPqCgYi1ByOhCWjXfmiAqVfeQekDIooMxIXFpG
         o57cd9i2poX/1Acdvzm8hWSyinwljXgyrZjR+C4MCV35za32Rc7t/05H5ghD0GTECe0x
         InWg==
X-Gm-Message-State: AFqh2ko7B7k0/EZB428D1V2abcbUvkAK1J1e5y0H+EyT3YhLJ6h4XYQv
        3Mg9yjNS0FAjpLT7SC5oQLM2QQ==
X-Google-Smtp-Source: AMrXdXsbc9n/g1+u8JUnhcO7kGSHTECrCDzmbD74Hi2JAYshVaML6iu8Guf114h0dp7t20MAjSXaqA==
X-Received: by 2002:a2e:95c7:0:b0:27f:382f:8f60 with SMTP id y7-20020a2e95c7000000b0027f382f8f60mr10312943ljh.9.1672649695260;
        Mon, 02 Jan 2023 00:54:55 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b004aac23e0dd6sm4408815lfb.29.2023.01.02.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:54:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/6] arm64: dts: qcom: sm6375: align PSCI domain names with DT schema
Date:   Mon,  2 Jan 2023 09:54:48 +0100
Message-Id: <20230102085452.10753-2-krzysztof.kozlowski@linaro.org>
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

  sm6375-sony-xperia-murray-pdx225.dtb: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'cpu3', 'cpu4', 'cpu5', 'cpu6',
    'cpu7' do not match any of the regexes: '^power-domain-', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 12cf5dbe5bd6..31b88c738510 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -264,55 +264,55 @@ psci {
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
 			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
 		};
 
-		CPU_PD5: cpu5 {
+		CPU_PD5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
 			power-domains = <&CLUSTER_PD>;
 			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
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

