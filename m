Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF89627A87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiKNKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiKNKbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:31:15 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B55714D2C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:31:13 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE8Wcie019990;
        Mon, 14 Nov 2022 04:29:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=wR8WznTLjHtXuxSzrfRxj5uzxnQfyrE3rhFbBYPUl9E=;
 b=Pz4b01vd4pkAmDey1/iXQitssuwC7GwX/0K9JnvGvgzq+o8fE3FKSzfVCrzQ8Jc8bLdH
 hUZSQjs7aVA0wl0SY5u41xvH6fdat2Wubil7qfcEUfs9dZQ3KTbUesGKBmTQyQFnxmGC
 CaKTjyNWg9bPUOBXfPX6p5I7RVetKAbVq68YEF28OxaYf5e9Qyzy5eI30XtRmrsNR3C0
 zEr97UTqDoo65QFwA6CpB4DA0ybLEgHy07ISEsYOJSeJ2ryxUpVICeaRcVYBvHHCjexb
 7CQ+/rz5wt7GIMPpJhiwKZUDjCrLGKKpBh2AmtA1srIZGO+B0LUVym/B/Ge74BkQwZdG uA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kt8sst0cm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 04:29:59 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Mon, 14 Nov
 2022 04:29:56 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Mon, 14 Nov 2022 04:29:56 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 66CF8B2F;
        Mon, 14 Nov 2022 10:29:56 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/4] soundwire: debugfs: Switch to sdw_read_no_pm
Date:   Mon, 14 Nov 2022 10:29:55 +0000
Message-ID: <20221114102956.914468-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Q3wEA4SA0jb2CYzwI9IxJadDNNpQfAj0
X-Proofpoint-ORIG-GUID: Q3wEA4SA0jb2CYzwI9IxJadDNNpQfAj0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is rather inefficient to be constantly enabling/disabling the PM
runtime as we print out each individual register, switch to holding a PM
runtime reference across the whole register output.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/debugfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 49900cd207bc7..0718e9cda138a 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/debugfs.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -35,7 +36,7 @@ static ssize_t sdw_sprintf(struct sdw_slave *slave,
 {
 	int value;
 
-	value = sdw_read(slave, reg);
+	value = sdw_read_no_pm(slave, reg);
 
 	if (value < 0)
 		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
@@ -55,6 +56,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	if (!buf)
 		return -ENOMEM;
 
+	ret = pm_runtime_resume_and_get(&slave->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
 	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
 
 	/* DP0 non-banked registers */
@@ -112,6 +117,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	}
 
 	seq_printf(s_file, "%s", buf);
+
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put(&slave->dev);
+
 	kfree(buf);
 
 	return 0;
-- 
2.30.2

