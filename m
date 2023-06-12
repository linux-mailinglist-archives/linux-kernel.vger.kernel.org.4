Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3072BB37
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjFLIwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjFLIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:52:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFBFF5;
        Mon, 12 Jun 2023 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686559919; x=1718095919;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BBNfgqMFEu4CiWW3ME2sbOa4pebMX/L9DdT2Ta8fw7M=;
  b=R7m5X6l8xhRnhtAiBoIpO3j/TET9FiPUwaqt9rWG96aPZ3rT8ieJntfw
   eCOWiFHycj7XvYkuXTqwmgozJ+CmLTlZ0r2muzsiJdEUG60bxQxTZb/OI
   yxYVDKr3Gf2Dxw79hhZnNnghuM9WHzB0+HLnRk6+B49r+TIFIyH/OOKO3
   tRcVI1OfL2E6wvhqLajd6cYQZJNBExQ6B3hyyjwbmqf+cAR1XOSviVZl1
   InlljC/8kiy8/xUW/BKMCQh5rR3E6ixcHrG2bowJldG3msoZsHxNNlgHh
   2yiKFAmFOdmwx4cx46yWWEl2IEe4K3e2KEehpwwy3vLsl/4Kaoei013mo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347613312"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347613312"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="835365321"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835365321"
Received: from apeer-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.251.3.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:22 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 12 Jun 2023 00:55:58 -0600
Subject: [PATCH v3 3/4] tools/testing/cxl: Use named effects for the
 Command Effect Log
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v3-3-869f82069c95@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
In-Reply-To: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=2897;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=BBNfgqMFEu4CiWW3ME2sbOa4pebMX/L9DdT2Ta8fw7M=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCltB6dsaF86s+oyV9GEmSaL+F/b7lrn8+zKz0svP3pXi
 C1VzLCt7yhlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBEhJsY/gewfjq3gdFqxx6v
 3j/SU15u81KffXDN9H+zw2beqrFPrXdkZJil9vCW99323duP+yztmrf6yT+5Wbk+BXoPvrqW/3t
 cHMQOAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As more emulated mailbox commands are added to cxl_test, it is a pain
point to look up command effect numbers for each effect. Replace the
bare numbers in the mock driver with an enum that lists all possible
effects.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 403cd3608772..68668d8df1cd 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -21,42 +21,56 @@
 
 static unsigned int poison_inject_dev_max = MOCK_INJECT_DEV_MAX;
 
+enum cxl_command_effects {
+	CONF_CHANGE_COLD_RESET = 0,
+	CONF_CHANGE_IMMEDIATE,
+	DATA_CHANGE_IMMEDIATE,
+	POLICY_CHANGE_IMMEDIATE,
+	LOG_CHANGE_IMMEDIATE,
+	SECURITY_CHANGE_IMMEDIATE,
+	BACKGROUND_OP,
+	SECONDARY_MBOX_SUPPORTED,
+};
+
+#define CXL_CMD_EFFECT_NONE cpu_to_le16(0)
+
 static struct cxl_cel_entry mock_cel[] = {
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
-		.effect = cpu_to_le16(0),
+		.effect = CXL_CMD_EFFECT_NONE,
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_IDENTIFY),
-		.effect = cpu_to_le16(0),
+		.effect = CXL_CMD_EFFECT_NONE,
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_LSA),
-		.effect = cpu_to_le16(0),
+		.effect = CXL_CMD_EFFECT_NONE,
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_PARTITION_INFO),
-		.effect = cpu_to_le16(0),
+		.effect = CXL_CMD_EFFECT_NONE,
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
-		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE) |
+				      EFFECT(DATA_CHANGE_IMMEDIATE)),
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
-		.effect = cpu_to_le16(0),
+		.effect = CXL_CMD_EFFECT_NONE,
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
-		.effect = cpu_to_le16(0),
+		.effect = CXL_CMD_EFFECT_NONE,
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
-		.effect = cpu_to_le16(EFFECT(2)),
+		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
 	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
-		.effect = cpu_to_le16(EFFECT(2)),
+		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE)),
 	},
 };
 

-- 
2.40.1

