Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D76CB6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC1GPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjC1GPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:15:31 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCABF2D5B;
        Mon, 27 Mar 2023 23:15:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VerpCfk_1679984125;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VerpCfk_1679984125)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 14:15:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     michal.simek@xilinx.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] spi: xilinx: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 28 Mar 2023 14:15:24 +0800
Message-Id: <20230328061524.77529-1-yang.lee@linux.alibaba.com>
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

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/spi/spi-xilinx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 5dd3d1901412..8e6e3876aa9a 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -440,8 +440,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	xspi->bitbang.txrx_bufs = xilinx_spi_txrx_bufs;
 	init_completion(&xspi->done);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xspi->regs = devm_ioremap_resource(&pdev->dev, res);
+	xspi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(xspi->regs))
 		return PTR_ERR(xspi->regs);
 
-- 
2.20.1.7.g153144c

