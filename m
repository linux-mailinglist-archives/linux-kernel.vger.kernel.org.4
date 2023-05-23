Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC870D2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 06:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjEWErj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 00:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEWEq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 00:46:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47F0018E;
        Mon, 22 May 2023 21:46:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E91139F;
        Mon, 22 May 2023 21:47:36 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 09F3A3F6C4;
        Mon, 22 May 2023 21:46:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH V4 6/6] coresight: etm4x: Add ACPI support in platform driver
Date:   Tue, 23 May 2023 10:15:53 +0530
Message-Id: <20230523044553.1525048-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523044553.1525048-1-anshuman.khandual@arm.com>
References: <20230523044553.1525048-1-anshuman.khandual@arm.com>
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

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Drop ETM4X ACPI ID from the AMBA ACPI device list, and instead just move it
inside the new ACPI devices list detected and used via platform driver.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for ACPI specific changes)
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/acpi/acpi_amba.c                           |  1 -
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index f5b443ab01c2..099966cbac5a 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -22,7 +22,6 @@
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
 	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
-	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
 	{"ARMHC501", 0}, /* ARM CoreSight ETR */
 	{"ARMHC502", 0}, /* ARM CoreSight STM */
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c9e2219ee6b6..5f2c0c52b026 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -2344,12 +2345,21 @@ static const struct of_device_id etm4_sysreg_match[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id etm4x_acpi_ids[] = {
+	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
+#endif
+
 static struct platform_driver etm4_platform_driver = {
 	.probe		= etm4_probe_platform_dev,
 	.remove		= etm4_remove_platform_dev,
 	.driver			= {
 		.name			= "coresight-etm4x",
 		.of_match_table		= etm4_sysreg_match,
+		.acpi_match_table	= ACPI_PTR(etm4x_acpi_ids),
 		.suppress_bind_attrs	= true,
 		.pm			= &etm4_dev_pm_ops,
 	},
-- 
2.25.1

