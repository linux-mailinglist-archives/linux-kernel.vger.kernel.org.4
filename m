Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAC6B0141
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCHI0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCHIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:25:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817BCB1A4E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:25:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so1495333pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678263912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfPfJbuBCr/z6UPf30LbgTiprhegyjugmOR3U4nPOZw=;
        b=JzrgFsMkZEbo/x9XSaSLYAe3Xh0Ys+qsISvV8tYJb1YGAkQL1+CAgyekEEDsUIsPI6
         iaegsZRji2odfHxrMAnzaRtslPruxPs/i3tMqJoMrKFfL6ADGXfB5UvR80s6BXm8tK7U
         CjNyNJdShcE0omGpLz+KWJPgCaGD1Rvn5fmd3PEYED9ZSrr7sGaLvpl/D/hB5HHEDNvz
         Kxtu6WNVa0GjT3O4TtJP59xFfzguORhj2CzPWkLxhYmHTph8qGeH+uPRMsKF58SyHDbC
         yG7tpeWMzXzcT3Tx7GKIFC0kSL4FfmMbnXJG71GP6oQIZ+8sffc9ykpKGql0zCiBN0NR
         a9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfPfJbuBCr/z6UPf30LbgTiprhegyjugmOR3U4nPOZw=;
        b=WRIZSUZSME/aNNQr2PmCNHrdtKneFsr2HJDXn/7ak2lMPq1h9ApwJyzHsIzq/MvRZd
         NjTxAvaccJGfRDTR3PM4nH343WtlPXi/4vQYExiosEjZBF/2YZxmr64fwewtwX6kIBr4
         huKPkCKrdIG3VADgtbuyCOTeNtn7Yo3AIvBhbVBOm/H0EvZoz35zfBFtI+BHJW9eDvYe
         ftZ+q0dbse9yb4ZM9CmbJYGQ7gHtECxrbiT6N5rvHuw3fRSDH3HVa3NJWKGySdBVfivN
         YrMzv51s7sczA6i8j6j8xwOivNBJwpgjTZ9Ab1w1GaCvgCim2qRatrBb9a/lzCFhgjAu
         YOTQ==
X-Gm-Message-State: AO0yUKV2bHT4CvsJTdQzNmkVTl8OSm8cAz1Jj+18Oog7aotinBqupX6B
        wO8B+fvS355kyj+v+zyHyKrtP9b/nf0R92ywXA==
X-Google-Smtp-Source: AK7set/L1dsF97m39ajoh8yMTStHAFCR7t7AZ4VJpnF8cskdN97rs2QONWSB8stY+iDUtg3E0onT5w==
X-Received: by 2002:a17:903:441:b0:19a:b5cd:6e73 with SMTP id iw1-20020a170903044100b0019ab5cd6e73mr13939201plb.3.1678263911955;
        Wed, 08 Mar 2023 00:25:11 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b0019aaab3f9d7sm9448086plg.113.2023.03.08.00.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:25:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 09/13] ARM: dts: qcom: sdx55-t55: Enable PCIe RC support
Date:   Wed,  8 Mar 2023 13:54:20 +0530
Message-Id: <20230308082424.140224-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
References: <20230308082424.140224-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIe RC support on Thundercomm T55 board.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-t55.dts | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
index d5343bb0daee..5edc09af8e0d 100644
--- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
@@ -242,6 +242,23 @@ &ipa {
 	status = "okay";
 };
 
+&pcie_phy {
+	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
+	vdda-pll-supply = <&vreg_l4e_bb_0p875>;
+
+	status = "okay";
+};
+
+&pcie_rc {
+	perst-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &qpic_bam {
 	status = "okay";
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

