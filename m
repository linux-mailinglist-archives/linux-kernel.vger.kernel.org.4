Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E27C6E75A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjDSItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjDSItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:49:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3356A67;
        Wed, 19 Apr 2023 01:48:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J8mQJf027445;
        Wed, 19 Apr 2023 03:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681894106;
        bh=XbEtFK+H4/7qsl0ppFWnJWa8nE2+A+lGhJsRSLRMsZI=;
        h=From:To:CC:Subject:Date;
        b=X05IcQo6rJxC5jzIkoyxF7Wn06nh6hBy4LmgeHEcSJirXvHEpHNT4lt5eYBYaYRT1
         D8o2fH8ZeTO1s/P9C3EvcIK2Km4M2GQaJfNJ8Hlv9KNb2duHNQzeERYrktso6cJ/fX
         wYxUmTaW88w1YDhmDWpVcbDOfIjw7PqKZIH7oOWY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J8mQDl005205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 03:48:26 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 03:48:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 03:48:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J8mOuo068330;
        Wed, 19 Apr 2023 03:48:25 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh <vigneshr@ti.com>, Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS
Date:   Wed, 19 Apr 2023 14:18:17 +0530
Message-ID: <20230419084817.481136-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Address comments from previously posted patch:
https://patchwork.kernel.org/project/spi-devel-general/patch/20230417091027.966146-2-d-gole@ti.com/

 drivers/spi/spi-cadence-quadspi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 79ab7e309644..922026bb9380 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1829,12 +1829,7 @@ static int cqspi_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops cqspi__dev_pm_ops = {
-	.suspend = cqspi_suspend,
-	.resume = cqspi_resume,
-};
-
-#define CQSPI_DEV_PM_OPS	(&cqspi__dev_pm_ops)
+static DEFINE_SIMPLE_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend, cqspi_resume);
 #else
 #define CQSPI_DEV_PM_OPS	NULL
 #endif
@@ -1912,7 +1907,7 @@ static struct platform_driver cqspi_platform_driver = {
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

