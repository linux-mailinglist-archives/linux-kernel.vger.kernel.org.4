Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240D76151F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKATLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKATKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205E1CB10;
        Tue,  1 Nov 2022 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329853; x=1698865853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O/S/QsYQFEc16tb+lsIX+I1kIQ7ZiqtVom56wMadWUw=;
  b=QLggou5E+XtCmjABTe4FfFR3evE61KL16DFgkhCuhAKrwSUEe4/2RmlG
   v1+95X0wQ35GPNXlS5tP7Fa5kDzHHtauO4m85NtRGGx+WLIR5rCFrGPw4
   cLE5gXK4+mSyqoLIQCArulf1CO8otHav0iIcL6cDLmNUmAzRnYPICNQxS
   gQU/fP9TWmrMP2+p+fQqU/BcqdfyCS0fXpBU1MjjFwiu3dQyogdWFKy2n
   XBfwL5hqsaiS6+7uXGAZvwjFsoUpuzwRopFlMH/m/4MhWYyl0J6pvyb2e
   tJ6tBbqzSBy5TdIxTYZk3Abl4ZrJTJOAp4oqLJr7sicO3m+/S/3SvN356
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="335892059"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="335892059"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="585114145"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="585114145"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2022 12:10:27 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 6739D580B9D;
        Tue,  1 Nov 2022 12:10:27 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] tools/arch/x86: intel_sdsi: Add support for new GUID
Date:   Tue,  1 Nov 2022 12:10:22 -0700
Message-Id: <20221101191023.4150315-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure and content of the On Demand registers is based on the GUID
which is read from hardware through sysfs. Add support for decoding the
registers of a new GUID 0xF210D9EF.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 32 ++++++++++++++++++--------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 01b5f9994e11..0680eda78b1a 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -35,7 +35,8 @@
 #define SDSI_DEV		"intel_vsec.sdsi"
 #define AUX_DEV_PATH		"/sys/bus/auxiliary/devices/"
 #define SDSI_PATH		(AUX_DEV_DIR SDSI_DEV)
-#define GUID			0x6dd191
+#define GUID_V1			0x6dd191
+#define GUID_V2			0xF210D9EF
 #define REGISTERS_MIN_SIZE	72
 #define STATE_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
@@ -100,9 +101,17 @@ struct sdsi_regs {
 	struct availability prov_avail;
 	struct nvram_update_limit limits;
 	uint64_t pcu_cr3_capid_cfg;
-	uint64_t socket_id;
+	union {
+		struct {
+			uint64_t socket_id;
+		} v1;
+		struct {
+			uint64_t reserved;
+			uint64_t socket_id;
+			uint64_t reserved2;
+		} v2;
+	} extra;
 };
-
 #define CONTENT_TYPE_LK_ENC		0xD
 #define CONTENT_TYPE_LK_BLOB_ENC	0xE
 
@@ -146,7 +155,7 @@ struct sdsi_dev {
 	struct state_certificate sc;
 	char *dev_name;
 	char *dev_path;
-	int guid;
+	uint32_t guid;
 };
 
 enum command {
@@ -199,7 +208,7 @@ static int sdsi_update_registers(struct sdsi_dev *s)
 		return -1;
 	}
 
-	if (s->guid != GUID) {
+	if (s->guid != GUID_V1 && s->guid != GUID_V2) {
 		fprintf(stderr, "Unrecognized guid, 0x%x\n", s->guid);
 		fclose(regs_ptr);
 		return -1;
@@ -207,7 +216,7 @@ static int sdsi_update_registers(struct sdsi_dev *s)
 
 	/* Update register info for this guid */
 	ret = fread(&s->regs, sizeof(uint8_t), sizeof(s->regs), regs_ptr);
-	if (ret != sizeof(s->regs)) {
+	if (ret > (int)sizeof(s->regs)) { /* FIXME: Check size by guid */
 		fprintf(stderr, "Could not read 'registers' file\n");
 		fclose(regs_ptr);
 		return -1;
@@ -252,10 +261,13 @@ static int sdsi_read_reg(struct sdsi_dev *s)
 	printf("    Updates Available:          %d\n", s->regs.prov_avail.available);
 	printf("    Updates Threshold:          %d\n", s->regs.prov_avail.threshold);
 	printf("NVRAM Udate Limit\n");
-	printf("    50%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_50_pct ? "Yes" : "No");
-	printf("    75%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_75_pct ? "Yes" : "No");
-	printf("    90%% Limit Reached:         %s\n", !!s->regs.limits.sdsi_90_pct ? "Yes" : "No");
-	printf("Socket ID:                      %ld\n", s->regs.socket_id & 0xF);
+	printf("    50%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_50_pct ? "Yes" : "No");
+	printf("    75%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_75_pct ? "Yes" : "No");
+	printf("    90%% Limit Reached:          %s\n", !!s->regs.limits.sdsi_90_pct ? "Yes" : "No");
+	if (s->guid == GUID_V1)
+		printf("Socket ID:                      %ld\n", s->regs.extra.v1.socket_id & 0xF);
+	else
+		printf("Socket ID:                      %ld\n", s->regs.extra.v2.socket_id & 0xF);
 
 	return 0;
 }
-- 
2.25.1

