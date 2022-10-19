Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02083603A72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJSHQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJSHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:16:45 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7CD63F01
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666163804; x=1697699804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=idRMXOV7LEiNt8pIiLFFF8p2b7BGPUnm0JzpG6j/u38=;
  b=WWOtKI3Z4TQbu3if8eOoc9tzxA/RtaHwPVu/NIHRsBKK1J1xY8DYETIX
   x1Q7JmD6Vap55eZnk3vlsJHEgO7oGB5/EFPFXwF9NR0foqWPzWZ9+ORve
   ev9wJ1oXweZCrMx9zYz/VQDHoO//y/tHkEwwAZds+jSPQqTH8lycZodTF
   k=;
X-IronPort-AV: E=Sophos;i="5.95,195,1661817600"; 
   d="scan'208";a="253551215"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-d803d33a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 07:16:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-d803d33a.us-west-2.amazon.com (Postfix) with ESMTPS id 9013A817ED;
        Wed, 19 Oct 2022 07:16:37 +0000 (UTC)
Received: from EX19D013UWA002.ant.amazon.com (10.13.138.210) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 19 Oct 2022 07:16:33 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWA002.ant.amazon.com (10.13.138.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.15;
 Wed, 19 Oct 2022 07:16:33 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.42 via Frontend Transport; Wed, 19 Oct 2022 07:16:32
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 5D9EB2634; Wed, 19 Oct 2022 07:16:31 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <tudor.ambarus@microchip.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <jonnyc@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>, <itamark@amazon.com>,
        <shellykz@amazon.com>, <amitlavi@amazon.com>, <dkl@amazon.com>
Subject: [PATCH v2 1/1] mtd: spi-nor: micron-st: Enable locking for n25q256ax1/mt25qu256a
Date:   Wed, 19 Oct 2022 07:16:31 +0000
Message-ID: <20221019071631.15191-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n25q256ax1 [1] and mt25qu256a [2] (both have same jedec_id - 0x20bb19)
use the 4 bit Block Protection scheme and support Top/Bottom protection
via the BP and TB bits of the Status Register.
BP3 is located in bit 6 of the Status Register.
Tested on both n25q256ax1 and mt25qu256a.

[1] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_256mb_3v.pdf
[2] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
xxd -p /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
53464450060101ff00060110300000ff84000102800000ffffffffffffff
ffffffffffffffffffffffffffffffffffffe520fbffffffff0f29eb276b
273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
03d4ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
ffffffffffffffffffe7ffff21dcffff                            

md5sum /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp 
5ea738216f68c9f98987bb3725699a32  /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/sfdp

cat /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/jedec_id
20bb19104400

cat /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/partname 
mt25qu256a

cat /sys/devices/platform/soc/fd882000.spi/spi_master/spi0/spi0.0/spi-nor/manufacturer 
st

v2 --> v1:
- Enable locking also for mt25qu256a.
- Dump the SFDP tables.

 drivers/mtd/spi-nor/micron-st.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 3c9681a3f7a3..f4d0153a5b1b 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -201,11 +201,15 @@ static const struct flash_info st_nor_parts[] = {
 		MFR_FLAGS(USE_FSR)
 	},
 	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+		      SPI_NOR_BP3_SR_BIT6)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		MFR_FLAGS(USE_FSR)
 	},
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+		      SPI_NOR_BP3_SR_BIT6)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ)
 		MFR_FLAGS(USE_FSR)
 	},
-- 
2.37.1

