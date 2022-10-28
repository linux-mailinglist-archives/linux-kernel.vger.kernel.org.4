Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACC2611477
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiJ1OZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB775DE6;
        Fri, 28 Oct 2022 07:24:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOMfa023825;
        Fri, 28 Oct 2022 09:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967062;
        bh=/kPqQlZdcsUhjWCP7KPJkrqubvgGKg+hME77pCNOlPM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TLrhqLlL4XzL7AhYHvKbfGCyZJJ5rrtQP3FBHmI01PzIZIpH8t6nHVyGJEm7eMfKJ
         8r2IyPw6EqTiEX0r8gq8/YJbbe1HmsoACbPOJ83exfajd5dUlAB89/YKERYqzBciah
         2KgJYvENdyqaow6I4CL1uHT2g1i3SHHVxjECcBkw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOMBW072889
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:22 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:22 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfV039275;
        Fri, 28 Oct 2022 09:24:21 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 06/11] arm64: dts: ti: k3-am65: MDIO pinmux should belong to the MDIO node
Date:   Fri, 28 Oct 2022 09:24:12 -0500
Message-ID: <20221028142417.10642-7-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although usually integrated as a child of an Ethernet controller, MDIO
IP has an independent pinout. This pinout should be controlled by
the MDIO node (so if it was to be disabled for instance, the pinmux
state would reflect that).

Move the MDIO pins pinmux to the MIDO nodes.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index f4b8747ebaef6..0c63c24941061 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -529,10 +529,13 @@ flash@0 {
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>;
 };
 
 &davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mdio_pins_default>;
+
 	phy0: ethernet-phy@0 {
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-- 
2.37.3

