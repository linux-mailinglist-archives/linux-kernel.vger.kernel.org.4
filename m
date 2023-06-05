Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867EE72311D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjFEUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjFEUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:20:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5696CE49;
        Mon,  5 Jun 2023 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996454; x=1717532454;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=n4j/XZl+PPPV6uJ0tCXctxrlIofbKWp/qosTAht8r6c=;
  b=kwHQBReiUL+Wr9yQ2+xfZvYAw9INB6qzi33aK9ylRJGkbdMQYIzMbHBL
   v7jETbkckZKW9I7mmJHawcO1tbRp/mQC6acwFMaCvZFjgryDi4Znsua1V
   s5m7TnWR4lKrhl7K0Z494E7lOlVUcCVdfvz1dulR/yGsMdeq9le6f9AYl
   59GQimojyqm1zqWRBriIywYHYIe9GVQNCqtyD7eqxPDDE1qtTSc2HkMhm
   U4bE15wNSsQNhAO3GtquLEEbfhHt0eGuF6U4KBQuKpbBHZcj1fNyD9M8s
   VWpZMqcxekiD9QvtC6ISlx4LthSg/v2N/SZ4PONdW1n0ObngDBRyg/ThA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336093134"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="336093134"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="832934195"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="832934195"
Received: from kmsalzbe-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.52.9])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:51 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 05 Jun 2023 14:20:24 -0600
Subject: [PATCH v2 3/4] tools/testing/cxl: Use named effects for the
 Command Effect Log
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-vv-fw_update-v2-3-e9e5cd5adb44@intel.com>
References: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
In-Reply-To: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=n4j/XZl+PPPV6uJ0tCXctxrlIofbKWp/qosTAht8r6c=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCl1zoscGn/vLPDTf2389OtbgV06Auv+qBZxWW14Hb9x2
 ZfmulknOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRosUM/+Nuf877wZs99fWf
 At2tE4RP/frH9/j9ye0G9Ysu832Tn3GQ4X/gx2Py6uqsuYffntt1ufihj2j2Bk2p6pq6NN3q0PL
 f/awA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As more emulated mailbox commands are added to cxl_test, it is a pain
point to look up command effect numbers for each effect. Replace the
bare numbers in the mock driver with an enum that lists all possible
effects.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
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

