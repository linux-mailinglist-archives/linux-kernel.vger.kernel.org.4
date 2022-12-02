Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4676400B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiLBGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLBGyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:54:11 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D21BC58E;
        Thu,  1 Dec 2022 22:54:08 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NNkFB1c7xz4xVnH;
        Fri,  2 Dec 2022 14:54:06 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B26rtMr007050;
        Fri, 2 Dec 2022 14:53:55 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 14:53:57 +0800 (CST)
Date:   Fri, 2 Dec 2022 14:53:57 +0800 (CST)
X-Zmail-TransId: 2af96389a105fffffffff3915876
X-Mailer: Zmail v1.0
Message-ID: <202212021453578171100@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <jiangjian@cdjrlc.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jeff@labundy.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBJbnB1dDogbW91c2U6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B26rtMr007050
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6389A10E.000 by FangMail milter!
X-FangMail-Envelope: 1669964046/4NNkFB1c7xz4xVnH/6389A10E.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6389A10E.000/4NNkFB1c7xz4xVnH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
fix the code style.
 drivers/input/mouse/cyapa.c      | 17 ++++++++---------
 drivers/input/mouse/cyapa_gen3.c |  2 +-
 drivers/input/mouse/cyapa_gen5.c |  2 +-
 drivers/input/mouse/cyapa_gen6.c |  2 +-
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 77cc653edca2..897f0c2c9a05 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -756,15 +756,15 @@ static ssize_t cyapa_show_suspend_scanrate(struct device *dev,

 	switch (pwr_cmd) {
 	case PWR_MODE_BTN_ONLY:
-		len = scnprintf(buf, PAGE_SIZE, "%s\n", BTN_ONLY_MODE_NAME);
+		len = sysfs_emit(buf, "%s\n", BTN_ONLY_MODE_NAME);
 		break;

 	case PWR_MODE_OFF:
-		len = scnprintf(buf, PAGE_SIZE, "%s\n", OFF_MODE_NAME);
+		len = sysfs_emit(buf, "%s\n", OFF_MODE_NAME);
 		break;

 	default:
-		len = scnprintf(buf, PAGE_SIZE, "%u\n",
+		len = sysfs_emit(buf, "%u\n",
 				cyapa->gen == CYAPA_GEN3 ?
 					cyapa_pwr_cmd_to_sleep_time(pwr_cmd) :
 					sleep_time);
@@ -877,8 +877,8 @@ static ssize_t cyapa_show_rt_suspend_scanrate(struct device *dev,

 	mutex_unlock(&cyapa->state_sync_lock);

-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 cyapa->gen == CYAPA_GEN3 ?
+	return sysfs_emit(buf, "%u\n",
+			cyapa->gen == CYAPA_GEN3 ?
 				cyapa_pwr_cmd_to_sleep_time(pwr_cmd) :
 				sleep_time);
 }
@@ -988,8 +988,7 @@ static ssize_t cyapa_show_fm_ver(struct device *dev,
 	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
 	if (error)
 		return error;
-	error = scnprintf(buf, PAGE_SIZE, "%d.%d\n", cyapa->fw_maj_ver,
-			 cyapa->fw_min_ver);
+	error = sysfs_emit(buf, "%d.%d\n", cyapa->fw_maj_ver, cyapa->fw_min_ver);
 	mutex_unlock(&cyapa->state_sync_lock);
 	return error;
 }
@@ -1004,7 +1003,7 @@ static ssize_t cyapa_show_product_id(struct device *dev,
 	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
 	if (error)
 		return error;
-	size = scnprintf(buf, PAGE_SIZE, "%s\n", cyapa->product_id);
+	size = sysfs_emit(buf, "%s\n", cyapa->product_id);
 	mutex_unlock(&cyapa->state_sync_lock);
 	return size;
 }
@@ -1209,7 +1208,7 @@ static ssize_t cyapa_show_mode(struct device *dev,
 	if (error)
 		return error;

-	size = scnprintf(buf, PAGE_SIZE, "gen%d %s\n",
+	size = sysfs_emit(buf, "gen%d %s\n",
 			cyapa->gen, cyapa_state_to_string(cyapa));

 	mutex_unlock(&cyapa->state_sync_lock);
diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index a97f4acb6452..60c83bc71d84 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -860,7 +860,7 @@ static ssize_t cyapa_gen3_show_baseline(struct device *dev,

 	dev_dbg(dev, "Baseline report successful. Max: %d Min: %d\n",
 		max_baseline, min_baseline);
-	ret = scnprintf(buf, PAGE_SIZE, "%d %d\n", max_baseline, min_baseline);
+	ret = sysfs_emit(buf, "%d %d\n", max_baseline, min_baseline);

 out:
 	return ret;
diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index abf42f77b4c5..4c57036e4281 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -2418,7 +2418,7 @@ static ssize_t cyapa_gen5_show_baseline(struct device *dev,
 		return resume_error ? resume_error : error;

 	/* 12. Output data strings */
-	size = scnprintf(buf, PAGE_SIZE, "%d %d %d %d %d %d %d %d %d %d %d ",
+	size = sysfs_emit(buf, "%d %d %d %d %d %d %d %d %d %d %d ",
 		gidac_mutual_min, gidac_mutual_max, gidac_mutual_ave,
 		lidac_mutual_min, lidac_mutual_max, lidac_mutual_ave,
 		gidac_self_rx, gidac_self_tx,
diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 0caaf3e64215..b6f7c77c96c2 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -629,7 +629,7 @@ static ssize_t cyapa_gen6_show_baseline(struct device *dev,
 	if (error)
 		goto resume_scanning;

-	size = scnprintf(buf, PAGE_SIZE, "%d %d %d %d %d %d ",
+	size = sysfs_emit(buf, "%d %d %d %d %d %d ",
 			data[0],  /* RX Attenuator Mutual */
 			data[1],  /* IDAC Mutual */
 			data[2],  /* RX Attenuator Self RX */
-- 
2.25.1
