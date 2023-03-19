Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39816C0614
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCSWjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Mar 2023 18:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCSWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:39:40 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5B1B552;
        Sun, 19 Mar 2023 15:39:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 480133FAD8;
        Sun, 19 Mar 2023 23:39:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KJhJgw-w8jRe; Sun, 19 Mar 2023 23:39:36 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 76B533F55C;
        Sun, 19 Mar 2023 23:39:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id E33478EBDC;
        Sun, 19 Mar 2023 22:39:29 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2jlj8NBE25Am; Sun, 19 Mar 2023 22:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 4C6448EBC6;
        Sun, 19 Mar 2023 22:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sJCR34fAC0WB; Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 888C88EBB9;
        Sun, 19 Mar 2023 22:39:20 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH 2/3] iio: adc: palmas_gpadc: remove adc_wakeupX_data
Date:   Sun, 19 Mar 2023 23:39:07 +0100
Message-Id: <20230319223908.108540-3-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230319223908.108540-1-risca@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not seem to be used by anyone and having two ways to configure
the same thing but for different use cases is bound to introduce bugs.
This removes the special use case and leaves the generic one. It's still
possible to achieve the same thing as before from userspace.

Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 18 ------------------
 include/linux/mfd/palmas.h     |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 84c6e3b66205..419d7db51345 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -948,18 +948,6 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 				     "request auto1 irq %d failed\n",
 				     adc->irq_auto_1);
 
-	if (gpadc_pdata->adc_wakeup1_data) {
-		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
-			sizeof(adc->wakeup1_data));
-		adc->wakeup1_enable = true;
-	}
-
-	if (gpadc_pdata->adc_wakeup2_data) {
-		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
-				sizeof(adc->wakeup2_data));
-		adc->wakeup2_enable = true;
-	}
-
 	adc->event0.channel = -1;
 	adc->event0.direction = IIO_EV_DIR_NONE;
 	adc->event1.channel = -1;
@@ -1004,12 +992,6 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 	}
 
 	device_set_wakeup_capable(&pdev->dev, 1);
-	if (adc->wakeup1_enable || adc->wakeup2_enable) {
-		ret = palmas_adc_wakeup_configure(adc);
-		if (ret)
-			return ret;
-		device_wakeup_enable(&pdev->dev);
-	}
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       palmas_disable_wakeup,
 				       adc);
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 1e61c7e9f50d..dc79d5e2d680 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -153,8 +153,6 @@ struct palmas_gpadc_platform_data {
 	int start_polarity;
 
 	int auto_conversion_period_ms;
-	struct palmas_adc_wakeup_property *adc_wakeup1_data;
-	struct palmas_adc_wakeup_property *adc_wakeup2_data;
 };
 
 struct palmas_reg_init {
-- 
2.25.1

