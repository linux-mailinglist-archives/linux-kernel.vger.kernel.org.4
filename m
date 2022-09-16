Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD45BABB6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIPKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiIPKxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:53:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F940AFADC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:36:23 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G4mEDq002644;
        Fri, 16 Sep 2022 05:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=06y84B2zg0NNkNS46/H8foYFWp+a7npO/FgDpA0VjSI=;
 b=QlEdKJm1iEg7YrzEZfvOTR8YIEt7t9j/H9G1AGEHZg2TzLHknv9/WV9lawmTN22zkL+x
 3q4+JTVixXuD3UYCJQ7jjKBVEPzPiGug/S53hN7Xu3YGpSHq78IH11uw/lYSCYUE9p/e
 V3Z1KgfWUnXjPdca2RzcP40Kdm3142fFxBRAER3G7yx+sG06pJDcEPhk585lc1No1rSL
 2wpHGEdG4gOZkY0jn62JSS+qtTahcfM7t6E7dEzh4+uQpWrpXd1llPShgudtfGiISYy9
 AroHzWHs9f/we6tYB0q6ciNeOUrHwz4I8VMY8/3SzNFmP/iAF3vdg/wPZrCd37NSpS1w NQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jm92qgycb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 05:35:13 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Fri, 16 Sep
 2022 05:35:11 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Fri, 16 Sep 2022 05:35:11 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 03BF7468;
        Fri, 16 Sep 2022 10:35:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] soundwire: cadence: Don't overwrite msg->buf during write commands
Date:   Fri, 16 Sep 2022 11:35:05 +0100
Message-ID: <20220916103505.1562210-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SSj2ik-bRFGeaMqKbQA7NedWI_lObQKm
X-Proofpoint-ORIG-GUID: SSj2ik-bRFGeaMqKbQA7NedWI_lObQKm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buf passed in struct sdw_msg must only be written for a READ,
in that case the RDATA part of the response is the data value of the
register.

For a write command there is no RDATA, and buf should be assumed to
be const and unmodifable. The original caller should not expect its data
buffer to be corrupted by an sdw_nwrite().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/cadence_master.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index be9cd47f31ec..3ef472049980 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -544,9 +544,12 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
 		return SDW_CMD_IGNORED;
 	}
 
-	/* fill response */
-	for (i = 0; i < count; i++)
-		msg->buf[i + offset] = FIELD_GET(CDNS_MCP_RESP_RDATA, cdns->response_buf[i]);
+	if (msg->flags == SDW_MSG_FLAG_READ) {
+		/* fill response */
+		for (i = 0; i < count; i++)
+			msg->buf[i + offset] = FIELD_GET(CDNS_MCP_RESP_RDATA,
+							 cdns->response_buf[i]);
+	}
 
 	return SDW_CMD_OK;
 }
-- 
2.30.2

