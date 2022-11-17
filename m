Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0580662D890
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiKQKyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiKQKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:53:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBC5ADE0;
        Thu, 17 Nov 2022 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668682398; x=1700218398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H6jfv/98Y/BHItdiM3LYtojQb8Xu3XwDeExUAi0R+zs=;
  b=z1cYFK+OLBZGxMMogW4KNZ2mZnOIBPB5I7ZKsfP0zBTAN4G8F0vZ2Qp6
   27tt07qT2VKT4jd5iI7td9BzTtmwf5A7deukzgAZG1RudHILh/NQjGdvW
   THu9UVdrBYkVo8zkQZ2w17W8yK2PQumzXpb6vlfSFJL4UBjCh2v/bJEl3
   qzBzn7ucOU7icbNNncN/4soQomq/qikfkeTbW8r/OW5QykpxtJcFhUxlj
   YQCHoEQyRCyVeULAGLRESxPhfSqPTUxbr02p2Pgw5SYdnqXvN+bRkodax
   IBAO897VxOHNiZwTe4eMFX4GMV+D+Hj5v32ju+9Mhg0TGDf5quD4+WAHy
   w==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="183965650"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 03:53:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 03:53:11 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 03:53:09 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 6/8] ARM: dts: at91-sama5d27_som1: Set sst26vf064b SPI NOR flash at its maximum frequency
Date:   Thu, 17 Nov 2022 12:52:47 +0200
Message-ID: <20221117105249.115649-7-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117105249.115649-1-tudor.ambarus@microchip.com>
References: <20221117105249.115649-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sama5d27-som1 populates an sst26vf064b SPI NOR flash. Its maximum
operating frequency for 2.7-3.6V is 104 MHz. As the flash is operated
at 3.3V, increase its maximum supported frequency to 104MHz. The
increasing of the spi-max-frequency value requires the setting of the
"CE# Not Active Hold Time", thus set the spi-cs-setup-ns to a value of 7.

The sst26vf064b datasheet specifies just a minimum value for the
"CE# Not Active Hold Time" and it advertises it to 5 ns. There's no
maximum time specified. I determined experimentally that 5 ns for the
spi-cs-setup-ns is not enough when the flash is operated close to its
maximum frequency and tests showed that 7 ns is just fine, so set the
spi-cs-setup-ns dt property to 7.

With the increase of frequency the reads are now faster with ~37%.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
index 8aa9e8dea337..243f09f40761 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -43,7 +43,8 @@ flash@0 {
 					#size-cells = <1>;
 					compatible = "jedec,spi-nor";
 					reg = <0>;
-					spi-max-frequency = <80000000>;
+					spi-max-frequency = <104000000>;
+					spi-cs-setup-ns = /bits/ 16 <7>;
 					spi-tx-bus-width = <4>;
 					spi-rx-bus-width = <4>;
 					m25p,fast-read;
-- 
2.25.1

