Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC869F814
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBVPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjBVPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:34:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385FC37737
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id g14so9371240pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+9Sxg1sb41EUH4zAEeTtmCUVlAMIKcvxnijBOORmOY=;
        b=jlL9hkETSqXMCQvndvSYrxt2mtvIg+fQFVKMaFTHa4SB7e13POZ94FVzUYgK4CkUPc
         q/gXBN1CU4Pr4YfbVlwNfBnbSL7DcwyrdEy8OiAkbntBoeJqAlLuOWwP+5/6LqxvSVpU
         cQvUjKbI1/fXQzZZaDT4QttRFik1azUSoDVKVz3unFqI/Dh/yFP9l7Gc6pLiZlo55Ikq
         SgOALd1loK34qUMP788zXbxc9Abe/YCN8R1Lu3YVcxpg6WQl9JiZDq/pbBYf2OWd4CjV
         56Cazi3+t8EC15m9MsKHmFHJ42lEgh+pwhXLewFl54ri0vwFagXTlVKsYfxTET2Z+9sI
         YaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+9Sxg1sb41EUH4zAEeTtmCUVlAMIKcvxnijBOORmOY=;
        b=xUNJWwAet14TaExaVLlUjSMttAJaTmx2Le+BzJbjJkkndi/Y5Sa5un2/I05Cvv+v2f
         rmW9c9EmO6rGQ6lvYok0CdKswDk9y9N6/GTXuFsifrhQvoiswfWEq3ULGMNcczMIdoem
         iI52eeEaRhn/MMbkFPBq2alD28W/4u7/RAqxVE7+qV9ovla5gxeL6RQbn93rrx5/0QcK
         F5CX7hfsinKsQwRb0i5ZkIatJz7UIB630tgV2UioUi/OC5ZA7JsggWjR5MjRx9vCzEIK
         WNqsSnW5WFtLcdM0TFUaSHocNx1NGyc1VVuZfr9pDyB6RaGikxHKevRQwyndsLPRHN8m
         xsQw==
X-Gm-Message-State: AO0yUKVzMqhunezwbmnKy26QMiIuMkMfD8UVmBpKOcPwcSsqGKrsvIy3
        mN35jVbIS4xCyrzw04tRr9Cs
X-Google-Smtp-Source: AK7set+4JXdFNp466/OKLnsE3IvPEtUAHyclH/pPDs/H4vtCDnL2xEkVW/4LZOiSybtPhrEqOCUYGQ==
X-Received: by 2002:a05:6a20:430e:b0:bf:d67e:5517 with SMTP id h14-20020a056a20430e00b000bfd67e5517mr9458405pzk.42.1677080025381;
        Wed, 22 Feb 2023 07:33:45 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.15])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm5222482pfd.186.2023.02.22.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:33:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/11] ARM: dts: qcom: sdx55-t55: Enable PCIe RC support
Date:   Wed, 22 Feb 2023 21:02:48 +0530
Message-Id: <20230222153251.254492-9-manivannan.sadhasivam@linaro.org>
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

Enable PCIe RC support on Thundercomm T55 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-t55.dts | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
index 7ed8feb99afb..fb5b9264077c 100644
--- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
@@ -242,6 +242,23 @@ &ipa {
 	memory-region = <&ipa_fw_mem>;
 };
 
+&pcie_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
+	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
+};
+
+&pcie_rc {
+	status = "okay";
+
+	perst-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_default>;
+};
+
 &qpic_bam {
 	status = "ok";
 };
@@ -265,6 +282,31 @@ &remoteproc_mpss {
 	memory-region = <&mpss_adsp_mem>;
 };
 
+&tlmm {
+	pcie_default: pcie-default-state {
+		clkreq-pins {
+			pins = "gpio56";
+			function = "pcie_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-pins {
+			pins = "gpio57";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-pins {
+		       pins = "gpio53";
+		       function = "gpio";
+		       drive-strength = <2>;
+		       bias-pull-up;
+	       };
+	};
+};
+
 &usb_hsphy {
 	status = "okay";
 	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
-- 
2.25.1

