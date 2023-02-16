Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9277B699784
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBPOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBPOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:34:59 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC2822A2E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676558098; x=1708094098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aKKyce9a/yh1UTJ7iZWXMOgAYVhma3+YBZifpiHyfnA=;
  b=Rtj95y+D05bLjSPYBkskd0GL1ZB2I2gcKQodDwAUelNKmsfOJrywpsoV
   oqPO4s3ijW9FT7IhysLEm1lYRUURMM9S1y9BUEHRb8VCutQSHP1iFNPff
   cMgED1s3UMNLYRcpdrkWegPn+6KxXTsjS3980coR2VYKDPjX6FrjvMGmC
   SbzY43Soe1N3/ImkXMbHbX94kzJN54G3u8iRjLKTuhJ+vtqM0YyBBhPcZ
   3wDqxj9oMwmsd35QKfQxCNKdAfM3Eoo5/ESlIQMT8umUTAZLfznSUpLnt
   aq6KxrWtKtcZcGh0XNX++iNF6Vp4fSDpYXIEpvniDR6k6i2z32tNmWqqu
   w==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669071600"; 
   d="scan'208";a="29134872"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Feb 2023 15:34:56 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 16 Feb 2023 15:34:56 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 16 Feb 2023 15:34:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676558096; x=1708094096;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aKKyce9a/yh1UTJ7iZWXMOgAYVhma3+YBZifpiHyfnA=;
  b=Ah6d29FVUDv7jQvKX1pmouv6mB8BN2epmA5NDa5u3ZuMMw+Yvur97XRu
   cMfMs1k8gW2Thvi35qeQjTFx2hWIKGgYyuOeXRJ/BVjZDorLzNVlqfvt+
   TsMIPPY81EikTJUI5gqwwCc5f1Ce2qREmS3qyKT0iUfHECN2GUB11ubMO
   FK9WaCp4gJe7C2/HfR+E3KaNw+aGWTjAoH3Cg9r0CP3XZEDjvv4/STRQT
   HZ5Lpee0Xiy7Kf61n57W1wzil1CnLvlzLh3n6K/W8L58CjKG+aifmtZVO
   5CbGHTw7LpvnFrleip8nCzyko3goJ0ZGoRAFhU0yqXBEYnr+cHnRSB/1Y
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669071600"; 
   d="scan'208";a="29134871"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Feb 2023 15:34:56 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 46EBF280056;
        Thu, 16 Feb 2023 15:34:56 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/3] mfd: tqmx86: do not access I2C_DETECT register through io_base
Date:   Thu, 16 Feb 2023 15:34:22 +0100
Message-Id: <59041b6d888c886edef5a97fc6e3319d235e101a.1676557968.git.matthias.schiffer@ew.tq-group.com>
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
 drivers/mfd/tqmx86.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7ae906ff8e353..8dcbdafa88f4f 100644
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
@@ -213,7 +212,7 @@ static int tqmx86_probe(struct platform_device *pdev)
 		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
 		 board_name, board_id, rev >> 4, rev & 0xf);
 
-	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
+	i2c_det = inb(TQMX86_REG_I2C_DETECT);
 
 	if (gpio_irq_cfg) {
 		io_ext_int_val =
-- 
2.34.1

