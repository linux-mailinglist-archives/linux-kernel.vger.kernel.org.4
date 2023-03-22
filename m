Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE18F6C45BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCVJIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCVJIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:08:01 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31D85DEFC;
        Wed, 22 Mar 2023 02:07:38 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PhN0S4y60z8QrkZ;
        Wed, 22 Mar 2023 17:07:36 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 32M96wPo059116;
        Wed, 22 Mar 2023 17:06:58 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 22 Mar 2023 17:07:01 +0800 (CST)
Date:   Wed, 22 Mar 2023 17:07:01 +0800 (CST)
X-Zmail-TransId: 2afa641ac535fffffffff6a-21bb6
X-Mailer: Zmail v1.0
Message-ID: <202303221707010277273@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <ulf.hansson@linaro.org>
Cc:     <paul@crapouillou.net>, <linux-mips@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbWM6IGp6NDc0MDogVXNlIGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32M96wPo059116
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 641AC558.001 by FangMail milter!
X-FangMail-Envelope: 1679476056/4PhN0S4y60z8QrkZ/641AC558.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641AC558.001/4PhN0S4y60z8QrkZ
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mmc/host/jz4740_mmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 698450afa7bb..a6ad03b24add 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -232,10 +232,7 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 	if (!IS_ERR(host->dma_tx))
 		return 0;

-	if (PTR_ERR(host->dma_tx) != -ENODEV) {
-		dev_err(dev, "Failed to get dma tx-rx channel\n");
-		return PTR_ERR(host->dma_tx);
-	}
+	return dev_err_probe(dev, PTR_ERR(host->dma_tx), "Failed to get dma tx-rx channel\n");

 	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
 	if (IS_ERR(host->dma_tx)) {
-- 
2.25.1
