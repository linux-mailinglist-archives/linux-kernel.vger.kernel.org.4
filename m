Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAD6454B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLGHjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLGHjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:39:19 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B0338;
        Tue,  6 Dec 2022 23:39:18 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRq114wDJz8QrkZ;
        Wed,  7 Dec 2022 15:39:17 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B77d5vB059234;
        Wed, 7 Dec 2022 15:39:05 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:39:07 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:39:07 +0800 (CST)
X-Zmail-TransId: 2af96390431b63e7f32b
X-Mailer: Zmail v1.0
Message-ID: <202212071539074382512@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <lorenzo@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGh1bWlkaXR5OiBodHMyMTE6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B77d5vB059234
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63904325.001 by FangMail milter!
X-FangMail-Envelope: 1670398757/4NRq114wDJz8QrkZ/63904325.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63904325.001/4NRq114wDJz8QrkZ
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
 drivers/iio/humidity/hts221_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 2a413da87b76..e4ae4ffb9ffb 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -200,8 +200,7 @@ static ssize_t hts221_sysfs_sampling_freq(struct device *dev,
 	ssize_t len = 0;

 	for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 hts221_odr_table[i].hz);
+		len += sysfs_emit_at(buf, len, "%d ", hts221_odr_table[i].hz);
 	buf[len - 1] = '\n';

 	return len;
@@ -217,8 +216,7 @@ hts221_sysfs_rh_oversampling_avail(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 avg->avg_avl[i]);
+		len += sysfs_emit_at(buf, len, "%d ", avg->avg_avl[i]);
 	buf[len - 1] = '\n';

 	return len;
@@ -234,8 +232,7 @@ hts221_sysfs_temp_oversampling_avail(struct device *dev,
 	int i;

 	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 avg->avg_avl[i]);
+		len += sysfs_emit_at(buf, len, "%d ", avg->avg_avl[i]);
 	buf[len - 1] = '\n';

 	return len;
-- 
2.25.1
