Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA26C9B33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjC0Fya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjC0FyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:54:12 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4DB524C;
        Sun, 26 Mar 2023 22:53:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Veh3ZHc_1679896430;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Veh3ZHc_1679896430)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 13:53:51 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 3/3] spi: pic32: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 13:53:46 +0800
Message-Id: <20230327055346.76625-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230327055346.76625-1-yang.lee@linux.alibaba.com>
References: <20230327055346.76625-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/spi/spi-pic32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 8a02073a354d..f2af5e653f3d 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -710,8 +710,7 @@ static int pic32_spi_hw_probe(struct platform_device *pdev,
 	struct resource *mem;
 	int ret;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pic32s->regs = devm_ioremap_resource(&pdev->dev, mem);
+	pic32s->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(pic32s->regs))
 		return PTR_ERR(pic32s->regs);
 
-- 
2.20.1.7.g153144c

