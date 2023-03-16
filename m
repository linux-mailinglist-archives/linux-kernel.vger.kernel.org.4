Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337996BD438
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCPPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjCPPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:43:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87D18AB2;
        Thu, 16 Mar 2023 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981348; x=1710517348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9uP8XzziLZWnGyVTKrD8dSdDK3kla4iL+cMxPqtvaiU=;
  b=k+B8VTDW1fL3sWF08tFUznfirASwhRromRkir057E5NuclMXLLNaBSP+
   YLdULtS0FJXGbe9+8iicWkh7422IWzp42FiB1GzSp51OzLQ8IR4+DabdK
   cGwA2wk8ieEq1085mEgNot6mHQOc9aDzsa0rqTozmlUb8Ps9wAOI9wx1u
   Ofm8YIXqZrZCBORjRCxYsHqAGobV0LmUEZRBzYoUI4amCZ+eaMkohfZwS
   Im2IEHfKnviV9vP4BvMpmRTSFNAcFuuD6A8Ww+sWHwP39bKPIux96xOUG
   LESaesNh9iEwHpa5gGXrwRaCRt8YmQz+E4zZtfpHa/BA3mNHC8ypoEaLI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571070"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571070"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267135"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267135"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:08 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 11/15] powercap/intel_rapl: Remove redundant cpu parameter
Date:   Thu, 16 Mar 2023 23:38:37 +0800
Message-Id: <20230316153841.3666-12-rui.zhang@intel.com>
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

For rapl_packages that rely on online CPUs to work, rp->lead_cpu always
has a valid CPU id.

Remove the redundant cpu parameter in rapl_check_domain(),
rapl_detect_domains() and .check_unit() callbacks.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 636e05aa711b..27ebc2c51803 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -169,7 +169,7 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 
 struct rapl_defaults {
 	u8 floor_freq_reg_addr;
-	int (*check_unit)(struct rapl_domain *rd, int cpu);
+	int (*check_unit)(struct rapl_domain *rd);
 	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
 	u64 (*compute_time_window)(struct rapl_domain *rd, u64 val,
 				    bool to_raw);
@@ -819,16 +819,16 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
  * power unit : microWatts  : Represented in milliWatts by default
  * time unit  : microseconds: Represented in seconds by default
  */
-static int rapl_check_unit_core(struct rapl_domain *rd, int cpu)
+static int rapl_check_unit_core(struct rapl_domain *rd)
 {
 	struct reg_action ra;
 	u32 value;
 
 	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(cpu, &ra)) {
+	if (rd->rp->priv->read_raw(rd->rp->lead_cpu, &ra)) {
 		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
-			ra.reg, cpu);
+			ra.reg, rd->rp->lead_cpu);
 		return -ENODEV;
 	}
 
@@ -847,16 +847,16 @@ static int rapl_check_unit_core(struct rapl_domain *rd, int cpu)
 	return 0;
 }
 
-static int rapl_check_unit_atom(struct rapl_domain *rd, int cpu)
+static int rapl_check_unit_atom(struct rapl_domain *rd)
 {
 	struct reg_action ra;
 	u32 value;
 
 	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(cpu, &ra)) {
+	if (rd->rp->priv->read_raw(rd->rp->lead_cpu, &ra)) {
 		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
-			ra.reg, cpu);
+			ra.reg, rd->rp->lead_cpu);
 		return -ENODEV;
 	}
 
@@ -1233,7 +1233,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	return ret;
 }
 
-static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
+static int rapl_check_domain(int domain, struct rapl_package *rp)
 {
 	struct reg_action ra;
 
@@ -1254,7 +1254,7 @@ static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 	 */
 
 	ra.mask = ENERGY_STATUS_MASK;
-	if (rp->priv->read_raw(cpu, &ra) || !ra.value)
+	if (rp->priv->read_raw(rp->lead_cpu, &ra) || !ra.value)
 		return -ENODEV;
 
 	return 0;
@@ -1283,7 +1283,7 @@ static int rapl_get_domain_unit(struct rapl_domain *rd)
 		return -ENODEV;
 	}
 
-	ret = rpd->check_unit(rd, rd->rp->lead_cpu);
+	ret = rpd->check_unit(rd);
 	if (ret)
 		return ret;
 
@@ -1324,14 +1324,14 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 /* Detect active and valid domains for the given CPU, caller must
  * ensure the CPU belongs to the targeted package and CPU hotlug is disabled.
  */
-static int rapl_detect_domains(struct rapl_package *rp, int cpu)
+static int rapl_detect_domains(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
 	int i;
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		/* use physical package id to read counters */
-		if (!rapl_check_domain(cpu, i, rp)) {
+		if (!rapl_check_domain(i, rp)) {
 			rp->domain_map |= 1 << i;
 			pr_info("Found RAPL domain %s\n", rapl_domain_names[i]);
 		}
@@ -1435,7 +1435,7 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 			 topology_physical_package_id(cpu));
 
 	/* check if the package contains valid domains */
-	if (rapl_detect_domains(rp, cpu)) {
+	if (rapl_detect_domains(rp)) {
 		ret = -ENODEV;
 		goto err_free_package;
 	}
-- 
2.25.1

