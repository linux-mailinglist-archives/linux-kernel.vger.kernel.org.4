Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8E6E7137
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjDSCox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjDSCom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:44:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689172A4;
        Tue, 18 Apr 2023 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872280; x=1713408280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9XnMvtePO/iIdNKikaFqq/CxKTPjtFDADAp3AAzOas=;
  b=eWf5TuqPxJeMHeA8WAZoIqicvuHRDtS6qYOlf9QE3oOEhiocyzPPFh9d
   V1gpU9v65Ad0Itlh4EBhyJcvIRSKThqxay7n5+j6wdLI7WyX639y2/4tx
   cnl8jZ7h3cAM6M5fYoomKjSII4Dc0AguqKTugRIlkTNi/kHQAWcHhOJ7U
   1omrcVSW4B32dRxLy+/BrdXfafYF7Zl68MESRko66ox+ZbGItNkfdMkFL
   wTjBPsVj7+Ogzf7L2FHFEQSUFJSKoP/3zd6u6XCadaVCozRo2kgL7PfjD
   KmrCwD1UMKKCvRVCb9RB6LLZpBfPoojo0NSHgt9//vSwzmABBdHXoGPGC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215287"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215287"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478019"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478019"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:39 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 04/15] powercap/intel_rapl: Support per Interface primitive information
Date:   Wed, 19 Apr 2023 10:44:08 +0800
Message-Id: <20230419024419.324436-5-rui.zhang@intel.com>
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

RAPL primitive information is Interface specific.

Although current MSR and MMIO Interface share the same RAPL primitives,
new Interface like TPMI has its own RAPL primitive information.

Save the primitive information in the Interface private structure.

Plus, using variant name "rp" for struct rapl_primitive_info is
confusing because "rp" is also used for struct rapl_package.
Use "rpi" as the variant name for struct rapl_primitive_info, and rename
the previous rpi[] array to avoid conflict.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 50 ++++++++++++++++++----------
 include/linux/intel_rapl.h           |  2 ++
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 59e470a57342..267ec36b1649 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -654,7 +654,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 }
 
 /* in the order of enum rapl_primitives */
-static struct rapl_primitive_info rpi[] = {
+static struct rapl_primitive_info rpi_default[] = {
 	/* name, mask, shift, msr index, unit divisor */
 	PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
 			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
@@ -710,9 +710,20 @@ static struct rapl_primitive_info rpi[] = {
 	{NULL, 0, 0, 0},
 };
 
+static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
+{
+	struct rapl_primitive_info *rpi = rp->priv->rpi;
+
+	if (prim < 0 || prim > NR_RAPL_PRIMITIVES || !rpi)
+		return NULL;
+
+	return &rpi[prim];
+}
+
 static int rapl_config(struct rapl_package *rp)
 {
 	rp->priv->defaults = (void *)rapl_defaults;
+	rp->priv->rpi = (void *)rpi_default;
 	return 0;
 }
 
@@ -763,14 +774,14 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 {
 	u64 value;
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
-	struct rapl_primitive_info *rp = &rpi[prim_fixed];
+	struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
 	struct reg_action ra;
 	int cpu;
 
-	if (!rp->name || rp->flag & RAPL_PRIMITIVE_DUMMY)
+	if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
 		return -EINVAL;
 
-	ra.reg = rd->regs[rp->id];
+	ra.reg = rd->regs[rpi->id];
 	if (!ra.reg)
 		return -EINVAL;
 
@@ -778,26 +789,26 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	/* domain with 2 limits has different bit */
 	if (prim == FW_LOCK && rd->rp->priv->limits[rd->id] == 2) {
-		rp->mask = POWER_HIGH_LOCK;
-		rp->shift = 63;
+		rpi->mask = POWER_HIGH_LOCK;
+		rpi->shift = 63;
 	}
 	/* non-hardware data are collected by the polling thread */
-	if (rp->flag & RAPL_PRIMITIVE_DERIVED) {
+	if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
 		*data = rd->rdd.primitives[prim];
 		return 0;
 	}
 
-	ra.mask = rp->mask;
+	ra.mask = rpi->mask;
 
 	if (rd->rp->priv->read_raw(cpu, &ra)) {
 		pr_debug("failed to read reg 0x%llx on cpu %d\n", ra.reg, cpu);
 		return -EIO;
 	}
 
-	value = ra.value >> rp->shift;
+	value = ra.value >> rpi->shift;
 
 	if (xlate)
-		*data = rapl_unit_xlate(rd, rp->unit, value, 0);
+		*data = rapl_unit_xlate(rd, rpi->unit, value, 0);
 	else
 		*data = value;
 
@@ -810,21 +821,24 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 			       unsigned long long value)
 {
 	enum rapl_primitives prim_fixed = prim_fixups(rd, prim);
-	struct rapl_primitive_info *rp = &rpi[prim_fixed];
+	struct rapl_primitive_info *rpi = get_rpi(rd->rp, prim_fixed);
 	int cpu;
 	u64 bits;
 	struct reg_action ra;
 	int ret;
 
+	if (!rpi || !rpi->name || rpi->flag & RAPL_PRIMITIVE_DUMMY)
+		return -EINVAL;
+
 	cpu = rd->rp->lead_cpu;
-	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
-	bits <<= rp->shift;
-	bits &= rp->mask;
+	bits = rapl_unit_xlate(rd, rpi->unit, value, 1);
+	bits <<= rpi->shift;
+	bits &= rpi->mask;
 
 	memset(&ra, 0, sizeof(ra));
 
-	ra.reg = rd->regs[rp->id];
-	ra.mask = rp->mask;
+	ra.reg = rd->regs[rpi->id];
+	ra.mask = rpi->mask;
 	ra.value = bits;
 
 	ret = rd->rp->priv->write_raw(cpu, &ra);
@@ -1176,8 +1190,10 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 			 rp->domains[dmn].name);
 		/* exclude non-raw primitives */
 		for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
+			struct rapl_primitive_info *rpi = get_rpi(rp, prim);
+
 			if (!rapl_read_data_raw(&rp->domains[dmn], prim,
-						rpi[prim].unit, &val))
+						rpi->unit, &val))
 				rp->domains[dmn].rdd.primitives[prim] = val;
 		}
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index ebd1cad78212..f51e2df7130e 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -122,6 +122,7 @@ struct reg_action {
  * @write_raw:			Callback for writing RAPL interface specific
  *				registers.
  * @defaults:			internal pointer to interface default settings
+ * @rpi:			internal pointer to interface primitive info
  */
 struct rapl_if_priv {
 	struct powercap_control_type *control_type;
@@ -132,6 +133,7 @@ struct rapl_if_priv {
 	int (*read_raw)(int cpu, struct reg_action *ra);
 	int (*write_raw)(int cpu, struct reg_action *ra);
 	void *defaults;
+	void *rpi;
 };
 
 /* maximum rapl package domain name: package-%d-die-%d */
-- 
2.25.1

