Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50974D8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGJOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjGJOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:24:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125BB100
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688999028; x=1720535028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J9EwRbTUurltBJIoTWX0QYaR1P1M9Bb+T1CRNX2NRbE=;
  b=BCBCfFBXucqL/WXL27yW/p8MouDyUOR4n0fpdMpFrx0AUc/nPBAwgl5o
   OG036zh0RtNTlx0OT8Jx8cWzk3VFBFx7R7dkH/7an8zjkxALaxkb7F6R6
   zj3aDy36B4pJg2F7xjbImnmFMEZbVosV6jsfWvZvGstjxHkCO3DsCNqHj
   idFvB8cBrYmIeeSbVJAuLGOJT+VXjFw9aYkJofzxjnyAkvLLDsr2W5z4x
   CHxo5nUAGNypOiZwCdtBQ7tfsESYOIVlWHVzbV5zNVTSbJvj1sU0SiK2Y
   2RQB2inZwpJFICmQGQqU+8PBRpmhI8XO0IvkAvhz3rbfr+cj9J5Kr/LlN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349158444"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349158444"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720712734"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720712734"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 07:23:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B16CC1FC; Mon, 10 Jul 2023 17:23:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] regmap: spi: Use spi_message_init_with_transfers()
Date:   Mon, 10 Jul 2023 17:23:35 +0300
Message-Id: <20230710142335.66598-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use spi_message_init_with_transfers() instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 37ab23a9d034..65e8adac8d0e 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -43,9 +43,7 @@ static int regmap_spi_gather_write(void *context,
 	struct spi_transfer t[2] = { { .tx_buf = reg, .len = reg_len, },
 				     { .tx_buf = val, .len = val_len, }, };
 
-	spi_message_init(&m);
-	spi_message_add_tail(&t[0], &m);
-	spi_message_add_tail(&t[1], &m);
+	spi_message_init_with_transfers(&m, t, 2);
 
 	return spi_sync(spi, &m);
 }
@@ -66,10 +64,7 @@ static int regmap_spi_async_write(void *context,
 	async->t[1].tx_buf = val;
 	async->t[1].len = val_len;
 
-	spi_message_init(&async->m);
-	spi_message_add_tail(&async->t[0], &async->m);
-	if (val)
-		spi_message_add_tail(&async->t[1], &async->m);
+	spi_message_init_with_transfers(&async->m, async->t, val ? 2 : 1);
 
 	async->m.complete = regmap_spi_complete;
 	async->m.context = async;
-- 
2.40.0.1.gaa8946217a0b

