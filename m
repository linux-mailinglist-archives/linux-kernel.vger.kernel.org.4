Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07196E7146
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjDSCpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjDSCpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:45:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C59C179;
        Tue, 18 Apr 2023 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872288; x=1713408288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+N1HHnwA7fgHa7xRs4xzN3tVy3gLeWxXc9jMKtgeA54=;
  b=D91tGMt6CxZEojPKawPQlCVH1eRWZKextdik4ezEWWelakcl2pKGrcCV
   6WmIWLDDh3I6shl+GDo/0wKsrtzsw2MVOGpQIj2uoDj7HLYImD+9whXo9
   71kpvLaxu4A0u6D/nH0PBdgfuuI9ToefFpMraTnB6mofMdCEnw94zh3+Y
   Ft0f1vX7wKgdRvoHBPfFXsaWarf7LEVb0im1VSXC2KxTA/rVsxmWSNVF5
   1G30/VS54unU0Tl+qa9E57hTQMUuhAr2P2CspaEk6DbZeJdQnA+CJjVaB
   RRk0Hjjgud1KusbdtAeP8gKQnswoYKhy7GN9+fpGjUn48MBh4VwJ0Q3W+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215307"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215307"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478033"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478033"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:46 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 08/15] powercap/intel_rapl: Use bitmap for Power Limits
Date:   Wed, 19 Apr 2023 10:44:12 +0800
Message-Id: <20230419024419.324436-9-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419024419.324436-1-rui.zhang@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 drivers/powercap/intel_rapl_common.c               | 14 ++++++--------
 drivers/powercap/intel_rapl_msr.c                  |  6 +++---
 .../intel/int340x_thermal/processor_thermal_rapl.c |  4 ++--
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 154f93b3dee5..8e77df42257a 100644
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
index a27673706c3d..6fe5e556aa51 100644
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
@@ -169,7 +169,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
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

