Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24B5B8C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiINQDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiINQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:03:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4479A6B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:03:33 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDg5eo005918;
        Wed, 14 Sep 2022 11:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=NZLnWm5XBphTnhNkqh3/xFWAvi1Yf1HlsOfBdxtLhL0=;
 b=KJRYnPbeAXNCbnAVALFAF/0dwAtXbLFb1qz0E+X0mn07Q66u4gHba0xUZXhnr5kJNtao
 KpoeelGT/uLriwCHs6Sb+A8LylDgDZrKi4xBJZF0jPWiWfUpVusCe/oGTbprbJC/R9XD
 YWSeyKP0NHevhEh0AAEZmNPSSHIqfIRQfn1+yOnlAyqmqS8j4EFVlJ7B449nbJHw2Dzy
 SY+DkZqD9h579DefQMNsd4mB9s7BSfMMjlZsBFQ/5jpEyDQf6k6dbNvOkJR0DsDVkbTd
 de+/aCVLvSg2Wrb9fU1O9qIUlOziQ3bnnCYvEA5fw0gi8EoUK0ZNGnxGZJ41sod0o41u ow== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05h8ek-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 11:02:59 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 11:02:55 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 14 Sep 2022 11:02:55 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CEE28468;
        Wed, 14 Sep 2022 16:02:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 4/5] soundwire: cadence: Fix lost ATTACHED interrupts when enumerating
Date:   Wed, 14 Sep 2022 17:02:47 +0100
Message-ID: <20220914160248.1047627-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914160248.1047627-1-rf@opensource.cirrus.com>
References: <20220914160248.1047627-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rruyKmm1IlMyFT1IYJ0CFvMt3vYPjADY
X-Proofpoint-ORIG-GUID: rruyKmm1IlMyFT1IYJ0CFvMt3vYPjADY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct way to handle interrupts is to clear the bits we
are about to handle _before_ handling them. Thus if the condition
then re-asserts during the handling we won't lose it.

This patch changes cdns_update_slave_status_work() to do this.

The previous code cleared the interrupts after handling them.
The problem with this is that when handling enumeration of devices
the ATTACH statuses can be accidentally cleared and so some or all
of the devices never complete their enumeration.

Thus we can have a situation like this:
- one or more devices are reverting to ID #0

- accumulated status bits indicate some devices attached and some
  on ID #0. (Remember: status bits are sticky until they are handled)

- Because of device on #0 sdw_handle_slave_status() programs the
  device ID and exits without handling the other status, expecting
  to get an ATTACHED from this reprogrammed device.

- The device immediately starts reporting ATTACHED in PINGs, which
  will assert its CDNS_MCP_SLAVE_INTSTAT_ATTACHED bit.

- cdns_update_slave_status_work() clears INTSTAT0/1. If the initial
  status had CDNS_MCP_SLAVE_INTSTAT_ATTACHED bit set it will be
  cleared.

- The ATTACHED change for the device has now been lost.

- cdns_update_slave_status_work() clears CDNS_MCP_INT_SLAVE_MASK so
  if the new ATTACHED state had set it, it will be cleared without
  ever having been handled.

Unless there is some other state change from another device to cause
a new interrupt, the ATTACHED state of the reprogrammed device will
never cause an interrupt so its enumeration will not be completed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 245191d22ccd..be9cd47f31ec 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -954,9 +954,22 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 	u32 device0_status;
 	int retry_count = 0;
 
+	/*
+	 * Clear main interrupt first so we don't lose any assertions
+	 * that happen during this function.
+	 */
+	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
+
 	slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
 	slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
 
+	/*
+	 * Clear the bits before handling so we don't lose any
+	 * bits that re-assert.
+	 */
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
+	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
+
 	/* combine the two status */
 	slave_intstat = ((u64)slave1 << 32) | slave0;
 
@@ -964,8 +977,6 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 
 update_status:
 	cdns_update_slave_status(cdns, slave_intstat);
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
-	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
 
 	/*
 	 * When there is more than one peripheral per link, it's
@@ -982,6 +993,11 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 	 * attention with PING commands. There is no need to check for
 	 * ALERTS since they are not allowed until a non-zero
 	 * device_number is assigned.
+	 *
+	 * Do not clear the INTSTAT0/1. While looping to enumerate devices on
+	 * #0 there could be status changes on other devices - these must
+	 * be kept in the INTSTAT so they can be handled when all #0 devices
+	 * have been handled.
 	 */
 
 	device0_status = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
@@ -1001,8 +1017,7 @@ static void cdns_update_slave_status_work(struct work_struct *work)
 		}
 	}
 
-	/* clear and unmask Slave interrupt now */
-	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
+	/* unmask Slave interrupt now */
 	cdns_updatel(cdns, CDNS_MCP_INTMASK,
 		     CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
 
-- 
2.30.2

