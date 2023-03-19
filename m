Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD606C0615
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCSWjr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Mar 2023 18:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCSWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:39:40 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E21B542;
        Sun, 19 Mar 2023 15:39:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 8C3A23F683;
        Sun, 19 Mar 2023 23:39:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OYmxcAaU6aKO; Sun, 19 Mar 2023 23:39:34 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6840F3F55C;
        Sun, 19 Mar 2023 23:39:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 9FEE88EBD6;
        Sun, 19 Mar 2023 22:39:27 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WrE8dZEpIUYh; Sun, 19 Mar 2023 22:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 133008EBCF;
        Sun, 19 Mar 2023 22:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id crPBhBBIioQm; Sun, 19 Mar 2023 22:39:22 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id A9E248EBC8;
        Sun, 19 Mar 2023 22:39:21 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH 3/3] iio: adc: palmas_gpadc: remove palmas_adc_wakeup_property
Date:   Sun, 19 Mar 2023 23:39:08 +0100
Message-Id: <20230319223908.108540-4-risca@dalakolonin.se>
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

This struct contain essentially the same information as
palmas_adc_event and palmas_gpadc_thresholds combined, but with more
ambiguity: the code decided whether to trigger on rising or falling edge
based on the high threshold being non-zero.

Since its use in platform data has now been removed, we can remove it
entirely.

Lastly, the use case for waking up the cpu from sleep mode when a
threshold has been passed is no longer the primary use for events so all
code is changed to say "event" instead of "wakeup".

Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 94 +++++++++++++---------------------
 include/linux/mfd/palmas.h     |  6 ---
 2 files changed, 36 insertions(+), 64 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 419d7db51345..042b68f29444 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -122,10 +122,8 @@ struct palmas_gpadc {
 	int				irq_auto_1;
 	struct palmas_gpadc_info	*adc_info;
 	struct completion		conv_completion;
-	struct palmas_adc_wakeup_property wakeup1_data;
-	struct palmas_adc_wakeup_property wakeup2_data;
-	bool				wakeup1_enable;
-	bool				wakeup2_enable;
+	bool				event0_enable;
+	bool				event1_enable;
 	int				auto_conversion_period;
 	struct mutex			lock;
 	struct palmas_adc_event		event0;
@@ -592,50 +590,26 @@ static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static void palmas_adc_event_to_wakeup(struct palmas_gpadc *adc,
-				       struct palmas_adc_event *ev,
-				       struct palmas_adc_wakeup_property *wakeup)
-{
-	wakeup->adc_channel_number = ev->channel;
-	if (ev->direction == IIO_EV_DIR_RISING) {
-		wakeup->adc_low_threshold = 0;
-		wakeup->adc_high_threshold =
-			palmas_gpadc_get_high_threshold_raw(adc, &adc->event0);
-	}
-	else {
-		wakeup->adc_low_threshold =
-			palmas_gpadc_get_low_threshold_raw(adc, &adc->event0);
-		wakeup->adc_high_threshold = 0;
-	}
-}
-
-static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc);
-static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc);
+static int palmas_adc_events_configure(struct palmas_gpadc *adc);
+static int palmas_adc_events_reset(struct palmas_gpadc *adc);
 
 static int palmas_gpadc_reconfigure_event_channels(struct palmas_gpadc *adc)
 {
-	bool was_enabled = adc->wakeup1_enable || adc->wakeup2_enable;
+	bool was_enabled = adc->event0_enable || adc->event1_enable;
 	bool enable;
 
-	adc->wakeup1_enable = adc->event0.channel == -1 ? false : true;
-	adc->wakeup2_enable = adc->event1.channel == -1 ? false : true;
+	adc->event0_enable = adc->event0.channel == -1 ? false : true;
+	adc->event1_enable = adc->event1.channel == -1 ? false : true;
 
-	enable = adc->wakeup1_enable || adc->wakeup2_enable;
+	enable = adc->event0_enable || adc->event1_enable;
 	if (!was_enabled && enable)
 		device_wakeup_enable(adc->dev);
 	else if (was_enabled && !enable)
 		device_wakeup_disable(adc->dev);
 
-	if (!enable)
-		return palmas_adc_wakeup_reset(adc);
-
-	// adjust levels
-	if (adc->wakeup1_enable)
-		palmas_adc_event_to_wakeup(adc, &adc->event0, &adc->wakeup1_data);
-	if (adc->wakeup2_enable)
-		palmas_adc_event_to_wakeup(adc, &adc->event1, &adc->wakeup2_data);
-
-	return palmas_adc_wakeup_configure(adc);
+	return enable ?
+		palmas_adc_events_configure(adc) :
+		palmas_adc_events_reset(adc);
 }
 
 static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc,
@@ -864,12 +838,14 @@ static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
 	return 0;
 }
 
-static void palmas_disable_wakeup(void *data)
+static void palmas_disable_events(void *data)
 {
 	struct palmas_gpadc *adc = data;
 
-	if (adc->wakeup1_enable || adc->wakeup2_enable)
+	if (adc->event0_enable || adc->event1_enable) {
+		palmas_adc_events_reset(adc);
 		device_wakeup_disable(adc->dev);
+	}
 }
 
 static int palmas_gpadc_probe(struct platform_device *pdev)
@@ -993,7 +969,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 	device_set_wakeup_capable(&pdev->dev, 1);
 	ret = devm_add_action_or_reset(&pdev->dev,
-				       palmas_disable_wakeup,
+				       palmas_disable_events,
 				       adc);
 	if (ret)
 		return ret;
@@ -1001,7 +977,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
+static int palmas_adc_events_configure(struct palmas_gpadc *adc)
 {
 	int adc_period, conv;
 	int i;
@@ -1027,16 +1003,18 @@ static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 	}
 
 	conv = 0;
-	if (adc->wakeup1_enable) {
+	if (adc->event0_enable) {
+		struct palmas_adc_event *ev = &adc->event0;
 		int polarity;
 
-		ch0 = adc->wakeup1_data.adc_channel_number;
+		ch0 = ev->channel;
 		conv |= PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
-		if (adc->wakeup1_data.adc_high_threshold > 0) {
-			thres = adc->wakeup1_data.adc_high_threshold;
+
+		if (ev->direction == IIO_EV_DIR_RISING) {
+			thres = palmas_gpadc_get_high_threshold_raw(adc, ev);
 			polarity = 0;
 		} else {
-			thres = adc->wakeup1_data.adc_low_threshold;
+			thres = palmas_gpadc_get_low_threshold_raw(adc, ev);
 			polarity = PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
 		}
 
@@ -1058,16 +1036,18 @@ static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 		}
 	}
 
-	if (adc->wakeup2_enable) {
+	if (adc->event1_enable) {
+		struct palmas_adc_event *ev = &adc->event1;
 		int polarity;
 
-		ch1 = adc->wakeup2_data.adc_channel_number;
+		ch1 = ev->channel;
 		conv |= PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
-		if (adc->wakeup2_data.adc_high_threshold > 0) {
-			thres = adc->wakeup2_data.adc_high_threshold;
+
+		if (ev->direction == IIO_EV_DIR_RISING) {
+			thres = palmas_gpadc_get_high_threshold_raw(adc, ev);
 			polarity = 0;
 		} else {
-			thres = adc->wakeup2_data.adc_low_threshold;
+			thres = palmas_gpadc_get_low_threshold_raw(adc, ev);
 			polarity = PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
 		}
 
@@ -1106,7 +1086,7 @@ static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 	return ret;
 }
 
-static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
+static int palmas_adc_events_reset(struct palmas_gpadc *adc)
 {
 	int ret;
 
@@ -1128,15 +1108,14 @@ static int palmas_gpadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
-	int ret;
 
 	if (!device_may_wakeup(dev))
 		return 0;
 
-	if (adc->wakeup1_enable)
+	if (adc->event0_enable)
 		enable_irq_wake(adc->irq_auto_0);
 
-	if (adc->wakeup2_enable)
+	if (adc->event1_enable)
 		enable_irq_wake(adc->irq_auto_1);
 
 	return 0;
@@ -1146,15 +1125,14 @@ static int palmas_gpadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
-	int ret;
 
 	if (!device_may_wakeup(dev))
 		return 0;
 
-	if (adc->wakeup1_enable)
+	if (adc->event0_enable)
 		disable_irq_wake(adc->irq_auto_0);
 
-	if (adc->wakeup2_enable)
+	if (adc->event1_enable)
 		disable_irq_wake(adc->irq_auto_1);
 
 	return 0;
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index dc79d5e2d680..55f22adb1a9e 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -129,12 +129,6 @@ struct palmas_pmic_driver_data {
 			    struct regulator_config config);
 };
 
-struct palmas_adc_wakeup_property {
-	int adc_channel_number;
-	int adc_high_threshold;
-	int adc_low_threshold;
-};
-
 struct palmas_gpadc_platform_data {
 	/* Channel 3 current source is only enabled during conversion */
 	int ch3_current;	/* 0: off; 1: 10uA; 2: 400uA; 3: 800 uA */
-- 
2.25.1

