Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74763F24D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiLAOIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiLAOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:08:40 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA04A7AAA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:08:35 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B17QP4s028766;
        Thu, 1 Dec 2022 08:08:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=C+gnvUjF+dRHpOoHQk7AZtrMT0JKxATwowGCzKMV1XA=;
 b=peVHfzdA5nNVvvdT/qKLLfpn9R8HMlphHJZyIiNKyK/ECPoC0zQUeCiuIJoDG7jaZEhR
 Xgc5F4bgGZt5aMpCeK0kqGOlmMABgLjHampo+PCDo2ulfNK54psK/5Zr8fAD3v5BP0ey
 X0vGUbS0h70td2oKQtWFexc4rXpvMOIx9FPNSQM0DGPcTdVcpsaO68cS7PNIj5sSuE92
 Ifou4Uuwj4osPcIQFI2V3/rA+M2XAmdD20cHobFVb2KfSQ7e5YBxLdq7BCKQMC6wfDWN
 ODU/0DOak0D14PDXZy3j/eP+vJujIpM4MPLtYWXKibOQ2aAqWOksXhOM9CHTn4UxxKMN FQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k2vrjg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 08:08:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 1 Dec
 2022 08:08:13 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 1 Dec 2022 08:08:13 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 33DCEB2F;
        Thu,  1 Dec 2022 14:08:13 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] soundwire: bus: Don't zero page registers after every transaction
Date:   Thu, 1 Dec 2022 14:08:12 +0000
Message-ID: <20221201140813.4062146-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201140813.4062146-1-rf@opensource.cirrus.com>
References: <20221201140813.4062146-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hGhrQlAHdhaZ_-AZRiBj0ImihEhj9gUD
X-Proofpoint-ORIG-GUID: hGhrQlAHdhaZ_-AZRiBj0ImihEhj9gUD
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zeroing the page registers at the end of every paged transaction is just
overhead (40% overhead on a 1-register access, 25% on a 4-register
transaction). According to the spec the peripheral should only use the
values in the page registers if the address is paged, and since the page
registers are always overwritten at the start of a paged transaction there
will never be a transaction that uses the stale values from a previous
paged transaction.

For peripherals that need large amounts of data to be transferred, for
example firmware or filter coefficients, the overhead of page register
zeroing can become quite significant.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 76515c33e639..a02edcbfc282 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -247,23 +247,6 @@ static inline int do_transfer_defer(struct sdw_bus *bus,
 	return ret;
 }
 
-static int sdw_reset_page(struct sdw_bus *bus, u16 dev_num)
-{
-	int retry = bus->prop.err_threshold;
-	enum sdw_command_response resp;
-	int ret = 0, i;
-
-	for (i = 0; i <= retry; i++) {
-		resp = bus->ops->reset_page_addr(bus, dev_num);
-		ret = find_response_code(resp);
-		/* if cmd is ok or ignored return */
-		if (ret == 0 || ret == -ENODATA)
-			return ret;
-	}
-
-	return ret;
-}
-
 static int sdw_transfer_unlocked(struct sdw_bus *bus, struct sdw_msg *msg)
 {
 	int ret;
@@ -275,9 +258,6 @@ static int sdw_transfer_unlocked(struct sdw_bus *bus, struct sdw_msg *msg)
 			(msg->flags & SDW_MSG_FLAG_WRITE) ? "write" : "read",
 			msg->addr, msg->len);
 
-	if (msg->page)
-		sdw_reset_page(bus, msg->dev_num);
-
 	return ret;
 }
 
@@ -352,9 +332,6 @@ int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
 		dev_err(bus->dev, "Defer trf on Slave %d failed:%d\n",
 			msg->dev_num, ret);
 
-	if (msg->page)
-		sdw_reset_page(bus, msg->dev_num);
-
 	return ret;
 }
 
-- 
2.30.2

