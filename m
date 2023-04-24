Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE46ED3AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjDXRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjDXRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:37:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA449009;
        Mon, 24 Apr 2023 10:36:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OHaQBD038233;
        Mon, 24 Apr 2023 12:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682357786;
        bh=Bt8I2phOsHTqHoFHWTAEWE9tG89MYk99aiVqmL95K18=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Jt40UfQ5lsOFjVJE4wFIIiA1NyX/9UQviM/Afezd0jfDPdT2nQCVMZALjKbmoDfJR
         7RLEEl/PwosJHNcSZDGaKStT81pPRm5h1FtI3e1e/px3PK658xWgb+qdmNdJAMrMJa
         yLoguHliduBc/4wdGolvnk9WC3yOd6FX8CA05Geg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OHaQ3X027232
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 12:36:26 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 12:36:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 12:36:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OHaQT6027942;
        Mon, 24 Apr 2023 12:36:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        <vaishnav.a@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Split fss node up
Date:   Mon, 24 Apr 2023 12:36:23 -0500
Message-ID: <20230424173623.477577-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424173623.477577-1-nm@ti.com>
References: <20230424173623.477577-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

fss node claims to be entirely a syscon node, but it is really two
parts of it - one a syscon that controls the hbmc mux and a simple bus
where ospi, hbmc peripherals are located. So model it accordingly by
splitting the node up and using ti,j721e-system-controller to describe
the syscon

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index b58a31371bf3..7653cb191be1 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -338,18 +338,27 @@ mcu_spi2: spi@40320000 {
 		status = "disabled";
 	};
 
-	fss: syscon@47000000 {
-		compatible = "syscon", "simple-mfd";
+	hbmc_syscon: syscon@47000000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
 		reg = <0x00 0x47000000 0x00 0x100>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x47000000 0x100>;
 
-		hbmc_mux: hbmc-mux {
+		hbmc_mux: mux-controller@4 {
 			compatible = "mmio-mux";
+			reg = <0x4 0x2>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4 0x2>; /* HBMC select */
 		};
+	};
+
+	fss: bus@47030000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x47030000 0x0 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
 
 		hbmc: hyperbus@47034000 {
 			compatible = "ti,am654-hbmc";
-- 
2.40.0

