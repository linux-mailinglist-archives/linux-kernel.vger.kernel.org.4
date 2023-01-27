Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899AA67EB95
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjA0QwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjA0Qvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:41 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE7C7E04E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:51:40 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9k8LV030633;
        Fri, 27 Jan 2023 10:51:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=U/maz5mq7SDVzaMNMiD4HWoXA0LOACVlnq93oey3UBM=;
 b=jFZbsW3fNWzSXVtTVtqLfUylJ9G7+7ANLZnP8Fy7QfjqoytQ3y4dVLbB2b66TPRQkPCW
 f1vjkw8ho825Slg7jsN0yqcyBu6Pr2Hbe93V+aIFFD+u2xfYgvx9+tKKD7kf4k+n7etV
 k795p3z8r7Ihi2lbJArz/vrKvgaVdp6Kpfi9lE2fexx4+dueuFknxR5rMWPOARPflOdR
 clMQMg9eezpXoYafE+9Q+afJ7KuQP586gVnFgaBkKBxp0JTpvCMhxfszGNNGs7+3zC3G
 VK9WNWEUkAeIJNcAXzyoF2zDwxgyQyummbKogQMUKq9sGp8QvZ3SU8W2uDAUN2o5ZLGr oA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd1-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 10:51:33 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:29 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.7 via Frontend Transport; Fri, 27 Jan 2023 10:51:29 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7E92511DC;
        Fri, 27 Jan 2023 16:51:29 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 8/8] ASoC: cs42l42: Wait for debounce interval after resume
Date:   Fri, 27 Jan 2023 16:51:11 +0000
Message-ID: <20230127165111.3010960-9-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aAvAmRBgvSBVNp_iapDEzhgWA-nkGonO
X-Proofpoint-GUID: aAvAmRBgvSBVNp_iapDEzhgWA-nkGonO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since clock stop causes bus reset on Intel controllers, we need
to wait for the debounce interval on resume, to ensure all the
interrupt status registers are set correctly.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42-sdw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
index 0de370b40eaf0..79023268d4c1b 100644
--- a/sound/soc/codecs/cs42l42-sdw.c
+++ b/sound/soc/codecs/cs42l42-sdw.c
@@ -447,7 +447,9 @@ static int __maybe_unused cs42l42_sdw_handle_unattach(struct cs42l42_private *cs
 
 static int __maybe_unused cs42l42_sdw_runtime_resume(struct device *dev)
 {
+	static const unsigned int ts_dbnce_ms[] = { 0, 125, 250, 500, 750, 1000, 1250, 1500};
 	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
+	unsigned int dbnce;
 	int ret;
 
 	dev_dbg(dev, "Runtime resume\n");
@@ -456,8 +458,14 @@ static int __maybe_unused cs42l42_sdw_runtime_resume(struct device *dev)
 		return 0;
 
 	ret = cs42l42_sdw_handle_unattach(cs42l42);
-	if (ret < 0)
+	if (ret < 0) {
 		return ret;
+	} else if (ret > 0) {
+		dbnce = max(cs42l42->ts_dbnc_rise, cs42l42->ts_dbnc_fall);
+
+		if (dbnce > 0)
+			msleep(ts_dbnce_ms[dbnce]);
+	}
 
 	regcache_cache_only(cs42l42->regmap, false);
 
-- 
2.34.1

