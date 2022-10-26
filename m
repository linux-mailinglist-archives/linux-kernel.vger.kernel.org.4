Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB7F60D9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiJZDfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiJZDe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:34:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8A33E0A;
        Tue, 25 Oct 2022 20:34:51 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxvVN1ckzzpVrr;
        Wed, 26 Oct 2022 11:31:24 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:34:49 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 11:34:49 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: [RFC PATCH 2/2] rtc: fix race condition in rtc_set_time()
Date:   Wed, 26 Oct 2022 11:33:48 +0800
Message-ID: <20221026033348.1660732-3-liaoyu15@huawei.com>
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

Commit 7e7c005b4b1f ("rtc: disable uie before setting time and enable
after") was introduced to solve problem that rtc_timer_do_work will loop
for a while, when setting the time in the future with the uie timer
enabled. But reading uie timer state and setting rtc time are not in
a critical section, a race condition may occur in rtc_set_time which
has two issues:

1) In the above scenario, rtc_timer_do_work may still loop for a while.
   For example consider the following sequence:

   CPU0					CPU1
   ----					----
   ioctl(RTC_SET_TIME)			ioctl(RTC_UIE_ON)
   uie = rtc->uie_rtctimer.enabled;
   [ assume uie is 0 ]
   if (uie)
   	rtc_update_irq_enable(rtc, 0);

   					rtc_update_irq_enable(rtc, 1);
   					[ uie is enabled ]
   rtc->ops->set_time();
   [ set rtc time in the future ]

2) A thread try to turn off uie, however rtc_settime called by another
   thread turns on uie when they run in parallel. Consider the following
   sequence:

   CPU0					CPU1
   ----					----
   ioctl(RTC_SET_TIME)			ioctl(RTC_UIE_OFF)
   rtc->ops->set_time();
   					rtc_update_irq_enable(rtc, 0);
   rtc_update_irq_enable(rtc, 1);

Fix it by guaranteeing that reading uie timer state, setting rtc time
and enabling uie timer within a critical section.

Fixes: 7e7c005b4b1f ("rtc: disable uie before setting time and enable after")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/rtc/interface.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index bc55dd31bece..00a6173d8895 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -139,21 +139,21 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 
 	rtc_subtract_offset(rtc, tm);
 
+	err = mutex_lock_interruptible(&rtc->ops_lock);
+	if (err)
+		return err;
+
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	uie = rtc->uie_rtctimer.enabled || rtc->uie_irq_active;
 #else
 	uie = rtc->uie_rtctimer.enabled;
 #endif
 	if (uie) {
-		err = rtc_update_irq_enable(rtc, 0);
+		err = __rtc_update_irq_enable(rtc, 0);
 		if (err)
 			return err;
 	}
 
-	err = mutex_lock_interruptible(&rtc->ops_lock);
-	if (err)
-		return err;
-
 	if (!rtc->ops)
 		err = -ENODEV;
 	else if (rtc->ops->set_time)
@@ -162,15 +162,15 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 		err = -EINVAL;
 
 	pm_stay_awake(rtc->dev.parent);
-	mutex_unlock(&rtc->ops_lock);
 	/* A timer might have just expired */
 	schedule_work(&rtc->irqwork);
 
 	if (uie) {
-		err = rtc_update_irq_enable(rtc, 1);
+		err = __rtc_update_irq_enable(rtc, 1);
 		if (err)
 			return err;
 	}
+	mutex_unlock(&rtc->ops_lock);
 
 	trace_rtc_set_time(rtc_tm_to_time64(tm), err);
 	return err;
-- 
2.25.1

