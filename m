Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0163E863
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLADmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLADmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:42:49 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D332A274;
        Wed, 30 Nov 2022 19:42:48 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NN22t4tYtz4y0vt;
        Thu,  1 Dec 2022 11:42:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B13gWM9064943;
        Thu, 1 Dec 2022 11:42:32 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 11:42:33 +0800 (CST)
Date:   Thu, 1 Dec 2022 11:42:33 +0800 (CST)
X-Zmail-TransId: 2af9638822a9ffffffffca187e63
X-Mailer: Zmail v1.0
Message-ID: <202212011142333790361@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGFkYzogYXQ5MS1zYW1hNWQyX2FkYzogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mCgogc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B13gWM9064943
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638822B6.003 by FangMail milter!
X-FangMail-Envelope: 1669866166/4NN22t4tYtz4y0vt/638822B6.003/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638822B6.003/4NN22t4tYtz4y0vt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ed4f8501bda8..50d02e5fc6fc 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2181,7 +2181,7 @@ static ssize_t at91_adc_get_fifo_state(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
+	return sysfs_emit(buf, "%d\n", !!st->dma_st.dma_chan);
 }

 static ssize_t at91_adc_get_watermark(struct device *dev,
@@ -2190,7 +2190,7 @@ static ssize_t at91_adc_get_watermark(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct at91_adc_state *st = iio_priv(indio_dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
+	return sysfs_emit(buf, "%d\n", st->dma_st.watermark);
 }

 static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
-- 
2.25.1
