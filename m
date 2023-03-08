Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA926B013C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCHI0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCHIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:25:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E401A7D087
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:25:07 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so703137pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yjf3s2TyGH/y+9CG/Fm2q4b8eA0ln6/5386V6jiDwps=;
        b=S4csL0AFz9Q8BpY56T295R/66sbYxsEYPViYEZxKxvR7pWoQSDV1UmUErdiwfN6B6b
         DzGYFqkj5rFWvfYm3SP7+vP8vLKvObNofzzQX2iRRAm8CCxl/LwP26irLW8VabWJWLtP
         alugDw4gcyy8XLZZFsBy+U+DVkDy3bT6nlzBe+ParDXCv3P7W5C4fOP3HijTiixC5aWN
         XXXZrY+VhETVPLG0U5OQqsPaCHjFPmgfkRxTk/EHq5ZaLNwkjeXMP3C8BhKRb1aka9+7
         rc7roPaDBeZ5RBtrncbkXWn6/kk3/+vPLGr6jBKzqBXHfvs/fwLr+0eAAdJFYRjIMd8c
         1NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yjf3s2TyGH/y+9CG/Fm2q4b8eA0ln6/5386V6jiDwps=;
        b=GlU6eMVJopP+xjAxM+xDXbrJmb/nAWOi+fANaMkRxQUZlS35qgmHKdS6NvT+RX1G0T
         jgysKiQLH9GnAt4knTEghMqmcnh0s1FZ7sGbjmDKj+xZP6rg0Ywz4AUoxgzZR/98Kjsp
         SON6bLN/4yEF+tWQ2so/doCMPoJDs5kyCQZnokVLVu96seSrFcH7jDjmeQBPChRTt5rL
         3YZ8R/MSSxg+TeMre10Mqf91pn+WO8iNpeLpXgFJYa+vOgLEYj4OArv38mrttD8XjV1Q
         Vnb6ycNAts3mlY6bdPxQRqxaTXXZ3PDeARrQKSf05e2xSVCpgifKCsargTgDioLKpqC1
         +NfQ==
X-Gm-Message-State: AO0yUKUCgVMbd84cWj+0rU46R4KXmVhLafDgdxEqozaOact/z9e2/GN4
        U4Tin9zu1GDdi7jedXvvbB2r
X-Google-Smtp-Source: AK7set/x/Tt/Gaf7cyi7yIYio3Lv8+0KLkcs+FxHic0Ne0UGCi8t1RDH7aRoWDm/p5Xwxbhqgd+K9w==
X-Received: by 2002:a17:902:c10a:b0:19e:7b09:bd4d with SMTP id 10-20020a170902c10a00b0019e7b09bd4dmr15605996pli.47.1678263907564;
        Wed, 08 Mar 2023 00:25:07 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:25:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 08/13] ARM: dts: qcom: sdx55: List the property values vertically
Date:   Wed,  8 Mar 2023 13:54:19 +0530
Message-Id: <20230308082424.140224-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with the rest of the devicetree files and the relative properties,
let's list the values of properties such as {reg/clock/interrupt}-names
vertically.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 9dabb94eafbc..286fa92da428 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -393,7 +393,11 @@ pcie_ep: pcie-ep@1c00000 {
 			      <0x40001000 0x1000>,
 			      <0x40200000 0x100000>,
 			      <0x01c03000 0x3000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "addr_space",
 				    "mmio";
 
 			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
@@ -405,12 +409,18 @@ pcie_ep: pcie-ep@1c00000 {
 				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
 				 <&gcc GCC_PCIE_SLEEP_CLK>,
 				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
-			clock-names = "aux", "cfg", "bus_master", "bus_slave",
-				      "slave_q2a", "sleep", "ref";
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "sleep",
+				      "ref";
 
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "global", "doorbell";
+			interrupt-names = "global",
+					  "doorbell";
 			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
 			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
 			resets = <&gcc GCC_PCIE_BCR>;
@@ -434,7 +444,10 @@ pcie_phy: phy@1c07000 {
 				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
 				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
 				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref", "refgen";
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "ref",
+				      "refgen";
 
 			resets = <&gcc GCC_PCIE_PHY_BCR>;
 			reset-names = "phy";
-- 
2.25.1

