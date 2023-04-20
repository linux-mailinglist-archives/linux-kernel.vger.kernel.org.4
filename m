Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E76E89AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjDTFoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTFoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:44:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795053A87;
        Wed, 19 Apr 2023 22:44:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33K5hYZf080236;
        Thu, 20 Apr 2023 00:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681969414;
        bh=6ajKYqWHNECSE5BjMGUN6lrTrtrHPa2R5TCfI4K0qPU=;
        h=From:To:CC:Subject:Date;
        b=oNRngS72p8IQecGlyKWkX8xFXfp8vcSJ1TwqfBpTNkT2TNB5/ybLu4sx4uaAlFrQT
         PwrblHa32uTD/5M+aU1x0vfbqGUMeKlVm7GtQmSLbhY48L95SG2buSbSngYLj54ZbC
         htxtewAIBPGXcAQuX8nocZ5C3/b0gPZfRQeERhbo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33K5hY9b011203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Apr 2023 00:43:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 20
 Apr 2023 00:43:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 20 Apr 2023 00:43:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33K5hWhL013841;
        Thu, 20 Apr 2023 00:43:33 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh <vigneshr@ti.com>, Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V3] spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS
Date:   Thu, 20 Apr 2023 11:12:57 +0530
Message-ID: <20230420054257.925092-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this macro makes the code more readable.
It also inits the members of dev_pm_ops in the following manner
without us explicitly needing to:

.suspend = cqspi_suspend, \
.resume = cqspi_resume, \
.freeze = cqspi_suspend, \
.thaw = cqspi_resume, \
.poweroff = cqspi_suspend, \
.restore = cqspi_resume

Also get rid of conditional compilation based on CONFIG_PM_SLEEP because
it introduces build issues with certain configs when CQSPI_DEV_PM_OPS is
just NULL.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304191900.2fARFQW9-lkp@intel.com/
Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Previously sent here:
https://lore.kernel.org/all/20230419084817.481136-1-d-gole@ti.com/

Base: next-20230419

Changelog:
* Fix build errors reported by kernel test bot.

 drivers/spi/spi-cadence-quadspi.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 53829eb5eca0..6ddb2dfc0f00 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1820,7 +1820,6 @@ static void cqspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
@@ -1850,15 +1849,7 @@ static int cqspi_resume(struct device *dev)
 	return spi_master_resume(master);
 }
 
-static const struct dev_pm_ops cqspi__dev_pm_ops = {
-	.suspend = cqspi_suspend,
-	.resume = cqspi_resume,
-};
-
-#define CQSPI_DEV_PM_OPS	(&cqspi__dev_pm_ops)
-#else
-#define CQSPI_DEV_PM_OPS	NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend, cqspi_resume);
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
@@ -1933,7 +1924,7 @@ static struct platform_driver cqspi_platform_driver = {
 	.remove_new = cqspi_remove,
 	.driver = {
 		.name = CQSPI_NAME,
-		.pm = CQSPI_DEV_PM_OPS,
+		.pm = &cqspi_dev_pm_ops,
 		.of_match_table = cqspi_dt_ids,
 	},
 };
-- 
2.25.1

