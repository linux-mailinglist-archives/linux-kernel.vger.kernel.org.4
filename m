Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E26DBA95
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDHLt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDHLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:49:23 -0400
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23D0EF9C;
        Sat,  8 Apr 2023 04:49:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 264763F6DD;
        Sat,  8 Apr 2023 13:49:16 +0200 (CEST)
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
        with ESMTP id QCGD13k5_3nC; Sat,  8 Apr 2023 13:49:14 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 9F89F3F645;
        Sat,  8 Apr 2023 13:49:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 2EAE295FBB;
        Sat,  8 Apr 2023 11:49:14 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0Y_c_wLMcn1K; Sat,  8 Apr 2023 11:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 5204A95FB5;
        Sat,  8 Apr 2023 11:49:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 5204A95FB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954552;
        bh=MIvS60g+N7evk2zc658kkSPiJ+/wC4UJjKm/8zr3l5w=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=oV71UjeBQ7Ms4z3Kyu+C7Qs9pLhUwD5uf2ZyxYDYm6I5N/U0q8xEQP5kr+K4KMvWI
         /+GyAir1aDnHLB0rJ1vlcQMR2QidmLIMZlIQN24QarDtmwqjDZRtxd/AFglQ6D8OR5
         D+aSFPto761ugy5rrNyU2PU+NE9kAAJkEq14EhI4f0hIqlmntUlfKp+EX98ufBgr8w
         OpPQ74ekrwoJM3IePv1KlYSsvCSdntkI+hWjjAKIWb85vShkC3E1VgDzPblWWrRYIh
         N/YyRKguYrIbdb/4PloSidOM1hY1DhVe4/0xRmklT9nJnx1yG7TuDsmQClxTafTvVn
         eMUCB3G0D/5kQ==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vhAdopkyiOka; Sat,  8 Apr 2023 11:49:11 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 3289E95FAF;
        Sat,  8 Apr 2023 11:49:11 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Signed-off-by=20=3A=20Patrik=20Dahlstr=C3=B6m?= 
        <risca@dalakolonin.se>
Subject: [PATCH v4 2/9] iio: adc: palmas: Take probe fully device managed.
Date:   Sat,  8 Apr 2023 13:48:18 +0200
Message-Id: <20230408114825.824505-3-risca@dalakolonin.se>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Review of a recent fix highlighted that this driver could be trivially
converted to be entirely devm managed.

That fix should be applied to resolve the fix in a fashion easy to back p=
ort
even though this change removes the relevant code.

[1] https://patchwork.kernel.org/project/linux-iio/patch/20230313205029.1=
881745-1-risca@dalakolonin.se/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 110 +++++++++++++--------------------
 1 file changed, 42 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 849a697a467e..2921186458e0 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -493,6 +493,11 @@ static int palmas_gpadc_get_adc_dt_data(struct platf=
orm_device *pdev,
 	return 0;
 }
=20
+static void palmas_disable_wakeup(void *dev)
+{
+	device_wakeup_disable(dev);
+}
+
 static int palmas_gpadc_probe(struct platform_device *pdev)
 {
 	struct palmas_gpadc *adc;
@@ -532,36 +537,30 @@ static int palmas_gpadc_probe(struct platform_devic=
e *pdev)
=20
 	adc->auto_conversion_period =3D gpadc_pdata->auto_conversion_period_ms;
 	adc->irq =3D palmas_irq_get_virq(adc->palmas, PALMAS_GPADC_EOC_SW_IRQ);
-	if (adc->irq < 0) {
-		dev_err(adc->dev,
-			"get virq failed: %d\n", adc->irq);
-		ret =3D adc->irq;
-		goto out;
-	}
-	ret =3D request_threaded_irq(adc->irq, NULL,
-		palmas_gpadc_irq,
-		IRQF_ONESHOT, dev_name(adc->dev),
-		adc);
-	if (ret < 0) {
-		dev_err(adc->dev,
-			"request irq %d failed: %d\n", adc->irq, ret);
-		goto out;
-	}
+	if (adc->irq < 0)
+		return dev_err_probe(adc->dev, adc->irq, "get virq failed\n");
+
+	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq, NULL,
+					palmas_gpadc_irq,
+					IRQF_ONESHOT, dev_name(adc->dev),
+					adc);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "request irq %d failed\n", adc->irq);
=20
 	if (gpadc_pdata->adc_wakeup1_data) {
 		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
 			sizeof(adc->wakeup1_data));
 		adc->wakeup1_enable =3D true;
 		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
-		ret =3D request_threaded_irq(adc->irq_auto_0, NULL,
-				palmas_gpadc_irq_auto,
-				IRQF_ONESHOT,
-				"palmas-adc-auto-0", adc);
-		if (ret < 0) {
-			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
-				adc->irq_auto_0, ret);
-			goto out_irq_free;
-		}
+		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
+						NULL, palmas_gpadc_irq_auto,
+						IRQF_ONESHOT,
+						"palmas-adc-auto-0", adc);
+		if (ret < 0)
+			return dev_err_probe(adc->dev, ret,
+					     "request auto0 irq %d failed\n",
+					     adc->irq_auto_0);
 	}
=20
 	if (gpadc_pdata->adc_wakeup2_data) {
@@ -569,15 +568,14 @@ static int palmas_gpadc_probe(struct platform_devic=
e *pdev)
 				sizeof(adc->wakeup2_data));
 		adc->wakeup2_enable =3D true;
 		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
-		ret =3D request_threaded_irq(adc->irq_auto_1, NULL,
-				palmas_gpadc_irq_auto,
-				IRQF_ONESHOT,
-				"palmas-adc-auto-1", adc);
-		if (ret < 0) {
-			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
-				adc->irq_auto_1, ret);
-			goto out_irq_auto0_free;
-		}
+		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
+						NULL, palmas_gpadc_irq_auto,
+						IRQF_ONESHOT,
+						"palmas-adc-auto-1", adc);
+		if (ret < 0)
+			return dev_err_probe(adc->dev, ret,
+					     "request auto1 irq %d failed\n",
+					     adc->irq_auto_1);
 	}
=20
 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
@@ -608,11 +606,10 @@ static int palmas_gpadc_probe(struct platform_devic=
e *pdev)
 	indio_dev->channels =3D palmas_gpadc_iio_channel;
 	indio_dev->num_channels =3D ARRAY_SIZE(palmas_gpadc_iio_channel);
=20
-	ret =3D iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(adc->dev, "iio_device_register() failed: %d\n", ret);
-		goto out_irq_auto1_free;
-	}
+	ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(adc->dev, ret,
+				     "iio_device_register() failed\n");
=20
 	device_set_wakeup_capable(&pdev->dev, 1);
 	for (i =3D 0; i < PALMAS_ADC_CH_MAX; i++) {
@@ -620,36 +617,14 @@ static int palmas_gpadc_probe(struct platform_devic=
e *pdev)
 			palmas_gpadc_calibrate(adc, i);
 	}
=20
-	if (adc->wakeup1_enable || adc->wakeup2_enable)
+	if (adc->wakeup1_enable || adc->wakeup2_enable) {
 		device_wakeup_enable(&pdev->dev);
-
-	return 0;
-
-out_irq_auto1_free:
-	if (gpadc_pdata->adc_wakeup2_data)
-		free_irq(adc->irq_auto_1, adc);
-out_irq_auto0_free:
-	if (gpadc_pdata->adc_wakeup1_data)
-		free_irq(adc->irq_auto_0, adc);
-out_irq_free:
-	free_irq(adc->irq, adc);
-out:
-	return ret;
-}
-
-static int palmas_gpadc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev =3D dev_get_drvdata(&pdev->dev);
-	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-
-	if (adc->wakeup1_enable || adc->wakeup2_enable)
-		device_wakeup_disable(&pdev->dev);
-	iio_device_unregister(indio_dev);
-	free_irq(adc->irq, adc);
-	if (adc->wakeup1_enable)
-		free_irq(adc->irq_auto_0, adc);
-	if (adc->wakeup2_enable)
-		free_irq(adc->irq_auto_1, adc);
+		ret =3D devm_add_action_or_reset(&pdev->dev,
+					       palmas_disable_wakeup,
+					       &pdev->dev);
+		if (ret)
+			return ret;
+	}
=20
 	return 0;
 }
@@ -834,7 +809,6 @@ MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
=20
 static struct platform_driver palmas_gpadc_driver =3D {
 	.probe =3D palmas_gpadc_probe,
-	.remove =3D palmas_gpadc_remove,
 	.driver =3D {
 		.name =3D MOD_NAME,
 		.pm =3D pm_sleep_ptr(&palmas_pm_ops),
--=20
2.25.1

