Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADE6EC276
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 23:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDWV1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 17:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDWV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 17:27:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377D31BD;
        Sun, 23 Apr 2023 14:27:07 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-763c3429abaso50882739f.1;
        Sun, 23 Apr 2023 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682285226; x=1684877226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOjlnvDsvb6bgAKebVUE0qApMvQz1jb06beyFrnv+hI=;
        b=JdKY7LVOvz6pfW6YMi1FWh663LWft33E69+aZxmpCZS0DF+Xa67kHnd7hfrX0uLKDV
         9doXrAmkjqdGXxo/lP9WxQhF/c6ynqECrbQg1thddHgKGN21BLOp6yBk/Q0T9ecs5fiw
         obEBzOyDc6v7Y2BoJWBcQY8plOgV/o7fvtEWyfFgKhc0+2DTtdBQbV+SmvWUct4J7SdP
         XgAo0mPGX8UA4Zdi8PAD0EYiBNUOWqrRkttEXaNFKb5/S5GGdqPgzkLreuktxVffoOjd
         d+z9YeEXeQ9Fx7e1ebpJmJoXdl2gj5Kpt+u3nLSFtbiwP7HhR9vQsloVbJ0NQgWOQVXh
         rtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682285226; x=1684877226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOjlnvDsvb6bgAKebVUE0qApMvQz1jb06beyFrnv+hI=;
        b=l+eAstTasw3E5nmcTcWDb5cLOXqvRmWbzgHf8qbVm/HggARRACB/cT3mpJHZS/reoL
         VAagxqggiqG/4+oRQMM40VSvRxWzYj1tSM6h+S+o751ZdTIbM1uek24l7UJGAmXFPJ3H
         /NbjR0KcC2kPlK9SDgqugc2cLh/wfzI7N3H0E3i8i8KYQBdZn5nwKh0EWjHjDW1Dfw95
         QmfNdMdN3JGAYi2Ldw8hFO82fhzeAT9ka4uRhy7rfXFh58wdpjQ+RO0sh2LwyxFwuJ8C
         oIjaJUmpWeHmbvOR2EqGJFIQnleMPch4aRuGUYwO+roX+8WYRiB2cSMQ50+XzuvK1FrB
         CXcg==
X-Gm-Message-State: AAQBX9eTiHuiLopRjhQy3ACl6kAe9RGz+JqrbwZQohtnxVg7Dd8WZg2j
        H1EvoFhphr7MCBh88M96Beo=
X-Google-Smtp-Source: AKy350Zxk1soynFZ/2qIEkzJVAsJqEoziH6TbN5V+g3lXWbh9c9y9NTnfo7xiVs1PUgj8cKo2wH9vA==
X-Received: by 2002:a5e:9202:0:b0:760:b45d:7d54 with SMTP id y2-20020a5e9202000000b00760b45d7d54mr4569336iop.13.1682285226325;
        Sun, 23 Apr 2023 14:27:06 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:83d3:c200:cd2e:6159])
        by smtp.gmail.com with ESMTPSA id d1-20020a028581000000b004050767f779sm2897403jai.164.2023.04.23.14.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 14:27:05 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8mn: Enable CSI and ISI Nodes
Date:   Sun, 23 Apr 2023 16:26:55 -0500
Message-Id: <20230423212656.1381002-1-aford173@gmail.com>
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

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 8be8f090e8b8..102550b41f22 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1104,6 +1104,24 @@ dsim_from_lcdif: endpoint {
 				};
 			};
 
+			isi: isi@32e20000 {
+				compatible = "fsl,imx8mn-isi";
+				reg = <0x32e20000 0x100>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>;
+				clock-names = "axi", "apb";
+				fsl,blk-ctrl = <&disp_blk_ctrl>;
+				power-domains = <&disp_blk_ctrl IMX8MN_DISPBLK_PD_ISI>;
+				status = "disabled";
+
+				port {
+					isi_in: endpoint {
+						remote-endpoint = <&mipi_csi_out>;
+					};
+				};
+			};
+
 			disp_blk_ctrl: blk-ctrl@32e28000 {
 				compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
 				reg = <0x32e28000 0x100>;
@@ -1147,6 +1165,42 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
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

