Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E026D6B4FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjCJR5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCJR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:56:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94456134831;
        Fri, 10 Mar 2023 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678470968; x=1710006968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vkJ1gJmE+nX0k0RDJxr3koG2zAk0rxfEp3qrjnGSjh8=;
  b=MAnHvaBmuCMWjaLG+vlk5T+EfnlLGc68rPBfoLBmMNtwwu5umkIQTSMH
   8kcY+ftpgs2wivJVKzorf/xfiJHE/kvI5xnQs9U4NTZGkhBmZtIhq+G+i
   MToYSadTlyP/0h62hTVelgynPhP4TFLCC+MOSe4rT7wOPQ9vrd2APtod9
   4cr5pXCRGMdVsebP5Qsk/jDubJt5/ncypy0fblbGm2DEX0qNosNjegOBV
   BXQk3U0YsncFClCEYQsa58z3Hn9j2e7m8mb1QzEz1JRM+JH8nEBtfZXe+
   5wvognIm3A1WW3jvB5czuEj8lZ8Y3xSDsuk2oE2o2SpAOs0rVrLomYmVe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="334266207"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="334266207"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:55:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="852008219"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="852008219"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.255.228.62])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:54:32 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 6/6] tools/testing/cxl: Mock support for Get Poison List
Date:   Fri, 10 Mar 2023 09:54:20 -0800
Message-Id: <2d36d28755beda9d941301fa63da97b525203d7a.1678468593.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1678468593.git.alison.schofield@intel.com>
References: <cover.1678468593.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Make mock memdevs support the Get Poison List mailbox command.
Return a fake poison error record when the get poison list command
is issued.

This supports testing the kernel tracing and cxl list capabilities
for media errors.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/testing/cxl/test/mem.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9263b04d35f7..2fa9c18d4c2c 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/bits.h>
+#include <asm/unaligned.h>
 #include <cxlmem.h>
 
 #include "trace.h"
@@ -40,6 +41,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -471,6 +476,8 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
 	};
 
+	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
+
 	if (cmd->size_out < sizeof(id))
 		return -EINVAL;
 
@@ -888,6 +895,34 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static int mock_get_poison(struct cxl_dev_state *cxlds,
+			   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
+
+	/* Mock one poison record at pi.offset for 64 bytes */
+	struct {
+		struct cxl_mbox_poison_payload_out po;
+		struct cxl_poison_record record;
+	} __packed mock_plist = {
+		.po = {
+			.count = cpu_to_le16(1),
+		},
+		.record = {
+			.length = cpu_to_le32(1),
+			.address = cpu_to_le64(le64_to_cpu(pi->offset) +
+					       CXL_POISON_SOURCE_INJECTED),
+		},
+	};
+
+	if (cmd->size_out < sizeof(mock_plist))
+		return -EINVAL;
+
+	memcpy(cmd->payload_out, &mock_plist, sizeof(mock_plist));
+	cmd->size_out = sizeof(mock_plist);
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
@@ -942,6 +977,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
 		rc = mock_passphrase_secure_erase(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_POISON:
+		rc = mock_get_poison(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1010,6 +1048,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = cxl_poison_state_init(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_dev_state_identify(cxlds);
 	if (rc)
 		return rc;
-- 
2.37.3

