Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33A701615
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjEMKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbjEMKOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:14:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C14EEB;
        Sat, 13 May 2023 03:14:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DADnqZ064579;
        Sat, 13 May 2023 05:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683972829;
        bh=QP9DLvpI2LxPsticdZKwk8ul13y1Xt9EKIf/9b5Kiwo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FOuxbSnq337fJurJ/347oAcyZxK9AA5WZztlmltrnmWgt+Son+CtZlqgiBdYxxUZq
         dNXS7Brs1EJSuJPOZyqRNBQlaBSKOVAKZHwu83f0GGgv0OAzxfEcMWYKjoT3uoOtom
         Qr0sim9ZN2glKBxC7E5Nccxf21F5boxXirJlmxIU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DADnVD039626
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 05:13:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 05:13:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 05:13:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DADl3f123835;
        Sat, 13 May 2023 05:13:48 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u-kumar1@ti.com>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-j7200-mcu-wakeup: Update fss node and hbmc_mux
Date:   Sat, 13 May 2023 15:43:43 +0530
Message-ID: <20230513101343.785-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230513101343.785-1-vaishnav.a@ti.com>
References: <20230513101343.785-1-vaishnav.a@ti.com>
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

From: Nishanth Menon <nm@ti.com>

FSS node claims to be a syscon node, while it actually is a simple bus
where OSPI, HBMC peripherals are located and a mux for path select
between OSPI and Hyperbus which can be modelled as a reg-mux. So model
it accordingly and use reg-mux to describe the hbmc_mux.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V2->V3:
 * Keep register regions unchanged as it is correct according to memory
  map.
 * Update commit messages as per Vignesh's suggestion.

V1->V2:
 * Address feedback from Udit to limit the FSS register region size as
 per TRM.
 * Use reg-mux changes to simplify the hbmc-mux modelling.
 * Update commit message to reflect changes.

Depends on:
 https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index b58a31371bf3..a7dd771b83e2 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -338,15 +338,16 @@
 		status = "disabled";
 	};
 
-	fss: syscon@47000000 {
-		compatible = "syscon", "simple-mfd";
+	fss: bus@47000000 {
+		compatible = "simple-bus";
 		reg = <0x00 0x47000000 0x00 0x100>;
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
 
-		hbmc_mux: hbmc-mux {
-			compatible = "mmio-mux";
+		hbmc_mux: mux-controller@47000004 {
+			compatible = "reg-mux";
+			reg = <0x00 0x47000004 0x00 0x2>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4 0x2>; /* HBMC select */
 		};
-- 
2.17.1

