Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED762255D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKII2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiKII1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176FE13D5E;
        Wed,  9 Nov 2022 00:27:51 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6dPh2thDzmVjq;
        Wed,  9 Nov 2022 16:27:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:49 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:03 +0800
Message-ID: <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
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

Fixes: fc19967bcb8f ("leds: add LED driver for EL15203000 board")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 drivers/leds/leds-el15203000.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
index 7e7b617..9be934e 100644
--- a/drivers/leds/leds-el15203000.c
+++ b/drivers/leds/leds-el15203000.c
@@ -287,10 +287,16 @@ static int el15203000_probe_dt(struct el15203000 *priv)
 	return ret;
 }
 
+static void el15203000_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int el15203000_probe(struct spi_device *spi)
 {
 	struct el15203000	*priv;
 	size_t			count;
+	int			ret;
 
 	count = device_get_child_node_count(&spi->dev);
 	if (!count) {
@@ -312,15 +318,14 @@ static int el15203000_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, priv);
 
+	ret = devm_add_action_or_reset(&spi->dev, el15203000_mutex_destroy,
+				       &priv->lock);
+	if (ret)
+		return ret;
+
 	return el15203000_probe_dt(priv);
 }
 
-static void el15203000_remove(struct spi_device *spi)
-{
-	struct el15203000 *priv = spi_get_drvdata(spi);
-
-	mutex_destroy(&priv->lock);
-}
 
 static const struct of_device_id el15203000_dt_ids[] = {
 	{ .compatible = "crane,el15203000", },
@@ -331,7 +336,6 @@ static void el15203000_remove(struct spi_device *spi)
 
 static struct spi_driver el15203000_driver = {
 	.probe		= el15203000_probe,
-	.remove		= el15203000_remove,
 	.driver = {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= el15203000_dt_ids,
-- 
1.8.3.1

