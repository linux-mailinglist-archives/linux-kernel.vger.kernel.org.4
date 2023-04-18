Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2186E66A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjDROHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDROHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:07:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14D312C9E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:07:07 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I7Uxao008791;
        Tue, 18 Apr 2023 09:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=hQHa8wBeeGW9puV7XlcRtvWMmKP2kW7m/WSCDKO6E64=;
 b=WhJbPa3b+Qlgj+pRhq2QppXp8PFTTAvAbRZNsl3VZyUMyIqEhcIxUf6rBQsIXc+0i1vz
 qRLZ5w7vynYkL3bqQJqCMzEH6w9RhELz3+t96D4dv8eWLo2BsPT/CUDsmD67o+JuUT06
 B/SfovDZku5207zCfvk6biPpTEhi8RtQ85r3oSeOHIlsSsK3RKEA3yW7zUMncjmuTXAT
 3CRo6/g+D+qmubJxR1nQxvhEZ+BXiG1loCCqcFyulZz9bVzPY4ipXqp34H+ub9AH3vUc
 6sQuUUoYFjj5fZHALUFqgDiHjPAw9hpVByFM1g797y7PYuVW184mGlZOGr1h8amgef2Q cA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pyrbpxdp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:06:51 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 18 Apr
 2023 09:06:50 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 18 Apr 2023 09:06:50 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A876B06;
        Tue, 18 Apr 2023 14:06:50 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2] soundwire: bus: Don't filter slave alerts
Date:   Tue, 18 Apr 2023 15:06:50 +0100
Message-ID: <20230418140650.297279-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xqcdqW-1U6epGePOSoUGzmzkzUP6iIwe
X-Proofpoint-ORIG-GUID: xqcdqW-1U6epGePOSoUGzmzkzUP6iIwe
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to have only a single point responsible for ensuring
that all currently pending IRQs are handled. The current code in
sdw_handle_slave_alerts confusingly splits this process in two.  This
code will loop until the asserted IRQs are cleared but it will only
handle IRQs that were already asserted when it was called. This
means the caller must also loop (either manually, or through its IRQ
mechanism) until the IRQs are all handled. It makes sense to either do
all the looping in sdw_handle_slave_alerts or do no looping there and
let the host controller repeatedly call it until things are handled.

There are realistically two sensible host controllers, those that
will generate an IRQ when the alert status changes and those
that will generate an IRQ continuously whilst the alert status
is high. The current code will work fine for the second of those
systems but not the first with out additional looping in the host
controller.  Removing the code that filters out new IRQs whilst
the handler is running enables both types of host controller to be
supported and simplifies the code. The code will still only loop up to
SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it to
get completely stuck handling IRQs forever, and if you are generating
IRQs faster than you can handle them you likely have bigger problems
anyway.

This fixes an issue on the Cadence SoundWire IP, which only generates
IRQs on an alert status change, where an alert which arrives whilst
another alert is being handled will never be handled and will block
all future alerts from being handled.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Update commit message

Thanks,
Charles

 drivers/soundwire/bus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1ea6a64f8c4a5..338f4f0b5d0cc 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1588,7 +1588,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	unsigned long port;
 	bool slave_notify;
 	u8 sdca_cascade = 0;
-	u8 buf, buf2[2], _buf, _buf2[2];
+	u8 buf, buf2[2];
 	bool parity_check;
 	bool parity_quirk;
 
@@ -1745,9 +1745,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
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
@@ -1765,12 +1765,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
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

