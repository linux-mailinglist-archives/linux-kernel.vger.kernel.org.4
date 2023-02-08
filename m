Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1DC68F704
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBHSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:36:22 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A053570;
        Wed,  8 Feb 2023 10:35:44 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1685cf2003aso24368758fac.12;
        Wed, 08 Feb 2023 10:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJYr4Zf6uscLIIeS4tHZ9ESk+y1K+YlFWuYnR2c2Tyo=;
        b=yV4672mD6wAnkOeVSOYa4fhpHOcnm78rBFiT1LvLUF8R1fM8UVFXel6u3V+DIMiSt5
         LIH9WgGFQRfNapmVF0JZg7pCjVwTqPkPewFJCPW6j+0i92fujA8FWn7rs3+vQ1ue1ugf
         sVviPLv5pGl2dBg0tYj2HJH6/59DT9KCmU+tIsYeZx4mgZ95aK2fBNsrnhC8xE5fBaGI
         72ihFY1ClcmJw1AGC7bNmYol8rIJ1uzAN2QxtblABdbhKFh8+/Qmr1c/CxaeMBe7NWLS
         I2q4wS9sEMBtAzowquoPAMzMnfet8STxpnSrrSm5P+9XSuVhhF+q6dlnuMFnGhef9W0r
         xS4g==
X-Gm-Message-State: AO0yUKXMk5nystp8i/IOFLHtYHvX8Hyp1xgxk7kzk4KaFSWvRYsyV2qY
        6tzVvmlZUZonkd2d6DaGhw==
X-Google-Smtp-Source: AK7set+MOQHxeEfczTB5yVhuZDv87NZx3ov891p44iJXP7TtW1H0LqJOImZCPCO431ZxHvqzR2esjQ==
X-Received: by 2002:a05:6870:b4a5:b0:166:732f:c936 with SMTP id y37-20020a056870b4a500b00166732fc936mr4200230oap.35.1675881317867;
        Wed, 08 Feb 2023 10:35:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l22-20020a056870d4d600b001636786f7absm7075017oai.43.2023.02.08.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:35:17 -0800 (PST)
Received: (nullmailer pid 2284391 invoked by uid 1000);
        Wed, 08 Feb 2023 18:35:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: layerscape: Fix GICv3 ITS node names
Date:   Wed,  8 Feb 2023 12:34:38 -0600
Message-Id: <20230208183437.2283665-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 ITS is an MSI controller, therefore its node name should be
'msi-controller'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that this exposes an issue that #msi-cells is missing. In turn, the 
use of msi-parent in PCI nodes is wrong and should be msi-map according 
to my sources (Robin M), but I have no idea what is correct there.

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 1b33cabb4e14..dd1c8f60fad1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -131,7 +131,7 @@ gic: interrupt-controller@6000000 {
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0xf) |
 					 IRQ_TYPE_LEVEL_LOW)>;
-		its: gic-its@6020000 {
+		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translater */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 260d045dbd9a..6dd680fb1b22 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -123,7 +123,7 @@ gic: interrupt-controller@6000000 {
 		#size-cells = <2>;
 		ranges;
 
-		its: gic-its@6020000 {
+		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			reg = <0x0 0x6020000 0 0x20000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 348d9e3a9125..d2f5345d0560 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -60,7 +60,7 @@ gic: interrupt-controller@6000000 {
 		interrupt-controller;
 		interrupts = <1 9 0x4>;
 
-		its: gic-its@6020000 {
+		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			reg = <0x0 0x6020000 0 0x20000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 50c19e8405d5..ea6a94b57aeb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -395,7 +395,7 @@ gic: interrupt-controller@6000000 {
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-		its: gic-its@6020000 {
+		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			reg = <0x0 0x6020000 0 0x20000>;
-- 
2.39.1

