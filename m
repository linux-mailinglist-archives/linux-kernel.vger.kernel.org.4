Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DF46D897F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjDEVXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjDEVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:23:29 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD97DA4;
        Wed,  5 Apr 2023 14:23:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 62BBF3FA21;
        Wed,  5 Apr 2023 23:23:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IcLgFRpfqez1; Wed,  5 Apr 2023 23:23:12 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 6B7123F870;
        Wed,  5 Apr 2023 23:23:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id F3D0B94E01;
        Wed,  5 Apr 2023 21:23:08 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mHGQsfKd3kNV; Wed,  5 Apr 2023 21:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id DA7C694DE1;
        Wed,  5 Apr 2023 21:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se DA7C694DE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680729778;
        bh=TmuWTPcVR6kjhWZxrkfB1qR/xKdRysUauxZUpzZtF7k=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=PSPEYxqePHdQP9cLR80UV50OIXfmQU2Chwoq5lbcziAM7e0A6IUs6LMYPldLAlChF
         C66rMH+yhRkh8tAOrjUdei9uEiAcmvl2V2pZXYa4qISknTCpxVDUPundcTVvDyDoQK
         OntzqsIIseATFk4XoXWnamZTN3OLWYbLmM0WNOSdY7FoqHyPGJiwRRGICK/MaE0tkb
         DRPMSU2Lm/F/HLBMoOPJR481qN1ZPiz1c/FO67YdMEhN9c+RXm77TA0CA6Fa0sjdMt
         NoMD+oqyZHHOez1DZNx2bQd0U9ssHJU8TdBebbVWVIpGMoP1mZMNYtRn92m6cXcucG
         +Cga0AS/RsH+A==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FO5mvdtNXwa9; Wed,  5 Apr 2023 21:22:57 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id C1D6A94DDA;
        Wed,  5 Apr 2023 21:22:56 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v3 4/7] iio: adc: palmas: move eventX_enable into palmas_adc_event
Date:   Wed,  5 Apr 2023 23:22:30 +0200
Message-Id: <20230405212233.4167986-5-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405212233.4167986-1-risca@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It just makes more sense to have all information regarding adc events in
one place.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 205a7628b235..8c6ea4a3cd2e 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -77,6 +77,7 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 };
=20
 struct palmas_adc_event {
+	bool enabled;
 	int channel;
 	int raw_thresh;
 	enum iio_event_direction direction;
@@ -119,8 +120,6 @@ struct palmas_gpadc {
 	struct completion		conv_completion;
 	struct palmas_adc_event		event0;
 	struct palmas_adc_event		event1;
-	bool				event0_enable;
-	bool				event1_enable;
 	int				auto_conversion_period;
 	struct mutex			lock;
 };
@@ -617,7 +616,7 @@ static int palmas_adc_configure_events(struct palmas_=
gpadc *adc)
 	}
=20
 	conv =3D 0;
-	if (adc->event0_enable) {
+	if (adc->event0.enabled) {
 		struct palmas_adc_event *ev =3D &adc->event0;
 		int polarity;
=20
@@ -653,7 +652,7 @@ static int palmas_adc_configure_events(struct palmas_=
gpadc *adc)
 		}
 	}
=20
-	if (adc->event1_enable) {
+	if (adc->event1.enabled) {
 		struct palmas_adc_event *ev =3D &adc->event1;
 		int polarity;
=20
@@ -728,7 +727,7 @@ static int palmas_gpadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0_enable || adc->event1_enable;
+	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
 	int ret;
=20
 	if (!device_may_wakeup(dev) || !wakeup)
@@ -738,10 +737,10 @@ static int palmas_gpadc_suspend(struct device *dev)
 	if (ret < 0)
 		return ret;
=20
-	if (adc->event0_enable)
+	if (adc->event0.enabled)
 		enable_irq_wake(adc->irq_auto_0);
=20
-	if (adc->event1_enable)
+	if (adc->event1.enabled)
 		enable_irq_wake(adc->irq_auto_1);
=20
 	return 0;
@@ -751,7 +750,7 @@ static int palmas_gpadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0_enable || adc->event1_enable;
+	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
 	int ret;
=20
 	if (!device_may_wakeup(dev) || !wakeup)
@@ -761,10 +760,10 @@ static int palmas_gpadc_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
=20
-	if (adc->event0_enable)
+	if (adc->event0.enabled)
 		disable_irq_wake(adc->irq_auto_0);
=20
-	if (adc->event1_enable)
+	if (adc->event1.enabled)
 		disable_irq_wake(adc->irq_auto_1);
=20
 	return 0;
--=20
2.25.1

