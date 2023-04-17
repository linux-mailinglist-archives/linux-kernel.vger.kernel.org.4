Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF2F6E4847
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDQMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:53:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66DB7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681736009; x=1713272009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3sG/FjAOmFFwFZ53HDQhlpYWLmIr5kYQL7tbWNDPmBg=;
  b=Dm6JP3YoIwMK8tsnlFFXdptB0akSHZ1EQ3AN7PpHdUKC8qqH1+cbVHc+
   6BLXuNlLkpFEig7KGhVhhShRxdC+T/W0j+W0QQF4054IXxpBDgPfLN9Fx
   QY6PZ59ps53KaCSfFsk2FGpt87jT03M8+YUKp7JLyiJeLSspuxY5fQDbH
   e0wyOuRrxueFIWLWxPAgl2BlU2gB3I3iuhJef4FzGyvZ2u30nKabTCkMZ
   LmT7gfSVNprpNSuKRhQ4M7Lt6ArpEklkhmFu7vKBbtXeBfPVOK6fo2uRR
   3F+RaG5MGUOal9i+tsHeYUOoRN57sZhBhEDJ1ZCUaPGwHkOiSpm/PPj/+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="342376757"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="342376757"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 05:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693228291"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="693228291"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2023 05:53:15 -0700
From:   niravkumar.l.rabara@intel.com
To:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        niravkumar.l.rabara@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: issi: add support for IS25WP01G
Date:   Mon, 17 Apr 2023 20:53:04 +0800
Message-Id: <20230417125304.1968382-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Tested on Intel N5X socdk board,
random data write, erase, read - verified erase operations
random data write, read and compare - verified write/read operations

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

---
root@n5x:~# cat /sys/devices/platform/soc/ff8d2000.spi/spi_master/
spi0/spi0.0/spi-nor/jedec_id
9d701b
root@n5x:~# cat /sys/devices/platform/soc/ff8d2000.spi/spi_master/
spi0/spi0.0/spi-nor/manufacturer
issi
root@n5x:~# cat /sys/devices/platform/soc/ff8d2000.spi/spi_master/
spi0/spi0.0/spi-nor/partname
is25wp01g
root@n5x:~# hexdump /sys/devices/platform/soc/ff8d2000.spi/spi_master
/spi0/spi0.0/spi-nor/sfdp
0000000 4653 5044 0106 ff01 0600 1001 0030 ff00
0000010 0084 0201 0080 ff00 ffff ffff ffff ffff
0000020 ffff ffff ffff ffff ffff ffff ffff ffff
0000030 20e5 fffb ffff 3fff eb44 6b08 3b08 bb80
0000040 fffe ffff ffff ff00 ffff eb44 200c 520f
0000050 d810 ff00 4262 00a9 6482 d302 8dec 4c69
0000060 757a 757a a4f7 5cd5 c24a ff2c 30e1 a9fa
0000070 ffff ffff ffff ffff ffff ffff ffff ffff
0000080 eeff ffff 5c21 ffdc
0000088
root@n5x:~# md5sum /sys/devices/platform/soc/ff8d2000.spi/spi_master/
spi0/spi0.0/spi-nor/sfdp
83440c0ff8676fe5292d207788693900  /sys/devices/platform/soc/ff8d2000.
spi/spi_master/spi0/spi0.0/spi-nor/sfdp
---
 drivers/mtd/spi-nor/issi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 400e2b42f45a..79132267cf0d 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -64,6 +64,8 @@ static const struct flash_info issi_nor_parts[] = {
 		PARSE_SFDP
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25wp01g",  INFO(0x9d701b, 0, 256 * 1024,  512)
+		PARSE_SFDP },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128)
-- 
2.25.1

