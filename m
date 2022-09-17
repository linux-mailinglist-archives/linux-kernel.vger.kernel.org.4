Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8F5BB7F6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIQLRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 07:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIQLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 07:17:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189232DB0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 04:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663413422; x=1694949422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r5R83j4pOSZlr5q6a2Hps+vq4FBEXptw1GqH09jMVRM=;
  b=WcCqlrMtFUE9ty00gf+lQYQ96Gp8dP2G6HoD73jLn3vg3azTw12l2sNC
   Ulf+SQ6xiN8KwCrnnREenNs6AUjgE4CyUnMwNmSQJG4++uuRVGzspoS5R
   KqfvE4/V1TpPxpuGHrQN1jVE7RVntZeslWAsEgsJ9LAuhiU5/lkMhM7MT
   E3xKwr2XG9UG0dpWMmudC96bldHXm0ebgyhsDsK/B1dPgAR9GOv/6+A30
   8RsVUQgFXIgThw8lzTyYYDz72kblhdZGRLfs7gF59e//LPzEPMB45CR6w
   bCEVmJCH+QjMhRHHuN99o5YWIjJmn5yBqrygjnmYeCQEAMOut/VV8Be5S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="363107123"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="363107123"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 04:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="743609171"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga004.jf.intel.com with ESMTP; 17 Sep 2022 04:16:59 -0700
From:   niravkumar.l.rabara@intel.com
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: spi-nor: macronix: Add support for mx66u1g45g
Date:   Sat, 17 Sep 2022 19:16:40 +0800
Message-Id: <20220917111640.977243-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916082215.883184-1-niravkumar.l.rabara@intel.com>
References: <20220916082215.883184-1-niravkumar.l.rabara@intel.com>
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
root@n5x:~# ls -al /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/
drwxr-xr-x    2 root     root             0 Dec 16 17:26 .
drwxr-xr-x    6 root     root             0 Dec 16 17:25 ..
-r--r--r--    1 root     root          4096 Dec 16 17:26 jedec_id
-r--r--r--    1 root     root          4096 Dec 16 17:26 manufacturer
-r--r--r--    1 root     root          4096 Dec 16 17:26 partname
-r--r--r--    1 root     root             0 Dec 16 17:26 sfdp
root@n5x:~#  cat  /sys/devices/platform/soc/ff8d2000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
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
 drivers/mtd/spi-nor/macronix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..07ace9da74b7 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -97,6 +97,10 @@ static const struct flash_info macronix_nor_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
+	{ "mx66u1g45g",  INFO(0xc2253b, 0, 64 * 1024, 2048)
+		PARSE_SFDP
+		FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
-- 
2.25.1

