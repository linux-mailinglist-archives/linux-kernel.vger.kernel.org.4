Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62CA5B87DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiINMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiINMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:10:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E42612B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:10:13 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EBt7vM003707;
        Wed, 14 Sep 2022 07:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=jSHVQM4f5c6nFOJUjjIDepmDXBFYw20rCfoBuGjpZxs=;
 b=FxHPAHNiev5LqKQxwq0fhh0knh9A3L+fH54NJHCdxxvwRcq7dNdE4bZ4pCexu3cY+Jet
 ULK78uyyKPdBowMSnAtXJocNnxAm4NVZ1eFr6GEOw3allWpqaOlXPce85ODQreR36lDx
 DGcJH6uSTRCoHlYtJv06oXPJMYghdIh0ymYtaDCo57/1A65ad8RsHGIFoS5aDnPJAFrQ
 PPOe5c/vdiOieIrITyTI2dy76Kl9om1CGmRQK4J9JageyUYul70fwVxM+vee6o8rxyr5
 6idGa1w6Z73O+g2FFG5blxvgJigbHEXU868KUh7KCdVe8uTdwz18Jer4rMAG8A2xZPkg OA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3jjxyr0xed-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 07:09:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 07:09:56 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 14 Sep 2022 07:09:56 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4796B11DA;
        Wed, 14 Sep 2022 12:09:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 3/5] soundwire: bus: Don't re-enumerate before status is UNATTACHED
Date:   Wed, 14 Sep 2022 13:09:47 +0100
Message-ID: <20220914120949.747951-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914120949.747951-1-rf@opensource.cirrus.com>
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xIMthwqaKpNG13HZSLZ4sCZHWrLoNil9
X-Proofpoint-GUID: xIMthwqaKpNG13HZSLZ4sCZHWrLoNil9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't re-enumerate a peripheral on #0 until we have seen and
handled an UNATTACHED notification for that peripheral.

Without this, it is possible for the UNATTACHED status to be missed
and so the slave->status remains at ATTACHED. If slave->status never
changes to UNATTACHED the child driver will never be notified of the
UNATTACH, and the code in sdw_handle_slave_status() will skip the
second part of enumeration because the slave->status has not changed.

This scenario can happen because PINGs are handled in a workqueue
function which is working from a snapshot of an old PING, and there
is no guarantee when this function will run.

A peripheral could report attached in the PING being handled by
sdw_handle_slave_status(), but has since reverted to device #0 and is
then found in the loop in sdw_program_device_num(). Previously the
code would not have updated slave->status to UNATTACHED because it had
not yet handled a PING where that peripheral had UNATTACHED.

This situation happens fairly frequently with multiple peripherals on
a bus that are intentionally reset (for example after downloading
firmware).

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 1cc858b4107d..6e569a875a9b 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -773,6 +773,16 @@ static int sdw_program_device_num(struct sdw_bus *bus)
 			if (sdw_compare_devid(slave, id) == 0) {
 				found = true;
 
+				/*
+				 * To prevent skipping state-machine stages don't
+				 * program a device until we've seen it UNATTACH.
+				 * Must return here because no other device on #0
+				 * can be detected until this one has been
+				 * assigned a device ID.
+				 */
+				if (slave->status != SDW_SLAVE_UNATTACHED)
+					return 0;
+
 				/*
 				 * Assign a new dev_num to this Slave and
 				 * not mark it present. It will be marked
-- 
2.30.2

