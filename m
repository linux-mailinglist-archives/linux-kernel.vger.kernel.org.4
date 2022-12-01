Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7D63F1F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiLANtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLANtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:49:02 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8DF1D33C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:49:01 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B15l1vA016609;
        Thu, 1 Dec 2022 07:48:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=UDUObvTRaFOUdD9rv8GBXPx2j6+kC61QN/WmZ7u8zjc=;
 b=q+T7YibByzd765Cy9Tf6/b7PaEDV5TokX6BcNq0l2al3IS8SoLTy4Rr+G7C29DGNDZD3
 StoDnLZK4PcPNMtCt2rhxmZXCcFQO94zjzSpWS8SXFQoFPbHegfI/3HBgaGLo1MLZm+F
 eAbJOX166t0FuR93mhtE8aMdf+h2Zv8ETIH7TLSBqAIuH+Pe9DFMjM0/ZisjATBIMpi2
 eV7n8GhAQLajEDYIn0aiGkFdf4L5FBP+a07/OUIARZWhnULLOMWx46elWndHIq9A1Zqb
 VQzcYve9BfOLMqPQVsU3j8r0P4zysJgL+sZbz3ZNvzlFeLsJfb4V9sX75gAWmRnXUanI 4Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k75rhqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 07:48:48 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 1 Dec
 2022 07:48:45 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 1 Dec 2022 07:48:45 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D93F1B12;
        Thu,  1 Dec 2022 13:48:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/3] soundwire: cadence: Don't overflow the command FIFOs
Date:   Thu, 1 Dec 2022 13:48:43 +0000
Message-ID: <20221201134845.4055907-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201134845.4055907-1-rf@opensource.cirrus.com>
References: <20221201134845.4055907-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lr2PW5dGGM8nM_Q84jPzwDLaJ1nemvP8
X-Proofpoint-GUID: lr2PW5dGGM8nM_Q84jPzwDLaJ1nemvP8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command FIFOs are 8 entries long, so change CDNS_MCP_CMD_LEN to 8.

CDNS_MCP_CMD_LEN was originally 32, which would lead to cdns_xfer_msg()
writing up to 32 commands into the FIFO, so any message longer than 8
commands would fail.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2f52a5177caa ("soundwire: cdns: Add cadence library")
---
 drivers/soundwire/cadence_master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index a1de363eba3f..27699f341f2c 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -127,7 +127,8 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 
 #define CDNS_MCP_CMD_BASE			0x80
 #define CDNS_MCP_RESP_BASE			0x80
-#define CDNS_MCP_CMD_LEN			0x20
+/* FIFO can hold 8 commands */
+#define CDNS_MCP_CMD_LEN			8
 #define CDNS_MCP_CMD_WORD_LEN			0x4
 
 #define CDNS_MCP_CMD_SSP_TAG			BIT(31)
-- 
2.30.2

