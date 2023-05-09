Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6E6FC70A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjEIMr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjEIMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:47:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CC524B;
        Tue,  9 May 2023 05:47:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349ClXqn115184;
        Tue, 9 May 2023 07:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683636453;
        bh=kYe3PMG7GdlCaIsTC89IeEqgGLCvPKO38uuzVvPvIE4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VCHyVApyxhaj0Q9LC1u67uLK4UJMMeqClkUOaLYIR+gKPLpyBM9ebZG2li/jqxJYE
         07sBgKbj2/CdkXJiwD23fJVNhm159AJ+59xInGcXbFrlozVIsOvhLXaDFXXDnKiEH2
         X5QWeMEw4txHFh/PRBTHe6dSfFKAjZNF05pfav10=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349ClXpZ009314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 07:47:33 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 07:47:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 07:47:33 -0500
Received: from ul0491018.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349ClRFE052292;
        Tue, 9 May 2023 07:47:31 -0500
From:   Thejasvi Konduru <t-konduru@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thejasvi Konduru <t-konduru@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am65-mcu: Fix node has a unit name, but no reg/ranges property
Date:   Tue, 9 May 2023 18:17:25 +0530
Message-ID: <20230509124727.18375-2-t-konduru@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230509124727.18375-1-t-konduru@ti.com>
References: <20230509124727.18375-1-t-konduru@ti.com>
MIME-Version: 1.0
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

If a node has unit name, then the node must include the
reg/ranges property.

This rule is not followed in the fss node.

Warning is fixed by adding the ranges property to the fss node.

Fixes: 07481770e84c7 ("arm64: dts: ti: k3-am65: Add OSPI DT node")
Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 5dfa31840e9c..5562373ac7fc 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -263,7 +263,9 @@
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
 
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
-- 
2.17.1

