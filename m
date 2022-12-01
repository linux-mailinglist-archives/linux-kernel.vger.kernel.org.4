Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2AF63F1FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiLANtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLANtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:49:03 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C82E1DA5E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:49:02 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B15l1vB016609;
        Thu, 1 Dec 2022 07:48:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=O24ewM62YnyTshopgCFYg5eq7HQMvKb/cYKJclNcynE=;
 b=iH+D/pvM3F2HsdV3sbPIDmZMdTQM3pFHKpJq7eZLee9i/u69NRVObv1KHnylpXDx7ZW/
 a5L/fxVSe+Y+kfarQfLMGjWxx9iBQS5Ecn2cV7K56rtxnXRJW+gZVGMkupk/uhGNYsLa
 Y/uT/3a8xeao+GGcs2AcKo5xUUKE19Csjn+SE3s8JxYCLevaOqeqcuvATznVKDyhTfge
 Qdy3VYF+3Ww7kS5JxfbIjCZi2OZ1eALVSI9F8xk7xed3OoCyz9bmBKDEwvOCmMGoIlgK
 xci/82cGnKqQXRrPWNynyJLv6+A/ijbd9xAb3cyJs/3fKXH6VwlYbzKDDHf8H1i9Zves WQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k75rhqm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 07:48:50 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 1 Dec
 2022 07:48:46 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 1 Dec 2022 07:48:46 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0BCC4B38;
        Thu,  1 Dec 2022 13:48:46 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/3] soundwire: cadence: Drain the RX FIFO after an IO timeout
Date:   Thu, 1 Dec 2022 13:48:45 +0000
Message-ID: <20221201134845.4055907-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201134845.4055907-1-rf@opensource.cirrus.com>
References: <20221201134845.4055907-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0xpdTaddmfdlDdsnGRcbsX2iSErxeRUZ
X-Proofpoint-GUID: 0xpdTaddmfdlDdsnGRcbsX2iSErxeRUZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wait_for_completion_timeout() times-out in _cdns_xfer_msg() it
is possible that something could have been written to the RX FIFO.
In this case, we should drain the RX FIFO so that anything in it
doesn't carry over and mess up the next transfer.

Obviously, if we got to this state something went wrong, and we
don't really know the state of everything. The cleanup in this
situation cannot be bullet-proof but we should attempt to avoid
breaking future transaction, if only to reduce the amount of
error noise when debugging the failure from a kernel log.

Note that this patch only implements the draining for blocking
(non-deferred) transfers. The deferred API doesn't have any proper
handling of error conditions and would need some re-design before
implementing cleanup. That is a task for a separate patch...

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/cadence_master.c | 48 ++++++++++++++++--------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 95c84d9f0775..6bffecf3d61a 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -555,6 +555,28 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
 	return SDW_CMD_OK;
 }
 
+static void cdns_read_response(struct sdw_cdns *cdns)
+{
+	u32 num_resp, cmd_base;
+	int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cdns->response_buf) < CDNS_MCP_CMD_LEN);
+
+	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
+	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
+	if (num_resp > ARRAY_SIZE(cdns->response_buf)) {
+		dev_warn(cdns->dev, "RX AVAIL %d too long\n", num_resp);
+		num_resp = CDNS_MCP_CMD_LEN;
+	}
+
+	cmd_base = CDNS_MCP_CMD_BASE;
+
+	for (i = 0; i < num_resp; i++) {
+		cdns->response_buf[i] = cdns_readl(cdns, cmd_base);
+		cmd_base += CDNS_MCP_CMD_WORD_LEN;
+	}
+}
+
 static enum sdw_command_response
 _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 	       int offset, int count, bool defer)
@@ -596,6 +618,10 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 		dev_err(cdns->dev, "IO transfer timed out, cmd %d device %d addr %x len %d\n",
 			cmd, msg->dev_num, msg->addr, msg->len);
 		msg->len = 0;
+
+		/* Drain anything in the RX_FIFO */
+		cdns_read_response(cdns);
+
 		return SDW_CMD_TIMEOUT;
 	}
 
@@ -769,28 +795,6 @@ EXPORT_SYMBOL(cdns_read_ping_status);
  * IRQ handling
  */
 
-static void cdns_read_response(struct sdw_cdns *cdns)
-{
-	u32 num_resp, cmd_base;
-	int i;
-
-	BUILD_BUG_ON(ARRAY_SIZE(cdns->response_buf) < CDNS_MCP_CMD_LEN);
-
-	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
-	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
-	if (num_resp > ARRAY_SIZE(cdns->response_buf)) {
-		dev_warn(cdns->dev, "RX AVAIL %d too long\n", num_resp);
-		num_resp = CDNS_MCP_CMD_LEN;
-	}
-
-	cmd_base = CDNS_MCP_CMD_BASE;
-
-	for (i = 0; i < num_resp; i++) {
-		cdns->response_buf[i] = cdns_readl(cdns, cmd_base);
-		cmd_base += CDNS_MCP_CMD_WORD_LEN;
-	}
-}
-
 static int cdns_update_slave_status(struct sdw_cdns *cdns,
 				    u64 slave_intstat)
 {
-- 
2.30.2

