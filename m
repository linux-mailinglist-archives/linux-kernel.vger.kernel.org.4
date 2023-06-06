Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4740724B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbjFFSXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjFFSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:55 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2C1980;
        Tue,  6 Jun 2023 11:22:38 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356IMNBE019421;
        Tue, 6 Jun 2023 13:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686075743;
        bh=eKKbm7jVZ/mb5ap5k7maFwPV6MZr901hlHMj/b4dikA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DBhmKTAovvPW2TRbOIVPjXrUgSovRU+7+/fpE+UwMCQYDFHzYjvn7jyNmEU7R6Mht
         LXWHoUpZJyL8Iv7GzhZM3SiU3y/qx4QgJDQCGIRDdtFzSiZYuyfzLE44n4wmyWGRAN
         dDfpSqf2PQ9mHuKFHBwdbf44rm5xha67yOJwZ6L4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356IMNml043902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 13:22:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 13:22:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 13:22:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356IMN3H040847;
        Tue, 6 Jun 2023 13:22:23 -0500
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
Subject: [PATCH V2 04/14] arm64: dts: ti: k3-j721e-beagleboneai64: Move eeprom WP gpio pinctrl to eeprom node
Date:   Tue, 6 Jun 2023 13:22:10 -0500
Message-ID: <20230606182220.3661956-5-nm@ti.com>
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

Move the eeprom WP GPIO mux configuration to be part of the eeprom node
instead of the I2C node.

Cc: Robert Nelson <robertcnelson@gmail.com>
Suggested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
New Patch

 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 1a65d3617a29..a3f602e4fb45 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -639,12 +639,14 @@ &main_i2c6 {
 &wkup_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&wkup_i2c0_pins_default &eeprom_wp_pins_default>;
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
 	eeprom@50 {
 		compatible = "atmel,24c04";
 		reg = <0x50>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eeprom_wp_pins_default>;
 	};
 };
 
-- 
2.40.0

