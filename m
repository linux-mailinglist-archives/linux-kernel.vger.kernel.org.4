Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F706BD432
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCPPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCPPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:42:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844952F7B;
        Thu, 16 Mar 2023 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981322; x=1710517322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nWvzlLMh+zSyTnKKNP31iQK+n8h1qa+NvmnSEY0mO7U=;
  b=HJR7ndPF2m9bJefpFem/Wb5KzAPxX1CUmex2VLK2DwMH8XWd8uKnLeou
   /1DBthy2HMJs6wDYTp/P+5YOpcC4gF/RRC7AGmp2jFaXgfyVMcvS+W0vp
   syfcYTwZL2KML1dN0Av/2j5WoXarzT+Mq+wifcXsw9CkUdKeSUaBRByxU
   rFDAzgQQbFQK0TP4cQpzCW0waehnYLsrfQIG5IxxErfD8hDX2syINvShX
   dOY7+c5ZsXLr4oS4gpR0WW8O7Jej98drPJO8I2zNKW6uVOYV6k4tif3qy
   XuuBS3VjhA0hBgBhl3J5eXjFk7ghKtVuRsdSxqyw+StmIloT4hXkvJv4Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571037"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571037"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267052"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267052"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:03 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 08/15] powercap/intel_rapl: Use bitmap for Power Limits
Date:   Thu, 16 Mar 2023 23:38:34 +0800
Message-Id: <20230316153841.3666-9-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316153841.3666-1-rui.zhang@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a RAPL package is registered with the number of Power Limits
supported in each RAPL domain. But this doesn't tell which Power Limits
are available. Using the number of Power Limits supported to guess the
availability of each Power Limit is fragile.

Use bitmap to represent the availability of each Power Limit.

Note that PL1 is mandatory thus it does not need to be set explicitly by
the RAPL Interface drivers.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c               | 14 ++++++--------
 drivers/powercap/intel_rapl_msr.c                  |  6 +++---
 .../intel/int340x_thermal/processor_thermal_rapl.c |  4 ++--
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3a8940d3bec8..0935a10b093e 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -574,20 +574,18 @@ static void rapl_init_domains(struct rapl_package *rp)
 				rapl_domain_names[i]);
 
 		rd->id = i;
+
+		/* PL1 is supported by default */
+		rp->priv->limits[i] |= BIT(POWER_LIMIT1);
 		rd->rpl[0].prim_id = PL1_ENABLE;
 		rd->rpl[0].name = pl1_name;
 
-		/*
-		 * The PL2 power domain is applicable for limits two
-		 * and limits three
-		 */
-		if (rp->priv->limits[i] >= 2) {
+		if (rp->priv->limits[i] & BIT(POWER_LIMIT2)) {
 			rd->rpl[1].prim_id = PL2_ENABLE;
 			rd->rpl[1].name = pl2_name;
 		}
 
-		/* Enable PL4 domain if the total power limits are three */
-		if (rp->priv->limits[i] == 3) {
+		if (rp->priv->limits[i] & BIT(POWER_LIMIT4)) {
 			rd->rpl[2].prim_id = PL4_ENABLE;
 			rd->rpl[2].name = pl4_name;
 		}
@@ -762,7 +760,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	cpu = rd->rp->lead_cpu;
 
 	/* domain with 2 limits has different bit */
-	if (prim == FW_LOCK && rd->rp->priv->limits[rd->id] == 2) {
+	if (prim == FW_LOCK && (rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2))) {
 		rpi->mask = POWER_HIGH_LOCK;
 		rpi->shift = 63;
 	}
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index bc6adda58883..e78460620340 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -45,8 +45,8 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
 		MSR_DRAM_POWER_LIMIT, MSR_DRAM_ENERGY_STATUS, MSR_DRAM_PERF_STATUS, 0, MSR_DRAM_POWER_INFO },
 	.regs[RAPL_DOMAIN_PLATFORM] = {
 		MSR_PLATFORM_POWER_LIMIT, MSR_PLATFORM_ENERGY_STATUS, 0, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = 2,
-	.limits[RAPL_DOMAIN_PLATFORM] = 2,
+	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
+	.limits[RAPL_DOMAIN_PLATFORM] = BIT(POWER_LIMIT2),
 };
 
 static struct rapl_if_priv rapl_msr_priv_amd = {
@@ -167,7 +167,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 
 	if (id) {
-		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] = 3;
+		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |= BIT(POWER_LIMIT4);
 		rapl_msr_priv->regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
 			MSR_VR_CURRENT_CONFIG;
 		pr_info("PL4 support detected.\n");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index a205221ec8df..e070239106f5 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -15,8 +15,8 @@ static const struct rapl_mmio_regs rapl_mmio_default = {
 	.reg_unit = 0x5938,
 	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
 	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = 2,
-	.limits[RAPL_DOMAIN_DRAM] = 2,
+	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
+	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
 static int rapl_mmio_cpu_online(unsigned int cpu)
-- 
2.25.1

