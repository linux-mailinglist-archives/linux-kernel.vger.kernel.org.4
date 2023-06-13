Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05172EFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbjFMWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjFMWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:51:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6521739;
        Tue, 13 Jun 2023 15:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696698; x=1718232698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6fzUoNwXKYDIUEJeBOFu4PTHp6SiilU8h6006HIQgo=;
  b=nAgmXLbcFrZgB6z9E0T6XlLnkEaX1mcrLQngo3t8Oyod5cD7liZzG+hh
   Kw/3PMj0P/V4nhIDKvao+G83rkgGUt33K7sZ7SdNF72s9oje+cY1MCp+c
   uTuWaUOMkrQDRJ0FSKKRjwX8a3aNxJSYbxaZA41HGy+QwDlFL68utXCdX
   KlQPCnH8kVM9Mi0wCF+ek6jzJaSOwGBK/bxt1C4oNgbfbUhDwl+JX28XH
   jekguV55/RIaYsleH04QlI71aUH4o61MQpcXqkMuX0eYGd0pwHmSHYpJy
   Ms0PYwD3heBSDWBX0plqfWg3FCVifBv9Qr3cfKu2aKwEUfu23uN/zRKd5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444842190"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444842190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824589642"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824589642"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 15:51:36 -0700
Received: from rjingar-desk5.amr.corp.intel.com (hciettox-mobl.amr.corp.intel.com [10.212.23.107])
        by linux.intel.com (Postfix) with ESMTP id 942CB580D61;
        Tue, 13 Jun 2023 15:51:36 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        irenic.rajneesh@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com
Cc:     xi.pardee@intel.com, Rajvi Jingar <rajvi.jingar@linux.intel.com>
Subject: [PATCH 4/8] platform/x86:intel/pmc: Enable debugfs multiple PMC support
Date:   Tue, 13 Jun 2023 15:53:43 -0700
Message-Id: <20230613225347.2720665-5-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613225347.2720665-1-rajvi.jingar@linux.intel.com>
References: <20230613225347.2720665-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

Enable debugfs support for multiple PMC. These debugfs attributes
show information for all enabled PMCs.

pch_ip_power_gating_status
substate_status_registers
substate_live_status_registers
ltr_show
ltr_ignore

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 195 +++++++++++++++++---------
 1 file changed, 129 insertions(+), 66 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 8d774461dd29..5864d2e85706 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -252,7 +252,7 @@ static int pmc_core_lpm_get_arr_size(const struct pmc_bit_map **maps)
 }
 
 static void pmc_core_lpm_display(struct pmc *pmc, struct device *dev,
-				 struct seq_file *s, u32 offset,
+				 struct seq_file *s, u32 offset, int pmc_index,
 				 const char *str,
 				 const struct pmc_bit_map **maps)
 {
@@ -271,19 +271,19 @@ static void pmc_core_lpm_display(struct pmc *pmc, struct device *dev,
 
 	for (idx = 0; idx < arr_size; idx++) {
 		if (dev)
-			dev_info(dev, "\nLPM_%s_%d:\t0x%x\n", str, idx,
+			dev_info(dev, "\nPMC%d:LPM_%s_%d:\t0x%x\n", pmc_index, str, idx,
 				lpm_regs[idx]);
 		if (s)
-			seq_printf(s, "\nLPM_%s_%d:\t0x%x\n", str, idx,
+			seq_printf(s, "\nPMC%d:LPM_%s_%d:\t0x%x\n", pmc_index, str, idx,
 				   lpm_regs[idx]);
 		for (index = 0; maps[idx][index].name && index < len; index++) {
 			bit_mask = maps[idx][index].bit_mask;
 			if (dev)
-				dev_info(dev, "%-30s %-30d\n",
+				dev_info(dev, "PMC%d:%-30s %-30d\n", pmc_index,
 					maps[idx][index].name,
 					lpm_regs[idx] & bit_mask ? 1 : 0);
 			if (s)
-				seq_printf(s, "%-30s %-30d\n",
+				seq_printf(s, "PMC%d:%-30s %-30d\n", pmc_index,
 					   maps[idx][index].name,
 					   lpm_regs[idx] & bit_mask ? 1 : 0);
 		}
@@ -300,32 +300,40 @@ static inline u8 pmc_core_reg_read_byte(struct pmc *pmc, int offset)
 }
 
 static void pmc_core_display_map(struct seq_file *s, int index, int idx, int ip,
-				 u8 pf_reg, const struct pmc_bit_map **pf_map)
+				 int pmc_index, u8 pf_reg, const struct pmc_bit_map **pf_map)
 {
-	seq_printf(s, "PCH IP: %-2d - %-32s\tState: %s\n",
-		   ip, pf_map[idx][index].name,
+	seq_printf(s, "PMC%d:PCH IP: %-2d - %-32s\tState: %s\n",
+		   pmc_index, ip, pf_map[idx][index].name,
 		   pf_map[idx][index].bit_mask & pf_reg ? "Off" : "On");
 }
 
 static int pmc_core_ppfear_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	const struct pmc_bit_map **maps = pmc->map->pfear_sts;
-	u8 pf_regs[PPFEAR_MAX_NUM_ENTRIES];
-	int index, iter, idx, ip = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		struct pmc *pmc = pmcdev->pmcs[i];
+		const struct pmc_bit_map **maps;
+		u8 pf_regs[PPFEAR_MAX_NUM_ENTRIES];
+		int index, iter, idx, ip = 0;
+
+		if (!pmc)
+			continue;
 
-	iter = pmc->map->ppfear0_offset;
+		maps = pmc->map->pfear_sts;
+		iter = pmc->map->ppfear0_offset;
 
-	for (index = 0; index < pmc->map->ppfear_buckets &&
-	     index < PPFEAR_MAX_NUM_ENTRIES; index++, iter++)
-		pf_regs[index] = pmc_core_reg_read_byte(pmc, iter);
+		for (index = 0; index < pmc->map->ppfear_buckets &&
+		     index < PPFEAR_MAX_NUM_ENTRIES; index++, iter++)
+			pf_regs[index] = pmc_core_reg_read_byte(pmc, iter);
 
-	for (idx = 0; maps[idx]; idx++) {
-		for (index = 0; maps[idx][index].name &&
-		     index < pmc->map->ppfear_buckets * 8; ip++, index++)
-			pmc_core_display_map(s, index, idx, ip,
-					     pf_regs[index / 8], maps);
+		for (idx = 0; maps[idx]; idx++) {
+			for (index = 0; maps[idx][index].name &&
+			     index < pmc->map->ppfear_buckets * 8; ip++, index++)
+				pmc_core_display_map(s, index, idx, ip, i,
+						     pf_regs[index / 8], maps);
+		}
 	}
 
 	return 0;
@@ -454,26 +462,48 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
 int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	const struct pmc_reg_map *map = pmc->map;
+	struct pmc *pmc;
+	const struct pmc_reg_map *map;
 	u32 reg;
-	int err = 0;
+	int pmc_index, ltr_index;
 
-	mutex_lock(&pmcdev->lock);
+	ltr_index = value;
+	/* For platforms with multiple pmcs, ltr index value given by user
+	 * is based on the contiguous indexes from ltr_show output.
+	 * pmc index and ltr index needs to be calculated from it.
+	 */
+	for (pmc_index = 0; pmc_index < ARRAY_SIZE(pmcdev->pmcs) && ltr_index > 0; pmc_index++) {
+		pmc = pmcdev->pmcs[pmc_index];
 
-	if (value > map->ltr_ignore_max) {
-		err = -EINVAL;
-		goto out_unlock;
+		if (!pmc)
+			continue;
+
+		map = pmc->map;
+		if (ltr_index <= map->ltr_ignore_max)
+			break;
+
+		/* Along with IP names, ltr_show map includes CURRENT_PLATFORM
+		 * and AGGREGATED_SYSTEM values per PMC. Take these two index
+		 * values into account in ltr_index calculation. Also, to start
+		 * ltr index from zero for next pmc, subtract it by 1.
+		 */
+		ltr_index = ltr_index - (map->ltr_ignore_max + 2) - 1;
 	}
 
+	if (pmc_index >= ARRAY_SIZE(pmcdev->pmcs) || ltr_index < 0)
+		return -EINVAL;
+
+	pr_debug("ltr_ignore for pmc%d: ltr_index:%d\n", pmc_index, ltr_index);
+
+	mutex_lock(&pmcdev->lock);
+
 	reg = pmc_core_reg_read(pmc, map->ltr_ignore_offset);
-	reg |= BIT(value);
+	reg |= BIT(ltr_index);
 	pmc_core_reg_write(pmc, map->ltr_ignore_offset, reg);
 
-out_unlock:
 	mutex_unlock(&pmcdev->lock);
 
-	return err;
+	return 0;
 }
 
 static ssize_t pmc_core_ltr_ignore_write(struct file *file,
@@ -586,36 +616,44 @@ static u32 convert_ltr_scale(u32 val)
 
 static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 {
-	struct pmc *pmc = s->private;
-	const struct pmc_bit_map *map = pmc->map->ltr_show_sts;
+	struct pmc_dev *pmcdev = s->private;
 	u64 decoded_snoop_ltr, decoded_non_snoop_ltr;
 	u32 ltr_raw_data, scale, val;
 	u16 snoop_ltr, nonsnoop_ltr;
-	int index;
+	int i, index, ltr_index = 0;
 
-	for (index = 0; map[index].name ; index++) {
-		decoded_snoop_ltr = decoded_non_snoop_ltr = 0;
-		ltr_raw_data = pmc_core_reg_read(pmc,
-						 map[index].bit_mask);
-		snoop_ltr = ltr_raw_data & ~MTPMC_MASK;
-		nonsnoop_ltr = (ltr_raw_data >> 0x10) & ~MTPMC_MASK;
-
-		if (FIELD_GET(LTR_REQ_NONSNOOP, ltr_raw_data)) {
-			scale = FIELD_GET(LTR_DECODED_SCALE, nonsnoop_ltr);
-			val = FIELD_GET(LTR_DECODED_VAL, nonsnoop_ltr);
-			decoded_non_snoop_ltr = val * convert_ltr_scale(scale);
-		}
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		struct pmc *pmc = pmcdev->pmcs[i];
+		const struct pmc_bit_map *map;
 
-		if (FIELD_GET(LTR_REQ_SNOOP, ltr_raw_data)) {
-			scale = FIELD_GET(LTR_DECODED_SCALE, snoop_ltr);
-			val = FIELD_GET(LTR_DECODED_VAL, snoop_ltr);
-			decoded_snoop_ltr = val * convert_ltr_scale(scale);
-		}
+		if (!pmc)
+			continue;
+
+		map = pmc->map->ltr_show_sts;
+		for (index = 0; map[index].name; index++) {
+			decoded_snoop_ltr = decoded_non_snoop_ltr = 0;
+			ltr_raw_data = pmc_core_reg_read(pmc,
+							 map[index].bit_mask);
+			snoop_ltr = ltr_raw_data & ~MTPMC_MASK;
+			nonsnoop_ltr = (ltr_raw_data >> 0x10) & ~MTPMC_MASK;
+
+			if (FIELD_GET(LTR_REQ_NONSNOOP, ltr_raw_data)) {
+				scale = FIELD_GET(LTR_DECODED_SCALE, nonsnoop_ltr);
+				val = FIELD_GET(LTR_DECODED_VAL, nonsnoop_ltr);
+				decoded_non_snoop_ltr = val * convert_ltr_scale(scale);
+			}
+			if (FIELD_GET(LTR_REQ_SNOOP, ltr_raw_data)) {
+				scale = FIELD_GET(LTR_DECODED_SCALE, snoop_ltr);
+				val = FIELD_GET(LTR_DECODED_VAL, snoop_ltr);
+				decoded_snoop_ltr = val * convert_ltr_scale(scale);
+			}
 
-		seq_printf(s, "%-32s\tLTR: RAW: 0x%-16x\tNon-Snoop(ns): %-16llu\tSnoop(ns): %-16llu\n",
-			   map[index].name, ltr_raw_data,
-			   decoded_non_snoop_ltr,
-			   decoded_snoop_ltr);
+			seq_printf(s, "%d\tPMC%d:%-32s\tLTR: RAW: 0x%-16x\tNon-Snoop(ns): %-16llu\tSnoop(ns): %-16llu\n",
+				   ltr_index, i, map[index].name, ltr_raw_data,
+				   decoded_non_snoop_ltr,
+				   decoded_snoop_ltr);
+			ltr_index++;
+		}
 	}
 	return 0;
 }
@@ -651,11 +689,19 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_res);
 static int pmc_core_substate_sts_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	const struct pmc_bit_map **maps = pmc->map->lpm_sts;
-	u32 offset = pmc->map->lpm_status_offset;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		struct pmc *pmc = pmcdev->pmcs[i];
+		const struct pmc_bit_map **maps;
+		u32 offset;
 
-	pmc_core_lpm_display(pmc, NULL, s, offset, "STATUS", maps);
+		if (!pmc)
+			continue;
+		maps = pmc->map->lpm_sts;
+		offset = pmc->map->lpm_status_offset;
+		pmc_core_lpm_display(pmc, NULL, s, offset, i, "STATUS", maps);
+	}
 
 	return 0;
 }
@@ -664,11 +710,19 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_sts_regs);
 static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	const struct pmc_bit_map **maps = pmc->map->lpm_sts;
-	u32 offset = pmc->map->lpm_live_status_offset;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		struct pmc *pmc = pmcdev->pmcs[i];
+		const struct pmc_bit_map **maps;
+		u32 offset;
 
-	pmc_core_lpm_display(pmc, NULL, s, offset, "LIVE_STATUS", maps);
+		if (!pmc)
+			continue;
+		maps = pmc->map->lpm_sts;
+		offset = pmc->map->lpm_live_status_offset;
+		pmc_core_lpm_display(pmc, NULL, s, offset, i, "LIVE_STATUS", maps);
+	}
 
 	return 0;
 }
@@ -1005,7 +1059,7 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	debugfs_create_file("ltr_ignore", 0644, dir, pmcdev,
 			    &pmc_core_ltr_ignore_ops);
 
-	debugfs_create_file("ltr_show", 0444, dir, primary_pmc, &pmc_core_ltr_fops);
+	debugfs_create_file("ltr_show", 0444, dir, pmcdev, &pmc_core_ltr_fops);
 
 	debugfs_create_file("package_cstate_show", 0444, dir, primary_pmc,
 			    &pmc_core_pkgc_fops);
@@ -1264,6 +1318,7 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	const struct pmc_bit_map **maps = pmc->map->lpm_sts;
 	int offset = pmc->map->lpm_status_offset;
+	int i;
 
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
@@ -1285,10 +1340,18 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
 	/* The real interesting case - S0ix failed - lets ask PMC why. */
 	dev_warn(dev, "CPU did not enter SLP_S0!!! (S0ix cnt=%llu)\n",
 		 pmcdev->s0ix_counter);
+
 	if (pmc->map->slps0_dbg_maps)
 		pmc_core_slps0_display(pmc, dev, NULL);
-	if (pmc->map->lpm_sts)
-		pmc_core_lpm_display(pmc, dev, NULL, offset, "STATUS", maps);
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		struct pmc *pmc = pmcdev->pmcs[i];
+
+		if (!pmc)
+			continue;
+		if (pmc->map->lpm_sts)
+			pmc_core_lpm_display(pmc, dev, NULL, offset, i, "STATUS", maps);
+	}
 
 	return 0;
 }
-- 
2.25.1

