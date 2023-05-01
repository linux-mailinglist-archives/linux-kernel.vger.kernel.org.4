Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9C6F36AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjEATZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjEATZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:25:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A82737
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 12:24:58 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64115e652eeso29012698b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682969098; x=1685561098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4KAh8wuSkuj+2XFnMn5E/sCgNnm5at5pl9Xs+VcK78=;
        b=OSkZqpdCuB5QWuNR04PgAmPEUjH9lrIt/8fHZtFsxK6vBVPRXLd4xCaiYatmE0t1lY
         sHJgTma5blWeCx9jiv6iZ/vhSVZEsJ1cnrrk+vVCAejaTAtI0yOoHjwSD1BslP0VbdTs
         hXxmXFB4z5xpaTEOzQDhnk/n+JNzBgqBl7u/VNha4MzUxTT62hSLc1wUylvtuy0En5FI
         jFWlLjbCJWgIq1JQNz8/HIbA6vetMbeWwdwl01MpUXYaMqLSvz36HTY5UbPTAU6SFWOd
         RrN+V3ohUtwO+3LheR6pnf+lLPzZ0SOIeyeTDXnxsFRREFFXch6oVdrbVrENEy4JP6bi
         xHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969098; x=1685561098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4KAh8wuSkuj+2XFnMn5E/sCgNnm5at5pl9Xs+VcK78=;
        b=VxDJ5toa0YgOzVdrFp3+HLvo8cYro99vAMlPQCMrxLm4dVc6EzOSI02vziajLZcRwT
         coUtysse2YTuSQlFm3xpl4UiC2vqRcPmVWjtkhlknvKCrVpqC3LrWFTFykIvJ/rZ/0yM
         iMkt4t5CqKwx9tnFoXTQwX65vZQMdFVmOLKQZW72VIDbQGotU8eTSB7dSeJEQuSS6HuH
         rPSU5J26Jx9yUc4F9rZX7VxFXTdSarwF1vA1vTVHlF62eEwfsiMZAGmbB1zcNP4oeMVP
         Zo/s4Ux8+B6MoFgqBY3k54FjXWKVngPaaHQrm5jaRyFV8+xop18CuluI6ZK0pQlsTHbX
         4XoA==
X-Gm-Message-State: AC+VfDz77SbHiJ7flzJInkyV6L0YZJFQr5X+Sc9igXKUCoIrt3kMyImP
        sCXW6B4BLRqZU0SKXvqPcoZknA==
X-Google-Smtp-Source: ACHHUZ6hgRXCvo7LQ2F8otRYZ2S2Y+KzvKEUcN3KvrlvdvTsfKjjzXRbjioBkjMw8muC7f1jBJ2BvQ==
X-Received: by 2002:a05:6a20:4420:b0:f2:b0:68e8 with SMTP id ce32-20020a056a20442000b000f200b068e8mr21999070pzb.3.1682969097966;
        Mon, 01 May 2023 12:24:57 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id 189-20020a6304c6000000b00513cc8c9597sm17459144pge.10.2023.05.01.12.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:24:57 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v9 3/4] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Tue,  2 May 2023 00:54:31 +0530
Message-Id: <20230501192432.1220727-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
References: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB superspeed qmp phy node to dtsi.

Make sure that the various board dts files (which include sm4250.dtsi file)
continue to work as intended.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++++++++--
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index a1f0622db5a0..75951fd439df 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -242,6 +242,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 631ca327e064..21d00b0295a1 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -661,6 +661,31 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy: phy@1615000 {
+			compatible = "qcom,sm6115-qmp-usb3-phy";
+			reg = <0x0 0x01615000 0x0 0x200>;
+
+			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "cfg_ahb",
+				      "ref",
+				      "com_aux",
+				      "pipe";
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
+			reset-names = "phy", "phy_phy";
+
+			#clock-cells = <0>;
+			clock-output-names = "usb3_phy_pipe_clk_src";
+
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
@@ -1111,8 +1136,8 @@ usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x04e00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_hsphy>;
-				phy-names = "usb2-phy";
+				phys = <&usb_hsphy>, <&usb_qmpphy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index ea3340d31110..81fdcaf48926 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -306,6 +306,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
-- 
2.38.1

