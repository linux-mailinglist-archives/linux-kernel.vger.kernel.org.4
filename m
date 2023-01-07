Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F46611DA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 22:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjAGVoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 16:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 16:44:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EC1321AC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673127847; x=1704663847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MwAPMW/T/jeDvYqPDbytyr8qYLB7Sr93oLXdTum30WU=;
  b=IPbi4Yun85uePqp7PpauBUbuZzoW28+hvVLpeFAsUWSYTUMGWLAqk7uZ
   fooR6gLgVLm8js4mzRFyWsWiJZYAthnitzeZqyV5hXEtEXnEHn0IVrH/R
   rdzXgFfWxUNO38qGLxosMk0hcxzkhHifJUJWs2qnocpIsQ+1hr0cpAbp1
   mHMcD9NeYm/x67nrKwhfSUg7lpuGe8Z6E2mgW4s4s2ygiX6ikMBPoS7aI
   f7c4RzVpHNmN3vf1EQcVMRL4vwb/xp8jTRWaKhMCxuvoTFnUa91W5rXBv
   AU14fB3QyKrobAQSwdYL6i62zei8/gzgNUYCIi0cf4SS4mFOPd3YjbRAv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="324686284"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="324686284"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 13:44:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="830228272"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="830228272"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 13:44:04 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v2] mtd: spi-nor: macronix: add support for mx77l51250f
Date:   Sat,  7 Jan 2023 23:43:45 +0200
Message-Id: <20230107214345.2524851-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.39.0
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

Add support for mx77l51250f spi-nor chips.

SPI NOR sysfs:

$ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
mx77l51250f
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
c2751a
$ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
macronix
$ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
53464450060103ff00060110300000ffc2000104100100ff030001020001
00ff84000102c00000ffffffffffffffffffe520f3ffffffff1f44eb086b
083b04bbeeffffffffff00ffffff00ff0c200f5210d800ff8341bd0082a7
04db4403373830b030b0f7a9d55c009e29fff050f985ffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff7f0ff0ff215cdcffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffff3c9b96f0c5a4c2ffffffffffffff
ffff003600279df9c064fecfffffffffffff

$ md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
36fb8e3e6f82c45bfabea45ec73c08a8
/sys/bus/spi/devices/spi0.0/spi-nor/sfdp

Note: The test_qspi.sh wasn not run as this device in intel setup is used
      for BIOS and platform firmware storage.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
V2:
1. This chip supports SFDP, parse it instead of the manual configuration.
2. Add required output of sysfs attributes 

 drivers/mtd/spi-nor/macronix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 6853ec9ae65d..6c3b4192a8ae 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -100,6 +100,8 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+	{ "mx77l51250f", INFO(0xc2751a, 0, 64 * 1024, 4096)
+		PARSE_SFDP },
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)
-- 
2.39.0

