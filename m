Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932287305E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbjFNRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjFNRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:18:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF42711;
        Wed, 14 Jun 2023 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686763092; x=1718299092;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KXze/yHtvX8i/7X5EL5m/NQ2O8y/9NNPJ8Ex4fgi0dY=;
  b=SYjXOEJZ3mNtMYrfxdgKdD47dZU9oTTd57WxTsL6c38W3vmEtzsxzLcW
   zpsWbMhWBnVZaGfOmo91g/xNhi6bBMZKFP0isVQ/XqKvtY2VpY1QYNGtA
   ku64g3KczwW3sY+hHnLpJz9wTHV2wxENclm+kXepdmXAvZvFHnXbOpbu9
   JsGVu/aWqR4CpEOq3+j8qjFAxo0AvPdfpmap/zINn5eKRUfcv/Ga2ZoC1
   3xUNC64+Dedf9B9g/6vw48HC5crXDr/OOMLWput2tr6egs3ezblrzKEXZ
   ChYi9J8BZ3Yt9rSF+AZkUJjbuR7LggVhWGSIWIYE+d7BilEGL8N3OFlcD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362054380"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362054380"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662470742"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="662470742"
Received: from mahbubu1-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.44.245])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:18:09 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Wed, 14 Jun 2023 11:17:42 -0600
Subject: [PATCH v4 3/4] tools/testing/cxl: Use named effects for the
 Command Effect Log
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v4-3-c6265bd7343b@intel.com>
References: <20230602-vv-fw_update-v4-0-c6265bd7343b@intel.com>
In-Reply-To: <20230602-vv-fw_update-v4-0-c6265bd7343b@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2945;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=KXze/yHtvX8i/7X5EL5m/NQ2O8y/9NNPJ8Ex4fgi0dY=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCmd3/xb9q61P2gwZ0l10aL+g9tfz7v0qP78WkaZv2vkn
 s0Ib3b70VHKwiDGxSArpsjyd89HxmNy2/N5AhMcYeawMoEMYeDiFICJLJFn+Cu0/U2G9P5PrXI+
 jTFKa8R9N3qanVyb8LRmf9DnSXpaqyIY/pek6em/v3unTuWQ1QWD8iVTzvGv3SkeNVHywh7fcwk
 9/bwA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

