Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01BA614322
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKACST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiKACSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:18:08 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A511788A;
        Mon, 31 Oct 2022 19:17:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VTaUC86_1667269072;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VTaUC86_1667269072)
          by smtp.aliyun-inc.com;
          Tue, 01 Nov 2022 10:17:53 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     clabbe@baylibre.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] crypto: Remove surplus dev_err() when using platform_get_irq()
Date:   Tue,  1 Nov 2022 10:17:51 +0800
Message-Id: <20221101021751.89362-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the dev_err() function directly to print a
custom message when handling an error from either the platform_get_irq()
or platform_get_irq_byname() functions as both are going to display an
appropriate error message in case of a failure.

./drivers/crypto/rockchip/rk3288_crypto.c:351:2-9: line 351 is
redundant because platform_get_irq() already prints an error

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2677
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 6217e73ba4c4..9f6ba770a90a 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -348,7 +348,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
 
 	crypto_info->irq = platform_get_irq(pdev, 0);
 	if (crypto_info->irq < 0) {
-		dev_err(&pdev->dev, "control Interrupt is not available.\n");
 		err = crypto_info->irq;
 		goto err_crypto;
 	}
-- 
2.20.1.7.g153144c

