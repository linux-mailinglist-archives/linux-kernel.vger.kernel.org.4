Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E229B62256B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKII2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiKII14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DDF1B9F5;
        Wed,  9 Nov 2022 00:27:55 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6dPs10w4zRp7v;
        Wed,  9 Nov 2022 16:27:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:53 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 13/13] leds: rt8515: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:14 +0800
Message-ID: <1667983694-15040-14-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When non-devm resources are allocated they mustn't be followed by devm
allocations, otherwise it will break the tear down ordering and might
lead to crashes or other bugs during ->remove() stage. Fix this by
wrapping mutex_destroy() call with devm_add_action_or_reset().

Fixes: e1c6edcbea13 ("leds: rt8515: Add Richtek RT8515 LED driver")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/leds/flash/leds-rt8515.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-rt8515.c b/drivers/leds/flash/leds-rt8515.c
index 44904fde..f2d92ea 100644
--- a/drivers/leds/flash/leds-rt8515.c
+++ b/drivers/leds/flash/leds-rt8515.c
@@ -273,6 +273,11 @@ static void rt8515_determine_max_intensity(struct rt8515 *rt,
 	*max_intensity_setting = max_intensity;
 }
 
+static void rt8515_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int rt8515_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -338,13 +343,16 @@ static int rt8515_probe(struct platform_device *pdev)
 	led->flags |= LED_CORE_SUSPENDRESUME | LED_DEV_CAP_FLASH;
 
 	mutex_init(&rt->lock);
+	ret = devm_add_action_or_reset(dev, rt8515_mutex_destroy,
+				       &rt->lock);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, rt);
 
 	ret = devm_led_classdev_flash_register_ext(dev, fled, &init_data);
 	if (ret) {
 		fwnode_handle_put(child);
-		mutex_destroy(&rt->lock);
 		dev_err(dev, "can't register LED %s\n", led->name);
 		return ret;
 	}
@@ -373,7 +381,6 @@ static int rt8515_remove(struct platform_device *pdev)
 
 	rt8515_v4l2_flash_release(rt);
 	del_timer_sync(&rt->powerdown_timer);
-	mutex_destroy(&rt->lock);
 
 	return 0;
 }
-- 
1.8.3.1

