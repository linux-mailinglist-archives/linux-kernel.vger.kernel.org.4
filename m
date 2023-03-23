Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C636C6151
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCWIKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCWIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:09:59 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4159F7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:09:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeTX4HA_1679558994;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VeTX4HA_1679558994)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 16:09:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     nm@ti.com
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] soc: ti: Use devm_platform_ioremap_resource()
Date:   Thu, 23 Mar 2023 16:09:52 +0800
Message-Id: <20230323080952.124410-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit 7945f929f1a7 ("drivers: provide
devm_platform_ioremap_resource()"), convert platform_get_resource(),
devm_ioremap_resource() to a single call to use
devm_platform_ioremap_resource(), as this is exactly what this function
does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 6970478b40f3..c9197912ec24 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -615,7 +615,6 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	int irq, ret, temp;
 	phandle rproc_phandle;
 	struct rproc *m3_rproc;
-	struct resource *res;
 	struct task_struct *task;
 	struct wkup_m3_ipc *m3_ipc;
 	struct device_node *np = dev->of_node;
@@ -624,8 +623,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 	if (!m3_ipc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	m3_ipc->ipc_mem_base = devm_ioremap_resource(dev, res);
+	m3_ipc->ipc_mem_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(m3_ipc->ipc_mem_base))
 		return PTR_ERR(m3_ipc->ipc_mem_base);
 
-- 
2.20.1.7.g153144c

