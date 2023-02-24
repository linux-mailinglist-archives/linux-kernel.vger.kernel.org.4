Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142636A1AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBXLBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBXLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:00:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCD9570B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:59:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so2465731pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M8kYEAz7MzsWNWHJToSlMHPi/nWVr288+AKYIv+MWQ=;
        b=SL27Mr2ERpEciqBGkdCVkt8X3uoEG0B+m/CpRXwDKRLeVSi8sk3S2P5KtaSPjVoC+0
         o+KprIlCXQT94+pAZnB6e9GBGvNpvrdGWLXqcfxnnkLazHHcy0x++Vx7DGjajdxMs3t0
         fjt7MwkjsgmMa5XFOG0ioZzxPwtWQDwtk1Uh6YBYx9/kK7AZkBwx1/+ymDfzPKJzUuxT
         WlgXFYeB1Q5OXEWGpkEGwWc3TXWH2xJ7TrV8n0g7bzlFVgCtHsBu38/6/fO0xWStygvI
         qM1ewxil2Ns92lWC2IwWuYL/ZjF2+jBLxUgbJRWD4pOMSc13tyhFPcEg/VNrGtPaVmsP
         Ok5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0M8kYEAz7MzsWNWHJToSlMHPi/nWVr288+AKYIv+MWQ=;
        b=bf4oF02MMuBfCHBZs9o+hDN+ale8EuZAYXuPvosfLbv5Xhe6PUy+VLPt5Nvw8ACXiQ
         4rD5kGJRBlVDMoXbzTdUYbiz2WS9GTiaisd0ftEfo0fx04APLvGMt2S2uDavLq7qnYf9
         0nWfJL+wNBPuduQnPRHTjcCyk3T0gS5+p5IsPt4I8nCjk2lZpayPNdNLkOPZ/MSOUYJB
         MoN6JMUz6V14zc+q9EQmk9KjvG/d5ixf6u+VLG9dQB6PKyns6bQxJAEnrQJIdJO0xMG/
         ZI4lDB+TfN2lwi8cA+bcxus+Gxe9/c+xhKMfTHmFpboVCkAZxuIWyOhY4yEAfT0NtC/M
         IXqw==
X-Gm-Message-State: AO0yUKXfz2PkCH1xnXk2SPaonRijuoBSaFMMYmQdanhRuVTqbDaFOBkf
        oSr6dd/hU/CrkkxGOyGrF4jD
X-Google-Smtp-Source: AK7set8Wj3Cy0TsPu96DQreGVAx4H+6J+lMBG0tY6SEfeX2bTCwaDqD2bvaNTFiSdVOXF0boee/TiA==
X-Received: by 2002:a17:90b:3a87:b0:230:c723:f37d with SMTP id om7-20020a17090b3a8700b00230c723f37dmr18680685pjb.40.1677236384121;
        Fri, 24 Feb 2023 02:59:44 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 06/13] ARM: dts: qcom: sdx55: Rename pcie0_{phy/lane} to pcie_{phy/lane}
Date:   Fri, 24 Feb 2023 16:28:59 +0530
Message-Id: <20230224105906.16540-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
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

There is only one PCIe PHY in this SoC, so there is no need to add an
index to the suffix. This also matches the naming convention of the PCIe
controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts | 2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
index ac8b4626ae9a..b7ee0237608f 100644
--- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
@@ -242,7 +242,7 @@ &ipa {
 	memory-region = <&ipa_fw_mem>;
 };
 
-&pcie0_phy {
+&pcie_phy {
 	status = "okay";
 
 	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index e84ca795cae6..a1f4a7b0904a 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -334,7 +334,7 @@ pcie_ep: pcie-ep@1c00000 {
 			resets = <&gcc GCC_PCIE_BCR>;
 			reset-names = "core";
 			power-domains = <&gcc PCIE_GDSC>;
-			phys = <&pcie0_lane>;
+			phys = <&pcie_lane>;
 			phy-names = "pciephy";
 			max-link-speed = <3>;
 			num-lanes = <2>;
@@ -342,7 +342,7 @@ pcie_ep: pcie-ep@1c00000 {
 			status = "disabled";
 		};
 
-		pcie0_phy: phy@1c07000 {
+		pcie_phy: phy@1c07000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
 			reg = <0x01c07000 0x1c4>;
 			#address-cells = <1>;
@@ -362,7 +362,7 @@ pcie0_phy: phy@1c07000 {
 
 			status = "disabled";
 
-			pcie0_lane: lanes@1c06000 {
+			pcie_lane: lanes@1c06000 {
 				reg = <0x01c06000 0x104>, /* tx0 */
 				      <0x01c06200 0x328>, /* rx0 */
 				      <0x01c07200 0x1e8>, /* pcs */
-- 
2.25.1

