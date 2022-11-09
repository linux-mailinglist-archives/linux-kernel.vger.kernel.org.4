Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8AD622566
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKII22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKII1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCB513E9E;
        Wed,  9 Nov 2022 00:27:53 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6dPl0SP1z15MVD;
        Wed,  9 Nov 2022 16:27:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:51 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 06/13] leds: lp50xx: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:07 +0800
Message-ID: <1667983694-15040-7-git-send-email-wangyufen@huawei.com>
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

Fixes: 242b81170fb8 ("leds: lp50xx: Add the LP50XX family of the RGB LED driver")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lp50xx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 28d6b39..fcec568e 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -521,6 +521,11 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 	return ret;
 }
 
+static void lp50xx_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int lp50xx_probe(struct i2c_client *client)
 {
 	struct lp50xx *led;
@@ -539,6 +544,11 @@ static int lp50xx_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&led->lock);
+	ret = devm_add_action_or_reset(&client->dev, lp50xx_mutex_destroy,
+				       &led->lock);
+	if (ret)
+		return ret;
+
 	led->client = client;
 	led->dev = &client->dev;
 	led->chip_info = device_get_match_data(&client->dev);
@@ -577,8 +587,6 @@ static void lp50xx_remove(struct i2c_client *client)
 		if (ret)
 			dev_err(led->dev, "Failed to disable regulator\n");
 	}
-
-	mutex_destroy(&led->lock);
 }
 
 static const struct i2c_device_id lp50xx_id[] = {
-- 
1.8.3.1

