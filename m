Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B97A633536
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKVGYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKVGYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:24:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08662D765;
        Mon, 21 Nov 2022 22:24:51 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGZ3T5WvHzRpNR;
        Tue, 22 Nov 2022 14:24:21 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 14:24:50 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 14:24:49 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <pavel@ucw.cz>, <andersson@kernel.org>, <swboyd@chromium.org>,
        <quic_c_skakit@quicinc.com>, <marijn.suijten@somainline.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH] leds: call of_node_put() when breaking out of for_each_available_child_of_node()
Date:   Tue, 22 Nov 2022 06:50:02 +0000
Message-ID: <20221122065002.2327772-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Since for_each_available_child_of_node() will increase the refcount of
node, we need to call of_node_put() manually when breaking out of the
iteration.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 02f51cc61837..8075115cef58 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1084,7 +1084,7 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 	ret = of_property_read_u32(np, "color", &color);
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
-		return ret;
+		goto err_put_np_node;
 	}
 
 	if (color == LED_COLOR_ID_RGB)
@@ -1093,21 +1093,25 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		num_channels = 1;
 
 	led = devm_kzalloc(lpg->dev, struct_size(led, channels, num_channels), GFP_KERNEL);
-	if (!led)
-		return -ENOMEM;
+	if (!led) {
+		ret = -ENOMEM
+		goto err_put_np_node;
+	}
 
 	led->lpg = lpg;
 	led->num_channels = num_channels;
 
 	if (color == LED_COLOR_ID_RGB) {
 		info = devm_kcalloc(lpg->dev, num_channels, sizeof(*info), GFP_KERNEL);
-		if (!info)
-			return -ENOMEM;
+		if (!info) {
+			ret = -ENOMEM
+			goto err_put_np_node;
+		}
 		i = 0;
 		for_each_available_child_of_node(np, child) {
 			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
 			if (ret < 0)
-				return ret;
+				goto err_put_child_node;
 
 			info[i].color_index = led->channels[i]->color;
 			info[i].intensity = 0;
@@ -1129,7 +1133,7 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 	} else {
 		ret = lpg_parse_channel(lpg, np, &led->channels[0]);
 		if (ret < 0)
-			return ret;
+			goto err_put_np_node;
 
 		cdev = &led->cdev;
 		cdev->brightness_set = lpg_brightness_single_set;
@@ -1161,7 +1165,15 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
 		ret = devm_led_classdev_register_ext(lpg->dev, &led->cdev, &init_data);
 	if (ret)
 		dev_err(lpg->dev, "unable to register %s\n", cdev->name);
+	else
+		return ret;
+
+err_put_np_node:
+	of_node_put(np);
+	return ret;
 
+err_put_child_node:
+	of_node_put(child);
 	return ret;
 }
 
-- 
2.25.1

