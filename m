Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6026454D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiLGHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLGHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:48:23 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C66F2F392;
        Tue,  6 Dec 2022 23:48:22 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRqCS641zz4xVnj;
        Wed,  7 Dec 2022 15:48:20 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B77m7jG070980;
        Wed, 7 Dec 2022 15:48:07 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:48:09 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:48:09 +0800 (CST)
X-Zmail-TransId: 2af963904539ffffffffebb91b96
X-Mailer: Zmail v1.0
Message-ID: <202212071548094732807@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGxpZ2h0OiB6b3B0MjIwMTogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B77m7jG070980
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63904544.000 by FangMail milter!
X-FangMail-Envelope: 1670399300/4NRqCS641zz4xVnj/63904544.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63904544.000/4NRqCS641zz4xVnj
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
 drivers/iio/light/zopt2201.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index e3bac8b56380..97e5412d3a4e 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -438,8 +438,7 @@ static ssize_t zopt2201_show_int_time_available(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06lu ",
-				 zopt2201_resolution[i].us);
+		len += sysfs_emit_at(buf, len, "0.%06lu ", zopt2201_resolution[i].us);
 	buf[len - 1] = '\n';

 	return len;
@@ -455,9 +454,9 @@ static ssize_t zopt2201_show_als_scale_avail(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_als); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
-				 zopt2201_scale_als[i].scale,
-				 zopt2201_scale_als[i].uscale);
+		len += sysfs_emit_at(buf, len, "%d.%06u ",
+				     zopt2201_scale_als[i].scale,
+				     zopt2201_scale_als[i].uscale);
 	buf[len - 1] = '\n';

 	return len;
@@ -471,9 +470,9 @@ static ssize_t zopt2201_show_uvb_scale_avail(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_uvb); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ",
-				 zopt2201_scale_uvb[i].scale,
-				 zopt2201_scale_uvb[i].uscale);
+		len += sysfs_emit_at(buf, len, "%d.%06u ",
+				     zopt2201_scale_uvb[i].scale,
+				     zopt2201_scale_uvb[i].uscale);
 	buf[len - 1] = '\n';

 	return len;
-- 
2.25.1
