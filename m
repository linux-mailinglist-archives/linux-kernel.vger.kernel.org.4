Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5263F1FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiLANtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiLANtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:49:05 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459D91AF01
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:49:03 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B15l1vC016609;
        Thu, 1 Dec 2022 07:48:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Sq7aVdOUXhv799GASybDC0oDppsFxEeabLuPhpHwJW0=;
 b=e+C5tD/EoW0mAzWlfnqJ6/Ne5Q24vNzUPJdGbKt7anCO7HW3HldpKtfQ++3FIxjV8J0M
 OwAuf25tJjinl0Td8ldA0kKN3MxFjZrFPzMTqVBncS2Qy8gMcZIn0p4ooVmqE+Eg1yQ1
 6wzkJ2th/lAQk7BeDePuSlbsGfiDv/zWsTSGDijQt/wh+Ril0qny4bmQBUcchM7JP1uf
 M9Y06VVwdxiPNea3LIeyFqFDmgBDVOr4G9SLM3pCnqPgQt95q6cdzcq2ZZ6/1z3p/jle
 W7LfyQUrEu+iU5wGAaRDxmTloeDJ/rQrpS7MPIqZSZLjuv5mZsgpgcSWY0r+sOWkWuHz cA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k75rhqm-3
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EC48DB2F;
        Thu,  1 Dec 2022 13:48:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] soundwire: cadence: Remove wasted space in response_buf
Date:   Thu, 1 Dec 2022 13:48:44 +0000
Message-ID: <20221201134845.4055907-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201134845.4055907-1-rf@opensource.cirrus.com>
References: <20221201134845.4055907-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gNFKnIwsnYaYG1Uc5sYyKBgrGUK914N_
X-Proofpoint-GUID: gNFKnIwsnYaYG1Uc5sYyKBgrGUK914N_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The response_buf was declared much larger (128 entries) than the number
of responses that could ever be written into it (maximum 8).

Reduce response_buf to 8 entries and add checking in cdns_read_response()
to prevent overflowing reponse_buf if CDNS_MCP_RX_FIFO_AVAIL contains
an unexpectedly large number.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/cadence_master.c | 6 ++++++
 drivers/soundwire/cadence_master.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 27699f341f2c..95c84d9f0775 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -774,8 +774,14 @@ static void cdns_read_response(struct sdw_cdns *cdns)
 	u32 num_resp, cmd_base;
 	int i;
 
+	BUILD_BUG_ON(ARRAY_SIZE(cdns->response_buf) < CDNS_MCP_CMD_LEN);
+
 	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
 	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
+	if (num_resp > ARRAY_SIZE(cdns->response_buf)) {
+		dev_warn(cdns->dev, "RX AVAIL %d too long\n", num_resp);
+		num_resp = CDNS_MCP_CMD_LEN;
+	}
 
 	cmd_base = CDNS_MCP_CMD_BASE;
 
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 0434d70d4b1f..c2d817e8e22a 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -117,7 +117,7 @@ struct sdw_cdns {
 	struct sdw_bus bus;
 	unsigned int instance;
 
-	u32 response_buf[0x80];
+	u32 response_buf[8];
 	struct completion tx_complete;
 	struct sdw_defer *defer;
 
-- 
2.30.2

