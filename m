Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69469C9CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjBTL02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBTL00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:26:26 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245558A6B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676892383; x=1708428383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7LmUwU+SS2w5GKPk+OLCBAiJ2JdcxGmTNn38enXxhA=;
  b=ORKUvrwaLveNaKSoZOOmdfJLL+s59sz/rrj48w0hPXdEGB+p5ZUwYz9M
   Lnd1+INz6aljLeOtbRDY3+jVeAojwgslvxIyvHJ58o/t+uyUKaAK82ys9
   eXwbkmjU8llqBtTu6ziIq2cgfFdtOIoyhwcWY+FgWQMySnpfraeaEKVzA
   fDWrO7yDP30jONvoI2Tsql3TPu4T/Yz2fpknUSY1e/KYlR7uYtqvPli5K
   OuDBtOwE3yNbw1tS1tqIVwslIeQLx78oksk202d3wsvMgOCBdoKMvgdzt
   VdStxxAXZXqXcJjhgdw88xD34xO3CxRNe7mNS6zVmmEtctUExB4H3pX6l
   w==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669071600"; 
   d="scan'208";a="29187432"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Feb 2023 12:26:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 20 Feb 2023 12:26:21 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 20 Feb 2023 12:26:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676892381; x=1708428381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7LmUwU+SS2w5GKPk+OLCBAiJ2JdcxGmTNn38enXxhA=;
  b=ClklIeCSKuQbo+bBYc7lqRBKlR8Qz20thTpSXbqOpcC9FLdQqYcPxEwn
   9c8sup22lNt3naSWW/+8Uk6poRBDnvIOaIod28TNQCg7SI7GD3mlP2nYz
   oGdW1FArZhsAvCmFbv0lL/oIRujonYbZyRi/STAgnOvuaZ+eCfS4QyIIW
   iORYd78clYA6sgvgrhFMT6SLvwOxPoD1QIjXNQJcATrwf/aB9MC7wwp7h
   KMgJM6LeeLc5qxoK53kQ3pAcVGeIgCx8/58/1jstLkBNjZbF02tRa9fwJ
   w+YCafk1+lHBk2OC88AUYyNu9jsSDxqeJC3DTqj2L/JtcWbpnM08CgLeh
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669071600"; 
   d="scan'208";a="29187424"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Feb 2023 12:26:20 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id EF709280056;
        Mon, 20 Feb 2023 12:26:14 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/3] mfd: tqmx86: do not access I2C_DETECT register through io_base
Date:   Mon, 20 Feb 2023 12:25:44 +0100
Message-Id: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C_DETECT register is at IO port 0x1a7, which is outside the range
passed to devm_ioport_map() for io_base, and was only working because
there aren't actually any bounds checks for IO port accesses.

Extending the range does not seem like a good solution here, as it would
then conflict with the IO resource assigned to the I2C controller. As
this is just a one-off access during probe, use a simple inb() instead.

While we're at it, drop the unused define TQMX86_REG_I2C_INT_EN.

Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

Notes:
    v2: add comment regarding use of inb() as suggested by Andrew

 drivers/mfd/tqmx86.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7ae906ff8e353..31d0efb5aacf8 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -49,9 +49,8 @@
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 
-#define TQMX86_REG_I2C_DETECT	0x47
+#define TQMX86_REG_I2C_DETECT	0x1a7
 #define TQMX86_REG_I2C_DETECT_SOFT		0xa5
-#define TQMX86_REG_I2C_INT_EN	0x49
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
@@ -213,7 +212,12 @@ static int tqmx86_probe(struct platform_device *pdev)
 		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
 		 board_name, board_id, rev >> 4, rev & 0xf);
 
-	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
+	/*
+	 * The I2C_DETECT register is in the range assigned to the I2C driver
+	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
+	 * access instead of ioport_map + unmap.
+	 */
+	i2c_det = inb(TQMX86_REG_I2C_DETECT);
 
 	if (gpio_irq_cfg) {
 		io_ext_int_val =
-- 
2.34.1

