Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7836A1A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBXK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBXK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:27:09 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22F5260;
        Fri, 24 Feb 2023 02:26:26 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31OAP2QN118657;
        Fri, 24 Feb 2023 04:25:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677234302;
        bh=CA6Eyemn/clGXeZozRpUvHhbedGCWY3VTAAasBA1r88=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k5RD2ApeYU+W6v0Ra4tVF1Hc+eWY0JmgyEc5AxQn76etRCql23kIp/e036cVBtJbt
         be1/Pd1iWmSHOXk2omv48/S2gJUc1UpM/+nHkDfDxXg+yT4Ntqb8H33OWU3nELlWxK
         ydQM498adlIoGLhVdzwBiUeN08ie10ad5RxQN7ow=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31OAP2k3044583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Feb 2023 04:25:02 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Feb 2023 04:25:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Feb 2023 04:25:01 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31OAOcXf016652;
        Fri, 24 Feb 2023 04:24:58 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 5/8] arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
Date:   Fri, 24 Feb 2023 15:54:35 +0530
Message-ID: <20230224102438.6541-6-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230224102438.6541-1-r-gunasekaran@ti.com>
References: <20230224102438.6541-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

The board uses lane 1 of SERDES for USB. Set the mux
accordingly.

The USB controller and EVM supports super-speed for USB0
on the Type-C port. However, the SERDES has a limitation
that up to 2 protocols can be used at a time. The SERDES is
wired for PCIe, eDP and USB super-speed. It has been
chosen to use PCIe and eDP as default. So restrict
USB0 to high-speed mode.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
I had reviewed this patch in the v5 series [0].
Since I'm taking over upstreaming this series, I removed the self
Reviewed-by tag.

[0] - https://lore.kernel.org/all/96058a13-4903-2b8c-8de2-f37fdfd3672b@ti.com/

Changes from v10:
* Removed Link tag from commit message

Changes from v9:
* Enabled USB nodes

Changes from v8:
* No change

Changes from v7:
* No change

Changes from v6:
* No change

Changes from v5:
* Removed Cc tags from commit message

Changes from v4:
* No change

Changes from v3:
* No change

Changes from v2:
* No change

Changes from v1:
* No change

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 907f34ff22a5..fa38940fe6cd 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -147,6 +147,12 @@
 			J721S2_IOPAD(0x020, PIN_INPUT, 7) /* (AA23) MCAN15_RX.GPIO0_8 */
 		>;
 	};
+
+	main_usbss0_pins_default: main-usbss0-pins-default {
+		pinctrl-single,pins = <
+			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -323,6 +329,24 @@
 	};
 };
 
+&usb_serdes_mux {
+	idle-states = <1>; /* USB0 to SERDES lane 1 */
+};
+
+&usbss0 {
+	status = "okay";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	pinctrl-names = "default";
+	ti,vbus-divider;
+	ti,usb2-only;
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+};
+
 &mcu_mcan0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.17.1

