Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD25F673F50
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjASQvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjASQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:51:19 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB67EE5E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:51:14 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J1KBde020876;
        Thu, 19 Jan 2023 10:51:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=CkQ7VPfrmIC/WzRHmQdR/avtEQWObcg9xXhXG0ZGX5w=;
 b=QP9K8tch1hW17mbzxWgDq9rPVEJfD6WXM4BrZ0+QclR/CqBjmKcnbzkTtu4NPB/Szexr
 iImDRFs3OYviLhZ5H8Zwq1uOfI5I8N13GQ8jX7TCTENjlRH1+E5qu7HneodUEErQ2mOW
 CAAfaIiEYOADP3whEo5e83P5ZZdfl1Zxb9JDFP99xv7OK7bCgXah2nFpcM1tsOOQuUe0
 xzUfwdt8xdJKX0qCbHKt2DqF8VnsXOkMnSKliuf8g/IoA7g+zrPi4l9d2g85v6qpKxOP
 4n4Gu0cQ/2yDYvzKii4Gm65dynSbeatXSIUVJTLFzC7ea3AQ9row4wBXIa9o11/YT/sM rw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3n3tp6ga7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 10:51:06 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 19 Jan
 2023 10:51:04 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Thu, 19 Jan 2023 10:51:04 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6568AB12;
        Thu, 19 Jan 2023 16:51:04 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] soundwire: bus: Don't filter slave alerts
Date:   Thu, 19 Jan 2023 16:51:03 +0000
Message-ID: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IfEzvwbMwPqsRAnyGbfZaY2ssxED5uhT
X-Proofpoint-GUID: IfEzvwbMwPqsRAnyGbfZaY2ssxED5uhT
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the SoundWire core will loop handling slave alerts but it will
only handle those present when the alert was first raised. This causes
some issues with the Cadence SoundWire IP, which only generates an IRQ
when alert changes state. This means that if a new alert arrives whilst
old alerts are being handled it will not be handled in the currently
loop and then no further alerts will be processed since alert never
changes state to trigger a new IRQ.

Correct this issue by allowing the core to handle all pending alerts in
the IRQ handling loop. The code will still only loop up to
SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it get
completely stuck and if you are generating IRQs faster than you can
handle them you likely have bigger problems anyway.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/bus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 633d411b64f35..daee2cca94a4d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1560,7 +1560,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	unsigned long port;
 	bool slave_notify;
 	u8 sdca_cascade = 0;
-	u8 buf, buf2[2], _buf, _buf2[2];
+	u8 buf, buf2[2];
 	bool parity_check;
 	bool parity_quirk;
 
@@ -1716,9 +1716,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 				"SDW_SCP_INT1 recheck read failed:%d\n", ret);
 			goto io_err;
 		}
-		_buf = ret;
+		buf = ret;
 
-		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, _buf2);
+		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, buf2);
 		if (ret < 0) {
 			dev_err(&slave->dev,
 				"SDW_SCP_INT2/3 recheck read failed:%d\n", ret);
@@ -1736,12 +1736,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		}
 
 		/*
-		 * Make sure no interrupts are pending, but filter to limit loop
-		 * to interrupts identified in the first status read
+		 * Make sure no interrupts are pending
 		 */
-		buf &= _buf;
-		buf2[0] &= _buf2[0];
-		buf2[1] &= _buf2[1];
 		stat = buf || buf2[0] || buf2[1] || sdca_cascade;
 
 		/*
-- 
2.30.2

