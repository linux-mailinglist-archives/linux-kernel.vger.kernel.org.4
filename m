Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145CE605B04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJTJVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJTJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:21:15 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D8FF25E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666257674; x=1697793674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gUzH+1qdyWGYtFXjCxZ0XI1LQRnYPZ2F7W0BfgT0mUQ=;
  b=QHL0zXqBYBVAhGpdMIquWR+eMI6Ex29VWrdGatMIp7zYaqWt8BnNvjW3
   hYDdp/fQOMwHXXoYrvPm0IRR4ihD0oppM6Ef7urzhl4icR5oC2A34HXzX
   B2U92eLPlL/ehK+YDAbT50oRJsgyz5icJ3eSaBpB70FRc3T6iuQEyGMBu
   A=;
X-IronPort-AV: E=Sophos;i="5.95,198,1661817600"; 
   d="scan'208";a="1065876450"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:21:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-90d70b14.us-east-1.amazon.com (Postfix) with ESMTPS id AA9B9C4680;
        Thu, 20 Oct 2022 09:21:00 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 20 Oct 2022 09:21:00 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.15; Thu, 20 Oct 2022 09:20:59 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.42 via Frontend Transport; Thu, 20 Oct 2022 09:20:58
 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id BF3FC4B99; Thu, 20 Oct 2022 09:20:58 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <tudor.ambarus@microchip.com>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <jonnyc@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>, <farbere@amazon.com>, <itamark@amazon.com>,
        <shellykz@amazon.com>, <amitlavi@amazon.com>, <dkl@amazon.com>
Subject: [PATCH v3 1/1] mtd: spi-nor: micron-st: Enable locking for mt25qu256a
Date:   Thu, 20 Oct 2022 09:20:58 +0000
Message-ID: <20221020092058.33844-1-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt25qu256a [1] uses the 4 bit Block Protection scheme and supports
Top/Bottom protection via the BP and TB bits of the Status Register.
BP3 is located in bit 6 of the Status Register.
Tested on MT25QU256ABA8ESF-0SIT.

[1] https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf

Signed-off-by: Eliav Farber <farbere@amazon.com>
Link: https://lore.kernel.org/lkml/20221019071631.15191-1-farbere@amazon.com
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

v3 --> v2:
- Minimize change only to mt25qu256a which it was tested on.

v2 --> v1:
- Enable locking also for mt25qu256a.
- Dump the SFDP tables.

 drivers/mtd/spi-nor/micron-st.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 3c9681a3f7a3..53ff41534977 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -201,6 +201,8 @@ static const struct flash_info st_nor_parts[] = {
 		MFR_FLAGS(USE_FSR)
 	},
 	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
+		      SPI_NOR_BP3_SR_BIT6)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		MFR_FLAGS(USE_FSR)
-- 
2.37.1

