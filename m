Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2E6B3DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCJLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCJLdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:33:17 -0500
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BFC19C7B;
        Fri, 10 Mar 2023 03:33:13 -0800 (PST)
Received: from Chengziqiu-Lab-Desktop.. ([172.16.0.254])
        (user=chengziqiu@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32ABW23d008330-32ABW23e008330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Mar 2023 19:32:06 +0800
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
Subject: [PATCH v2] drivers: iio: remove dead code in at91_adc_probe
Date:   Fri, 10 Mar 2023 19:31:58 +0800
Message-Id: <20230310113158.428940-1-chengziqiu@hust.edu.cn>
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

