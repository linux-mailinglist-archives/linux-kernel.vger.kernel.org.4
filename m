Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34C45B87DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiINMKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiINMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:10:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2522530
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:10:14 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EBk1kW005558;
        Wed, 14 Sep 2022 07:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ibOfn/+ASXTfvCcNK8UK8/PJfMDVm1gjDjZjwUSKE7M=;
 b=KbCp0V8KWXXb5+nLOALWDmhFnRnHae/yRaWY5xAnoO0ll95IR0u8ufdLvl+ld7gjJLzP
 KZ6wyMIFtqktD/gK/vPAmsHaM1peUCrFyiuQETnFlt0r8SPrnW0TZjeys2vN1YdCyQ95
 UgWtaD/Gcr5Pt54PE4or8fAMETrdIICprLuwvXZfKo4d/8adPn+IYfDGcque+SxzlQqS
 IpH/4Q4oDHtPjxlyhKf6KCyBv3gT+Vxpg4YSZ0bf8tgJ1XGwS/T/AHNBpZ97cI8VnQDT
 5RYnTg/X1kFXaYPO704q0d2brrlDpGIzyBCuufztfdUuPKxW47+/cvoAWAct1fU5a/js dg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05gy54-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 07:09:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 07:09:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 14 Sep 2022 07:09:56 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 358A2B16;
        Wed, 14 Sep 2022 12:09:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 2/5] soundwire: bus: Don't lose unattach notifications
Date:   Wed, 14 Sep 2022 13:09:46 +0100
Message-ID: <20220914120949.747951-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914120949.747951-1-rf@opensource.cirrus.com>
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KS_-SWXAHzN8Y8NSg8p4pWFnbbb0d7Gv
X-Proofpoint-ORIG-GUID: KS_-SWXAHzN8Y8NSg8p4pWFnbbb0d7Gv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that if sdw_handle_slave_status() sees a peripheral
has dropped off the bus it reports it to the client driver.

If there are any devices reporting on address 0 it bails out
after programming the device IDs. So it never reaches the second
loop that calls sdw_update_slave_status().

If the missing device is one that is now showing as unenumerated
it has been given a device ID so will report as attached next
time sdw_handle_slave_status() runs.

With the previous code the client driver would only see another
ATTACHED notification because the UNATTACHED state was lost when
sdw_handle_slave_status() bailed out after programming the
device ID.

This shows up most when the peripheral has to be reset after
downloading updated firmware and there are multiple of these
peripherals on the bus. They will all return to unenumerated state
after the reset, and then there is a mix of unattached, attached
and unenumerated PING states from the peripherals, as each is reset
and they reboot.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index d773eee71bc1..1cc858b4107d 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1767,6 +1767,11 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
 				 i, slave->status);
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+
+			/* Ensure driver knows that peripheral unattached */
+			ret = sdw_update_slave_status(slave, status[i]);
+			if (ret < 0)
+				dev_warn(&slave->dev, "Update Slave status failed:%d\n", ret);
 		}
 	}
 
-- 
2.30.2

