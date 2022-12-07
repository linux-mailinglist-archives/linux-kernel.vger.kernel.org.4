Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA83D6454D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLGHq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLGHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:46:55 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC782EF21;
        Tue,  6 Dec 2022 23:46:54 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NRq9m0kk0z4y0v1;
        Wed,  7 Dec 2022 15:46:52 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B77kiio065981;
        Wed, 7 Dec 2022 15:46:44 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:46:47 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:46:47 +0800 (CST)
X-Zmail-TransId: 2af9639044e73898f066
X-Mailer: Zmail v1.0
Message-ID: <202212071546472332762@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>,
        <u.kleine-koenig@pengutronix.de>, <gwendal@chromium.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGxpZ2h0OiB0c2wyNzcyOiBDb252ZXJ0IHRvIHVzZcKgc3lzZnNfZW1pdCgpL3N5c2ZzX2VtaXRfYXQoKSBBUElz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77kiio065981
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 639044EC.000 by FangMail milter!
X-FangMail-Envelope: 1670399212/4NRq9m0kk0z4y0v1/639044EC.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 639044EC.000/4NRq9m0kk0z4y0v1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iio/light/tsl2772.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index ad50baa0202c..03cae6a536b4 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -927,7 +927,7 @@ static ssize_t in_illuminance0_target_input_show(struct device *dev,
 {
 	struct tsl2772_chip *chip = iio_priv(dev_to_iio_dev(dev));

-	return scnprintf(buf, PAGE_SIZE, "%d\n", chip->settings.als_cal_target);
+	return sysfs_emit(buf, "%d\n", chip->settings.als_cal_target);
 }

 static ssize_t in_illuminance0_target_input_store(struct device *dev,
@@ -981,9 +981,9 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 	int offset = 0;

 	while (i < TSL2772_MAX_LUX_TABLE_SIZE) {
-		offset += scnprintf(buf + offset, PAGE_SIZE - offset, "%u,%u,",
-			chip->tsl2772_device_lux[i].ch0,
-			chip->tsl2772_device_lux[i].ch1);
+		offset += sysfs_emit_at(buf, offset, "%u,%u,",
+					chip->tsl2772_device_lux[i].ch0,
+					chip->tsl2772_device_lux[i].ch1);
 		if (chip->tsl2772_device_lux[i].ch0 == 0) {
 			/*
 			 * We just printed the first "0" entry.
@@ -995,7 +995,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 		i++;
 	}

-	offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n");
+	offset += sysfs_emit_at(buf, offset, "\n");
 	return offset;
 }

-- 
2.25.1
