Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678287244E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbjFFNvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbjFFNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:51:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAAD83;
        Tue,  6 Jun 2023 06:51:02 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 2408D5FD41;
        Tue,  6 Jun 2023 16:50:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686059459;
        bh=9kFJi/z4Psvva6f9jMpTP3rE2fmtgwDXrYMID542PFA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=XxNJshJLzEfaXwSgrsmMX4VErysyDd8xVvonhfy0pQ3JD3GU3R5CGil3yXhiOwIiW
         TT+eNHkzPiFdHESY+ysL1qPgFtjoK+8H7XgVTm0NqPLUcus1+JwO9vu5WIjdtZuxex
         n6UBSfRqECNtxsOm4XGP3M5OTgPcfMowX4N/qXfq8Y1oM4MgEz9xdyth7pMui8yd85
         JmL5LTk3Ycrc5UkOboyvzPst7gfqJEwBs6XflONf7kUdaWhkP6DTvg5CNpH8CCpBjN
         tHffklVSr1fBCDfGlDgewLXXx9A4WYf879EVIap+P1iEvNRbQ8d+PxtHM0jOPvwO8W
         dHQKBpXp5dC3w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  6 Jun 2023 16:50:57 +0300 (MSK)
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
Subject: [PATCH v2] meson saradc: fix clock divider mask length
Date:   Tue, 6 Jun 2023 16:50:17 +0300
Message-ID: <20230606135017.4141617-1-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/06 11:10:00 #21443593
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to datasheets of supported meson SOCs
length of ADC_CLK_DIV field is 6 bits long.
Although all supported SOCs have the register with the
field ADC_CLK_DIV documented later SOCs use external clock
rather than ADC internal clock so
this patch affects only meson8 family (S8* SOCs)

Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
Changelog:

v1 -> v2:
    * Update commit message
---
 drivers/iio/adc/meson_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 85b6826cc10c..b93ff42b8c19 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -72,7 +72,7 @@
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
 	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
-	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
+	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
 
-- 
2.38.4

