Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FFE67405F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjASR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjASR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:57:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEF77EE7D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674151037; x=1705687037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=edJ4pPulO/hiZmIEBnwaOh+9iVoSxF8F7xkVf7rEopU=;
  b=Vz0Ds95JmZ9qAI+FsaOTLIYl7SR4T48QeuenC2LBHp9CBpWkB41x2oOp
   lypNifpBFSOzZ3QuiCR7VMhSYhd1EcIPA30wB6rrFKndWDsPlYjbuNBw/
   ycRtugCEIiOp1eP7DpKxNKp3ymXg+5g6Bh3npijeVEth9BRnB3eArVpHD
   ST19ieh1IuZWSLJRaP7NRWQPRrX4DkPnXkB3Pcr3WDlucar2Lt6mGpOqg
   pC2cPzUqrLWw1WRRRmnuzoS/6fSVmj6RU1CEEW2eP4AdXmvbdrejkIxw/
   VCxcPhV/+aCK+Wqlmxa2Dlb1cxRTf4sbPQJZzqanN/DtPPwE2K04qWA9/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324051462"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="324051462"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802723188"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="802723188"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 09:57:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A53AE36D; Thu, 19 Jan 2023 19:57:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] eeprom: at25: Convert to use fwnode_device_is_compatible()
Date:   Thu, 19 Jan 2023 19:57:42 +0200
Message-Id: <20230119175742.77723-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded fwnode_device_is_compatible() in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/at25.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index bdffc6543f6f..65d49a6de1a7 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -437,12 +437,6 @@ static int at25_probe(struct spi_device *spi)
 	struct spi_eeprom *pdata;
 	bool is_fram;
 
-	err = device_property_match_string(&spi->dev, "compatible", "cypress,fm25");
-	if (err >= 0)
-		is_fram = true;
-	else
-		is_fram = false;
-
 	/*
 	 * Ping the chip ... the status register is pretty portable,
 	 * unlike probing manufacturer IDs. We do expect that system
@@ -462,6 +456,8 @@ static int at25_probe(struct spi_device *spi)
 	at25->spi = spi;
 	spi_set_drvdata(spi, at25);
 
+	is_fram = fwnode_device_is_compatible(dev_fwnode(&spi->dev), "cypress,fm25");
+
 	/* Chip description */
 	pdata = dev_get_platdata(&spi->dev);
 	if (pdata) {
-- 
2.39.0

