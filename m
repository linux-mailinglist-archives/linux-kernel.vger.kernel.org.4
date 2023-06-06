Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29FF724B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjFFSWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjFFSWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F71739;
        Tue,  6 Jun 2023 11:22:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356IMNNH072503;
        Tue, 6 Jun 2023 13:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686075743;
        bh=lMZZxncTym8Lnk4/i0leCY7pTLSHTcSq64FvwMvoqhg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xp90dUTvzxqJn7nIJvEyOfPV1f2xVX29p+S0+rXEX7EAQWvY7UcxiCk23AU8DTKgB
         M59Ap3Azfa0pldtdrb1rmRWWtFAIHDSMpfpt2RMPCIo4G9VJGbRldQufYoL9tyoe/d
         mVqkJN4SU6SyvMaRUkvSTg0znCqkxCoM3Wj4G39w=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356IMNeZ094566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 13:22:23 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 13:22:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 13:22:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356IMMwf024134;
        Tue, 6 Jun 2023 13:22:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH V2 03/14] arm64: dts: ti: k3-j721e-beagleboneai64: Move camera gpio pinctrl to gpio node
Date:   Tue, 6 Jun 2023 13:22:09 -0500
Message-ID: <20230606182220.3661956-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606182220.3661956-1-nm@ti.com>
References: <20230606182220.3661956-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the GPIO mux configuration needed for camera module to work to the
GPIO node instead of the I2C node.

Camera nodes are maintained as overlay files, but the common mux is
always needed to ensure that camera probes fine and ensuring the mux
is configured as part of the GPIO module allows for the multiple
overlay files to be simpler.

Cc: Robert Nelson <robertcnelson@gmail.com>
Suggested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch

 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 37c24b077b6a..1a65d3617a29 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -593,7 +593,7 @@ &main_i2c0 {
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c1_pins_default &csi1_gpio_pins_default>;
+	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 };
 
@@ -623,7 +623,7 @@ &main_i2c4 {
 &main_i2c5 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_i2c5_pins_default &csi0_gpio_pins_default>;
+	pinctrl-0 = <&main_i2c5_pins_default>;
 	clock-frequency = <400000>;
 };
 
@@ -688,6 +688,11 @@ &wkup_gpio1 {
 	status = "disabled";
 };
 
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi1_gpio_pins_default>, <&csi0_gpio_pins_default>;
+};
+
 &usb_serdes_mux {
 	idle-states = <1>, <1>; /* USB0 to SERDES3, USB1 to SERDES2 */
 };
-- 
2.40.0

