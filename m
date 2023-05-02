Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4848C6F4279
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjEBLQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEBLQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:16:49 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4227159D8;
        Tue,  2 May 2023 04:16:40 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id BE6347200BB;
        Tue,  2 May 2023 13:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1683026154;
        bh=Icos1CRSpLsU5WPpF2CpjE8xWcpBrCeK308FlAHPLcU=;
        h=From:To:CC:Subject:Date:From;
        b=V6+am2fGLm88Kp1Q9umhI5nohbx0qHTpEJ9eA21EciwTPH2sMfyQojmTgaLP/6mwn
         81J/GW0SY6Fa+jpF1RSJ0qJhrfXlpSwUQgF6UHDEzoj7BBJyjT5qudP7kHhKovWAg5
         pSaj1DUt5+9thtCGle5IMBYysS6ZpTcPAyqY6JbXurJQbOjrFpRy+3R8Y0n4eruPW3
         EJJz54SjDMXN8B8TqsW6F8FslrlIlFwMVfQX9g+Vns9AWhgHQOdo3PN2fNnTwezTEC
         6hIyjIw+bAmCUZNhSSMfqdPN1Z8qANWzHV/0fiN379lD/SbDewpCjrF1Xrn7VdOW5F
         XF8oaXVMx4NZw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 May 2023 13:15:41 +0200
Received: from localhost.localdomain (172.16.51.25) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Tue, 2 May 2023 13:15:40 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx6ull-dhcor: Set and limit the mode for PMIC buck 1, 2 and 3
Date:   Tue, 2 May 2023 13:14:24 +0200
Message-ID: <20230502111424.3114-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Renesas Electronics (formerly Dialog Semiconductor), the
standard AUTO mode of the PMIC DA9061 can lead to stability problems
depending on the hardware revision. It is recommended to set a defined
mode such as PFM or PWM permanently. So set and limit the mode for
buck 1, 2 and 3 to a fixed one.

Fixes: 611b6c891e40 ("ARM: dts: imx6ull-dhcom: Add DH electronics DHCOM i.MX6ULL SoM and PDK2 board")

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx6ull-dhcor-som.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
index 5882c7565f64..32a6022625d9 100644
--- a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/regulator/dlg,da9063-regulator.h>
 #include "imx6ull.dtsi"
 
 / {
@@ -84,16 +85,20 @@
 
 		regulators {
 			vdd_soc_in_1v4: buck1 {
+				regulator-allowed-modes = <DA9063_BUCK_MODE_SLEEP>; /* PFM */
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <DA9063_BUCK_MODE_SLEEP>;
 				regulator-max-microvolt = <1400000>;
 				regulator-min-microvolt = <1400000>;
 				regulator-name = "vdd_soc_in_1v4";
 			};
 
 			vcc_3v3: buck2 {
+				regulator-allowed-modes = <DA9063_BUCK_MODE_SYNC>; /* PWM */
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <DA9063_BUCK_MODE_SYNC>;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <3300000>;
 				regulator-name = "vcc_3v3";
@@ -106,8 +111,10 @@
 			 * the voltage is set to 1.5V.
 			 */
 			vcc_ddr_1v35: buck3 {
+				regulator-allowed-modes = <DA9063_BUCK_MODE_SYNC>; /* PWM */
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <DA9063_BUCK_MODE_SYNC>;
 				regulator-max-microvolt = <1500000>;
 				regulator-min-microvolt = <1500000>;
 				regulator-name = "vcc_ddr_1v35";
-- 
2.11.0

