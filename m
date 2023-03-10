Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E155A6B3D73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCJLP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCJLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:15:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB3104AFC;
        Fri, 10 Mar 2023 03:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678446909; x=1709982909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5cipnkTtV2IAeEseLv2I7GLwybIA9bfYWqS/t41seXQ=;
  b=behbJHKmmAQurLmtTN/OOE32egKcyFn5RlClNgesxEwOZQEkn7dbqvjk
   kvFCrcVdv9pcUp/CN4QZFi1JJNHdnU1mQYgppB1c0bBreaCDR4dJ91HBp
   9TSKL2uCpKYr76nNu0ZnXLySWrtialM8Tn4aGNo6O61wqyQJXXrZ8KP7H
   sL9s/MWRbRLsLYee6/qc1I7WuGjzTvJrJNcAN18/LsyeH2QikhV1v6wP3
   A0Reb1Zd5Igp0gt3iTiJWQO9qz6tft23CV54LcxP03bFxCFe9i9U4CEaT
   PETWd73X4xAcAN5tQcNKTPYdkourA1tz6Y10545gqiLDv8Y3MIaO165/b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335402012"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="335402012"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="677775939"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="677775939"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2023 03:15:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C940314F; Fri, 10 Mar 2023 13:15:50 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] spi: mpc5xxx-psc: Remove goto to the unexisted label
Date:   Fri, 10 Mar 2023 13:15:44 +0200
Message-Id: <20230310111544.57342-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous cleanup patch had lost one of its parts in a crack,
Finish the cleanup by removing the leftovers.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9e21720a4958 ("spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-mpc512x-psc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 77a228f633d1..0b86f1804682 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -511,13 +511,9 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *pdev)
 
 	ret = mpc512x_psc_spi_port_config(master, mps);
 	if (ret < 0)
-		goto free_ipg_clock;
-
-	ret = devm_spi_register_master(dev, master);
-	if (ret < 0)
-		goto free_ipg_clock;
+		return ret;
 
-	return ret;
+	return devm_spi_register_master(dev, master);
 }
 
 static const struct of_device_id mpc512x_psc_spi_of_match[] = {
-- 
2.39.1

