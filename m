Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA326454CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLGHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:45:30 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D81B3B3;
        Tue,  6 Dec 2022 23:45:29 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NRq876cwGz4y0tt;
        Wed,  7 Dec 2022 15:45:27 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B77jFkp068016;
        Wed, 7 Dec 2022 15:45:15 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:45:17 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:45:17 +0800 (CST)
X-Zmail-TransId: 2af96390448d54e8c22e
X-Mailer: Zmail v1.0
Message-ID: <202212071545177462713@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGxpZ2h0OiBsdjAxMDRjczogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B77jFkp068016
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63904497.000 by FangMail milter!
X-FangMail-Envelope: 1670399127/4NRq876cwGz4y0tt/63904497.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63904497.000/4NRq876cwGz4y0tt
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
 drivers/iio/light/lv0104cs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
index c041fa0faa5d..c0e82ae12920 100644
--- a/drivers/iio/light/lv0104cs.c
+++ b/drivers/iio/light/lv0104cs.c
@@ -397,9 +397,9 @@ static ssize_t lv0104cs_show_calibscale_avail(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(lv0104cs_calibscales); i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
-				lv0104cs_calibscales[i].val,
-				lv0104cs_calibscales[i].val2);
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
+				     lv0104cs_calibscales[i].val,
+				     lv0104cs_calibscales[i].val2);
 	}

 	buf[len - 1] = '\n';
@@ -414,9 +414,9 @@ static ssize_t lv0104cs_show_scale_avail(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(lv0104cs_scales); i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
-				lv0104cs_scales[i].val,
-				lv0104cs_scales[i].val2);
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
+				     lv0104cs_scales[i].val,
+				     lv0104cs_scales[i].val2);
 	}

 	buf[len - 1] = '\n';
@@ -431,9 +431,9 @@ static ssize_t lv0104cs_show_int_time_avail(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(lv0104cs_int_times); i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
-				lv0104cs_int_times[i].val,
-				lv0104cs_int_times[i].val2);
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
+				     lv0104cs_int_times[i].val,
+				     lv0104cs_int_times[i].val2);
 	}

 	buf[len - 1] = '\n';
-- 
2.25.1
