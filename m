Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507FF6D3910
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjDBQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjDBQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:43:28 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEDBE38A;
        Sun,  2 Apr 2023 09:43:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 0E4403F928;
        Sun,  2 Apr 2023 18:43:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UQwyZCEcysYL; Sun,  2 Apr 2023 18:43:25 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 21BC63F870;
        Sun,  2 Apr 2023 18:43:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 8B5B4937B6;
        Sun,  2 Apr 2023 16:43:23 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JUx3J_MFxJad; Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 765DC93781;
        Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 765DC93781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680453797;
        bh=O57gHkEpVTKn8I3om9qdhVzafl1oRPjNnelXQ9I1rt0=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=erF9mTF9AXtu270s2WwNtrgj6Cb2vWFghD8YNxh6crZ2iKVoi7ZVf8l/epPNhBVZW
         kYBSBcYMLBfbwMdrdIfp0aU8nXZAlEnY7pNavgNxlfTh3zYjwJN/23IvMyW9Q18tDR
         kqtwBu3l/G2rZrbyLdsRFr30kpM8J2Og6dzDFxTwFfffIQpDk0geCX6sZxd+T1p2th
         /Om74VcPRQGXMT9ycx1d8KpTXXuYFG0GbEE2iEEGfLAAePwwpcb0GKes23Ck5gkJpb
         ZrmlAlFwJkAP31hr+mwid42UJHgxVRl/aucvXvYAoETo87wnaJ6Kd17qDaeLPpa0uU
         A4yPJYutubBQg==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8iwmJDGeYFAr; Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 344F793779;
        Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v2 2/7] iio: adc: palmas: replace "wakeup" with "event"
Date:   Sun,  2 Apr 2023 18:42:42 +0200
Message-Id: <20230402164247.3089146-3-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230402164247.3089146-1-risca@dalakolonin.se>
References: <20230402164247.3089146-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The palmas gpadc block has support for monitoring up to 2 ADC channels
and issue an interrupt if they reach past a set threshold. This is
currently used to wake up the system from sleep, but the functionality
is more generic than that. As such, change the naming of functions and
variables to refer to it as events instead, except during suspend and
resume where wakeup still make sense.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 50 +++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 943ac579eb1f..3ef0e1c08c8b 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -76,7 +76,7 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
 };
=20
-struct palmas_adc_wakeup_property {
+struct palmas_adc_event {
 	int adc_channel_number;
 	int adc_high_threshold;
 	int adc_low_threshold;
@@ -117,10 +117,10 @@ struct palmas_gpadc {
 	int				irq_auto_1;
 	struct palmas_gpadc_info	*adc_info;
 	struct completion		conv_completion;
-	struct palmas_adc_wakeup_property wakeup1_data;
-	struct palmas_adc_wakeup_property wakeup2_data;
-	bool				wakeup1_enable;
-	bool				wakeup2_enable;
+	struct palmas_adc_event		event0;
+	struct palmas_adc_event		event1;
+	bool				event0_enable;
+	bool				event1_enable;
 	int				auto_conversion_period;
 	struct mutex			lock;
 };
@@ -590,7 +590,7 @@ static int palmas_gpadc_probe(struct platform_device =
*pdev)
 	return 0;
 }
=20
-static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
+static int palmas_adc_configure_events(struct palmas_gpadc *adc)
 {
 	int adc_period, conv;
 	int i;
@@ -616,16 +616,16 @@ static int palmas_adc_wakeup_configure(struct palma=
s_gpadc *adc)
 	}
=20
 	conv =3D 0;
-	if (adc->wakeup1_enable) {
+	if (adc->event0_enable) {
 		int polarity;
=20
-		ch0 =3D adc->wakeup1_data.adc_channel_number;
+		ch0 =3D adc->event0.adc_channel_number;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
-		if (adc->wakeup1_data.adc_high_threshold > 0) {
-			thres =3D adc->wakeup1_data.adc_high_threshold;
+		if (adc->event0.adc_high_threshold > 0) {
+			thres =3D adc->event0.adc_high_threshold;
 			polarity =3D 0;
 		} else {
-			thres =3D adc->wakeup1_data.adc_low_threshold;
+			thres =3D adc->event0.adc_low_threshold;
 			polarity =3D PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
 		}
=20
@@ -647,16 +647,16 @@ static int palmas_adc_wakeup_configure(struct palma=
s_gpadc *adc)
 		}
 	}
=20
-	if (adc->wakeup2_enable) {
+	if (adc->event1_enable) {
 		int polarity;
=20
-		ch1 =3D adc->wakeup2_data.adc_channel_number;
+		ch1 =3D adc->event1.adc_channel_number;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
-		if (adc->wakeup2_data.adc_high_threshold > 0) {
-			thres =3D adc->wakeup2_data.adc_high_threshold;
+		if (adc->event1.adc_high_threshold > 0) {
+			thres =3D adc->event1.adc_high_threshold;
 			polarity =3D 0;
 		} else {
-			thres =3D adc->wakeup2_data.adc_low_threshold;
+			thres =3D adc->event1.adc_low_threshold;
 			polarity =3D PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
 		}
=20
@@ -695,7 +695,7 @@ static int palmas_adc_wakeup_configure(struct palmas_=
gpadc *adc)
 	return ret;
 }
=20
-static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
+static int palmas_adc_reset_events(struct palmas_gpadc *adc)
 {
 	int ret;
=20
@@ -717,20 +717,20 @@ static int palmas_gpadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
+	int wakeup =3D adc->event0_enable || adc->event1_enable;
 	int ret;
=20
 	if (!device_may_wakeup(dev) || !wakeup)
 		return 0;
=20
-	ret =3D palmas_adc_wakeup_configure(adc);
+	ret =3D palmas_adc_configure_events(adc);
 	if (ret < 0)
 		return ret;
=20
-	if (adc->wakeup1_enable)
+	if (adc->event0_enable)
 		enable_irq_wake(adc->irq_auto_0);
=20
-	if (adc->wakeup2_enable)
+	if (adc->event1_enable)
 		enable_irq_wake(adc->irq_auto_1);
=20
 	return 0;
@@ -740,20 +740,20 @@ static int palmas_gpadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
+	int wakeup =3D adc->event0_enable || adc->event1_enable;
 	int ret;
=20
 	if (!device_may_wakeup(dev) || !wakeup)
 		return 0;
=20
-	ret =3D palmas_adc_wakeup_reset(adc);
+	ret =3D palmas_adc_reset_events(adc);
 	if (ret < 0)
 		return ret;
=20
-	if (adc->wakeup1_enable)
+	if (adc->event0_enable)
 		disable_irq_wake(adc->irq_auto_0);
=20
-	if (adc->wakeup2_enable)
+	if (adc->event1_enable)
 		disable_irq_wake(adc->irq_auto_1);
=20
 	return 0;
--=20
2.25.1

