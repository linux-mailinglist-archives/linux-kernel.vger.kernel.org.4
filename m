Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24C605C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJTK03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJTK0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:26:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E16FBCE5;
        Thu, 20 Oct 2022 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666261504; x=1697797504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5CJvQyXYSyeyrHUYB55JAtZ2HIfmh1x13LmNIgYZbtw=;
  b=IqqWI2sdPXe+7bDpyXR/QhF3teLG5ump0wWhqTIHuS1A2nh236+Hl4GE
   E7RlO8tV/SW5opxbAkCtt0vAHN93R6ZEz4RGbkaWEqSi2mt0P4GhX1+BN
   JXd34QW7ma81RY9Yu41gZXYmUlonicMJt3jh9Hd0pc5DjYeIx2EFIJu64
   Mpu4z5S6Zv7UvZQfnZsaGu0c72F8fUgkmlcQThas4xe/YlH2UwRHjwjd1
   sqVa8ccALFNRnrhwEelgyfTv+do/OyxQxLWqaEiTtjA0/fNsF91gfiZI4
   dJVrLotCta7XXZFCZdg76Q6YW0QmYr9BuLvPWqTgiVe7FNQ5YnzccJdma
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="196279431"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Oct 2022 03:24:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 20 Oct 2022 03:24:53 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 20 Oct 2022 03:24:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] iio: adc: at91-sama5d2_adc: get rid of 5 degrees Celsius adjustment
Date:   Thu, 20 Oct 2022 13:27:05 +0300
Message-ID: <20221020102705.3639204-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SAMA7G5 final chip version there is no need for 5 degrees Celsius
adjustment when computing junction temperature, thus, remove it.

Fixes: 5ab38b81895c ("iio: adc: at91-sama5d2_adc: add support for temperature sensor")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 33e251552214..870f4cb60923 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2307,11 +2307,9 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
 	clb->p6 = buf[AT91_ADC_TS_CLB_IDX_P6];
 
 	/*
-	 * We prepare here the conversion to milli and also add constant
-	 * factor (5 degrees Celsius) to p1 here to avoid doing it on
-	 * hotpath.
+	 * We prepare here the conversion to milli to avoid doing it on hotpath.
 	 */
-	clb->p1 = clb->p1 * 1000 + 5000;
+	clb->p1 = clb->p1 * 1000;
 
 free_buf:
 	kfree(buf);
-- 
2.34.1

