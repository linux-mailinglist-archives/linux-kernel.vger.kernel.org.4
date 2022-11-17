Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B378162D885
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiKQKxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239321AbiKQKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:53:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D05E9FA;
        Thu, 17 Nov 2022 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668682381; x=1700218381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pNGHdixQJ8kphWteopGCeA+0rgR0b/xkVnhBdzmmawA=;
  b=J9vZ00vo4O562sGrr9HkM+ApUT/RJYNA4qwTwf3PoIVCfpBknhJTc3OI
   AxhEnkkc0Yv5h7KQ80VgVwBPEgO2PfbNjAPj4JnBc02Lb5VwVipVYl1Fu
   z635yxzentFqyexrBYq4q5/ptKyN6mdKA0aKN+bCBO6POV4b4ri6FLAdW
   tddWBwSBhWes642mzi05usUABB9jvyy8G4izjqIYQOk6tbaaK+Nkg/dEj
   1KE5bhL8raydCqY5YXWAMaL8PHVwi/iuEIavDDlKGzqg56JaH7Zq9KbTy
   hUKoPAIPXZ5kpAEu5K1K0089fZizyNUoGTFUan194lUzvBHGAYgHhZO17
   g==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="183965612"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 03:53:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 03:52:59 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 03:52:56 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/8] spi: Introduce spi-cs-setup-ns property
Date:   Thu, 17 Nov 2022 12:52:43 +0200
Message-ID: <20221117105249.115649-3-tudor.ambarus@microchip.com>
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

SPI NOR flashes have specific cs-setup time requirements without which
they can't work at frequencies close to their maximum supported frequency,
as they miss the first bits of the instruction command. Unrecognized
commands are ignored, thus the flash will be unresponsive. Introduce the
spi-cs-setup-ns property to allow spi devices to specify their cs setup
time.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4ddd250481f5..b93a6085d9a0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2224,6 +2224,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
 	u32 value;
+	u16 cs_setup;
 	int rc;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2309,6 +2310,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
 
+	if (!of_property_read_u16(nc, "spi-cs-setup-ns", &cs_setup)) {
+		spi->cs_setup.value = cs_setup;
+		spi->cs_setup.unit = SPI_DELAY_UNIT_NSECS;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

