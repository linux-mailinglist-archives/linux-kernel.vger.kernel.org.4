Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4565EC10E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiI0LV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiI0LUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905857274;
        Tue, 27 Sep 2022 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664277624; x=1695813624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z5gQaoAmgcNsBt6UN6nHGaKgQKU1tky1WsEv+3dwAJA=;
  b=K1zhU3TvaNAJYQ/+n23KVCmdxRWT1/d1FevQeUcnGFtcL0mSuCG35ykW
   AoHoLwGVVrL+UUMoVpYA3oRhny2cAmkrVAHeGrSYUFfMncWAwHCHP+2v1
   M1ftjjzJ9YWEaFS2RXY7zSQqzTSOeSdXUnRnxu+k9kweO+m9B9QR5UUyq
   CRLDGIgl2J4Kn4f+vOCbQmKFXFWTC/S9TZFvBtH8j5TidlOUdlR1h8XDO
   mkWCeFCDU8H/qVO/y2j9c/KrAhxSCB5qjADvIr5TErBr/3oeKUJ1DBg0e
   Q6DykQTfHEhL43NXFUAph9Jq8n+eGrS2bsi4Ng5cGqGc76vs0i4mp28mP
   w==;
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="179094371"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 04:20:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 04:20:17 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 27 Sep 2022 04:20:14 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 07/11] riscv: dts: microchip: icicle: re-jig fabric peripheral addresses
Date:   Tue, 27 Sep 2022 12:19:19 +0100
Message-ID: <20220927111922.3602838-8-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927111922.3602838-1-conor.dooley@microchip.com>
References: <20220927111922.3602838-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users try to add onto the reference design, they find that the
current addresses that peripherals connected to Fabric InterConnect
(FIC) 3 use are restrictive. For the v2022.09 reference design, the
peripherals have been shifted down, leaving more contiguous address
space for their custom IP/peripherals.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 9ca2ac4ad8e2..35030ea330ee 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -5,18 +5,18 @@ / {
 	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
 		     "microchip,mpfs";
 
-	core_pwm0: pwm@41000000 {
+	core_pwm0: pwm@40000000 {
 		compatible = "microchip,corepwm-rtl-v4";
-		reg = <0x0 0x41000000 0x0 0xF0>;
+		reg = <0x0 0x40000000 0x0 0xF0>;
 		microchip,sync-update-mask = /bits/ 32 <0>;
 		#pwm-cells = <2>;
 		clocks = <&fabric_clk3>;
 		status = "disabled";
 	};
 
-	i2c2: i2c@44000000 {
+	i2c2: i2c@40000200 {
 		compatible = "microchip,corei2c-rtl-v7";
-		reg = <0x0 0x44000000 0x0 0x1000>;
+		reg = <0x0 0x40000200 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&fabric_clk3>;
-- 
2.37.3

