Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED36F6FC709
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjEIMsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjEIMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:47:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0F54EF2;
        Tue,  9 May 2023 05:47:49 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349Cld48072705;
        Tue, 9 May 2023 07:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683636459;
        bh=pAmXovtyH0VcPwKCvbrRjZAEPL79KKeiL2ZkNeDGf4o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nVcO67Fn0TRBmbPUqvLjbkexCphG++g+j/9KCB0qKndJkCRXYBnmptdIDxer1PnEd
         JeU9/DxAN+36uxNqpgabiNndkglBDm8wel1FhgY6IQG3BT5AKrc5a+WOjimUv0cvT2
         PupbZT38zQb1aLre7nGbSg2f9R1+P1zDgm5lm4uQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349CldmA009350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 07:47:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 07:47:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 07:47:39 -0500
Received: from ul0491018.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349ClRFG052292;
        Tue, 9 May 2023 07:47:36 -0500
From:   Thejasvi Konduru <t-konduru@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thejasvi Konduru <t-konduru@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j7200-main: Fix node has a unit name, but no reg/ranges property
Date:   Tue, 9 May 2023 18:17:27 +0530
Message-ID: <20230509124727.18375-4-t-konduru@ti.com>
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

This rule is not followed in the serdes_ln_ctrl and usb_serdes_mux nodes.

Warning is fixed by adding the reg property in the serdes_ln_ctrl
and usb_serdes_mux nodes.

Fixes: 1509295295c03 ("arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux")
Fixes: 9a09e6e9cfcf5 ("arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX")
Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 138381f43ce4..a99077b4ca0e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -35,6 +35,7 @@
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
+			reg = <0x4080 0x10>;
 			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
 					<0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
 		};
@@ -42,6 +43,7 @@
 		usb_serdes_mux: mux-controller@4000 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
+			reg = <0x4000 0x4>;
 			mux-reg-masks = <0x4000 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
 		};
 	};
-- 
2.17.1

