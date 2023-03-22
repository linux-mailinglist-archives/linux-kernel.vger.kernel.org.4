Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D916C4035
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjCVCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCVCMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:12:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57015A1B4;
        Tue, 21 Mar 2023 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679451151; x=1710987151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bx5UzUKl047tv8KD71htOdRpfAR/w5OkFPahmHxcAs4=;
  b=Wxanfj/VahLySig6Q5ja5Qp7Uf5TRfi/RJz9nt7ICi00FtJudFLZkYuV
   KzW6ICCErfVREvYcbuPvq4+7LqltsULMX/YMNUoGodB7np0iawcniUjo3
   iqaHzLMeM7iJQYtGI9t8Cq1kNx1fxOLXj4JQALZBx09KfsqoRBFheILGk
   lUghLbuYrp0ycf0Gyi8Ue7/07IxqT886lvuFIushg97vxp/Vqw41K5W/b
   qUhYtJbpakchaL+oeAarTzpfOty/9vPtl0CWv6IuA1/kgILEfb4P4hJAM
   WuM8I2qHRONod9YXLpbzbFyTldnOU3A0Lk71mR7p4KnYC2OZQ3fCypzLw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322949650"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322949650"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="805663252"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="805663252"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.21.85])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:12:29 -0700
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
Subject: [PATCH v10 6/6] tools/testing/cxl: Mock support for Get Poison List
Date:   Tue, 21 Mar 2023 19:12:19 -0700
Message-Id: <bac0ec2f8afdb0c28790b1595af49ac6fada0672.1679448904.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679448904.git.alison.schofield@intel.com>
References: <cover.1679448904.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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

