Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD06D897C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjDEVXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjDEVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:23:18 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1E61BF;
        Wed,  5 Apr 2023 14:23:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 3AD023F4DA;
        Wed,  5 Apr 2023 23:23:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t_WA2Mg8pMkx; Wed,  5 Apr 2023 23:23:06 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 7FA1B3F3A9;
        Wed,  5 Apr 2023 23:23:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id D88F094DFA;
        Wed,  5 Apr 2023 21:23:05 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B7jsiih08e8c; Wed,  5 Apr 2023 21:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id CEA1694DD9;
        Wed,  5 Apr 2023 21:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se CEA1694DD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680729774;
        bh=8oCsKoWj+OT4dqdz4wKUl0ESprUGM0ZozVBAf1AeyA0=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=pq5LjY4swcA7YwZoss5qZBn7Fk1BvLJhUJIuWLkUq5nm3e2Igysq6O8u1JGxWl8B7
         kiBoE6wPmAiRbGO+c3Y/2+2xyNuht2Zi6siVsMMczPUPLrQJ9CZreWGJ8BV0/MnVfA
         p+sDlXcrEFImDUeu9htb3XfZCm7p1NewTd9BflLVy/ZKpx7TGAVo35iLxr23U5h3Pr
         x4i6ZiYwmYS8jVAOJpitJx7HQnx6LlZJetTiaTT1AJCRB9wmflCHo5oBLbftDENzfQ
         8Z6aS1Ucd7TbDiV4c+G2yiihihHquGNn+KvLMbYV6Q/5+HcBkjQRBZkqg6jD50rCmn
         F88yrunmXTnzw==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uv4ko-kqoacb; Wed,  5 Apr 2023 21:22:54 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id BD65F94DD6;
        Wed,  5 Apr 2023 21:22:53 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v3 3/7] iio: adc: palmas: use iio_event_direction for threshold polarity
Date:   Wed,  5 Apr 2023 23:22:29 +0200
Message-Id: <20230405212233.4167986-4-risca@dalakolonin.se>
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

Instead of having high_threshold > 0 as an indicator for upper threshold
event and lower threshold event otherwise, use enum iio_event_direction
instead. This is hopefully less ambiguous.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 55fdf59ef711..205a7628b235 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -77,9 +77,9 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 };
=20
 struct palmas_adc_event {
-	int adc_channel_number;
-	int adc_high_threshold;
-	int adc_low_threshold;
+	int channel;
+	int raw_thresh;
+	enum iio_event_direction direction;
 };
=20
 /*
@@ -618,16 +618,21 @@ static int palmas_adc_configure_events(struct palma=
s_gpadc *adc)
=20
 	conv =3D 0;
 	if (adc->event0_enable) {
+		struct palmas_adc_event *ev =3D &adc->event0;
 		int polarity;
=20
-		ch0 =3D adc->event0.adc_channel_number;
+		ch0 =3D ev->channel;
+		thres =3D ev->raw_thresh;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
-		if (adc->event0.adc_high_threshold > 0) {
-			thres =3D adc->event0.adc_high_threshold;
+		switch (ev->direction) {
+		case IIO_EV_DIR_RISING:
 			polarity =3D 0;
-		} else {
-			thres =3D adc->event0.adc_low_threshold;
+			break;
+		case IIO_EV_DIR_FALLING:
 			polarity =3D PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
+			break;
+		default:
+			return -EINVAL;
 		}
=20
 		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
@@ -649,16 +654,21 @@ static int palmas_adc_configure_events(struct palma=
s_gpadc *adc)
 	}
=20
 	if (adc->event1_enable) {
+		struct palmas_adc_event *ev =3D &adc->event1;
 		int polarity;
=20
-		ch1 =3D adc->event1.adc_channel_number;
+		ch1 =3D ev->channel;
+		thres =3D ev->raw_thresh;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
-		if (adc->event1.adc_high_threshold > 0) {
-			thres =3D adc->event1.adc_high_threshold;
+		switch (ev->direction) {
+		case IIO_EV_DIR_RISING:
 			polarity =3D 0;
-		} else {
-			thres =3D adc->event1.adc_low_threshold;
+			break;
+		case IIO_EV_DIR_FALLING:
 			polarity =3D PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
+			break;
+		default:
+			return -EINVAL;
 		}
=20
 		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
--=20
2.25.1

