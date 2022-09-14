Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B35B8C69
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiINQDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:03:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778856A490
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:03:29 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDgEGI005943;
        Wed, 14 Sep 2022 11:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=jSHVQM4f5c6nFOJUjjIDepmDXBFYw20rCfoBuGjpZxs=;
 b=LbWAVZ3JGBBzCZCY+jQwN45OrJLq24z2wZ6a3YlT1TioVjw7fVLXfOB45UVlEMrP/Ray
 0Ncn/l0TXBHucxSgK+3iRtNz6NJNLVGwrOn6heS0lhRWsRuZnCm9AMWsXi5iE4fkS1ax
 B2uyPS2dMzRQIcFV4WLpXn0BzOTpaMDO44Hz4dirqwNok7A06vfH0gCsDzsIhp5qhgVk
 QaVxDnkFReJ5F1zPvXq0yTnU6erawsgwkcoYqlA1pjWTg2X9vys5Qvad3Ipbx+e0peWw
 oAO7LXYJqZzdNEi9JySMZtWU6iumHjnjIbs6FiDCPH/tVNx6AmvLAKPxOKKok2tojy03 +g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jjy05h8em-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 11:02:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Wed, 14 Sep
 2022 11:02:55 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.12 via Frontend
 Transport; Wed, 14 Sep 2022 11:02:55 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BD12511C7;
        Wed, 14 Sep 2022 16:02:55 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 3/5] soundwire: bus: Don't re-enumerate before status is UNATTACHED
Date:   Wed, 14 Sep 2022 17:02:46 +0100
Message-ID: <20220914160248.1047627-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220914160248.1047627-1-rf@opensource.cirrus.com>
References: <20220914160248.1047627-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -gdhMwViXDGTP4Urpmc0oSg-yySIbC0K
X-Proofpoint-ORIG-GUID: -gdhMwViXDGTP4Urpmc0oSg-yySIbC0K
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

