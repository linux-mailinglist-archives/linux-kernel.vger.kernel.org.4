Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD60B722D34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjFERCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjFERBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:01:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3411F1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:01:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30B8152B;
        Mon,  5 Jun 2023 10:02:33 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 714D13F587;
        Mon,  5 Jun 2023 10:01:47 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] perf/arm_cspmu: Clean up ACPI dependency
Date:   Mon,  5 Jun 2023 18:01:33 +0100
Message-Id: <9d126711c7498b199b3e6f5cf48ca60ffb9df54c.1685983270.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1685983270.git.robin.murphy@arm.com>
References: <cover.1685983270.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build-wise, the ACPI dependency consists of only a couple of things
which could probably stand being factored out into ACPI helpers anyway.
However for the immediate concern of working towards Devicetree support
here, it's easy enough to make a few tweaks to contain the affected code
locally, such that we can relax the Kconfig dependency.

Reviewed-and-Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/Kconfig     |  3 +--
 drivers/perf/arm_cspmu/arm_cspmu.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 0b316fe69a45..25d25ded0983 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -4,8 +4,7 @@
 
 config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	tristate "ARM Coresight Architecture PMU"
-	depends on ARM64 && ACPI
-	depends on ACPI_APMT || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
 	help
 	  Provides support for performance monitoring unit (PMU) devices
 	  based on ARM CoreSight PMU architecture. Note that this PMU
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 72dc7a9e1ca8..3b91115c376d 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -28,7 +28,6 @@
 #include <linux/module.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
-#include <acpi/processor.h>
 
 #include "arm_cspmu.h"
 #include "nvidia_cspmu.h"
@@ -1075,6 +1074,9 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_ARM64)
+#include <acpi/processor.h>
+
 static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 {
 	u32 acpi_uid;
@@ -1099,7 +1101,7 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 	return -ENODEV;
 }
 
-static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
+static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 {
 	struct device *dev;
 	struct acpi_apmt_node *apmt_node;
@@ -1135,6 +1137,17 @@ static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
 
 	return 0;
 }
+#else
+static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
+{
+	return -ENODEV;
+}
+#endif
+
+static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
+{
+	return arm_cspmu_acpi_get_cpus(cspmu);
+}
 
 static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 {
-- 
2.39.2.101.g768bb238c484.dirty

