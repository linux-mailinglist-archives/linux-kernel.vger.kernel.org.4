Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6030C5B8C6A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiINQDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiINQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:03:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8E6A490
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:03:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDgEGJ005943;
        Wed, 14 Sep 2022 11:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=FIRDieEsowSycNKPp8qdtTr+yeOJU0N2yv9agRWOIiY=;
 b=TCxiazcCCT/OmH5ugFrsWwrerVCSx0PFqQiXVBTK0u+ud+7CvZEKy0Z479LPJDrKzOL8
 mlwCn2RCWPqthXKvMzZoIiExtBURJeMejk4EP1e6pohBBgiBiohfOwgJtO2EIW23RCAE
 sBewmMCDwqV8pZNgrcuiu28dhY9ASiIEci1rT4M0wd3JadKv4fdl9iY9eUcq+BFk6lid
 1SPwR4YwBXBymbtl+jCPeSXqVbX9Sny71k8NGjVVq0b053Tw632HAdaCqno9HTpLIVDP
 5ss9ZS9zCFMh9TBYMMAokNmb2H8GGUFbzMeqcEqUz1/1yr5LKOPn5RW1rVHs1uaT/KE1 9Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05h8em-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 11:02:59 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 11:02:55 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 14 Sep 2022 11:02:55 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DD67D11DA;
        Wed, 14 Sep 2022 16:02:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 5/5] soundwire: bus: Don't exit early if no device IDs were programmed
Date:   Wed, 14 Sep 2022 17:02:48 +0100
Message-ID: <20220914160248.1047627-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914160248.1047627-1-rf@opensource.cirrus.com>
References: <20220914160248.1047627-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tgoVBfEYbfIhJBtDBTq9zVfqX4vxbrnO
X-Proofpoint-ORIG-GUID: tgoVBfEYbfIhJBtDBTq9zVfqX4vxbrnO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only exit sdw_handle_slave_status() right after calling
sdw_program_device_num() if it actually programmed an ID into at
least one device.

sdw_handle_slave_status() should protect itself against phantom
device #0 ATTACHED indications. In that case there is no actual
device still on #0. The early exit relies on there being a status
change to ATTACHED on the reprogrammed device to trigger another
call to sdw_handle_slave_status() which will then handle the status
of all peripherals. If no device was actually programmed with an
ID there won't be a new ATTACHED indication. This can lead to the
status of other peripherals not being handled.

The status passed to sdw_handle_slave_status() is obviously always
from a point of time in the past, and may indicate accumulated
unhandled events (depending how the bus manager operates). It's
possible that a device ID is reprogrammed but the last PING status
captured state just before that, when it was still reporting on
ID #0. Then sdw_handle_slave_status() is called with this PING info,
just before a new PING status is available showing it now on its new
ID. So sdw_handle_slave_status() will receive a phantom report of a
device on #0, but it will not find one.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6e569a875a9b..8eded1a55227 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -729,7 +729,7 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
 }
 EXPORT_SYMBOL(sdw_extract_slave_id);
 
-static int sdw_program_device_num(struct sdw_bus *bus)
+static int sdw_program_device_num(struct sdw_bus *bus, bool *programmed)
 {
 	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
 	struct sdw_slave *slave, *_s;
@@ -739,6 +739,8 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 	int count = 0, ret;
 	u64 addr;
 
+	*programmed = false;
+
 	/* No Slave, so use raw xfer api */
 	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
 			   SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
@@ -797,6 +799,8 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 					return ret;
 				}
 
+				*programmed = true;
+
 				break;
 			}
 		}
@@ -1756,7 +1760,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 {
 	enum sdw_slave_status prev_status;
 	struct sdw_slave *slave;
-	bool attached_initializing;
+	bool attached_initializing, id_programmed;
 	int i, ret = 0;
 
 	/* first check if any Slaves fell off the bus */
@@ -1787,14 +1791,23 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 
 	if (status[0] == SDW_SLAVE_ATTACHED) {
 		dev_dbg(bus->dev, "Slave attached, programming device number\n");
-		ret = sdw_program_device_num(bus);
-		if (ret < 0)
-			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
+
 		/*
-		 * programming a device number will have side effects,
-		 * so we deal with other devices at a later time
+		 * Programming a device number will have side effects,
+		 * so we deal with other devices at a later time.
+		 * This relies on those devices reporting ATTACHED, which will
+		 * trigger another call to this function. This will only
+		 * happen if at least one device ID was programmed.
+		 * Error returns from sdw_program_device_num() are currently
+		 * ignored because there's no useful recovery that can be done.
+		 * Returning the error here could result in the current status
+		 * of other devices not being handled, because if no device IDs
+		 * were programmed there's nothing to guarantee a status change
+		 * to trigger another call to this function.
 		 */
-		return ret;
+		sdw_program_device_num(bus, &id_programmed);
+		if (id_programmed)
+			return 0;
 	}
 
 	/* Continue to check other slave statuses */
-- 
2.30.2

