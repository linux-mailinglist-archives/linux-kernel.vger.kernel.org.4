Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8196273F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiKNAxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKNAxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:53:14 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F80DE9D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:53:13 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9W4V51l4zHvqK;
        Mon, 14 Nov 2022 08:52:42 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:53:11 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:53:10 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <p.zabel@pengutronix.de>, <hayashi.kunihiko@socionext.com>,
        <mhiramat@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>
Subject: [PATCH] reset: uniphier-glue: Fix possible null-ptr-deref
Date:   Mon, 14 Nov 2022 08:49:58 +0800
Message-ID: <20221114004958.258513-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will cause null-ptr-deref when resource_size(res) invoked,
if platform_get_resource() returns NULL.

Fixes: 499fef09a323 ("reset: uniphier: add USB3 core reset control")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/reset/reset-uniphier-glue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
index 146fd5d45e99..15abac9fc72c 100644
--- a/drivers/reset/reset-uniphier-glue.c
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -47,7 +47,6 @@ static int uniphier_glue_reset_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct uniphier_glue_reset_priv *priv;
 	struct resource *res;
-	resource_size_t size;
 	int i, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -60,7 +59,6 @@ static int uniphier_glue_reset_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	size = resource_size(res);
 	priv->rdata.membase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(priv->rdata.membase))
 		return PTR_ERR(priv->rdata.membase);
@@ -96,7 +94,7 @@ static int uniphier_glue_reset_probe(struct platform_device *pdev)
 
 	spin_lock_init(&priv->rdata.lock);
 	priv->rdata.rcdev.owner = THIS_MODULE;
-	priv->rdata.rcdev.nr_resets = size * BITS_PER_BYTE;
+	priv->rdata.rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
 	priv->rdata.rcdev.ops = &reset_simple_ops;
 	priv->rdata.rcdev.of_node = dev->of_node;
 	priv->rdata.active_low = true;
-- 
2.17.1

