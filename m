Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C397406D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjF0XTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjF0XTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:19:09 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E586E2944
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:19:06 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 38CB5120007;
        Wed, 28 Jun 2023 01:40:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 38CB5120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687905633;
        bh=pIiTNsqBpMxAZqv/NstgXhxXHNEujlfElFDDzZB/69s=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=ilqBpqSKF+NS4WPwx0RnsrBHZ/AXZviok0OdV3LOyaJly6kqvnY29eODnsE3X7xcH
         AxU5XdJyQjXMFT9SElJE3rjVrQijFZsrge3mLj1xeg7dKO+OVU8MJH9osyZ/FDXuA9
         poFxXu4CKjiVrzLEZ/xc8R0riBjxbMtQchemKKwT7oY4bbeEPjCw5r+hIlBlW8TmW9
         fZfnqbBoZLKXh4/1A0QGUWfqHkVJF6Ehrethft0Qdpa6+KYWf/QAS5A8Nhvfi17gFI
         Q+Uj3Ck71pUdXFqlGG86+b52vznwSwBh3JsrYcpoRxbzYqfrYRxZDylpFf0qFQQyAn
         T1yFoyA0AOQww==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 01:40:32 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 01:39:34 +0300
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>
Subject: [PATCH v3 3/5] meson saradc: add enum for iio channel numbers
Date:   Wed, 28 Jun 2023 01:37:16 +0300
Message-ID: <20230627224017.1724097-4-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627224017.1724097-1-gnstark@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178297 [Jun 27 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/27 18:27:00 #21588965
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Stark <GNStark@sberdevices.ru>

Add enum for iio channel numbers.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 51 +++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 6e69b40b3309..803d7ca2e0fa 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -224,29 +224,42 @@ enum meson_sar_adc_chan7_mux_sel {
 	CHAN7_MUX_CH7_INPUT = 0x7,
 };
 
+enum meson_sar_adc_channel_index {
+	NUM_CHAN_0,
+	NUM_CHAN_1,
+	NUM_CHAN_2,
+	NUM_CHAN_3,
+	NUM_CHAN_4,
+	NUM_CHAN_5,
+	NUM_CHAN_6,
+	NUM_CHAN_7,
+	NUM_CHAN_TEMP,
+	NUM_CHAN_SOFT_TIMESTAMP,
+};
+
 static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
-	MESON_SAR_ADC_CHAN(0),
-	MESON_SAR_ADC_CHAN(1),
-	MESON_SAR_ADC_CHAN(2),
-	MESON_SAR_ADC_CHAN(3),
-	MESON_SAR_ADC_CHAN(4),
-	MESON_SAR_ADC_CHAN(5),
-	MESON_SAR_ADC_CHAN(6),
-	MESON_SAR_ADC_CHAN(7),
-	IIO_CHAN_SOFT_TIMESTAMP(8),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_0),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_1),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_2),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_3),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_4),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_5),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
+	IIO_CHAN_SOFT_TIMESTAMP(NUM_CHAN_SOFT_TIMESTAMP),
 };
 
 static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
-	MESON_SAR_ADC_CHAN(0),
-	MESON_SAR_ADC_CHAN(1),
-	MESON_SAR_ADC_CHAN(2),
-	MESON_SAR_ADC_CHAN(3),
-	MESON_SAR_ADC_CHAN(4),
-	MESON_SAR_ADC_CHAN(5),
-	MESON_SAR_ADC_CHAN(6),
-	MESON_SAR_ADC_CHAN(7),
-	MESON_SAR_ADC_TEMP_CHAN(8),
-	IIO_CHAN_SOFT_TIMESTAMP(9),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_0),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_1),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_2),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_3),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_4),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_5),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_6),
+	MESON_SAR_ADC_CHAN(NUM_CHAN_7),
+	MESON_SAR_ADC_TEMP_CHAN(NUM_CHAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(NUM_CHAN_SOFT_TIMESTAMP),
 };
 
 struct meson_sar_adc_param {
-- 
2.38.4

