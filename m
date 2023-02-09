Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F28691492
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjBIXgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjBIXfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:35:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68176F201;
        Thu,  9 Feb 2023 15:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675985712; x=1707521712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XCVgqF8shH5rFyH7hk0Emjtujq62iDahDM3kYDntmz4=;
  b=HvkrHeTa4VBHBXazw+WB9hly1+XkQGAY3hnHhnLC0o4Yjd1ti+qLFq6Q
   lYsfOfqS0jmhu5lj3PZZreN+439RfPPCMjY9aLaABoXB0niUYWaB+gINV
   gG2rTnA47I965A81UueXJMP7T7nJ0Hqdp5uqoaOh78WxKIOeA1IjoFclf
   E03hFiy7cxeCfDPSjXZpAHw3C4XGUhq9kjBvlzc5qEXgBWu4HaUtE6D1Q
   uuNFXh7d6bhIX+YTY+ZY/RAeYH2FTFyIfMBHd62K25RUAzXzVF6w/fpMY
   4hAtDyd8PWS9A/lIXSMQ+9HvjMvIo07frg+2+7gbT8LjyhVeRArEEjbPr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416508753"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416508753"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756592054"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756592054"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.13.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:11 -0800
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
Subject: [PATCH v6 6/6] tools/testing/cxl: Mock support for Get Poison List
Date:   Thu,  9 Feb 2023 15:32:59 -0800
Message-Id: <26eb1ac9b8d6e7ff969537e29812d9e2d007632a.1675983077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1675983077.git.alison.schofield@intel.com>
References: <cover.1675983077.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
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

