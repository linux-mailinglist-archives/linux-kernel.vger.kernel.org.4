Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A36DBA98
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjDHLtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDHLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:49:32 -0400
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E662110243;
        Sat,  8 Apr 2023 04:49:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 814D03F703;
        Sat,  8 Apr 2023 13:49:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9PCjORLLcL0a; Sat,  8 Apr 2023 13:49:17 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 8C4FB3F645;
        Sat,  8 Apr 2023 13:49:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 4EACC95FCB;
        Sat,  8 Apr 2023 11:49:17 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z3kSxSC3AhDS; Sat,  8 Apr 2023 11:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 0CCCA95FC0;
        Sat,  8 Apr 2023 11:49:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 0CCCA95FC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954556;
        bh=QpAkz8NzyhCd80cX7C/EMbSMfNw/jsM+n+BufT6T6ZU=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=cxyyknrj95FW92fCs3jDBc55NbqQHb6Q7TvXf5q1uc6dKelPPIyiOdVG/RggWhv2M
         bQgZKWI2tdl5Yk0ZkyaBbhp06H+6xDGqR0wE++7U7izx0GA8R6+5zkQGJS5TggFt2u
         g7neprvTyl7pG0NU/xglgHtHflaOojp78hJ6BgwJlBaa/UpdblQxn1KDt2K3sJ74Cs
         jilJ+KehzIdDZl+Rtl6h7WxCMWNus1Sa0TTb0FSpRSRYt3apTIRG2by/7GpQ2Kicic
         3ID/dJENyp1cx1hEi9wp738eqWRRDAkDffIo9UrDQgthVr9h9WSRrTxtizZAYgzYs1
         v0HWCGnqjV/9g==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KsIYKCglIhS7; Sat,  8 Apr 2023 11:49:15 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id D489895FBD;
        Sat,  8 Apr 2023 11:49:15 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v4 3/9] iio: adc: palmas: remove adc_wakeupX_data
Date:   Sat,  8 Apr 2023 13:48:19 +0200
Message-Id: <20230408114825.824505-4-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230408114825.824505-1-risca@dalakolonin.se>
References: <20230408114825.824505-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not seem to be used by anyone and later patches in this series
are made simpler by first removing this. There is now a lot of dead code
that cannot be reached, until later patches revive it. Arguably, this is
preferred over removing the code only to add it again.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 50 ++++------------------------------
 include/linux/mfd/palmas.h     |  8 ------
 2 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 2921186458e0..03af6cd73ec8 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -76,6 +76,12 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
 };
=20
+struct palmas_adc_wakeup_property {
+	int adc_channel_number;
+	int adc_high_threshold;
+	int adc_low_threshold;
+};
+
 /*
  * struct palmas_gpadc - the palmas_gpadc structure
  * @ch0_current:	channel 0 current source setting
@@ -493,11 +499,6 @@ static int palmas_gpadc_get_adc_dt_data(struct platf=
orm_device *pdev,
 	return 0;
 }
=20
-static void palmas_disable_wakeup(void *dev)
-{
-	device_wakeup_disable(dev);
-}
-
 static int palmas_gpadc_probe(struct platform_device *pdev)
 {
 	struct palmas_gpadc *adc;
@@ -548,36 +549,6 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
 		return dev_err_probe(adc->dev, ret,
 				     "request irq %d failed\n", adc->irq);
=20
-	if (gpadc_pdata->adc_wakeup1_data) {
-		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
-			sizeof(adc->wakeup1_data));
-		adc->wakeup1_enable =3D true;
-		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
-		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
-						NULL, palmas_gpadc_irq_auto,
-						IRQF_ONESHOT,
-						"palmas-adc-auto-0", adc);
-		if (ret < 0)
-			return dev_err_probe(adc->dev, ret,
-					     "request auto0 irq %d failed\n",
-					     adc->irq_auto_0);
-	}
-
-	if (gpadc_pdata->adc_wakeup2_data) {
-		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
-				sizeof(adc->wakeup2_data));
-		adc->wakeup2_enable =3D true;
-		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
-		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
-						NULL, palmas_gpadc_irq_auto,
-						IRQF_ONESHOT,
-						"palmas-adc-auto-1", adc);
-		if (ret < 0)
-			return dev_err_probe(adc->dev, ret,
-					     "request auto1 irq %d failed\n",
-					     adc->irq_auto_1);
-	}
-
 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
 	if (gpadc_pdata->ch0_current <=3D 1)
 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
@@ -617,15 +588,6 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
 			palmas_gpadc_calibrate(adc, i);
 	}
=20
-	if (adc->wakeup1_enable || adc->wakeup2_enable) {
-		device_wakeup_enable(&pdev->dev);
-		ret =3D devm_add_action_or_reset(&pdev->dev,
-					       palmas_disable_wakeup,
-					       &pdev->dev);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
=20
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 117d02708439..eda1ffd99c1a 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -128,12 +128,6 @@ struct palmas_pmic_driver_data {
 			    struct regulator_config config);
 };
=20
-struct palmas_adc_wakeup_property {
-	int adc_channel_number;
-	int adc_high_threshold;
-	int adc_low_threshold;
-};
-
 struct palmas_gpadc_platform_data {
 	/* Channel 3 current source is only enabled during conversion */
 	int ch3_current;	/* 0: off; 1: 10uA; 2: 400uA; 3: 800 uA */
@@ -152,8 +146,6 @@ struct palmas_gpadc_platform_data {
 	int start_polarity;
=20
 	int auto_conversion_period_ms;
-	struct palmas_adc_wakeup_property *adc_wakeup1_data;
-	struct palmas_adc_wakeup_property *adc_wakeup2_data;
 };
=20
 struct palmas_reg_init {
--=20
2.25.1

