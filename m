Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C87664E2F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLOVSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLOVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:18:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF10059156;
        Thu, 15 Dec 2022 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671139082; x=1702675082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMyW+MRrTkyrFYxqA8ddxUtmVsGx3eQy/KpbR7JQwsM=;
  b=ML/SC9j8yESPMBrCWSBXWpVmdnBqctYbcUZOZvfrLNmDjoe5LqiN2aB9
   f7oCDe7pANAoXNLboFh+ouaCHQEA6bNLJPZWjkKGWw/JuyLbk+PXa4qUI
   CJv1DcvLiJIvzz5hyklkqZyXxE6ZswvOekkUMBZaCyLj0A9s6rmUmh5ak
   dx4wesNTlYeKIbrb9v+Jk6sn+xicolG9Dl71LvBZNMaj6z4XSymtckXW0
   ZgPEJ7XDO6uYogjaZjWQn9hWhuA0JJd6D1uyb4WHGBZe5kzfdhlhuCznW
   zXbGRGpTP/CiEoP3R44mMmyJQEU2yJT721jAbm+zpYQ9BurzRomn5VyN5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="302230315"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="302230315"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649570089"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="649570089"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.178])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:53 -0800
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
Subject: [PATCH v4 5/5] tools/testing/cxl: Mock support for Get Poison List
Date:   Thu, 15 Dec 2022 13:17:47 -0800
Message-Id: <c4117df0cc50b10f204827d0d2df84aae9d760cd.1671135967.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1671135967.git.alison.schofield@intel.com>
References: <cover.1671135967.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 5e4ecd93f1d2..9bbbad083ede 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/bits.h>
+#include <asm/unaligned.h>
 #include <cxlmem.h>
 
 #define LSA_SIZE SZ_128K
@@ -38,6 +39,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
 		.effect = cpu_to_le16(0),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
+		.effect = cpu_to_le16(0),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -141,6 +146,8 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
 	};
 
+	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
+
 	if (cmd->size_out < sizeof(id))
 		return -EINVAL;
 
@@ -558,6 +565,34 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
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
+	} mock_plist = {
+		.po = {
+			.count = cpu_to_le16(1),
+		},
+		.record = {
+			.length = cpu_to_le32(1),
+			.address = cpu_to_le64(pi->offset |
+					       CXL_POISON_SOURCE_INTERNAL),
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
@@ -606,6 +641,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
 		rc = mock_passphrase_secure_erase(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_GET_POISON:
+		rc = mock_get_poison(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
@@ -664,6 +702,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
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

