Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4772EFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbjFMWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjFMWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:51:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B16EC;
        Tue, 13 Jun 2023 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696700; x=1718232700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZY3z6BjCSOhZSStN0QmqBrpo5tpcryq8FmwLtwtVP8=;
  b=cgFOQryoxKRpU35W7qVLdwE2IoDMKdz2v/GpzSMgG1gZpTJzV9wTfQIF
   YdrLb80LmOPubCWPXyLOb+WnRDeSn+MrmOS+yKBWjqo+GZWtk/NPCwwMD
   l+lwu6TWHkd0xRi8WBbH4kVCyUPmXkMd3t8G+CnUb3A9fj47Ugb3LMCjd
   CXe+B+KtbtcaVNoFHwgpCgLiAiiMD+nV+k0wdDrvs09x/9f4OQ+J7LVQt
   UIqGcNcI721tVnVvvhzp1wIgycwTfhL6V+0+PEA+YZDHxb0p5pjpVEyD2
   IFWdpy+OW49MgItUAQughUqlloyITWvT83gA3nxRHGy/JwVuxJhI7+N1f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444842197"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444842197"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824589648"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824589648"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 15:51:38 -0700
Received: from rjingar-desk5.amr.corp.intel.com (hciettox-mobl.amr.corp.intel.com [10.212.23.107])
        by linux.intel.com (Postfix) with ESMTP id EE068580BF8;
        Tue, 13 Jun 2023 15:51:37 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        irenic.rajneesh@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com
Cc:     xi.pardee@intel.com
Subject: [PATCH 6/8] platform/x86:intel/pmc: Use SSRAM to discover pwrm base address of primary PMC
Date:   Tue, 13 Jun 2023 15:53:45 -0700
Message-Id: <20230613225347.2720665-7-rajvi.jingar@linux.intel.com>
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

On older platforms, the base address for PMC was hardcoded in the
driver. Newer platforms can now retrieve the base address from SSRAM.
Use SSRAM to discover pwrm base address on Meteor Lake platform. If
this method fails, it will fall back to the hardcoded value.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/mtl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index e53dc7900dbf..b5552bb146c9 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -467,7 +467,12 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 };
 
+#define PMC_DEVID_SOCM	0x7e7f
 static struct pmc_info mtl_pmc_info_list[] = {
+	{
+		.devid = PMC_DEVID_SOCM,
+		.map = &mtl_socm_reg_map,
+	},
 	{}
 };
 
@@ -513,9 +518,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
-	int ret;
-
-	pmc->map = &mtl_socm_reg_map;
+	int ret = 0;
 
 	mtl_d3_fixup();
 
@@ -524,9 +527,13 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	pmcdev->regmap_list = mtl_pmc_info_list;
 	pmc_core_ssram_init(pmcdev);
 
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
+	/* If regbase not assigned, set map and discover using legacy method */
+	if (!pmc->regbase) {
+		pmc->map = &mtl_socm_reg_map;
+		ret = get_primary_reg_base(pmc);
+		if (ret)
+			return ret;
+	}
 
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
-- 
2.25.1

