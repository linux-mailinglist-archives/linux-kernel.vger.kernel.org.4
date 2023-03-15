Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC66BA71E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCOFc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCOFc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:32:28 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638B1CAD6;
        Tue, 14 Mar 2023 22:31:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VdumAc3_1678858288;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdumAc3_1678858288)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 13:31:29 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ulf.hansson@linaro.org
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] mmc: jz4740: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 15 Mar 2023 13:31:27 +0800
Message-Id: <20230315053127.33855-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mmc/host/jz4740_mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 698450afa7bb..1846a05210e3 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1079,8 +1079,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_host;
 	}
 
-	host->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host->base = devm_ioremap_resource(&pdev->dev, host->mem_res);
+	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &host->mem_res);
 	if (IS_ERR(host->base)) {
 		ret = PTR_ERR(host->base);
 		goto err_free_host;
-- 
2.20.1.7.g153144c

