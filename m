Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E25B8C68
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiINQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiINQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:03:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103165660
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:03:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDgEGH005943;
        Wed, 14 Sep 2022 11:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Pgl4azxf90HlSnGT8l1UNSDlf+sSOeBJVYvFNp1rmXo=;
 b=oVmM4umexWUUdAx1RKQXKuDoLsOHFuyRtfw+INigtXdkuwvl/xlj9WIbWzNSRmc2yxD4
 G8cvubXabj1pXUVv3K2aUmXvR760JQ3nuVqOun23lCro6H+NtG68irfDEaaTGdToC3A4
 nMLiVpCoplxLo8GqfWNjS+e3Xj1tIEZaynXMCPcCu+qPTsA2SmQw57pkRePQ06jnHRLI
 MKynTNNfa/S3ZvAj5GngcNXlLeYTZsUowyrxwESV31ylHltLboi4UZEsFS5IWX4hJvdc
 1MHcViVVLTO8GkfgYwbVBBSSLGaFmHq+zs28/P82lR17eeDiiW/BZzDiV0+XkHLEI/VV Rg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05h8em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 11:02:57 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 11:02:55 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Wed, 14 Sep 2022 11:02:55 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 98ABE46C;
        Wed, 14 Sep 2022 16:02:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 1/5] soundwire: cadence: fix updating slave status when a bus has multiple peripherals
Date:   Wed, 14 Sep 2022 17:02:44 +0100
Message-ID: <20220914160248.1047627-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914160248.1047627-1-rf@opensource.cirrus.com>
References: <20220914160248.1047627-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jBAIM2RRWvGi9lof-wrrAS-KB07Ecdys
X-Proofpoint-ORIG-GUID: jBAIM2RRWvGi9lof-wrrAS-KB07Ecdys
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The cadence IP explicitly reports slave status changes with bits for
each possible change. The function cdns_update_slave_status() attempts
to translate this into the current status of each of the slaves.

However when there are multiple peripherals on a bus any slave that did
not have a status change when the work function ran would not have it's
status updated - the array is initialised to a value that equates to
UNATTACHED and this can cause spurious reports that slaves had dropped
off the bus.

In the case where a slave has no status change or has multiple status
changes the value from the last PING command is used.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 57 +++++++++++++-----------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4fbb19557f5e..245191d22ccd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -782,6 +782,7 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	bool is_slave = false;
 	u32 mask;
+	u32 val;
 	int i, set_status;
 
 	memset(status, 0, sizeof(status));
@@ -789,41 +790,38 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
 		mask = (slave_intstat >> (i * CDNS_MCP_SLAVE_STATUS_NUM)) &
 			CDNS_MCP_SLAVE_STATUS_BITS;
-		if (!mask)
-			continue;
 
-		is_slave = true;
 		set_status = 0;
 
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_RESERVED) {
-			status[i] = SDW_SLAVE_RESERVED;
-			set_status++;
-		}
-
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_ATTACHED) {
-			status[i] = SDW_SLAVE_ATTACHED;
-			set_status++;
-		}
+		if (mask) {
+			is_slave = true;
 
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_ALERT) {
-			status[i] = SDW_SLAVE_ALERT;
-			set_status++;
-		}
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_RESERVED) {
+				status[i] = SDW_SLAVE_RESERVED;
+				set_status++;
+			}
 
-		if (mask & CDNS_MCP_SLAVE_INTSTAT_NPRESENT) {
-			status[i] = SDW_SLAVE_UNATTACHED;
-			set_status++;
-		}
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_ATTACHED) {
+				status[i] = SDW_SLAVE_ATTACHED;
+				set_status++;
+			}
 
-		/* first check if Slave reported multiple status */
-		if (set_status > 1) {
-			u32 val;
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_ALERT) {
+				status[i] = SDW_SLAVE_ALERT;
+				set_status++;
+			}
 
-			dev_warn_ratelimited(cdns->dev,
-					     "Slave %d reported multiple Status: %d\n",
-					     i, mask);
+			if (mask & CDNS_MCP_SLAVE_INTSTAT_NPRESENT) {
+				status[i] = SDW_SLAVE_UNATTACHED;
+				set_status++;
+			}
+		}
 
-			/* check latest status extracted from PING commands */
+		/*
+		 * check that there was a single reported Slave status and when
+		 * there is not use the latest status extracted from PING commands
+		 */
+		if (set_status != 1) {
 			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
 			val >>= (i * 2);
 
@@ -842,11 +840,6 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 				status[i] = SDW_SLAVE_RESERVED;
 				break;
 			}
-
-			dev_warn_ratelimited(cdns->dev,
-					     "Slave %d status updated to %d\n",
-					     i, status[i]);
-
 		}
 	}
 
-- 
2.30.2

