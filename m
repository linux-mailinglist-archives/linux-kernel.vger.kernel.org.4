Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39A471EE81
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjFAQQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFAQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:16:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A613D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:16:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3517XPpJ025991;
        Thu, 1 Jun 2023 11:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=8aVpdlwW2w+KYJE7+AHWZW/cn5CRFeVkk84n9PBWCZg=;
 b=UnT+dCfq2a2bFjbclyx2HycRQiGETWpiqvhOfPpN7Gd99gL0/qednxFwBQ83aDKqn6kv
 vC0OtM6h+7BwfaIsf+6wKMeRIYgXRirdwU/9JX2vVeJo/bNa2223eE0Yhst/HtRmHjUW
 4Qq7fNxE2rUpDfQcLBFtvxo3fND0T3B7OzuoCTsJ/ul5cgQ3+S5AJo8n8mWg7pX4DUmZ
 W2Du4LiZS/3HxI+WMWXqizuyzHEJy+Mb0eGADGEnJpdST9ML+a0ns+sGXlRKGSH29Amr
 JwKF4kQxFOGgwNzdDe86WSOrtBPZCkTO6VG7dAp1cTg8frQS2y+yV9MEW1GOdEcDns4O vg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mxmbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:16:24 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 1 Jun
 2023 17:16:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 1 Jun 2023 17:16:23 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EACCD15B7;
        Thu,  1 Jun 2023 16:16:22 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 4/4] soundwire: stream: Tidy do_bank_switch error messages
Date:   Thu, 1 Jun 2023 17:16:22 +0100
Message-ID: <20230601161622.1808135-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lPtkQwjhyZbOsug5tD47n3WRBjOJE70v
X-Proofpoint-ORIG-GUID: lPtkQwjhyZbOsug5tD47n3WRBjOJE70v
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every error path in do_bank_switch prints an error message so there is no
need for the callers to also print error messages. Indeed in multi-master
cases these extra messages are confusing because they print out against a
random bus device whereas the do_bank_switch messages print against the bus
that actually failed.

This also allows clean up of a couple of if's and variable initialisations
that were only there to silence potentially uninitialised variable
warnings on the bus variable.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/stream.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 248ab243ec6e4..b5c7a52aac19e 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1338,7 +1338,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 			       bool update_params)
 {
 	struct sdw_master_runtime *m_rt;
-	struct sdw_bus *bus = NULL;
+	struct sdw_bus *bus;
 	struct sdw_master_prop *prop;
 	struct sdw_bus_params params;
 	int ret;
@@ -1380,16 +1380,9 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 		}
 	}
 
-	if (!bus) {
-		pr_err("Configuration error in %s\n", __func__);
-		return -EINVAL;
-	}
-
 	ret = do_bank_switch(stream);
-	if (ret < 0) {
-		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
+	if (ret < 0)
 		goto restore_params;
-	}
 
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		bus = m_rt->bus;
@@ -1465,7 +1458,7 @@ EXPORT_SYMBOL(sdw_prepare_stream);
 static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	struct sdw_bus *bus = NULL;
+	struct sdw_bus *bus;
 	int ret;
 
 	/* Enable Master(s) and Slave(s) port(s) associated with stream */
@@ -1488,16 +1481,9 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 		}
 	}
 
-	if (!bus) {
-		pr_err("Configuration error in %s\n", __func__);
-		return -EINVAL;
-	}
-
 	ret = do_bank_switch(stream);
-	if (ret < 0) {
-		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	stream->state = SDW_STREAM_ENABLED;
 	return 0;
@@ -1571,10 +1557,8 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
 	}
 
 	ret = do_bank_switch(stream);
-	if (ret < 0) {
-		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* make sure alternate bank (previous current) is also disabled */
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
-- 
2.30.2

