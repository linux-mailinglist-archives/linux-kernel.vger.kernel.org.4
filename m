Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302EC5BB89F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiIQODc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 10:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIQOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:03:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F022BB00
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:03:28 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28HDswAC031443;
        Sat, 17 Sep 2022 09:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=lKY8j0vzKxC7NFBZD8JvtgkQHrhbXHdKGnrRODBlXW4=;
 b=d+i7lvHIPmIFmVDH8w8AjoEDw7g87Bjwo02CXaz4sFeNQ9Woe4dsTxpBWe4Wmo8bWqf6
 JZLbNe1t1lwp5z+8rY4e0ApXoK6xkulnwLVXoRrYsUBN1ebRZZ2rePPWBnuIa0/tlsjg
 hMKCf9X7vDsLVF6V6gbaFBUWxtYyyexT55gmN55tLpt7uHlsW/uZZc43aujpzfZrCNG9
 Ho5EoQM/oAitMvOvpuFczpdGyQrRLFHdkpv8K1dMJ2nvQCVUFBNXufHpc2QCu99wT3nl
 lTGSUCTSxcFbQznBmA6UM0FEj4QkBDmi4TK8HzrkRmS07X2ob8TwPLVQZFkQ2zCyRypd Yw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jnanmg86h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Sep 2022 09:03:07 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Sat, 17 Sep
 2022 09:03:05 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Sat, 17 Sep 2022 09:03:05 -0500
Received: from debianA11184.ad.cirrus.com (unknown [198.61.65.112])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D3B112BA;
        Sat, 17 Sep 2022 14:02:58 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] soundwire: bus: Fix wrong port number in sdw_handle_slave_alerts()
Date:   Sat, 17 Sep 2022 15:02:56 +0100
Message-ID: <20220917140256.689678-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _oA7DauQ6_eVTiTbkbYThvi38yUvu3GH
X-Proofpoint-ORIG-GUID: _oA7DauQ6_eVTiTbkbYThvi38yUvu3GH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_set_bit() gives the bit-number counting from 0 (LSbit==0).
When processing INTSTAT2, bit 0 is DP4 so the port number is (bit + 4).
Likewise for INTSTAT3 bit 0 is DP11 so port number is (bit + 11).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 8eded1a55227..df0ae869ee51 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1622,7 +1622,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			port = buf2[0] & SDW_SCP_INTSTAT2_PORT4_10;
 			for_each_set_bit(bit, &port, 8) {
 				/* scp2 ports start from 4 */
-				port_num = bit + 3;
+				port_num = bit + 4;
 				sdw_handle_port_interrupt(slave,
 						port_num,
 						&port_status[port_num]);
@@ -1634,7 +1634,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			port = buf2[1] & SDW_SCP_INTSTAT3_PORT11_14;
 			for_each_set_bit(bit, &port, 8) {
 				/* scp3 ports start from 11 */
-				port_num = bit + 10;
+				port_num = bit + 11;
 				sdw_handle_port_interrupt(slave,
 						port_num,
 						&port_status[port_num]);
-- 
2.30.2

