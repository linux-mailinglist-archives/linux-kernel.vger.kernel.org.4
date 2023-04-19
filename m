Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6076E714D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjDSCpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjDSCpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:45:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10B0B476;
        Tue, 18 Apr 2023 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872307; x=1713408307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyXxoAwG4W/8x6sK+/ECee9E2b+9or/2Yzlx9s2JV08=;
  b=F9v9fQawmB6GvwQJf1Too4ufsxdr1tlqZX877Ord5kj7YWIrzToKq1Yt
   XVymCfi/4GWE1ZozaIFoJoyvzWgGgg8mfZHjeGUwGCNkjz2VjEdq+0trn
   AssYeOxRoNstQshie6yimKMszbSkFscAB7gbe8c1oNCGduuAamWr6a4HW
   qovMbypnXSxsbRyf1VP2OwlE5LO3GrhJkWMZXm/8LHnTF6BGpv8WWRWEv
   60cBaUxS1UN/HxT+xrigUBmEYvj9kwTmNwhW49+/LKt8DcbNDvtFYFWN5
   x3Iq1EQiJlJCGKh9IWEoUmfCYCfdD/9fm99q9ewrbzIZDPWR8WL7Fszcf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215319"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215319"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478043"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478043"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:52 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 11/15] powercap/intel_rapl: Remove redundant cpu parameter
Date:   Wed, 19 Apr 2023 10:44:15 +0800
Message-Id: <20230419024419.324436-12-rui.zhang@intel.com>
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

For rapl_packages that rely on online CPUs to work, rp->lead_cpu always
has a valid CPU id.

Remove the redundant cpu parameter in rapl_check_domain(),
rapl_detect_domains() and .check_unit() callbacks.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index d88008308d7a..fcb92f1f4bfc 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -178,7 +178,7 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 
 struct rapl_defaults {
 	u8 floor_freq_reg_addr;
-	int (*check_unit)(struct rapl_domain *rd, int cpu);
+	int (*check_unit)(struct rapl_domain *rd);
 	void (*set_floor_freq)(struct rapl_domain *rd, bool mode);
 	u64 (*compute_time_window)(struct rapl_domain *rd, u64 val,
 				    bool to_raw);
@@ -828,16 +828,16 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
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
 
@@ -856,16 +856,16 @@ static int rapl_check_unit_core(struct rapl_domain *rd, int cpu)
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
 
@@ -1242,7 +1242,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	return ret;
 }
 
-static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
+static int rapl_check_domain(int domain, struct rapl_package *rp)
 {
 	struct reg_action ra;
 
@@ -1263,7 +1263,7 @@ static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 	 */
 
 	ra.mask = ENERGY_STATUS_MASK;
-	if (rp->priv->read_raw(cpu, &ra) || !ra.value)
+	if (rp->priv->read_raw(rp->lead_cpu, &ra) || !ra.value)
 		return -ENODEV;
 
 	return 0;
@@ -1292,7 +1292,7 @@ static int rapl_get_domain_unit(struct rapl_domain *rd)
 		return -ENODEV;
 	}
 
-	ret = defaults->check_unit(rd, rd->rp->lead_cpu);
+	ret = defaults->check_unit(rd);
 	if (ret)
 		return ret;
 
@@ -1334,14 +1334,14 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
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
@@ -1445,7 +1445,7 @@ struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv)
 			 topology_physical_package_id(cpu));
 
 	/* check if the package contains valid domains */
-	if (rapl_detect_domains(rp, cpu)) {
+	if (rapl_detect_domains(rp)) {
 		ret = -ENODEV;
 		goto err_free_package;
 	}
-- 
2.25.1

