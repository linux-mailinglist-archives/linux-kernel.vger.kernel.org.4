Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C853622568
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKII2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKII1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:27:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051E13D5E;
        Wed,  9 Nov 2022 00:27:54 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6dPl45LczmVnk;
        Wed,  9 Nov 2022 16:27:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:27:52 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel@ucw.cz>, Wang Yufen <wangyufen@huawei.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 09/13] leds: mt6323: Fix devm vs. non-devm ordering
Date:   Wed, 9 Nov 2022 16:48:10 +0800
Message-ID: <1667983694-15040-10-git-send-email-wangyufen@huawei.com>
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

Fixes: 216ec6cc4c19 ("leds: Add LED support for MT6323 PMIC")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Cc: Sean Wang <sean.wang@mediatek.com>
---
 drivers/leds/leds-mt6323.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index f59e0e8..2dacaca 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -361,6 +361,11 @@ static int mt6323_led_set_dt_default(struct led_classdev *cdev,
 	return ret;
 }
 
+static void mt6323_led_mutex_destroy(void *lock)
+{
+	mutex_destroy(lock);
+}
+
 static int mt6323_led_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -386,6 +391,10 @@ static int mt6323_led_probe(struct platform_device *pdev)
 	 */
 	leds->hw = hw;
 	mutex_init(&leds->lock);
+	ret = devm_add_action_or_reset(dev, mt6323_led_mutex_destroy,
+				       &leds->lock);
+	if (ret)
+		return ret;
 
 	status = MT6323_RG_DRV_32K_CK_PDN;
 	ret = regmap_update_bits(leds->hw->regmap, MT6323_TOP_CKPDN0,
@@ -464,8 +473,6 @@ static int mt6323_led_remove(struct platform_device *pdev)
 			   MT6323_RG_DRV_32K_CK_PDN_MASK,
 			   MT6323_RG_DRV_32K_CK_PDN);
 
-	mutex_destroy(&leds->lock);
-
 	return 0;
 }
 
-- 
1.8.3.1

