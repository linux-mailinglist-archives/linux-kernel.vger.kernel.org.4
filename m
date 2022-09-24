Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843375E8973
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIXIFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiIXIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:05:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FA9115F63
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g20so2301125ljg.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qpPAnA+QVmbRHt57Vf9Ofo1IOIWMIyAWhzEBUC3GMcA=;
        b=PlY5vqslF7wJTD/i8kL2Fa7Nr8DVGgCizMgKhyxTsTzELwUUVbjvvRnzVapmqQvAOB
         yZ9e0JTdvDxOEhEy028vFxnCqK3wyodZ0RnqYynZYxj9wM/9E7eR1bC//f5YwkXWf3Bt
         3dO4jIlVez3FPw6mwqEp6A88gsmuT59EiOdvHhggpzc7zFtbxOVMBDdNkGqXZtuCsXpj
         F3PZY45F2kJA59vsdlW/U+p+biuSNGnvUnEdqHFRYoqGgPEzY5DSw4jB21btM6uXVKCC
         d26qcer4vKFQljGo1ATIK5+Qcmpd4HEJ6HL4jGWxNhVLLQEWSsN8ItScemidLyxOtqCn
         hdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qpPAnA+QVmbRHt57Vf9Ofo1IOIWMIyAWhzEBUC3GMcA=;
        b=WukjpiBXEKvnvh5kWWM7LbjYkGEehB32a12zHyMSocea5BAaFx15/8C/Yh+Ytu0cVq
         7vH09prFdw9/DX1gTohH8pomiiApJAnbH7liFAyShISgtqvxjyD0gibjRLGuiQu/uCpe
         HAUci5b/rmayEGhpFmZnVMu9o8i42IBRW2Yw/Air8zXzL9XYzRppujd1VQsgasm9pHtS
         tc0jw486QLz3kZX1xGvAo9ffC6jmTA5LvyCbc0GBsTUjPMTb2aeAs8nquchLeTAVk2CT
         U0L8kX/gl02n3qDlh4yU64/1CJDg7qY3dKPqHFeCjLheYerZ4Ubpo0lsI6FwLQ5PpbBy
         uL6g==
X-Gm-Message-State: ACrzQf3daA9iOH26D3XEf0pRhXyb4UDz9vddQriRVY/2jdei/7qTbrQs
        JkY6+vkF7PDUqFSAG6GIYzpJQw==
X-Google-Smtp-Source: AMsMyM5SssSTodF8AELP2K6sTbI+heTbN8c602rZtM+w+exc7FnStzJQl2BO0JvVdyCChkbqbKa7Eg==
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id k1-20020a2e8881000000b00255779025e6mr4091632lji.525.1664006712493;
        Sat, 24 Sep 2022 01:05:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/32] ARM: dts: qcom: sdx55: align TLMM pin configuration with DT schema
Date:   Sat, 24 Sep 2022 10:04:31 +0200
Message-Id: <20220924080459.13084-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.  Schema
also requires 'function' property, so two nodes for the same gpio (mux
and config) should be merged into one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 45 +++++++------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
index a4fa468a095f..ac8b4626ae9a 100644
--- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
@@ -282,40 +282,25 @@ &remoteproc_mpss {
 };
 
 &tlmm {
-	pcie_ep_clkreq_default: pcie_ep_clkreq_default {
-		mux {
-			pins = "gpio56";
-			function = "pcie_clkreq";
-		};
-		config {
-			pins = "gpio56";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	pcie_ep_clkreq_default: pcie-ep-clkreq-default-state {
+		pins = "gpio56";
+		function = "pcie_clkreq";
+		drive-strength = <2>;
+		bias-disable;
 	};
 
-	pcie_ep_perst_default: pcie_ep_perst_default {
-		mux {
-			pins = "gpio57";
-			function = "gpio";
-		};
-		config {
-			pins = "gpio57";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
+	pcie_ep_perst_default: pcie-ep-perst-default-state {
+		pins = "gpio57";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
 	};
 
-	pcie_ep_wake_default: pcie_ep_wake_default {
-		mux {
-			pins = "gpio53";
-			function = "gpio";
-		};
-		config {
-			pins = "gpio53";
-			drive-strength = <2>;
-			bias-disable;
-		};
+	pcie_ep_wake_default: pcie-ep-wake-default-state {
+		pins = "gpio53";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
 	};
 };
 
-- 
2.34.1

