Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC771FEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjFBKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjFBKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:12:04 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC7DC0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:12:03 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3529pNL5008786;
        Fri, 2 Jun 2023 05:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=TBrMIq8lNLq6LXZ22105Me5KRw2T5hajdIlSi0oqyZ4=;
 b=PRBjBC6KAAu8AF730aSdv4vxPv7Iwu7bd31XVYRsDm9ifxiSDdFMDnLd/9HHF1+FqvCn
 PN9IlrCuMGPQXorBCl5Biw6tGirQE8gHaT4JW3zOmHl9G5ofv3GZuMIhi8D9PqgUZruw
 RHWL0cQDmlAQHcBCdrW7blpaS0IBeBLDknSM8fHVN6nPK4HKcC28FzcNhULs0AxKrtSu
 4WWATWN494DkVH3ZkBMm8gaUDiluWNQnctJTbgkXjACrrJ01jtOvO2/NpHErcuSmFd85
 ysRKFD4uN9D0woNuM4V/yzdYtZKXiMIOnCI48+AIqYxo924Z4yObb2GcXvqEkQNinupo uA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3quf90y83v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 05:11:43 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 2 Jun
 2023 11:11:40 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 2 Jun 2023 11:11:40 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B735711AA;
        Fri,  2 Jun 2023 10:11:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/5] soundwire: stream: Remove unneeded checks for NULL bus
Date:   Fri, 2 Jun 2023 11:11:38 +0100
Message-ID: <20230602101140.2040141-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ttStr9w0m9_VGqBI0a0LwYRjYUnmlaIQ
X-Proofpoint-ORIG-GUID: ttStr9w0m9_VGqBI0a0LwYRjYUnmlaIQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version of the code prior to commit d014688eb373 ("soundwire: stream:
remove bus->dev from logs on multiple buses"), used bus->dev in the
error message after do_bank_switch, this necessitated some checking to
ensure the bus pointer was valid. As the code no longer uses bus->dev
said checking is now redundant, so remove it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Left the duplicate error prints in.

Thanks,
Charles

 drivers/soundwire/stream.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 379228f221869..6595f47b403b5 100644
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
@@ -1382,11 +1382,6 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 		}
 	}
 
-	if (!bus) {
-		pr_err("Configuration error in %s\n", __func__);
-		return -EINVAL;
-	}
-
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
 		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
@@ -1467,7 +1462,7 @@ EXPORT_SYMBOL(sdw_prepare_stream);
 static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
-	struct sdw_bus *bus = NULL;
+	struct sdw_bus *bus;
 	int ret;
 
 	/* Enable Master(s) and Slave(s) port(s) associated with stream */
@@ -1490,11 +1485,6 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 		}
 	}
 
-	if (!bus) {
-		pr_err("Configuration error in %s\n", __func__);
-		return -EINVAL;
-	}
-
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
 		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
-- 
2.30.2

