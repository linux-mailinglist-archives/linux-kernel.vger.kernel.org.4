Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F46FC708
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjEIMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjEIMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:47:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874A524E;
        Tue,  9 May 2023 05:47:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349Clar6001023;
        Tue, 9 May 2023 07:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683636456;
        bh=OSSmCn7EuGrchjM/4RqxD1HuFPjAvPXu+4cTVuZSFNU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uxgMHGVOqfF2gWmOZ2ePqGaPOnV2HLfiwVMXH8aK5WjBMzpok9xNSiqL3fwd11FNv
         6l6OOXBBpZ8Hqm7lmElU97x65sj8NzkzyXGd0r458pJYLFblIHCyQSlCpr6hTIikgD
         Gi4aynddoOY34je2O7GDgpv6Q8hhgVv8QPE6BQyQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349ClaQI009332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 07:47:36 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 07:47:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 07:47:35 -0500
Received: from ul0491018.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349ClRFF052292;
        Tue, 9 May 2023 07:47:33 -0500
From:   Thejasvi Konduru <t-konduru@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thejasvi Konduru <t-konduru@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j721e-main: Fix node has a unit name, but no reg/ranges property
Date:   Tue, 9 May 2023 18:17:26 +0530
Message-ID: <20230509124727.18375-3-t-konduru@ti.com>
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

This rule is not followed in the usb_serdes_mux node.

Warning is fixed by adding the reg property to the usb_serdes_mux
node.

Fixes: 4716053a0a7be ("arm64: dts: ti: k3-j721e-main.dtsi: Add USB to SERDES MUX")
Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c935622f0102..c73f1bbadf44 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -64,6 +64,7 @@
 		usb_serdes_mux: mux-controller@4000 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
+			reg = <0x4000 0x14>;
 			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
 					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
 		};
-- 
2.17.1

