Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956D0630869
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiKSBX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKSBWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:22:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C07347315;
        Fri, 18 Nov 2022 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668817431; x=1700353431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uBqlisKs26ATJhIPFUU6cAt5vH5D3rY9J+8CYlHIE3E=;
  b=L0pPVpkTLjOMpUwS0DorrF8w5Vr+8KgS3DiUYN95pdSArDNSYwq6MpIR
   FoYzrSMmtRypZdvqKOPXiWlc1G4lxneM36EQX5TSke5ekeOP2HywvGemR
   3f5SE+6qnkzVSw0qxPFaOxyWKMUVfa2GGiKnUxtHWFxnuMJBt1/KCJPlG
   Wzgm22AKycQBdwHlqbKiyErmWaQ/dtrjHt4c4iBphM+ixzVAu1+N7rmlj
   EpE+HgY4/WraoXwgXfLKgqcpEpCeZwMKoHzmxSMJ4sjcXZNnd/UpQ7u86
   gHYs9kaS75rYJemrNh94gAjfm3O2DtICrB7xe7WpXDKO3/Sq94ZVYPwia
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="296629184"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="296629184"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746200849"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746200849"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2022 16:23:47 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id C798E580DFA;
        Fri, 18 Nov 2022 16:23:46 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 8/9] tools/arch/x86: intel_sdsi: Add support for new GUID
Date:   Fri, 18 Nov 2022 16:23:42 -0800
Message-Id: <20221119002343.1281885-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119002343.1281885-1-david.e.box@linux.intel.com>
References: <20221119002343.1281885-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
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

V2 - Add defines for GUID based register sizes and check for the expected
     size after reading the file. Removes previous FIXME.

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 36 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 01b5f9994e11..b42e1b6a6a1b 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -35,8 +35,10 @@
 #define SDSI_DEV		"intel_vsec.sdsi"
 #define AUX_DEV_PATH		"/sys/bus/auxiliary/devices/"
 #define SDSI_PATH		(AUX_DEV_DIR SDSI_DEV)
-#define GUID			0x6dd191
-#define REGISTERS_MIN_SIZE	72
+#define GUID_V1			0x6dd191
+#define REGS_SIZE_GUID_V1	72
+#define GUID_V2			0xF210D9EF
+#define REGS_SIZE_GUID_V2	80
 #define STATE_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
@@ -100,9 +102,17 @@ struct sdsi_regs {
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
 
@@ -146,7 +156,7 @@ struct sdsi_dev {
 	struct state_certificate sc;
 	char *dev_name;
 	char *dev_path;
-	int guid;
+	uint32_t guid;
 };
 
 enum command {
@@ -199,7 +209,7 @@ static int sdsi_update_registers(struct sdsi_dev *s)
 		return -1;
 	}
 
-	if (s->guid != GUID) {
+	if (s->guid != GUID_V1 && s->guid != GUID_V2) {
 		fprintf(stderr, "Unrecognized guid, 0x%x\n", s->guid);
 		fclose(regs_ptr);
 		return -1;
@@ -207,7 +217,8 @@ static int sdsi_update_registers(struct sdsi_dev *s)
 
 	/* Update register info for this guid */
 	ret = fread(&s->regs, sizeof(uint8_t), sizeof(s->regs), regs_ptr);
-	if (ret != sizeof(s->regs)) {
+	if ((s->guid == GUID_V1 && ret != REGS_SIZE_GUID_V1) ||
+	    (s->guid == GUID_V2 && ret != REGS_SIZE_GUID_V2)) {
 		fprintf(stderr, "Could not read 'registers' file\n");
 		fclose(regs_ptr);
 		return -1;
@@ -252,10 +263,13 @@ static int sdsi_read_reg(struct sdsi_dev *s)
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
2.34.1

