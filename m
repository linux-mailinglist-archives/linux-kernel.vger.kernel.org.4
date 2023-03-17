Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2096BE8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCQL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCQL5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:57:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D514B856D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:57:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F38751480;
        Fri, 17 Mar 2023 04:58:18 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D4BE3F885;
        Fri, 17 Mar 2023 04:57:34 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     coresight@lists.linaro.org
Cc:     mike.leach@linaro.org, james.clark@arm.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>
Subject: [PATCH] coresight: etm4x: Do not access TRCIDR1 for identification
Date:   Fri, 17 Mar 2023 11:57:28 +0000
Message-Id: <20230317115728.1358368-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETM4x architecture clearly provides ways to identify a device
via registers in the "Management" class, TRCDEVARCH and TRCDEVTYPE. These
registers can be accessed without the Trace domain being powered on.
We additionally added TRCIDR1 as fallback in order to cover for any
ETMs that may not have implemented TRCDEVARCH. So far, nobody has
reported hitting a WARNING we placed to catch such systems.

Also, more importantly it is problematic to access TRCIDR1, which is a "Trace"
register via MMIO access, without clearing the OSLK. But we cannot
mess with the OSLK until we know for sure that this is an ETMv4 device.
Thus, this kind of creates a chicken and egg problem unnecessarily for systems
"which are compliant" to the ETMv4 architecture.

Let us remove the TRCIDR1 fall back check and rely only on TRCDEVARCH.

Reported-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Link: https://lore.kernel.org/all/143540e5623d4c7393d24833f2b80600d8d745d2.1677881753.git.scclevenger@os.amperecomputing.com/
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Fixes: 8b94db1edaee ("coresight: etm4x: Use TRCDEVARCH for component discovery")
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-etm4x-core.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 104333c2c8a3..c1b72d892d7d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1070,25 +1070,17 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
 	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
-	u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
 
 	/*
 	 * All ETMs must implement TRCDEVARCH to indicate that
-	 * the component is an ETMv4. To support any broken
-	 * implementations we fall back to TRCIDR1 check, which
-	 * is not really reliable.
+	 * the component is an ETMv4
 	 */
-	if ((devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH) {
-		drvdata->arch = etm_devarch_to_arch(devarch);
-	} else {
-		pr_warn("CPU%d: ETM4x incompatible TRCDEVARCH: %x, falling back to TRCIDR1\n",
-			smp_processor_id(), devarch);
-
-		if (ETM_TRCIDR1_ARCH_MAJOR(idr1) != ETM_TRCIDR1_ARCH_ETMv4)
-			return false;
-		drvdata->arch = etm_trcidr_to_arch(idr1);
+	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH) {
+		pr_warn_once("TRCDEVARCH doesn't match ETMv4 architecture\n");
+		return false;
 	}
 
+	drvdata->arch = etm_devarch_to_arch(devarch);
 	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
 	return true;
 }
-- 
2.34.1

