Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78560D9F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiJZDfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJZDex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:34:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1B231DC5;
        Tue, 25 Oct 2022 20:34:50 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxvSn55RlzVjB5;
        Wed, 26 Oct 2022 11:30:01 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:34:48 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 11:34:48 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: [RFC PATCH 1/2] rtc: add lockless rtc_update_irq_enable
Date:   Wed, 26 Oct 2022 11:33:47 +0800
Message-ID: <20221026033348.1660732-2-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026033348.1660732-1-liaoyu15@huawei.com>
References: <20221026033348.1660732-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out a function that does not acquire rtc->ops_lock from
rtc_update_irq_enable, in preparation for fixing race condition in
rtc_set_time.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/rtc/interface.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9edd662c69ac..bc55dd31bece 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -19,6 +19,7 @@
 
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer);
 static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer);
+static int __rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled);
 
 static void rtc_add_offset(struct rtc_device *rtc, struct rtc_time *tm)
 {
@@ -81,6 +82,7 @@ static int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
 	return 0;
 }
 
+/* This function must be called with rtc->ops_lock held */
 static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 {
 	int err;
@@ -553,27 +555,21 @@ int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 }
 EXPORT_SYMBOL_GPL(rtc_alarm_irq_enable);
 
-int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
+static int __rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 {
-	int err;
-
-	err = mutex_lock_interruptible(&rtc->ops_lock);
-	if (err)
-		return err;
+	int err = 0;
 
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	if (enabled == 0 && rtc->uie_irq_active) {
-		mutex_unlock(&rtc->ops_lock);
 		return rtc_dev_update_irq_enable_emul(rtc, 0);
 	}
 #endif
 	/* make sure we're changing state */
 	if (rtc->uie_rtctimer.enabled == enabled)
-		goto out;
+		return err;
 
 	if (!test_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features) ||
 	    !test_bit(RTC_FEATURE_ALARM, rtc->features)) {
-		mutex_unlock(&rtc->ops_lock);
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 		return rtc_dev_update_irq_enable_emul(rtc, enabled);
 #else
@@ -587,7 +583,7 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 
 		err = __rtc_read_time(rtc, &tm);
 		if (err)
-			goto out;
+			return err;
 		onesec = ktime_set(1, 0);
 		now = rtc_tm_to_ktime(tm);
 		rtc->uie_rtctimer.node.expires = ktime_add(now, onesec);
@@ -597,7 +593,19 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		rtc_timer_remove(rtc, &rtc->uie_rtctimer);
 	}
 
-out:
+	return err;
+}
+
+int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
+{
+	int err;
+
+	err = mutex_lock_interruptible(&rtc->ops_lock);
+	if (err)
+		return err;
+
+	err = __rtc_update_irq_enable(rtc, enabled);
+
 	mutex_unlock(&rtc->ops_lock);
 
 	return err;
-- 
2.25.1

