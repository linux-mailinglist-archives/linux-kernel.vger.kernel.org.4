Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772696F4D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjEBXPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjEBXPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:15:45 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF261FF9;
        Tue,  2 May 2023 16:15:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 342NFSmi094575;
        Tue, 2 May 2023 18:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683069328;
        bh=nMHuxuebwtV1J20/l5jxszE0QZAUu3Z1rgEvqfMfE4c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lmjBut2EFqAuS7y9NQsml2reDZZ9jzT29qgeFMS+tfy10MTDJ04h3uu9/07ZBSOiD
         POGP7dQpm739AubWdUJsd3t6Y6sKDkqXFWVOFo+A2fdGAA7WUzI1STQf35BEVGPGUO
         Hwy/Cx4a2SGxrCG9gcNoCqwlLYhlo2nPmh/ePMYs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 342NFS3F081518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 May 2023 18:15:28 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 May 2023 18:15:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 May 2023 18:15:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 342NFR38089851;
        Tue, 2 May 2023 18:15:27 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes
Date:   Tue, 2 May 2023 18:15:26 -0500
Message-ID: <20230502231527.25879-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230502231527.25879-1-hnagalla@ti.com>
References: <20230502231527.25879-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J784S4 SoCs have four TMS320C71x DSP subsystems in the MAIN voltage
domain. The functionality of these DSP subsystems is similar to the C71x
DSP subsystems on earlier k3 device J721S2. Each subsystem has a 48 KB of
L1D configurable SRAM/Cache and 512 KB of L2 SRAM/Cache. This subsystem
has a CMMU but is not currently used. The inter-processor communication
between the main A72 cores and the C71x DSPs is achieved through shared
memory and mailboxes. Add the DT nodes for these DSP processor sub-systems.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 3c785cef4f20..7277bf6eda09 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1232,4 +1232,52 @@ main_r5fss2_core1: r5f@5a00000 {
 			ti,loczrama = <1>;
 		};
 	};
+
+	c71_0: dsp@64800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x64800000 0x00 0x00080000>,
+		      <0x00 0x64e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <30>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 30 1>;
+		firmware-name = "j784s4-c71_0-fw";
+	};
+
+	c71_1: dsp@65800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x65800000 0x00 0x00080000>,
+		      <0x00 0x65e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <33>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 33 1>;
+		firmware-name = "j784s4-c71_1-fw";
+	};
+
+	c71_2: dsp@66800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x66800000 0x00 0x00080000>,
+		      <0x00 0x66e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <37>;
+		ti,sci-proc-ids = <0x32 0xff>;
+		resets = <&k3_reset 37 1>;
+		firmware-name = "j784s4-c71_2-fw";
+	};
+
+	c71_3: dsp@67800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x67800000 0x00 0x00080000>,
+		      <0x00 0x67e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <40>;
+		ti,sci-proc-ids = <0x33 0xff>;
+		resets = <&k3_reset 40 1>;
+		firmware-name = "j784s4-c71_3-fw";
+	};
 };
-- 
2.34.1

