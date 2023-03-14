Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4045A6B8BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCNHEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCNHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:04:53 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68774A6E;
        Tue, 14 Mar 2023 00:04:51 -0700 (PDT)
Received: from Chengziqiu-Lab-Desktop.. ([172.16.0.254])
        (user=chengziqiu@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32E71V5Y025436-32E71V5Z025436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Mar 2023 15:01:39 +0800
From:   Cheng Ziqiu <chengziqiu@hust.edu.cn>
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Cheng Ziqiu <chengziqiu@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: at91-sama5d2_adc: remove dead code in `at91_adc_probe`
Date:   Tue, 14 Mar 2023 15:01:30 +0800
Message-Id: <20230314070130.60581-1-chengziqiu@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: chengziqiu@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the comment of platform_get_irq, it only returns non-zero IRQ
number and negative error number, other than zero.

Fix this by removing the if condition.

Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v2->v3: Change subject to make it regular.
v1->v2: Change commit message from SoB to Reviewed-by.
 drivers/iio/adc/at91-sama5d2_adc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 50d02e5fc6fc..168399092590 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2400,12 +2400,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 	st->dma_st.phys_addr = res->start;
 
 	st->irq = platform_get_irq(pdev, 0);
-	if (st->irq <= 0) {
-		if (!st->irq)
-			st->irq = -ENXIO;
-
+	if (st->irq < 0)
 		return st->irq;
-	}
 
 	st->per_clk = devm_clk_get(&pdev->dev, "adc_clk");
 	if (IS_ERR(st->per_clk))
-- 
2.34.1

