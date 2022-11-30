Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD363D2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiK3KQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiK3KP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:15:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61BF61;
        Wed, 30 Nov 2022 02:15:57 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMZpC0DgPzmVxP;
        Wed, 30 Nov 2022 18:15:15 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 18:15:55 +0800
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 18:15:55 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <linus.walleij@linaro.org>, <gregkh@linuxfoundation.org>,
        <yiyang13@huawei.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: fotg210-udc: fix potential memory leak in fotg210_udc_probe()
Date:   Wed, 30 Nov 2022 18:12:51 +0800
Message-ID: <20221130101251.245399-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Fixes: 718a38d092ec ("fotg210-udc: Handle PCLK")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/usb/fotg210/fotg210-udc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index b9ea6c6d931c..a366d69c1818 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1178,7 +1178,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
 		ret = clk_prepare_enable(fotg210->pclk);
 		if (ret) {
 			dev_err(dev, "failed to enable PCLK\n");
-			return ret;
+			goto err;
 		}
 	} else if (PTR_ERR(fotg210->pclk) == -EPROBE_DEFER) {
 		/*
@@ -1302,8 +1302,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
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

