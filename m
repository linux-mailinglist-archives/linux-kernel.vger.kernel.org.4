Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0C1622562
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKII2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKII1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D646E13D16;
        Wed,  9 Nov 2022 00:27:50 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6dPS2L5VzHvg6;
        Wed,  9 Nov 2022 16:27:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:48 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH 01/13] leds: cr0014114: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:02 +0800
Message-ID: <1667983694-15040-2-git-send-email-wangyufen@huawei.com>
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

Fixes: 9e50d5fb0d18 ("leds: add LED driver for CR0014114 board")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 drivers/leds/leds-cr0014114.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index c87686b..f3a0320 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -211,6 +211,11 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
 	return 0;
 }
 
+static void cr0014114_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int cr0014114_probe(struct spi_device *spi)
 {
 	struct cr0014114	*priv;
@@ -240,6 +245,11 @@ static int cr0014114_probe(struct spi_device *spi)
 	priv->delay	= jiffies -
 			  msecs_to_jiffies(CR_FW_DELAY_MSEC);
 
+	ret = devm_add_action_or_reset(&spi->dev, cr0014114_mutex_destroy,
+				       &priv->lock);
+	if (ret)
+		return ret;
+
 	priv->do_recount = true;
 	ret = cr0014114_sync(priv);
 	if (ret) {
@@ -271,7 +281,6 @@ static void cr0014114_remove(struct spi_device *spi)
 	struct cr0014114 *priv = spi_get_drvdata(spi);
 
 	cancel_delayed_work_sync(&priv->work);
-	mutex_destroy(&priv->lock);
 }
 
 static const struct of_device_id cr0014114_dt_ids[] = {
-- 
1.8.3.1

