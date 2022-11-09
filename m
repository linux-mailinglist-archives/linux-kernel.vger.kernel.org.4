Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156B9622563
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiKII2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKII1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:53 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D8013D63;
        Wed,  9 Nov 2022 00:27:52 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6dPj35N4zmVlR;
        Wed,  9 Nov 2022 16:27:37 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:49 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 04/13] leds: lm3692x: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:05 +0800
Message-ID: <1667983694-15040-5-git-send-email-wangyufen@huawei.com>
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

Fixes: 9699cb6bbef2 ("leds: lm3692x: Introduce LM3692x dual string driver")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3692x.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 54b4662..aa1b0cc 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -456,6 +456,11 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 	return ret;
 }
 
+static void lm3692x_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int lm3692x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -472,6 +477,11 @@ static int lm3692x_probe(struct i2c_client *client,
 	led->model_id = id->driver_data;
 	i2c_set_clientdata(client, led);
 
+	ret = devm_add_action_or_reset(&client->dev, lm3692x_mutex_destroy,
+				       &led->lock);
+	if (ret)
+		return ret;
+
 	led->regmap = devm_regmap_init_i2c(client, &lm3692x_regmap_config);
 	if (IS_ERR(led->regmap)) {
 		ret = PTR_ERR(led->regmap);
@@ -496,7 +506,6 @@ static void lm3692x_remove(struct i2c_client *client)
 	struct lm3692x_led *led = i2c_get_clientdata(client);
 
 	lm3692x_leds_disable(led);
-	mutex_destroy(&led->lock);
 }
 
 static const struct i2c_device_id lm3692x_id[] = {
-- 
1.8.3.1

