Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2863163FDA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiLBBYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLBBYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:24:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3405695830;
        Thu,  1 Dec 2022 17:24:47 -0800 (PST)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NNZsD0JNxzJp4h;
        Fri,  2 Dec 2022 09:21:20 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 09:24:44 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <andrzej.p@collabora.com>, <yiyang13@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] usb: fotg210-udc: fix potential memory leak in fotg210_udc_probe()
Date:   Fri, 2 Dec 2022 09:21:26 +0800
Message-ID: <20221202012126.246953-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fotg210_udc_probe(), if devm_clk_get() or clk_prepare_enable()
fails, 'fotg210' will not be freed, which will lead to a memory leak.
Fix it by moving kfree() to a proper location.

In addition，we can use "return -ENOMEM" instead of "goto err"
to simplify the code.

Fixes: 718a38d092ec ("fotg210-udc: Handle PCLK")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
v2:
-Use "return -ENOMEM" instead of "goto err"
 drivers/usb/fotg210/fotg210-udc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index b9ea6c6d931c..66e1b7ee3346 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1163,12 +1163,10 @@ int fotg210_udc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = -ENOMEM;
-
 	/* initialize udc */
 	fotg210 = kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
 	if (fotg210 == NULL)
-		goto err;
+		return -ENOMEM;
 
 	fotg210->dev = dev;
 
@@ -1178,7 +1176,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(fotg210->pclk);
 		if (ret) {
 			dev_err(dev, "failed to enable PCLK\n");
-			return ret;
+			goto err;
 		}
 	} else if (PTR_ERR(fotg210->pclk) == -EPROBE_DEFER) {
 		/*
@@ -1302,8 +1300,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
 	if (!IS_ERR(fotg210->pclk))
 		clk_disable_unprepare(fotg210->pclk);
 
-	kfree(fotg210);
-
 err:
+	kfree(fotg210);
 	return ret;
 }
-- 
2.17.1

