Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B97B6C9B31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC0FyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjC0Fx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:53:57 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E840FB;
        Sun, 26 Mar 2023 22:53:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VefjAs7_1679896428;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VefjAs7_1679896428)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 13:53:49 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/3] spi: orion: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 13:53:45 +0800
Message-Id: <20230327055346.76625-2-yang.lee@linux.alibaba.com>
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
 drivers/spi/spi-orion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index bb244b596143..ad9e83e34297 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -728,8 +728,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = devdata->max_hz;
 	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->max_divisor);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	spi->base = devm_ioremap_resource(&pdev->dev, r);
+	spi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(spi->base)) {
 		status = PTR_ERR(spi->base);
 		goto out_rel_axi_clk;
-- 
2.20.1.7.g153144c

