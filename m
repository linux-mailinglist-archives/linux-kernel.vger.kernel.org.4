Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9CF6BD43A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjCPPnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjCPPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:43:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14FE1FEF;
        Thu, 16 Mar 2023 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981352; x=1710517352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HriePrlflVA6Mh7mETQnqDKAmcQLPOTtZW1XMlA7/L0=;
  b=Ivfd0FdfLQeZqqpYRhABhbcIBJVq+iFovv0hcgjV9WlWpjwDmZim4F6D
   vFbM4YBAI7HJ/f40WtfLEFWHu8KkpoF4tKynUfvdxUnNfH8GmIJx7K9wR
   Re44bmgh+qH6FO8eCeLm2YZz/d3InR7LI0/LQ8VALgOj3LgazP9TR2fh5
   GVOLQNEtBxPeQ5dK4Mf7WD3yah1mxoCW6nu0Fqt5Jacz7BSvmn/Jxu8wg
   kYKVYpq+rU/K/k34UICkLOFm21LTU+v1KanQqPzvjLE8yUI1bhIgksTqH
   ZY6u/xqm4KCVS764788lBhwrZjtB4QPdHanYQ69BBzrGkq+gmBRHp4ky5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571081"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571081"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267170"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267170"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:10 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 12/15] powercap/intel_rapl: Make cpu optional for rapl_package
Date:   Thu, 16 Mar 2023 23:38:38 +0800
Message-Id: <20230316153841.3666-13-rui.zhang@intel.com>
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

MSR RAPL Interface always removes a rapl_package when all the CPUs in
that rapl_package are offlined. This is because it relies on an online
CPU to access the MSR.

But for RAPL Interface using MMIO registers, when all the cpus within
the rapl_package are offlined,
1. the register can still be accessed
2. monitoring and setting the Power Pimits for the rapl_package is still
   meaningful because of uncore power.

This means that, a valid rapl_package doesn't rely on one or more cpus
being onlined.

For this sense, make cpu optional for rapl_package. A rapl_package can
be registered either using a CPU id to represent the physical
package/die, or using the physical package id directly.

Note that, the thermal throttling interrupt is not disabled via
MSR_IA32_PACKAGE_THERM_INTERRUPT for such rapl_package at the moment.
If it is still needed in the future, this can be achieved by selecting
an onlined CPU using the physical package id.

Note that, processor_thermal_rapl, the current MMIO RAPL Interface
driver can be converted to register with a package id instead. This is
not done because processor_thermal_rapl driver works on single-package
systems only, and offlining the only package will not happen. So keep
the previous logic.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c          | 84 +++++++++++--------
 drivers/powercap/intel_rapl_msr.c             |  6 +-
 .../int340x_thermal/processor_thermal_rapl.c  |  6 +-
 include/linux/intel_rapl.h                    |  8 +-
 4 files changed, 60 insertions(+), 44 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 27ebc2c51803..a6a7d048d0b4 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -523,6 +523,12 @@ static const struct powercap_zone_constraint_ops constraint_ops = {
 	.get_name = get_constraint_name,
 };
 
+/* Return the id used for read_raw/write_raw callback */
+static int get_rid(struct rapl_package *rp)
+{
+	return rp->lead_cpu >= 0 ? rp->lead_cpu : rp->id;
+}
+
 /* called after domain detection and package level data are set */
 static void rapl_init_domains(struct rapl_package *rp)
 {
@@ -541,10 +547,12 @@ static void rapl_init_domains(struct rapl_package *rp)
 
 		if (i == RAPL_DOMAIN_PLATFORM && rp->id > 0) {
 			snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "psys-%d",
-				topology_physical_package_id(rp->lead_cpu));
-		} else
+				rp->lead_cpu >= 0 ? topology_physical_package_id(rp->lead_cpu) :
+				rp->id);
+		} else {
 			snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "%s",
 				rapl_domain_names[i]);
+		}
 
 		rd->id = i;
 
@@ -716,7 +724,6 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
 	struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
 	struct reg_action ra;
-	int cpu;
 
 	if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
 		return -EINVAL;
@@ -725,8 +732,6 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	if (!ra.reg)
 		return -EINVAL;
 
-	cpu = rd->rp->lead_cpu;
-
 	/* non-hardware data are collected by the polling thread */
 	if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
 		*data = rd->rdd.primitives[prim];
@@ -735,8 +740,8 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	ra.mask = rpi->mask;
 
-	if (rd->rp->priv->read_raw(cpu, &ra)) {
-		pr_debug("failed to read reg 0x%llx on cpu %d\n", ra.reg, cpu);
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+		pr_debug("failed to read reg 0x%llx for %s:%s\n", ra.reg, rd->rp->name, rd->name);
 		return -EIO;
 	}
 
@@ -757,7 +762,6 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 {
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
 	struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
-	int cpu;
 	u64 bits;
 	struct reg_action ra;
 	int ret;
@@ -765,7 +769,6 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
 		return -EINVAL;
 
-	cpu = rd->rp->lead_cpu;
 	bits = rapl_unit_xlate(rd, rpi->unit, value, 1);
 	bits <<= rpi->shift;
 	bits &= rpi->mask;
@@ -776,7 +779,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 	ra.mask = rpi->mask;
 	ra.value = bits;
 
-	ret = rd->rp->priv->write_raw(cpu, &ra);
+	ret = rd->rp->priv->write_raw(get_rid(rd->rp), &ra);
 
 	return ret;
 }
@@ -826,9 +829,9 @@ static int rapl_check_unit_core(struct rapl_domain *rd)
 
 	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(rd->rp->lead_cpu, &ra)) {
-		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
-			ra.reg, rd->rp->lead_cpu);
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
+			ra.reg, rd->rp->name, rd->name);
 		return -ENODEV;
 	}
 
@@ -854,9 +857,9 @@ static int rapl_check_unit_atom(struct rapl_domain *rd)
 
 	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
 	ra.mask = ~0;
-	if (rd->rp->priv->read_raw(rd->rp->lead_cpu, &ra)) {
-		pr_err("Failed to read power unit REG 0x%llx on CPU %d, exit.\n",
-			ra.reg, rd->rp->lead_cpu);
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
+			ra.reg, rd->rp->name, rd->name);
 		return -ENODEV;
 	}
 
@@ -902,6 +905,9 @@ static void power_limit_irq_save_cpu(void *info)
 
 static void package_power_limit_irq_save(struct rapl_package *rp)
 {
+	if (rp->lead_cpu < 0)
+		return;
+
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
@@ -916,6 +922,9 @@ static void package_power_limit_irq_restore(struct rapl_package *rp)
 {
 	u32 l, h;
 
+	if (rp->lead_cpu < 0)
+		return;
+
 	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
 		return;
 
@@ -1254,7 +1263,7 @@ static int rapl_check_domain(int domain, struct rapl_package *rp)
 	 */
 
 	ra.mask = ENERGY_STATUS_MASK;
-	if (rp->priv->read_raw(rp->lead_cpu, &ra) || !ra.value)
+	if (rp->priv->read_raw(get_rid(rp), &ra) || !ra.value)
 		return -ENODEV;
 
 	return 0;
@@ -1391,13 +1400,18 @@ void rapl_remove_package(struct rapl_package *rp)
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
 /* caller to ensure CPU hotplug lock is held */
-struct rapl_package *rapl_find_package_domain(int cpu, struct rapl_if_priv *priv)
+struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
 {
-	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
+	int uid;
+
+	if (id_is_cpu)
+		uid = topology_logical_die_id(id);
+	else
+		uid = id;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
-		if (rp->id == id
+		if (rp->id == uid
 		    && rp->priv->control_type == priv->control_type)
 			return rp;
 	}
@@ -1407,9 +1421,8 @@ struct rapl_package *rapl_find_package_domain(int cpu, struct rapl_if_priv *priv
 EXPORT_SYMBOL_GPL(rapl_find_package_domain);
 
 /* called from CPU hotplug notifier, hotplug lock held */
-struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
+struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
 {
-	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
@@ -1417,23 +1430,26 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 	if (!rp)
 		return ERR_PTR(-ENOMEM);
 
-	/* add the new package to the list */
-	rp->id = id;
-	rp->lead_cpu = cpu;
-	rp->priv = priv;
+	if (id_is_cpu) {
+		rp->id = topology_logical_die_id(id);
+		rp->lead_cpu = id;
+		if (topology_max_die_per_package() > 1)
+			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
+				 topology_physical_package_id(id), topology_die_id(id));
+		else
+			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
+				 topology_physical_package_id(id));
+	} else {
+		rp->id = id;
+		rp->lead_cpu = -1;
+		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d", id);
+	}
 
+	rp->priv = priv;
 	ret = rapl_config(rp);
 	if (ret)
 		goto err_free_package;
 
-	if (topology_max_die_per_package() > 1)
-		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
-			 "package-%d-die-%d",
-			 topology_physical_package_id(cpu), topology_die_id(cpu));
-	else
-		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
-			 topology_physical_package_id(cpu));
-
 	/* check if the package contains valid domains */
 	if (rapl_detect_domains(rp)) {
 		ret = -ENODEV;
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index e78460620340..3e48e729050d 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -68,9 +68,9 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	struct rapl_package *rp;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, rapl_msr_priv);
+		rp = rapl_add_package(cpu, rapl_msr_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -83,7 +83,7 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv);
+	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
 	if (!rp)
 		return 0;
 
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index e070239106f5..140fb85cfa7b 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -27,9 +27,9 @@ static int rapl_mmio_cpu_online(unsigned int cpu)
 	if (topology_physical_package_id(cpu))
 		return 0;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv);
+	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_mmio_priv);
+		rp = rapl_add_package(cpu, &rapl_mmio_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -42,7 +42,7 @@ static int rapl_mmio_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv);
+	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
 	if (!rp)
 		return 0;
 
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 325ec00be7a7..d92ded956140 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -135,8 +135,8 @@ struct rapl_if_priv {
 	u64 reg_unit;
 	u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
 	int limits[RAPL_DOMAIN_MAX];
-	int (*read_raw)(int cpu, struct reg_action *ra);
-	int (*write_raw)(int cpu, struct reg_action *ra);
+	int (*read_raw)(int id, struct reg_action *ra);
+	int (*write_raw)(int id, struct reg_action *ra);
 	void *rpd;
 	void *rpi;
 };
@@ -161,8 +161,8 @@ struct rapl_package {
 	struct rapl_if_priv *priv;
 };
 
-struct rapl_package *rapl_find_package_domain(int cpu, struct rapl_if_priv *priv);
-struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv);
+struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu);
+struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 void rapl_remove_package(struct rapl_package *rp);
 
 #endif /* __INTEL_RAPL_H__ */
-- 
2.25.1

