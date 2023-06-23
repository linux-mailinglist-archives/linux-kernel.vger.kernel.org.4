Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451C773B993
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjFWONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjFWOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:13:03 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CAE2693;
        Fri, 23 Jun 2023 07:12:43 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NCr2cB032061;
        Fri, 23 Jun 2023 16:12:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=9PABWGQzflpyBNsQSau8KnwnhehmoSEGW4CUo0AjJHs=;
 b=IUC8QEWF/lS7xcMDiXz3ODE3yD1qrOE6Rg6Cl5AWg1GZ4Lb6Eg5IdbXJnWRy0AY28ETc
 HzUZvvNIxa2wMFD/rL40JI30lFcA0+EvDrfZM/yPaFOhNAnuRnIpGD0UL1VZ1mY2Ijgt
 AEqdjCg48y55lg/Rh4kKGJbv6VPKrVYKgOWGXKHfidXkyNMw4lkc9Frhj0mBjco4zgLr
 eXlfRnwOEsXccAfp616cKjC8MCW1y8x6G2OHWbC1zW/H944niyyV+tF5TkYJHvaGHE5X
 z0Y5NQTrZ/kHWyydNYxHrtlRnozYFhZC0EulHsg8ZkyAJ4AiMKSNc2a8UijMk+OVaU0q eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rd6mab0fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:12:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B95A10007B;
        Fri, 23 Jun 2023 16:12:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 443EA22D16C;
        Fri, 23 Jun 2023 16:12:30 +0200 (CEST)
Received: from localhost (10.252.5.198) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 23 Jun
 2023 16:12:30 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 5/7] iio: adc: sd_adc_modulator: change to iio backend device
Date:   Fri, 23 Jun 2023 16:09:41 +0200
Message-ID: <20230623140944.2613002-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
References: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.5.198]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the SD modulator as an IIO backend device instead of
a standard IIO device.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/sd_adc_modulator.c | 65 ++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
index 327cc2097f6c..61246a52dc79 100644
--- a/drivers/iio/adc/sd_adc_modulator.c
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -7,42 +7,65 @@
  */
 
 #include <linux/iio/iio.h>
+#include <linux/iio/backend.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
-static const struct iio_info iio_sd_mod_iio_info;
+struct iio_sd_mod_priv {
+};
 
-static const struct iio_chan_spec iio_sd_mod_ch = {
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.scan_type = {
-		.sign = 'u',
-		.realbits = 1,
-		.shift = 0,
-	},
+static int sd_mod_enable(struct iio_backend *backend)
+{
+	struct iio_sd_mod_priv *priv = backend->priv;
+
+	/* PM resume */
+
+	return 0;
+};
+
+static int sd_mod_disable(struct iio_backend *backend)
+{
+	struct iio_sd_mod_priv *priv = backend->priv;
+
+	/* PM suspend */
+
+	return 0;
+};
+
+static int sd_mod_read(struct iio_backend *backend, int *val, int *val2, long mask)
+{
+	struct iio_sd_mod_priv *priv = backend->priv;
+
+	switch (mask) {
+		/* Process channel info */
+	}
+
+	return -EINVAL;
+};
+
+static const struct iio_backend_ops sd_mod_ops = {
+	.enable = sd_mod_enable,
+	.disable = sd_mod_disable,
+	.read_raw = sd_mod_read,
 };
 
 static int iio_sd_mod_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct iio_dev *iio;
-
-	iio = devm_iio_device_alloc(dev, 0);
-	if (!iio)
-		return -ENOMEM;
+	struct iio_backend *backend;
+	struct iio_sd_mod_priv *priv;
+	int ret;
 
-	iio->name = dev_name(dev);
-	iio->info = &iio_sd_mod_iio_info;
-	iio->modes = INDIO_BUFFER_HARDWARE;
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 
-	iio->num_channels = 1;
-	iio->channels = &iio_sd_mod_ch;
+	backend = iio_backend_alloc(dev);
 
-	platform_set_drvdata(pdev, iio);
+	backend->priv = priv;
+	backend->ops = &sd_mod_ops;
 
-	return devm_iio_device_register(&pdev->dev, iio);
+	return iio_backend_register(backend);
 }
 
 static const struct of_device_id sd_adc_of_match[] = {
-- 
2.25.1

