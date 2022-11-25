Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5EE638BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiKYOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKYOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:20:48 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2352523155
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:20:48 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APCp6w8007040;
        Fri, 25 Nov 2022 08:20:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fmtjNKPzLbqjNIqHltuZn0oCtwpbo1qpHKVTmVc8jZc=;
 b=LhZNHUmHWJLT2pQ9s4mQSKQ19X7WWiWy4sncMf3o6LmGyzTZeCKR8gmy91JjLXxkZIRu
 KpaZK20spzt7id3XxM2Lo2A4044JDGlVVxo3oU4oD3VWaR6P2PkmMhjpsI9dYjZosZpw
 8kdZ+4sOi2MKRU5/n9oo0PYCPbYO6+1GVo9MiNtvwRoOxtvZAwtIiyug6KGYBlHuV6lY
 e7u3rowcl+L4uns42OPO7kic7rr6IPRucSECJSWFWs6QjDEs5mlj5S89a+RY89w/4uzz
 9EuUEyDmOwj86Egmskc+MzJIsDE3snGlmdq+Nv0FsaiJ5hPSpH1p5wS6CkXnNUujM7Gb ew== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet7ccn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Nov 2022 08:20:32 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 25 Nov
 2022 08:20:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 25 Nov 2022 08:20:29 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 27DF2B2F;
        Fri, 25 Nov 2022 14:20:29 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v4 3/4] soundwire: debugfs: Switch to sdw_read_no_pm
Date:   Fri, 25 Nov 2022 14:20:27 +0000
Message-ID: <20221125142028.1118618-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221125142028.1118618-1-ckeepax@opensource.cirrus.com>
References: <20221125142028.1118618-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tbFnoGi_Ad1V39P-G-zMdKzR9s9Ew5e6
X-Proofpoint-GUID: tbFnoGi_Ad1V39P-G-zMdKzR9s9Ew5e6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is rather inefficient to be constantly playing with the runtime
PM reference for each individual register, switch to holding a PM
runtime reference across the whole register output.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v3.

 drivers/soundwire/debugfs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 49900cd207bc7..dea782e0edc4b 100644
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
@@ -55,6 +56,12 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 	if (!buf)
 		return -ENOMEM;
 
+	ret = pm_runtime_resume_and_get(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		kfree(buf);
+		return ret;
+	}
+
 	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
 
 	/* DP0 non-banked registers */
@@ -112,6 +119,10 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
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

