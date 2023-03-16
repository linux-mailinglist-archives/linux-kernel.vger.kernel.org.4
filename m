Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013756BD41D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjCPPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjCPPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:41:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CF518A9D;
        Thu, 16 Mar 2023 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981241; x=1710517241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bttphz0hLk8xseU0ShQu0CWX6uXhwd0kE3XsA+KsKDs=;
  b=TTsy3ojqn6TuNXAQFDxlto4Knw4Z/dOApTgQcIf3RO/V/dUky7EG/S92
   C3zFzmji1dkYbe6W5lw501iK6SGMycXTddDCRrU9jrA7r2ORV2NkV/y3Q
   4ECRB2W0fpfsz0f6jVmqRG5Yi/hJXKfvHaGutywiyxuXT3xXcAylqWRXj
   olqsY7D9+fVd5mrS2NG6FlWZjw1UmxCgWnC85iHjFo1VxNUTZSc+u1drb
   NA3mt5DiM6kK6Vxsft5hLZlP9125mMDDjvdVdrb2N3cKYh2D8iyQf/S12
   MhwMvxSibkE8UJEkvzEzkw5a0V7Q/f6JWPpoYnO3KPcrAaxetxUcLUHHY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339570961"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339570961"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009266983"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009266983"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:53 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 03/15] powercap/intel_rapl: Support per Interface rapl_defaults
Date:   Thu, 16 Mar 2023 23:38:29 +0800
Message-Id: <20230316153841.3666-4-rui.zhang@intel.com>
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

rapl_defaults is Interface specific.

Although current MSR and MMIO Interface share the same rapl_defaults,
new Interface like TPMI need its own rapl_defaults callbacks.

Save the rapl_defaults information in the Interface private structure.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 46 ++++++++++++++++++++--------
 include/linux/intel_rapl.h           |  2 ++
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2d2c15eea8eb..56e8af2a1e6f 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -115,6 +115,11 @@ struct rapl_defaults {
 };
 static struct rapl_defaults *rapl_defaults;
 
+static struct rapl_defaults *get_rpd(struct rapl_package *rp)
+{
+	return rp->priv->rpd;
+}
+
 /* Sideband MBI registers */
 #define IOSF_CPU_POWER_BUDGET_CTL_BYT (0x2)
 #define IOSF_CPU_POWER_BUDGET_CTL_TNG (0xdf)
@@ -227,14 +232,15 @@ static int find_nr_power_limit(struct rapl_domain *rd)
 static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
+	struct rapl_defaults *rpd = get_rpd(rd->rp);
 
 	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
 		return -EACCES;
 
 	cpus_read_lock();
 	rapl_write_data_raw(rd, PL1_ENABLE, mode);
-	if (rapl_defaults->set_floor_freq)
-		rapl_defaults->set_floor_freq(rd, mode);
+	if (rpd->set_floor_freq)
+		rpd->set_floor_freq(rd, mode);
 	cpus_read_unlock();
 
 	return 0;
@@ -551,6 +557,7 @@ static void rapl_init_domains(struct rapl_package *rp)
 	enum rapl_domain_type i;
 	enum rapl_domain_reg_id j;
 	struct rapl_domain *rd = rp->domains;
+	struct rapl_defaults *rpd = get_rpd(rp);
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		unsigned int mask = rp->domain_map & (1 << i);
@@ -592,14 +599,14 @@ static void rapl_init_domains(struct rapl_package *rp)
 		switch (i) {
 		case RAPL_DOMAIN_DRAM:
 			rd->domain_energy_unit =
-			    rapl_defaults->dram_domain_energy_unit;
+			    rpd->dram_domain_energy_unit;
 			if (rd->domain_energy_unit)
 				pr_info("DRAM domain energy unit %dpj\n",
 					rd->domain_energy_unit);
 			break;
 		case RAPL_DOMAIN_PLATFORM:
 			rd->domain_energy_unit =
-			    rapl_defaults->psys_domain_energy_unit;
+			    rpd->psys_domain_energy_unit;
 			if (rd->domain_energy_unit)
 				pr_info("Platform domain energy unit %dpj\n",
 					rd->domain_energy_unit);
@@ -616,6 +623,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 {
 	u64 units = 1;
 	struct rapl_package *rp = rd->rp;
+	struct rapl_defaults *rpd = get_rpd(rp);
 	u64 scale = 1;
 
 	switch (type) {
@@ -631,7 +639,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 			units = rp->energy_unit;
 		break;
 	case TIME_UNIT:
-		return rapl_defaults->compute_time_window(rp, value, to_raw);
+		return rpd->compute_time_window(rp, value, to_raw);
 	case ARBITRARY_UNIT:
 	default:
 		return value;
@@ -702,10 +710,18 @@ static struct rapl_primitive_info rpi[] = {
 	{NULL, 0, 0, 0},
 };
 
+static int rapl_config(struct rapl_package *rp)
+{
+	rp->priv->rpd = (void *)rapl_defaults;
+	return 0;
+}
+
 static enum rapl_primitives
 prim_fixups(struct rapl_domain *rd, enum rapl_primitives prim)
 {
-	if (!rapl_defaults->spr_psys_bits)
+	struct rapl_defaults *rpd = get_rpd(rd->rp);
+
+	if (!rpd->spr_psys_bits)
 		return prim;
 
 	if (rd->id != RAPL_DOMAIN_PLATFORM)
@@ -960,16 +976,17 @@ static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
 static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 {
 	static u32 power_ctrl_orig_val;
+	struct rapl_defaults *rpd = get_rpd(rd->rp);
 	u32 mdata;
 
-	if (!rapl_defaults->floor_freq_reg_addr) {
+	if (!rpd->floor_freq_reg_addr) {
 		pr_err("Invalid floor frequency config register\n");
 		return;
 	}
 
 	if (!power_ctrl_orig_val)
 		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
-			      rapl_defaults->floor_freq_reg_addr,
+			      rpd->floor_freq_reg_addr,
 			      &power_ctrl_orig_val);
 	mdata = power_ctrl_orig_val;
 	if (enable) {
@@ -977,7 +994,7 @@ static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 		mdata |= 1 << 8;
 	}
 	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
-		       rapl_defaults->floor_freq_reg_addr, mdata);
+		       rpd->floor_freq_reg_addr, mdata);
 }
 
 static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
@@ -1385,11 +1402,9 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 {
 	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
+	struct rapl_defaults *rpd;
 	int ret;
 
-	if (!rapl_defaults)
-		return ERR_PTR(-ENODEV);
-
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
 	if (!rp)
 		return ERR_PTR(-ENOMEM);
@@ -1399,6 +1414,10 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 	rp->lead_cpu = cpu;
 	rp->priv = priv;
 
+	ret = rapl_config(rp);
+	if (ret)
+		goto err_free_package;
+
 	if (topology_max_die_per_package() > 1)
 		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
 			 "package-%d-die-%d",
@@ -1407,8 +1426,9 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
 			 topology_physical_package_id(cpu));
 
+	rpd = get_rpd(rp);
 	/* check if the package contains valid domains */
-	if (rapl_detect_domains(rp, cpu) || rapl_defaults->check_unit(rp, cpu)) {
+	if (rapl_detect_domains(rp, cpu) || rpd->check_unit(rp, cpu)) {
 		ret = -ENODEV;
 		goto err_free_package;
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 828557645770..76d480733b0f 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -121,6 +121,7 @@ struct reg_action {
  *				registers.
  * @write_raw:			Callback for writing RAPL interface specific
  *				registers.
+ * @rpd:			internal pointer to interface default settings
  */
 struct rapl_if_priv {
 	struct powercap_control_type *control_type;
@@ -130,6 +131,7 @@ struct rapl_if_priv {
 	int limits[RAPL_DOMAIN_MAX];
 	int (*read_raw)(int cpu, struct reg_action *ra);
 	int (*write_raw)(int cpu, struct reg_action *ra);
+	void *rpd;
 };
 
 /* maximum rapl package domain name: package-%d-die-%d */
-- 
2.25.1

