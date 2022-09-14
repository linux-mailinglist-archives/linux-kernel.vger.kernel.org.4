Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077115B7F78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiINDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiINDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:33:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7075A8B0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:33:52 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MS5VF0xnXzHnsX;
        Wed, 14 Sep 2022 11:31:49 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 11:33:50 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 14 Sep
 2022 11:33:50 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <verdun@hpe.com>, <nick.hawkins@hpe.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clocksource/drivers/timer-gxp: Add missing error handling in gxp_timer_probe
Date:   Wed, 14 Sep 2022 11:30:18 +0800
Message-ID: <20220914033018.97484-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform_device_put() to make sure to free the platform
device in the event platform_device_add() fails.

Fixes: 5184f4bf151b ("clocksource/drivers/timer-gxp: Add HPE GXP Timer")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 drivers/clocksource/timer-gxp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index 8b38b3212388..fe4fa8d7b3f1 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -171,6 +171,7 @@ static int gxp_timer_probe(struct platform_device *pdev)
 {
 	struct platform_device *gxp_watchdog_device;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	if (!gxp_timer) {
 		pr_err("Gxp Timer not initialized, cannot create watchdog");
@@ -187,7 +188,11 @@ static int gxp_timer_probe(struct platform_device *pdev)
 	gxp_watchdog_device->dev.platform_data = gxp_timer->counter;
 	gxp_watchdog_device->dev.parent = dev;
 
-	return platform_device_add(gxp_watchdog_device);
+	ret = platform_device_add(gxp_watchdog_device);
+	if (ret)
+		platform_device_put(gxp_watchdog_device);
+
+	return ret;
 }
 
 static const struct of_device_id gxp_timer_of_match[] = {
-- 
2.17.1

