Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DA06F993B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjEGPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEGPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:16:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47614124A7;
        Sun,  7 May 2023 08:15:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-76355514e03so285382339f.0;
        Sun, 07 May 2023 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683472558; x=1686064558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nbuBL7Zla4w3yRTggafEgE8ynuUvfM99IQbcp/hNf0=;
        b=sq+ArR+X7CV3ieO+RMaWHvKBYucfkvVF8Q6qQjQU50UH1JQYk+bzUzv2KAPyMWNZlZ
         TLS4X9mAp74u+ibZwDHi+Bux08oeEiHAQs0/j2o2IgqcmqYx6COcQh1qGStNE1Oo5gtD
         R3YCrwfrDTuTTb0CTbqPRT1ulROeAk+5JjZiB6aR96oJLqWgc1krHe2DfCPPI4PstEpx
         VTz+TsfNnqKauu2E0Z6rUYOHZJTzcEadzAqm9dfB6wz8RL/FmJ7J+5NmJZvRvvPSy9RC
         ljNzyaqQU3/0ElPaDOciOfVGW5ld4/AdrTRuUFPConQmW+B+FTYjb5LDqGhfBLhAZdCe
         fQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683472558; x=1686064558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nbuBL7Zla4w3yRTggafEgE8ynuUvfM99IQbcp/hNf0=;
        b=A2AHjFVtoxJ0ufzmaY5r6IZh9t2LFgrir0ejpJf0IDx7nghgIIrV9dDwZXxlLuSIMD
         sAJF10I4nYfHAVoTZ5/37f1Nr+gwQeTCBhExcPodK3d+yw5EPcooQ0zsjFqy047VwUCa
         xAPOIk4ry0g09I1s86yUlNiV/HKuHe4Fm4I/ZheGDJuXRjmfW/nAol38X/O+aPdg53Mp
         4aT0xwNhMSU5X4d4kfm/2+2NEyX2LiDI2H2ResyTH5fBKzPKL+bKhyighSh6Z9jtMb6Z
         Dzyj0LltMFwQvHxr9pYOj3VaazNDlRJ7I5pEIQFxvbIN/CN8wfoiY4TNHKiHQrevFbzs
         A4+Q==
X-Gm-Message-State: AC+VfDweLMmtxh1jqd3TBgwsRe7iwwlcXq0xsMfgnkWSrLilQ3gRywQW
        vOgHIYoXr076yXT/5T7eU0yIXqF0bS51Uw==
X-Google-Smtp-Source: ACHHUZ7LFCKjZxyGUHjBS8/Nt9+JEgMTYIz07RzkSo1rJLwQ1li1PD6d1xAW/8crSdLThh5ZGYAGzw==
X-Received: by 2002:a5d:9c96:0:b0:763:68c9:9d07 with SMTP id p22-20020a5d9c96000000b0076368c99d07mr6308999iop.10.1683472558519;
        Sun, 07 May 2023 08:15:58 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:32f2:3dc9:fe53:5220])
        by smtp.gmail.com with ESMTPSA id s1-20020a02b141000000b0040faf05071asm1293566jah.156.2023.05.07.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:15:57 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/3] arm64: dts: imx8mn: Add CSI and ISI Nodes
Date:   Sun,  7 May 2023 10:15:46 -0500
Message-Id: <20230507151549.1216019-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSI in the imx8mn is the same as what is used in the imx8mm,
but it's routed to the ISI on the Nano. Add both the ISI and CSI
nodes, and pointing them to each other. Since the CSI capture is
dependent on an attached camera, mark both ISI and CSI as
disabled by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Change from a singular 'port' to 'ports' per feedback from Laurent Pinchart
     "When a single port is present using a "port" node directly
     is fine from an OF graph point of view, but to avoid too much complexity
     in the ISI binding the consensus was to always require a "ports" node
     for the ISI."
     This is also consistent with the binding YAML file.

     Change the size allocated to the ISI to 32k.  The datasheet indicates it should
     be 64K, but the disp_blk_ctrl sits at 32e28000.

     Change the subject from 'Enable' to 'Add' since the ISI and CSI nodes are both
     technically disabled.

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 8be8f090e8b8..9869fe7652fc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1104,6 +1104,30 @@ dsim_from_lcdif: endpoint {
 				};
 			};
 
+			isi: isi@32e20000 {
+				compatible = "fsl,imx8mn-isi";
+				reg = <0x32e20000 0x8000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
+				clock-names = "axi", "apb";
+				fsl,blk-ctrl = <&disp_blk_ctrl>;
+				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_ISI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						isi_in: endpoint {
+							remote-endpoint = <&mipi_csi_out>;
+						};
+					};
+				};
+			};
+
 			disp_blk_ctrl: blk-ctrl@32e28000 {
 				compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
 				reg = <0x32e28000 0x100>;
@@ -1147,6 +1171,42 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 				#power-domain-cells = <1>;
 			};
 
+			mipi_csi: mipi-csi@32e30000 {
+				compatible = "fsl,imx8mm-mipi-csi2";
+				reg = <0x32e30000 0x1000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				assigned-clocks = <&clk IMX8MN_CLK_CAMERA_PIXEL>,
+						  <&clk IMX8MN_CLK_CSI1_PHY_REF>;
+				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_1000M>,
+							  <&clk IMX8MN_SYS_PLL2_1000M>;
+				assigned-clock-rates = <333000000>;
+				clock-frequency = <333000000>;
+				clocks = <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MN_CLK_CAMERA_PIXEL>,
+					 <&clk IMX8MN_CLK_CSI1_PHY_REF>,
+					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>;
+				clock-names = "pclk", "wrap", "phy", "axi";
+				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_MIPI_CSI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_csi_out: endpoint {
+							remote-endpoint = <&isi_in>;
+						};
+					};
+				};
+			};
+
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
-- 
2.39.2

