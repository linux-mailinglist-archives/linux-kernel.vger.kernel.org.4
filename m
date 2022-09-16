Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C873F5BA818
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiIPIWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIPIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:22:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1140EA4B0A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663316549; x=1694852549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/i/1Al2xe3YtNErK1BStvXExvCKvkVYhTtFeQyc+g8=;
  b=Ho1/7cxDY12ZrMbGS/zbtXlklfT3IKjFJPBFrDz4ieWYDQopL9sGcmEl
   S/Vc3eqbXgI53DhWpikw7BEAQ71cuRSy7l9074LT+JH5W9Yy+5yKhx1mM
   BbnFH1XZW9uA99kp63pudEz4cLV92GGd+P61kTcAYIWQDZ6Y0rcwhhQOh
   Ir2VV7XqskBF66bSEm+N2KgLUWhO/gShWz8XfB33qfQpyP6QlcJLoSDLt
   KbdqT2zsoOuQPIrC4jWzt+x9noluhczHcHw1yn+ROEr3I1upGb+/Bpwnx
   5JBsbqHb4mDix/oB+I5BdlnV0VKtBBHXlheFzH2befVvXQuPg3gaHnyk/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="279324031"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="279324031"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 01:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="617592748"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2022 01:22:26 -0700
From:   niravkumar.l.rabara@intel.com
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        niravkumar.l.rabara@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: macronix: Add support for mx66u1g45g
Date:   Fri, 16 Sep 2022 16:22:15 +0800
Message-Id: <20220916082215.883184-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

The MX66U1G45G is the smaller sibling (128MB) of the MX66U2G45G (256MB)
that is already supported.

Tested on Intel N5X socdk board,
- random data write, erase, read   - verified erase operations
- random data write, read and compare  - verified write/read operations

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
root@n5x:~# find / -iname spi-nor
/sys/kernel/debug/spi-nor
/sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor
/sys/bus/spi/drivers/spi-nor
root@n5x:~# ls -al /sys/devices/platform/soc/
driver/                      ffd00200.watchdog/
driver_override              ffd10000.clock-controller/
f8011100.sdr/                ffd11000.rstmgr/
f87f8000.memory-controller/  ffd12000.sysmgr/
ff800000.ethernet/           ffda0000.dma-controller/
ff808000.mmc/                ffe00000.sram/
ff8d2000.spi/                modalias
ffb00000.usb/                of_node/
ffc02000.serial/             power/
ffc03000.timer0/             soc:base_fpga_region/
ffc03100.timer1/             soc:eccmgr/
ffd00000.timer2/             subsystem/
ffd00100.timer3/             uevent
root@n5x:~# ls -al /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/
drwxr-xr-x    2 root     root             0 Dec 16 17:27 .
drwxr-xr-x    6 root     root             0 Dec 16 17:25 ..
-r--r--r--    1 root     root          4096 Dec 16 17:27 jedec_id
-r--r--r--    1 root     root          4096 Dec 16 17:27 manufacturer
-r--r--r--    1 root     root          4096 Dec 16 17:27 partname
-r--r--r--    1 root     root             0 Dec 16 17:27 sfdp
root@n5x:~# cat  /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
c2253b
root@n5x:~# cat  /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer
macronix
root@n5x:~# cat  /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/partname
mx66u1g45g
root@n5x:~# cat  /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp > mx66u1g45g-sfdp
root@n5x:~# hexdump mx66u1g45g-sfdp
0000000 4653 5044 0106 ff02 0600 1001 0030 ff00
0000010 00c2 0401 0110 ff00 0084 0201 00c0 ff00
0000020 ffff ffff ffff ffff ffff ffff ffff ffff
0000030 20e5 fffb ffff 3fff eb44 6b08 3b08 bb04
0000040 fffe ffff ffff ff00 ffff eb44 200c 520f
0000050 d810 ff00 4987 00b5 d282 e204 0344 3867
0000060 b030 b030 bdf7 5cd5 9e4a ff29 50f0 85f9
0000070 ffff ffff ffff ffff ffff ffff ffff ffff
*
00000c0 8f7f ffff 5c21 ffdc ffff ffff ffff ffff
00000d0 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000110 2000 1600 f99d 64c0 cb85 ffff ffff ffff
0000120
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..723efe4ca57e 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -97,6 +97,9 @@ static const struct flash_info macronix_nor_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
+	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-- 
2.25.1

