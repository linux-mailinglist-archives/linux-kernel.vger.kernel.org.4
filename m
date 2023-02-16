Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D07698D14
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBPGeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBPGeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:34:15 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF941B5A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:34:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbnN4Hk_1676529245;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VbnN4Hk_1676529245)
          by smtp.aliyun-inc.com;
          Thu, 16 Feb 2023 14:34:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     xueshuai@linux.alibaba.com
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drivers/perf: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 16 Feb 2023 14:34:03 +0800
Message-Id: <20230216063403.9753-1-yang.lee@linux.alibaba.com>
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

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index a7689fecb49d..5c5be9fc1b15 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -656,8 +656,7 @@ static int ali_drw_pmu_probe(struct platform_device *pdev)
 	drw_pmu->dev = &pdev->dev;
 	platform_set_drvdata(pdev, drw_pmu);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drw_pmu->cfg_base = devm_ioremap_resource(&pdev->dev, res);
+	drw_pmu->cfg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(drw_pmu->cfg_base))
 		return PTR_ERR(drw_pmu->cfg_base);
 
-- 
2.20.1.7.g153144c

