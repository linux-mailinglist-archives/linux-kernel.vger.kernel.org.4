Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680CB629654
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiKOKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiKOKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:51:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692E25C78
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a29so23803360lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bLbp0wJvq57oO/aqR1507U+w5Xitt7wxnM4y42X75Ug=;
        b=iSXQillTkvNosXmaPm3UaEUZyQ7JYBLtOTkIO/cr26J8ImBqIgc7pgOExn9yXF3NVm
         BRTP3wWYj+opRxTFeaC1kRLFsf2nRrhZaK02RTNKHj4Hp7lxSk83c4uXCFLs3hXhhV4A
         zZct5RrKRNx3NaJ+yHm0J0+U+3ldDguzsszXc0zS7Jj74G2+8xkCS+g6QIm9c1kZ+17R
         o5ftC0VdljUjW3e2m4X0souftrED2x3+u6K+S7/jRV+q+osT4ZcuFXGmrw/Yut8h6cIZ
         K4N8aLgyHZPrj/M+XsLPUV0sodKuILS6/sG0AHGf1Bgom0RXPMIS2ADFk9epVhOiG90L
         MWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLbp0wJvq57oO/aqR1507U+w5Xitt7wxnM4y42X75Ug=;
        b=DxA/ChETJcxtJ/5n5K2qFkqi6tmAS2BC7mCLp8A3VpyCFccVm5nvDlgUR6eV4eYcqB
         lrv17lHshpXnQYS4R0sFns6qFaOOEwWDx+B2Aqbl1Z1JfSpiLJ6Ri5Esx7NOYkyXJD2L
         E8tWt5XXq09vIrL0w/A0iW9lfCJc9Xl1UPU+e61KDX4HkMGZ2aLnvoNAR/5bAKtNm9gA
         knakNkjNP4l10O0Y4T0CSWed+tHoq1jbhLp5onXeMR++RW1MNuLoNemnyGpoH6J4fzC/
         sySiCSJ7WBAFObHLeCV0dOcikE+Ao2/8cW/H7RQsld1AtvBmbdPmqtEJZY3pCjTavEuU
         pP8A==
X-Gm-Message-State: ANoB5plMy6fy7Nx53aBcUirDH5XfaL16aTSLeld+MLPPwsiFdJ7mBd/w
        6Jhx3Olt3GW4CYEfj2vIlhGPvg==
X-Google-Smtp-Source: AA0mqf4/YK3RiUextXoV5tx032V9L1KGOHjfxnaEsuFiTHIdltPf410U5euv3K8Ked/kbso/cCMUWw==
X-Received: by 2002:a05:6512:128e:b0:4b3:ccea:9b2e with SMTP id u14-20020a056512128e00b004b3ccea9b2emr6150372lfs.379.1668509445829;
        Tue, 15 Nov 2022 02:50:45 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be17-20020a056512251100b00494935ddb88sm2150742lfb.240.2022.11.15.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:50:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: ti: trim addresses to 8 digits
Date:   Tue, 15 Nov 2022 11:50:44 +0100
Message-Id: <20221115105044.95225-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hex numbers in addresses and sizes should be rather eight digits, not
nine.  Drop leading zeros.  No functional change (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  | 2 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi    | 4 ++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index ff936d547c99..38dced6b4fef 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -31,7 +31,7 @@ wkup_uart0: serial@2b300000 {
 
 	wkup_i2c0: i2c@2b200000 {
 		compatible = "ti,am64-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02b200000 0x00 0x100>;
+		reg = <0x00 0x2b200000 0x00 0x100>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 99afac40e8d4..81d984414fd4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -31,7 +31,7 @@ wkup_uart0: serial@2b300000 {
 
 	wkup_i2c0: i2c@2b200000 {
 		compatible = "ti,am64-i2c", "ti,omap4-i2c";
-		reg = <0x00 0x02b200000 0x00 0x100>;
+		reg = <0x00 0x2b200000 0x00 0x100>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d2ea067df686..6fec2b41e780 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1369,8 +1369,8 @@ gpmc0: memory-controller@3b000000 {
 		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 80 0>;
 		clock-names = "fck";
-		reg = <0x00 0x03b000000 0x00 0x400>,
-		      <0x00 0x050000000 0x00 0x8000000>;
+		reg = <0x00 0x3b000000 0x00 0x400>,
+		      <0x00 0x50000000 0x00 0x8000000>;
 		reg-names = "cfg", "data";
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		gpmc,num-cs = <3>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1930da25d282..6378f8ff5400 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -355,7 +355,7 @@ serdes_mux: mux-controller {
 
 		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
 			compatible = "syscon";
-			reg = <0x0000041e0 0x14>;
+			reg = <0x000041e0 0x14>;
 		};
 
 		ehrpwm_tbclk: clock@4140 {
-- 
2.34.1

