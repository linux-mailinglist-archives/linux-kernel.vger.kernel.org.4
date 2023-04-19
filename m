Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC21D6E7148
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjDSCpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjDSCpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:45:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60112AF16;
        Tue, 18 Apr 2023 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872300; x=1713408300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1E13JAIB2FWkm22rjS4fjRAjoYbyxhN26C2wtDkQQls=;
  b=HLOqB95NGEbGzfCxgoTG3HliJBqr/IVARnXVCL31b1T1NQZGIpRCJ8CQ
   tBnwCyXoNnxiyuS8VOIWYGSFFKU99ftRlyelwVAip5zuXpJqwFyXYm6Dz
   beMZmyZSOnT8nS03ZDqMZWnl+8IvuLhuEo+75Beyit9xCbA4B+KzcZUgD
   RBmfTXKKzkrrokSROWks31sf//3OGiJQA/7uxpRRYUsjUO2Hez1hPMcTm
   h4rwNEBZSZ/Eh/x4JF42JP0fr0qo3ZjMk8a6W3wUIk+YWCeFt0WgZ4O+6
   H8d901Aya+/DM3C/p+faMnezulUwOkRcgnU1MgOdtIxqCiCTe+bZrbz7g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215316"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215316"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478040"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478040"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:50 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 10/15] powercap/intel_rapl: Add support for lock bit per Power Limit
Date:   Wed, 19 Apr 2023 10:44:14 +0800
Message-Id: <20230419024419.324436-11-rui.zhang@intel.com>
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

With RAPL MSR/MMIO Interface, each RAPL domain has one Power Limit
register. Each Power Limit register has one lock bit which tells the OS
if the power limit register can be used or not.
Depending on the number of power limits supported by the power limit
register, the lock bit may apply to one or more power limits.

With RAPL TPMI Interface, each RAPL domain has multiple Power Limits,
and each Power Limit has its own register, with a lock bit.

To handle this, introduce support for lock bit per Power Limit.

For existing RAPL MSR/MMIO Interfaces, the lock bit in the Power Limit
register applies to all the Power Limits controlled by this register.

Remove the per domain DOMAIN_STATE_BIOS_LOCKED flag at the same time
because it can be replaced by the per Power Limit lock.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 50 +++++++++++++++++-----------
 include/linux/intel_rapl.h           |  2 ++
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 7f80c35e5c86..d88008308d7a 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -94,7 +94,6 @@ enum unit_type {
 
 #define	DOMAIN_STATE_INACTIVE           BIT(0)
 #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
-#define DOMAIN_STATE_BIOS_LOCKED        BIT(2)
 
 static const char *pl_names[NR_POWER_LIMITS] = {
 	[POWER_LIMIT1] = "long_term",
@@ -108,6 +107,7 @@ enum pl_prims {
 	PL_LIMIT,
 	PL_TIME_WINDOW,
 	PL_MAX_POWER,
+	PL_LOCK,
 };
 
 static bool is_pl_valid(struct rapl_domain *rd, int pl)
@@ -117,7 +117,18 @@ static bool is_pl_valid(struct rapl_domain *rd, int pl)
 	return rd->rpl[pl].name ? true : false;
 }
 
-static int get_pl_prim(int pl, enum pl_prims prim)
+static int get_pl_lock_prim(struct rapl_domain *rd, int pl)
+{
+	/*
+	 * Power Limit register that supports two power limits has a different
+	 * bit position for the Lock bit.
+	 */
+	if (rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2))
+		return FW_HIGH_LOCK;
+	return FW_LOCK;
+}
+
+static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 {
 	switch (pl) {
 	case POWER_LIMIT1:
@@ -131,6 +142,8 @@ static int get_pl_prim(int pl, enum pl_prims prim)
 			return TIME_WINDOW1;
 		if (prim == PL_MAX_POWER)
 			return THERMAL_SPEC_POWER;
+		if (prim == PL_LOCK)
+			return get_pl_lock_prim(rd, pl);
 		return -EINVAL;
 	case POWER_LIMIT2:
 		if (prim == PL_ENABLE)
@@ -143,6 +156,8 @@ static int get_pl_prim(int pl, enum pl_prims prim)
 			return TIME_WINDOW2;
 		if (prim == PL_MAX_POWER)
 			return MAX_POWER;
+		if (prim == PL_LOCK)
+			return get_pl_lock_prim(rd, pl);
 		return -EINVAL;
 	case POWER_LIMIT4:
 		if (prim == PL_LIMIT)
@@ -314,7 +329,7 @@ static int get_domain_enable(struct powercap_zone *power_zone, bool *mode)
 	u64 val;
 	int ret;
 
-	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
+	if (rd->rpl[POWER_LIMIT1].locked) {
 		*mode = false;
 		return 0;
 	}
@@ -599,6 +614,8 @@ static struct rapl_primitive_info rpi_default[NR_RAPL_PRIMITIVES] = {
 			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
 	[FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[FW_HIGH_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_HIGH_LOCK, 63,
+			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL1_CLAMP] = PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
@@ -719,11 +736,6 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	cpu = rd->rp->lead_cpu;
 
-	/* domain with 2 limits has different bit */
-	if (prim == FW_LOCK && (rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2))) {
-		rpi->mask = POWER_HIGH_LOCK;
-		rpi->shift = 63;
-	}
 	/* non-hardware data are collected by the polling thread */
 	if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
 		*data = rd->rdd.primitives[prim];
@@ -781,7 +793,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
 			      enum pl_prims pl_prim, bool xlate, u64 *data)
 {
-	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
+	enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
 
 	if (!is_pl_valid(rd, pl))
 		return -EINVAL;
@@ -793,12 +805,12 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
 			       enum pl_prims pl_prim,
 			       unsigned long long value)
 {
-	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
+	enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
 
 	if (!is_pl_valid(rd, pl))
 		return -EINVAL;
 
-	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
+	if (rd->rpl[pl].locked) {
 		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
 		return -EACCES;
 	}
@@ -1305,17 +1317,15 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 	u64 val64;
 	int i;
 
-	/* check if the domain is locked by BIOS, ignore if MSR doesn't exist */
-	if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
-		if (val64) {
-			pr_info("RAPL %s domain %s locked by BIOS\n",
-				rd->rp->name, rd->name);
-			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
+	for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
+		if (!rapl_read_pl_data(rd, i, PL_LOCK, false, &val64)) {
+			if (val64) {
+				rd->rpl[i].locked = true;
+				pr_info("%s:%s:%s locked by BIOS\n",
+					rd->rp->name, rd->name, pl_names[i]);
+			}
 		}
-	}
 
-	/* check if power limit exists, otherwise domain is monitoring only */
-	for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
 		if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
 			rd->rpl[i].name = NULL;
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index df17f4e51dbf..d07b460bac3b 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -42,6 +42,7 @@ enum rapl_primitives {
 	POWER_LIMIT4,
 	ENERGY_COUNTER,
 	FW_LOCK,
+	FW_HIGH_LOCK,
 
 	PL1_ENABLE,		/* power limit 1, aka long term */
 	PL1_CLAMP,		/* allow frequency to go below OS request */
@@ -81,6 +82,7 @@ struct rapl_power_limit {
 	struct powercap_zone_constraint *constraint;
 	struct rapl_domain *domain;
 	const char *name;
+	bool locked;
 	u64 last_power_limit;
 };
 
-- 
2.25.1

