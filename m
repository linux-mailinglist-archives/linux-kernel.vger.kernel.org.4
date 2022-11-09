Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A762256C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKII2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiKII14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6522913F99;
        Wed,  9 Nov 2022 00:27:55 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6dPr56sDzRnvt;
        Wed,  9 Nov 2022 16:27:44 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:53 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Christian Mauderer <oss@c-mauderer.de>
Subject: [PATCH 12/13] leds: spi-byte: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:13 +0800
Message-ID: <1667983694-15040-13-git-send-email-wangyufen@huawei.com>
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

Fixes: e9a804d7a428 ("leds: spi-byte: add single byte SPI LED driver")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Christian Mauderer <oss@c-mauderer.de>
---
 drivers/leds/leds-spi-byte.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index 2bc5c99..a169780 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -78,6 +78,11 @@ static int spi_byte_brightness_set_blocking(struct led_classdev *dev,
 	return ret;
 }
 
+static void spi_byte_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int spi_byte_probe(struct spi_device *spi)
 {
 	struct device_node *child;
@@ -101,6 +106,10 @@ static int spi_byte_probe(struct spi_device *spi)
 	strlcpy(led->name, name, sizeof(led->name));
 	led->spi = spi;
 	mutex_init(&led->mutex);
+	ret = devm_add_action_or_reset(dev, spi_byte_mutex_destroy,
+				       &led->mutex);
+	if (ret)
+		return ret;
 	led->cdef = device_get_match_data(dev);
 	led->ldev.name = led->name;
 	led->ldev.brightness = LED_OFF;
@@ -121,25 +130,15 @@ static int spi_byte_probe(struct spi_device *spi)
 					 led->ldev.brightness);
 
 	ret = devm_led_classdev_register(&spi->dev, &led->ldev);
-	if (ret) {
-		mutex_destroy(&led->mutex);
+	if (ret)
 		return ret;
-	}
 	spi_set_drvdata(spi, led);
 
 	return 0;
 }
 
-static void spi_byte_remove(struct spi_device *spi)
-{
-	struct spi_byte_led	*led = spi_get_drvdata(spi);
-
-	mutex_destroy(&led->mutex);
-}
-
 static struct spi_driver spi_byte_driver = {
 	.probe		= spi_byte_probe,
-	.remove		= spi_byte_remove,
 	.driver = {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= spi_byte_dt_ids,
-- 
1.8.3.1

