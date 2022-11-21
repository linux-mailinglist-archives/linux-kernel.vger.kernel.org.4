Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADE632956
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKUQZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKUQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:25:03 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD975C8462
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:25:02 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALCRK4S019971;
        Mon, 21 Nov 2022 10:24:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=4UMzaT3FllzN9o30ghlwgUoU6Qf25HeCEVnbg8A8Ecc=;
 b=UoERFtE3WImezBAOkahdFI0yZOiLurMH8OXIlr2qhr7IWM+PC4xsTX5xw3ad9HqsDfuC
 orLmJI/VVvuPfL7sd5NuZ9WMpqsAyEQVneimhgXMPlYWzgIi00Fj7zNTPysWbuSsVBIM
 dExSx/RoRhw5ec7eIOzGlulOf8JI7rbw4F1JibvzKjIKxIRlKv9eqmm095YQaes9fZn7
 CuFJa45j4mO9M/Mgb/E/+3TP828EMkly6PmjgntZbS6NPIUlin+TMCmXONIAFADVlCKn
 Nlligg05A4ZDu6waBAlmYMTUV/Gsm8AennGD3aoMkZ0Mdf4mKByKWykMAxzlnQHMkc6a Hg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6tcmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 10:24:55 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 21 Nov
 2022 10:24:53 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Mon, 21 Nov 2022 10:24:53 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 06496468;
        Mon, 21 Nov 2022 16:24:53 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] soundwire: bus_type: Avoid lockdep assert in sdw_drv_probe()
Date:   Mon, 21 Nov 2022 16:24:52 +0000
Message-ID: <20221121162453.1834170-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9e45ZdA9sZUWEGKY2jXQmLpCGetehFOp
X-Proofpoint-GUID: 9e45ZdA9sZUWEGKY2jXQmLpCGetehFOp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't hold sdw_dev_lock while calling the peripheral driver
probe() and remove() callbacks.

Holding sdw_dev_lock around the probe() and remove() calls
causes a theoretical mutex inversion which lockdep will
assert on. The peripheral driver probe will probably register
a soundcard, which will take ALSA and ASoC locks. During
normal operation a runtime resume suspend can be triggered
while these locks are held and will then take sdw_dev_lock.

It's not necessary to hold sdw_dev_lock when calling the
probe() and remove(), it is only used to prevent the bus core
calling the driver callbacks if there isn't a driver or the
driver is removing.

If sdw_dev_lock is held while setting and clearing the
'probed' flag this is sufficient to guarantee the safety of
callback functions.

The potential race of a bus event happening while probe() is
executing is the same as the existing race of the bus event
handler taking the mutex first and processing the event
before probe() can run. In both cases the event has already
happened before the driver is probed and ready to accept
callbacks.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/bus_type.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 04b3529f8929..963498db0fd2 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -105,20 +105,19 @@ static int sdw_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	mutex_lock(&slave->sdw_dev_lock);
-
 	ret = drv->probe(slave, id);
 	if (ret) {
 		name = drv->name;
 		if (!name)
 			name = drv->driver.name;
-		mutex_unlock(&slave->sdw_dev_lock);
 
 		dev_err(dev, "Probe of %s failed: %d\n", name, ret);
 		dev_pm_domain_detach(dev, false);
 		return ret;
 	}
 
+	mutex_lock(&slave->sdw_dev_lock);
+
 	/* device is probed so let's read the properties now */
 	if (drv->ops && drv->ops->read_prop)
 		drv->ops->read_prop(slave);
@@ -167,14 +166,12 @@ static int sdw_drv_remove(struct device *dev)
 	int ret = 0;
 
 	mutex_lock(&slave->sdw_dev_lock);
-
 	slave->probed = false;
+	mutex_unlock(&slave->sdw_dev_lock);
 
 	if (drv->remove)
 		ret = drv->remove(slave);
 
-	mutex_unlock(&slave->sdw_dev_lock);
-
 	dev_pm_domain_detach(dev, false);
 
 	return ret;
-- 
2.30.2

