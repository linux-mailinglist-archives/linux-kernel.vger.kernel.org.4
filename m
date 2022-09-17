Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616465BB934
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIQPtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 11:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIQPtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 11:49:53 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0BDFD3D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 08:49:51 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28HFmbdC028028;
        Sat, 17 Sep 2022 10:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=vJHaMLJvcCzzgtqNWiXZsB/9X6s3SfKiDcoQeDm4FFM=;
 b=bZ6olJVgI8XqZpFG5M1+zLqLGu31bSekptfqhHSvQGQumrFPJm7BLHXXA9rjjuGUg06V
 OnWi8XYDSncvf8QKEmJAb2KyJypcNJm1zM2HtU6bUCycXBe/nNjtTO7Rv3LKkYKLRxmf
 N3f2tu9qYhlBY5A8XD0fEjR0yuYDkh8btY/W3jl3Qfjt/2c1rvjzCbw/vWraEmdUBJVT
 hfSG5N6kE2ylGK7PDHIYt8T7303ZAI0N+eV+PzmSg8y7FVqdplkz5x8grWBU14KMhhuV
 ccwlBbXoZvSqKUUQPRL+pnCCYSm3D0+UqVjRaimJX0Eb0YliuI6UOncEETU+4dKm/Wu1 Tg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jnbn08bd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Sep 2022 10:48:37 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Sat, 17 Sep
 2022 10:48:35 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Sat, 17 Sep 2022 10:48:35 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.112])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 411482BA;
        Sat, 17 Sep 2022 15:48:35 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] soundwire: cadence: Simplify error paths in cdns_xfer_msg()
Date:   Sat, 17 Sep 2022 16:48:22 +0100
Message-ID: <20220917154822.690472-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220917154822.690472-1-rf@opensource.cirrus.com>
References: <20220917154822.690472-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VTRd6noz-XehbOX2jNDJSU56AgkzW945
X-Proofpoint-ORIG-GUID: VTRd6noz-XehbOX2jNDJSU56AgkzW945
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to goto an exit label to return from cdns_xfer_msg().
It doesn't do any cleanup, only a return statement.

Replace the gotos with returns.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/cadence_master.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 3543a923ee6b..30b8c628fdbd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -709,17 +709,14 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
 				     CDNS_MCP_CMD_LEN, false);
 		if (ret != SDW_CMD_OK)
-			goto exit;
+			return ret;
 	}
 
 	if (!(msg->len % CDNS_MCP_CMD_LEN))
-		goto exit;
+		return SDW_CMD_OK;
 
-	ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
-			     msg->len % CDNS_MCP_CMD_LEN, false);
-
-exit:
-	return ret;
+	return _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
+			      msg->len % CDNS_MCP_CMD_LEN, false);
 }
 EXPORT_SYMBOL(cdns_xfer_msg);
 
-- 
2.30.2

