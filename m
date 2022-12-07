Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05506454E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLGHvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLGHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:51:15 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71230554;
        Tue,  6 Dec 2022 23:51:14 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRqGm6Y0Qz8R03d;
        Wed,  7 Dec 2022 15:51:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B77oxMU075141;
        Wed, 7 Dec 2022 15:50:59 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:51:01 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:51:01 +0800 (CST)
X-Zmail-TransId: 2af9639045e552c97201
X-Mailer: Zmail v1.0
Message-ID: <202212071551017192888@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andy.shevchenko@gmail.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>, <jiangjian@cdjrlc.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IG1hZ25ldG9tZXRlcjogaG1jNTg0MzogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpwqBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B77oxMU075141
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 639045F0.001 by FangMail milter!
X-FangMail-Envelope: 1670399472/4NRqGm6Y0Qz8R03d/639045F0.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 639045F0.001/4NRqGm6Y0Qz8R03d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iio/magnetometer/hmc5843_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index c5521d61da29..134f6045e24a 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -274,9 +274,9 @@ ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
 	int i;

 	for (i = 0; i < data->variant->n_regval_to_samp_freq; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			"%d.%d ", data->variant->regval_to_samp_freq[i][0],
-			data->variant->regval_to_samp_freq[i][1]);
+		len += sysfs_emit_at(buf, len, "%d.%d ",
+				     data->variant->regval_to_samp_freq[i][0],
+				     data->variant->regval_to_samp_freq[i][1]);

 	/* replace trailing space by newline */
 	buf[len - 1] = '\n';
@@ -335,8 +335,7 @@ static ssize_t hmc5843_show_scale_avail(struct device *dev,
 	int i;

 	for (i = 0; i < data->variant->n_regval_to_nanoscale; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			"0.%09d ", data->variant->regval_to_nanoscale[i]);
+		len += sysfs_emit_at(buf, len, "0.%09d ", data->variant->regval_to_nanoscale[i]);

 	/* replace trailing space by newline */
 	buf[len - 1] = '\n';
-- 
2.25.1
