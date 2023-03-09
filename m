Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F886B1EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCIIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCIIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:52:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D845DAB9A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:52:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nn12so1447348pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfGaCzEutI1ZxAuEhg+K1BmQaCq/7g5+zrL93kp+oys=;
        b=xnX8gn3VqqRCIkI1Pl9KquZdU8pKPj8UUrVFdbF78Hr/tgz2VvAaE3X0c2E/33nFLc
         HpXjOlMEXeocAl8mcFNNdHzJIiGePDP0FqyjE2yI/FkLfoyGybn8fa9Ab1gQh4cN2e31
         XgIeiWeLtRXkB6awQ8GjTOJ1qN+eGa0joEZtLNn7WDgk+TuqjH172hwzk+0PbqL1cmLL
         K+xesbdregYpgoC9CfkSYoIzrkM2xQyV8HZMVmP6JtoYFgtiV9Vx8Qur2gb3BA6NPL04
         FEKWfddiiiEmcafnIUaoz++C55hlNVdHsz57yHQXBSmlwXsAUWl9ufjprCyL6zoHYLmf
         NJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfGaCzEutI1ZxAuEhg+K1BmQaCq/7g5+zrL93kp+oys=;
        b=TVAn40caNle8Sl+dzhJ0sOBoFhOeEjX6TkBGE13JC+taCjDowZnBoAPbm6PyyVzqtw
         gEx96ymO+WVNd4OFR2aufWyUDqILrC6mha1AQ8qBzQ9YiO2Yma3zrdW11Skw3fNuUcLB
         b3WNil/RvP41Sojvw1ccAzFPQDndLR0Fm+i30rzJT+h1b0Tgl3hzw+UYcc6hjskujUzH
         eU9DU8jPBPzVsmztVoAgfFMe9giY05yaczFeRPRUkXx0RIxp+0frD+c5N2gBeYnMecgt
         pW3e7IBV/TJeKnZCJwSIE/WK1pg1c6qgcVwuH6QFDD7URWMbYlVBV9fOTDM+CkAOTLlx
         gTAw==
X-Gm-Message-State: AO0yUKXL+F701kfAWlqli/BE0c3pqsQep5gNATUcJMMM15+9Cv97UL0E
        3nrUuRQfjmI0wE7I7HY5vCZ+
X-Google-Smtp-Source: AK7set+JbOF39Hv8Q7TKkLMsOFAB4LTKP/gMeEDdydASrVo9+6Ml+DsWdzVwj+px3L0Kw40bI4tgrQ==
X-Received: by 2002:a05:6a20:4910:b0:b9:6208:44e6 with SMTP id ft16-20020a056a20491000b000b9620844e6mr16958982pzb.7.1678351938580;
        Thu, 09 Mar 2023 00:52:18 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:52:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 16/17] arm64: dts: qcom: sc8280xp: Add "mhi" region to the PCIe nodes
Date:   Thu,  9 Mar 2023 14:21:01 +0530
Message-Id: <20230309085102.120977-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

The "mhi" region contains the debug registers that could be used to monitor
the PCIe link transitions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..eb87c3e5d2bc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1653,8 +1653,9 @@ pcie4: pcie@1c00000 {
 			      <0x0 0x30000000 0x0 0xf1d>,
 			      <0x0 0x30000f20 0x0 0xa8>,
 			      <0x0 0x30001000 0x0 0x1000>,
-			      <0x0 0x30100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0x0 0x30100000 0x0 0x100000>,
+			      <0x0 0x01c03000 0x0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x30200000 0x0 0x30200000 0x0 0x100000>,
@@ -1752,8 +1753,9 @@ pcie3b: pcie@1c08000 {
 			      <0x0 0x32000000 0x0 0xf1d>,
 			      <0x0 0x32000f20 0x0 0xa8>,
 			      <0x0 0x32001000 0x0 0x1000>,
-			      <0x0 0x32100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0x0 0x32100000 0x0 0x100000>,
+			      <0x0 0x01c0b000 0x0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
@@ -1849,8 +1851,9 @@ pcie3a: pcie@1c10000 {
 			      <0x0 0x34000000 0x0 0xf1d>,
 			      <0x0 0x34000f20 0x0 0xa8>,
 			      <0x0 0x34001000 0x0 0x1000>,
-			      <0x0 0x34100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0x0 0x34100000 0x0 0x100000>,
+			      <0x0 0x01c13000 0x0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x34200000 0x0 0x34200000 0x0 0x100000>,
@@ -1949,8 +1952,9 @@ pcie2b: pcie@1c18000 {
 			      <0x0 0x38000000 0x0 0xf1d>,
 			      <0x0 0x38000f20 0x0 0xa8>,
 			      <0x0 0x38001000 0x0 0x1000>,
-			      <0x0 0x38100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0x0 0x38100000 0x0 0x100000>,
+			      <0x0 0x01c1b000 0x0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x38200000 0x0 0x38200000 0x0 0x100000>,
@@ -2046,8 +2050,9 @@ pcie2a: pcie@1c20000 {
 			      <0x0 0x3c000000 0x0 0xf1d>,
 			      <0x0 0x3c000f20 0x0 0xa8>,
 			      <0x0 0x3c001000 0x0 0x1000>,
-			      <0x0 0x3c100000 0x0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0x0 0x3c100000 0x0 0x100000>,
+			      <0x0 0x01c23000 0x0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
-- 
2.25.1

