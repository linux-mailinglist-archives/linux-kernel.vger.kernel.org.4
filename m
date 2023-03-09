Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405566B2887
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCIPRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCIPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:17:42 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1803B729F;
        Thu,  9 Mar 2023 07:17:40 -0800 (PST)
Received: from Chengziqiu-Lab-Desktop.. ([172.16.0.254])
        (user=chengziqiu@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 329F54EL022028-329F54EM022028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Mar 2023 23:05:07 +0800
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
Subject: [PATCH] drivers: iio: remove dead code in at91_adc_probe
Date:   Thu,  9 Mar 2023 23:05:02 +0800
Message-Id: <20230309150502.400312-1-chengziqiu@hust.edu.cn>
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
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
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

