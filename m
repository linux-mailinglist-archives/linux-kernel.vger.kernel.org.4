Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194BA6FA851
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjEHKj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjEHKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:39:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0A2945B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:39:22 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3489EmkA028057;
        Mon, 8 May 2023 05:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=GndCEdzK1snefdFRYVEkK8R4R1g8K0x/+ofecHZlDn4=;
 b=AP3UEY2x4slF7flmnqfWGrDWKWt3hEX6gXgE0YteQ05jmVw3Y3AljJQzbzjUpArLXqfY
 d8xMcma5cap0OCe4f9GuJjHUheFwZ0FJSknpCNjwbiq9CtC/g1g2LYuVS6JathPHubKp
 eZ9Y8jAkMIGEIZxvhgbptTeOxh86XflN+u1bMYjCMGkX0ffBFpsNKxkkF2Mf80hJERMr
 jOdV0Jy8xH3Y0Fwida6/LYYnvTwh870DehUgTwerTVXdUPQQ0x50FehX/qQQ2ZQlFm29
 Y+93Dy+j6p8pLZDb8g6l1Q4wd83Vmj5aTjisr2xImqusZKe+mdY5luNmTgG+c+HtK3oe 8Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qdkaqt25u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 05:39:05 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 8 May
 2023 05:39:04 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 8 May 2023 05:39:04 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BD87B475;
        Mon,  8 May 2023 10:39:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <vkoul@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] soundwire: intel: Make DEV_NUM_IDA_MIN a module param
Date:   Mon, 8 May 2023 11:39:01 +0100
Message-ID: <20230508103901.7840-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4RI7U7Hf5yYf6td2Ckif9-tZ5xmGGciR
X-Proofpoint-GUID: 4RI7U7Hf5yYf6td2Ckif9-tZ5xmGGciR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a module param so that globally-unique peripheral ID
allocation is only enabled if wanted.

The globally-unique IDs were introduced by
commit c60561014257
("soundwire: bus: allow device number to be unique at system level")

and
commit 1f2dcf3a154a ("soundwire: intel: set dev_num_ida_min")

Assigning globally-unique IDs limits the total number of
peripherals in a system, and the above two commits limit to a
maximum of 8 peripherals. We now have hardware with more than
8 peripherals in total, so this limit is a problem. As the
original commit says that it is only for debug it can be made
optional.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/soundwire/intel_auxdevice.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index b21e86084f7b..9ebbf652e47a 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -23,8 +23,13 @@
 #include "intel.h"
 #include "intel_auxdevice.h"
 
-/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
-#define INTEL_DEV_NUM_IDA_MIN           4
+/*
+ * sdw_dev_num_min: Set to non-zero to enable globally-unique peripheral IDs.
+ * The value is the minimum ID that will be allocated.
+ */
+static int intel_dev_num_ida_min;
+module_param_named(sdw_dev_num_min, intel_dev_num_ida_min, int, 0444);
+MODULE_PARM_DESC(sdw_dev_num_min, "SoundWire Intel Master min globally-unique ID (0 to disable)");
 
 #define INTEL_MASTER_SUSPEND_DELAY_MS	3000
 
@@ -148,7 +153,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->msg_count = 0;
 
 	bus->link_id = auxdev->id;
-	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
+	bus->dev_num_ida_min = intel_dev_num_ida_min;
 	bus->clk_stop_timeout = 1;
 
 	sdw_cdns_probe(cdns);
-- 
2.30.2

