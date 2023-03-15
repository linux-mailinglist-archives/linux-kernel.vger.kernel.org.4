Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A16BA53C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCOCaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOCaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:30:22 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980DD5D275
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:30:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VduGZD6_1678847417;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VduGZD6_1678847417)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 10:30:18 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] perf: arm: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 15 Mar 2023 10:30:17 +0800
Message-Id: <20230315023017.35789-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/perf/arm_dmc620_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 54aa4658fb36..5de06f9a4dd3 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -655,8 +655,7 @@ static int dmc620_pmu_device_probe(struct platform_device *pdev)
 		.attr_groups	= dmc620_pmu_attr_groups,
 	};
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmc620_pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	dmc620_pmu->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(dmc620_pmu->base))
 		return PTR_ERR(dmc620_pmu->base);
 
-- 
2.20.1.7.g153144c

