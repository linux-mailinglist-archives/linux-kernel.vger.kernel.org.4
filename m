Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2616E8BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjDTHvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjDTHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:51:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A194C1F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so43932566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977063; x=1684569063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IihJMWhBQMAF9uLnh84rG7aXShOKGQju+1NiPpwGOQo=;
        b=aTENG6dKiTxIo85OoVhzc+ASDqM7blfSQWQ5qOku/IvCy7l6KOuUcCxhgPsYFPy9Vq
         8XOkTlt2yF/S1XblVYpR7igUvmeHME87Gl4CzHVwR+0wDA0jtAPLwWY8TrpmHOA3VGsD
         yE8kV0iEaJMXvk7FgG/6Qt59sNIj/BSr4FPzhDsUs7r6WA8c9mGnGEbM90BIZajkg0kS
         Pz3rBtwkuYyu8XjnMd+pzj6yaO6Ic7jH3j6f5t8eg6prrBjM6XTEuLrAsug0GcIKVvHn
         Yobsh3OLxF7KYA6oSP4gKHZx6dxVxJW0t3HCzgUN48MCTn36EVYViI5FuRRgJiX6KrI5
         m9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977063; x=1684569063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IihJMWhBQMAF9uLnh84rG7aXShOKGQju+1NiPpwGOQo=;
        b=XsDOVcYz0VvgSHm2PhUaYSlYw/+LZ1nWQPF77lmJDjhXC5KJFXcyGGnGw5E6ZZK/+C
         5EsIqT7bc3wt1m8lWzkEqczgFPhMDAs39PBT0NJl6002R38rQ1mVdXaSGLgf1ZqbFBFl
         jd1fvsETP/mIZe1uDtbuEBkyBuoeIsLKsx8/sY1sJO99W5AZ6hYAsW5w8H/DB1TrMpCK
         8aq3wYR/CTkv7xudBm1Taz54ZXopBZwvdHXYJqd5Yj8AiLqZKUnTwYcFhfJSsm/mE060
         FDXSjW0R8XeDou3AKeNKw5IY6G8tL9DTr1tYe6czrpyhshPuFypHNJOBg01mqPuQTsA2
         izOg==
X-Gm-Message-State: AAQBX9f8A3nQ6/WvBKXPoT8Bu1MDbyM3MBmSVml3UFNyl+KOhQhBfr5s
        yO5r+TLLjz69OwrSIn9CGz/Zqg==
X-Google-Smtp-Source: AKy350YMCd8ORAhjQ5DAsJNtBjqifqJ6hOIiEHGVWZ8YaBx8JqhsDuzeY/VByDUM8HM3WekNYDo52g==
X-Received: by 2002:a05:6402:7c2:b0:4fb:5089:6e01 with SMTP id u2-20020a05640207c200b004fb50896e01mr1070495edy.6.1681977063583;
        Thu, 20 Apr 2023 00:51:03 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm447165edr.94.2023.04.20.00.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:51:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/10] ARM: dts: qcom: ipq8064: align USB node names with bindings
Date:   Thu, 20 Apr 2023 09:50:50 +0200
Message-Id: <20230420075053.41976-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect USB controller node names to be named "usb".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 49310520da1c..396938ec46cb 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -614,7 +614,7 @@ nss_common: syscon@3000000 {
 			reg = <0x03000000 0x0000FFFF>;
 		};
 
-		usb3_0: usb3@100f8800 {
+		usb3_0: usb@100f8800 {
 			compatible = "qcom,ipq8064-dwc3", "qcom,dwc3";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -629,7 +629,7 @@ usb3_0: usb3@100f8800 {
 
 			status = "disabled";
 
-			dwc3_0: dwc3@10000000 {
+			dwc3_0: usb@10000000 {
 				compatible = "snps,dwc3";
 				reg = <0x10000000 0xcd00>;
 				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
@@ -660,7 +660,7 @@ ss_phy_0: phy@100f8830 {
 			status = "disabled";
 		};
 
-		usb3_1: usb3@110f8800 {
+		usb3_1: usb@110f8800 {
 			compatible = "qcom,ipq8064-dwc3", "qcom,dwc3";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -675,7 +675,7 @@ usb3_1: usb3@110f8800 {
 
 			status = "disabled";
 
-			dwc3_1: dwc3@11000000 {
+			dwc3_1: usb@11000000 {
 				compatible = "snps,dwc3";
 				reg = <0x11000000 0xcd00>;
 				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

