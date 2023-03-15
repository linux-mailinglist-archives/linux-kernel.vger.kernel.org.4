Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54326BA767
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCOFyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCOFyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:54:04 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9893F23334;
        Tue, 14 Mar 2023 22:54:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vduv5Vs_1678859637;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vduv5Vs_1678859637)
          by smtp.aliyun-inc.com;
          Wed, 15 Mar 2023 13:53:58 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ulf.hansson@linaro.org
Cc:     jesper.nilsson@axis.com, lars.persson@axis.com,
        linux-arm-kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] mmc: usdhi6rol0: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 15 Mar 2023 13:53:55 +0800
Message-Id: <20230315055355.66733-1-yang.lee@linux.alibaba.com>
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
 drivers/mmc/host/usdhi6rol0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 99515be6e5e5..2f59917b105e 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1790,8 +1790,7 @@ static int usdhi6_probe(struct platform_device *pdev)
 
 	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host->base = devm_ioremap_resource(dev, res);
+	host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(host->base)) {
 		ret = PTR_ERR(host->base);
 		goto e_free_mmc;
-- 
2.20.1.7.g153144c

