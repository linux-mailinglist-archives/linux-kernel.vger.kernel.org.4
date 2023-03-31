Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026E86D1DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCaKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCaKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:08:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC64696
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680256992; x=1711792992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wlywgRdYFCMfwefUgirPB5xmOD3K8zqnz1V+H3PCcUM=;
  b=0JI8mZGJtUmLL8sa3NqCdLmAewc1sh+hCdDHRnRKFlNhht2Ew+88c7Ia
   fCmTCe72N+R6//Gu+mgH7yYOfE6R/306vIbvdVr1Mg7l67Rzfee3zVnXB
   Wd3kgtLYcPEmnf/+P6583XI4BllvU9eJSqNBKm0IxQoIJkHfU49cUsOmv
   md81w4+YlFyW9xB4AQ0Hd7UNQsz67ph7IYzsg6b2o1mDxnCcj+RKJHmdJ
   oQm6HXeeShyZLO+3aTO1Rn5SpU+x330jZdj1E1YyXjQtwLVWQX/CCdXFZ
   bDksK5aEwpKigQGdzwOwuPvI174HBQkJmjFP2lqrO6VvUTV6tgWB87a9c
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="scan'208";a="204368686"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 02:56:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 02:56:08 -0700
Received: from ROU-LT-M43238L.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 02:56:06 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tudor.ambarus@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-mtd@lists.infradead.org>,
        "Guillaume Socquet" <guillaume.socquet@microchip.com>
Subject: [PATCH] mtd: spi-nor: sst: Unlock addition for sst26vf016
Date:   Fri, 31 Mar 2023 11:55:49 +0200
Message-ID: <20230331095549.16393-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Socquet <guillaume.socquet@microchip.com>

Modify sst26vf016 flash_info struct so when such device is detected by
the driver it may be unlocked for write operation as sst26vf064.

Signed-off-by: Guillaume Socquet <guillaume.socquet@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/mtd/spi-nor/sst.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 63bcc97bf978..99c8a19493f5 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -110,7 +110,9 @@ static const struct flash_info sst_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
 	{ "sst26vf016b", INFO(0xbf2641, 0, 64 * 1024, 32)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ) },
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ)
+		.fixups = &sst26vf_nor_fixups },
 	{ "sst26vf064b", INFO(0xbf2643, 0, 64 * 1024, 128)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-- 
2.34.1

