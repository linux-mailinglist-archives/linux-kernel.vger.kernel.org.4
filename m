Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DE660DAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiJZFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiJZFek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:34:40 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E797511178;
        Tue, 25 Oct 2022 22:34:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VT5r56a_1666762474;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VT5r56a_1666762474)
          by smtp.aliyun-inc.com;
          Wed, 26 Oct 2022 13:34:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] firmware: tegra: Remove surplus dev_err() when using platform_get_irq_byname()
Date:   Wed, 26 Oct 2022 13:34:33 +0800
Message-Id: <20221026053433.58529-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

./drivers/firmware/tegra/bpmp-tegra210.c:204:2-9: line 204 is redundant
because platform_get_irq() already prints an error
./drivers/firmware/tegra/bpmp-tegra210.c:216:2-9: line 216 is redundant
because platform_get_irq() already prints an error

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2579
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/firmware/tegra/bpmp-tegra210.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-tegra210.c b/drivers/firmware/tegra/bpmp-tegra210.c
index 6421e11954f6..6295f5640c15 100644
--- a/drivers/firmware/tegra/bpmp-tegra210.c
+++ b/drivers/firmware/tegra/bpmp-tegra210.c
@@ -200,10 +200,8 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 	}
 
 	err = platform_get_irq_byname(pdev, "tx");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get TX IRQ: %d\n", err);
+	if (err < 0)
 		return err;
-	}
 
 	priv->tx_irq_data = irq_get_irq_data(err);
 	if (!priv->tx_irq_data) {
@@ -212,10 +210,8 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 	}
 
 	err = platform_get_irq_byname(pdev, "rx");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get rx IRQ: %d\n", err);
+	if (err < 0)
 		return err;
-	}
 
 	err = devm_request_irq(&pdev->dev, err, rx_irq,
 			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), bpmp);
-- 
2.20.1.7.g153144c

