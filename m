Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08F069F7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBVPeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjBVPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:34:07 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DF39CED
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b20so5368851pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMflvsnFsn2zSdUZQv5yrtakTBmlDgkLH0Li1CsV2To=;
        b=YZJTTFPH0Pr2V8A31PjTaOSzgCTBXNraY7fMtPG5G+knvwky3RUWDSHn90AdWCV+9c
         J7EgwlG7yr0zO+cSybo6QMHLw3Xn0c8lHhMNKWpRCEg3TNfRgB7VO5Rjt6T9sLvhke6c
         x8jEe4o8ji7g5Wn3ZWspnn6L3KgKp8F3CWU41iPX0s+86vH8EmvHcaJOlbnq0MmrjW3Z
         iMEkr+33udcLVafW1PQUPJBSeP/bKpHg9f+bcMpWXcjrge9yEQtbkpSRoctusJu7bFvr
         F+jac6Os3hegzKKQHkhH7HpIatpRdD7sjimt+gZiR6TViFGeItQ6UyeP49l7IhWn1W6p
         q1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMflvsnFsn2zSdUZQv5yrtakTBmlDgkLH0Li1CsV2To=;
        b=FQheCRW+d+Zdu515e7LWCrOdsE17jVKnZzeYsC3ejBQn/pk0F3RCDiQ8gLZ7DZlg6u
         XMQCLbapeWWY8ryaqPiR1SVnHGSlX+H4fwTz2FhGpBSO9KBAGIpo+S4rubprG+H18Klb
         X/KZiXUZxIpLU0h246RMh2sXwq2LBRxWi0AzZKBzLzRMxP4gN81jztfXLOHskHDtGXwM
         +cv9jyVXqSmtT68FBMVy54Osjl5kvdYmlDjH10dpy1JcQKYUkYJ5dzCg9L+VevE3iyxT
         efhoIlVI6FjFRDKJk/atOZUQJK7LGgvaJr+75ObVNj1VNb8EZ6W6WQQ8GMEf1DrZdg9F
         uDeA==
X-Gm-Message-State: AO0yUKVTH/udXV6qu1CmgTu07VZvysLUe3tg4VwvwXG3Tomvx+m9+ysC
        w64GD8N3rWn/XbkUffz1/O8O1i8iOpQuOMU=
X-Google-Smtp-Source: AK7set/DaY4JX5g0bxT/WJ1K/Re0gRMiLL10QT0E6/zqLIvI5b7akQzia7g4DkJpCENlzYWk169QMw==
X-Received: by 2002:a62:505:0:b0:5a8:d97d:c346 with SMTP id 5-20020a620505000000b005a8d97dc346mr7084089pff.12.1677080013472;
        Wed, 22 Feb 2023 07:33:33 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.15])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm5222482pfd.186.2023.02.22.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:33:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/11] ARM: dts: qcom: sdx55: Rename pcie0_{phy/lane} to pcie_{phy/lane}
Date:   Wed, 22 Feb 2023 21:02:46 +0530
Message-Id: <20230222153251.254492-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
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

