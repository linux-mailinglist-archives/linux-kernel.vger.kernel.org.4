Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9426151FD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKATLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKATKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A11E3FC;
        Tue,  1 Nov 2022 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329854; x=1698865854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b1LAhIocLucoL1ImscGJbvcIGzaRlOd5dHOoHc/QWNI=;
  b=W8msGmwLT1kl1wPRsOdv059I6vaAl6f2A6gfBTkWSwZWSvZJLoo5YVAr
   7rX9QmhIPcrPnUzzf3wf3sfMbQKD+w8Vi0mjcQO/MB4N5z4QPCbSOlj60
   uBgZQTNaPJMqKKfcuznp3DJstR4coq656sGU0KyiUJTZUy0H+598Qhgrf
   bDEnPB325crZCJiU0YtyKMf/liZo3YFn0vDTrojBUrURJkgBQtXoQFkEd
   WN9giVhfykA46R/txz/g9lpSS39d2GmG2JaXIiv+/Yj683AQeeJ4watot
   lgFuClu3GyKDqd03UoRsKjBA1+qrJsEzJUDJjtFVkhTToi2CVkuVhJf2Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395531251"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="395531251"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="759278176"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="759278176"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2022 12:10:27 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 38D9D580DBC;
        Tue,  1 Nov 2022 12:10:27 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] tools/arch/x86: intel_sdsi: Read more On Demand registers
Date:   Tue,  1 Nov 2022 12:10:21 -0700
Message-Id: <20221101191023.4150315-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add decoding of the following On Demand register fields:

1. NVRAM content authorization error status
2. Enabled features: telemetry and attestation
3. Key provisioning status
4. NVRAM update limit
5. PCU_CR3_CAPID_CFG

Link: https://github.com/intel/intel-sdsi/blob/master/state-certificate-encoding.rst

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 50 +++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 3718bd0c05cb..01b5f9994e11 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -44,10 +44,28 @@
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
 
+struct nvram_content_auth_err_sts {
+	uint64_t reserved:3;
+	uint64_t sdsi_content_auth_err:1;
+	uint64_t reserved1:1;
+	uint64_t sdsi_metering_auth_err:1;
+	uint64_t reserved2:58;
+};
+
 struct enabled_features {
 	uint64_t reserved:3;
 	uint64_t sdsi:1;
-	uint64_t reserved1:60;
+	uint64_t reserved1:8;
+	uint64_t attestation:1;
+	uint64_t reserved2:13;
+	uint64_t metering:1;
+	uint64_t reserved3:37;
+};
+
+struct key_provision_status {
+	uint64_t reserved:1;
+	uint64_t license_key_provisioned:1;
+	uint64_t reserved2:62;
 };
 
 struct auth_fail_count {
@@ -65,15 +83,23 @@ struct availability {
 	uint64_t reserved2:10;
 };
 
+struct nvram_update_limit {
+	uint64_t reserved:12;
+	uint64_t sdsi_50_pct:1;
+	uint64_t sdsi_75_pct:1;
+	uint64_t sdsi_90_pct:1;
+	uint64_t reserved2:49;
+};
+
 struct sdsi_regs {
 	uint64_t ppin;
-	uint64_t reserved;
+	struct nvram_content_auth_err_sts auth_err_sts;
 	struct enabled_features en_features;
-	uint64_t reserved1;
+	struct key_provision_status key_prov_sts;
 	struct auth_fail_count auth_fail_count;
 	struct availability prov_avail;
-	uint64_t reserved2;
-	uint64_t reserved3;
+	struct nvram_update_limit limits;
+	uint64_t pcu_cr3_capid_cfg;
 	uint64_t socket_id;
 };
 
@@ -205,8 +231,18 @@ static int sdsi_read_reg(struct sdsi_dev *s)
 	printf("Socket information for device %s\n", s->dev_name);
 	printf("\n");
 	printf("PPIN:                           0x%lx\n", s->regs.ppin);
+	printf("NVRAM Content Authorization Error Status\n");
+	printf("    SDSi Auth Err Sts:          %s\n", !!s->regs.auth_err_sts.sdsi_content_auth_err ? "Error" : "Okay");
+
+	if (!!s->regs.en_features.metering)
+		printf("    Metering Auth Err Sts:      %s\n", !!s->regs.auth_err_sts.sdsi_metering_auth_err ? "Error" : "Okay");
+
 	printf("Enabled Features\n");
 	printf("    On Demand:                  %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
+	printf("    Attestation:                %s\n", !!s->regs.en_features.attestation ? "Enabled" : "Disabled");
+	printf("    On Demand:                  %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
+	printf("    Metering:                   %s\n", !!s->regs.en_features.metering ? "Enabled" : "Disabled");
+	printf("License Key (AKC) Provisioned:  %s\n", !!s->regs.key_prov_sts.license_key_provisioned ? "Yes" : "No");
 	printf("Authorization Failure Count\n");
 	printf("    AKC Failure Count:          %d\n", s->regs.auth_fail_count.key_failure_count);
 	printf("    AKC Failure Threshold:      %d\n", s->regs.auth_fail_count.key_failure_threshold);
@@ -215,6 +251,10 @@ static int sdsi_read_reg(struct sdsi_dev *s)
 	printf("Provisioning Availability\n");
 	printf("    Updates Available:          %d\n", s->regs.prov_avail.available);
 	printf("    Updates Threshold:          %d\n", s->regs.prov_avail.threshold);
+	printf("NVRAM Udate Limit\n");
+	printf("    50%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_50_pct ? "Yes" : "No");
+	printf("    75%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_75_pct ? "Yes" : "No");
+	printf("    90%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_90_pct ? "Yes" : "No");
 	printf("Socket ID:                      %ld\n", s->regs.socket_id & 0xF);
 
 	return 0;
-- 
2.25.1

