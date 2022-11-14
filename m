Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A98628809
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiKNSNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiKNSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:12:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0EA27B1E;
        Mon, 14 Nov 2022 10:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449572; x=1699985572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Izc7C7NB72npujQT+4yiQPGp32CEjAlPxxuAAKVMh4k=;
  b=DSYepAps80Tw8ErmedddblmK8murMBwZbiAz4+YmPRMESxL/3CKWNynG
   p4d9tqwtQpbeLkvutWlmi00djnVkle0R760Cm+mSTlhdSRv96VA7ktW7o
   FnpuAsjfd8S1blBS969TyKDzFRpsY8WdTlJXX9gExlWB7XFXkl37SIFi1
   Xipst/HXqx4petswWu26QryFaJiVmcys7VZaGHehSBmEcBzVVvVZmwMUX
   rkFk4aGH4pTGGndJzkEfv5SJ2WK4W+B1PGiWTNt2L4dLTMs4mm5aE8eaQ
   WS5UolNZ7gkLyal/CBF9yLoeugEg6woxK7Y302Npy/3xz4wN07iWRrpPO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398332829"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398332829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="883636897"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="883636897"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2022 10:12:51 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id AF77858097C;
        Mon, 14 Nov 2022 10:12:51 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com, David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 2/8] platform/x86: intel/pmc: Move variable declarations and definitions to header and core.c
Date:   Mon, 14 Nov 2022 10:12:01 -0800
Message-Id: <20221114181207.2062901-3-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

Move the msr_map variable declaration to core.h and move the pmc_lpm_modes
definition to core.c.

This is a prepartory patch for redesigning the pmc core driver as the
variables will be used in multiple PCH specific files.

Cc: David E Box <david.e.box@linux.intel.com>
Reviewed-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 15 ++++++++++++++-
 drivers/platform/x86/intel/pmc/core.h | 13 ++-----------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index b434cf5b094b..cfa654672cba 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -35,8 +35,21 @@
 #define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
 #define ACPI_GET_LOW_MODE_REGISTERS	1
 
+/* Maximum number of modes supported by platfoms that has low power mode capability */
+const char *pmc_lpm_modes[] = {
+	"S0i2.0",
+	"S0i2.1",
+	"S0i2.2",
+	"S0i3.0",
+	"S0i3.1",
+	"S0i3.2",
+	"S0i3.3",
+	"S0i3.4",
+	NULL
+};
+
 /* PKGC MSRs are common across Intel Core SoCs */
-static const struct pmc_bit_map msr_map[] = {
+const struct pmc_bit_map msr_map[] = {
 	{"Package C2",                  MSR_PKG_C2_RESIDENCY},
 	{"Package C3",                  MSR_PKG_C3_RESIDENCY},
 	{"Package C6",                  MSR_PKG_C6_RESIDENCY},
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index e64b33e46397..b4279ed59bbe 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -237,17 +237,7 @@ enum ppfear_regs {
 #define ADL_LPM_STATUS_LATCH_EN_OFFSET		0x1704
 #define ADL_LPM_LIVE_STATUS_OFFSET		0x1764
 
-static const char *pmc_lpm_modes[] = {
-	"S0i2.0",
-	"S0i2.1",
-	"S0i2.2",
-	"S0i3.0",
-	"S0i3.1",
-	"S0i3.2",
-	"S0i3.3",
-	"S0i3.4",
-	NULL
-};
+extern const char *pmc_lpm_modes[];
 
 struct pmc_bit_map {
 	const char *name;
@@ -346,6 +336,7 @@ struct pmc_dev {
 	void (*core_configure)(struct pmc_dev *pmcdev);
 };
 
+extern const struct pmc_bit_map msr_map[];
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
 void icl_core_init(struct pmc_dev *pmcdev);
-- 
2.25.1

