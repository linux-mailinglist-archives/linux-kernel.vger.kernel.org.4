Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2D6F7F5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjEEIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEEIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:50:08 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6524D18916
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:50:06 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QCPVY6jCwzpW7r;
        Fri,  5 May 2023 16:48:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:50:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] irqchip/mbigen: unify the error handling in mbigen_of_create_domain()
Date:   Fri, 5 May 2023 17:06:54 +0800
Message-ID: <20230505090654.12793-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter reported that commit fea087fc291b "irqchip/mbigen: move
to use bus_get_dev_root()" leads to the following Smatch static checker
warning:

	drivers/irqchip/irq-mbigen.c:258 mbigen_of_create_domain()
	error: potentially dereferencing uninitialized 'child'.

It should not cause a problem on real hardware, but better to fix the
warning, let's move the bus_get_dev_root() out of the loop, and unify
the error handling to silence it.

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index eada5e0e3eb9..5101a3fb11df 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -240,26 +240,27 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
+	int ret = 0;
+
+	parent = bus_get_dev_root(&platform_bus_type);
+	if (!parent)
+		return -ENODEV;
 
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
-		parent = bus_get_dev_root(&platform_bus_type);
-		if (parent) {
-			child = of_platform_device_create(np, NULL, parent);
-			put_device(parent);
-			if (!child) {
-				of_node_put(np);
-				return -ENOMEM;
-			}
+		child = of_platform_device_create(np, NULL, parent);
+		if (!child) {
+			ret = -ENOMEM;
+			break;
 		}
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
 			dev_err(&pdev->dev, "No num-pins property\n");
-			of_node_put(np);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		domain = platform_msi_create_device_domain(&child->dev, num_pins,
@@ -267,12 +268,16 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 							   &mbigen_domain_ops,
 							   mgn_chip);
 		if (!domain) {
-			of_node_put(np);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			break;
 		}
 	}
 
-	return 0;
+	put_device(parent);
+	if (ret)
+		of_node_put(np);
+
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.35.3

