Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593766454CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLGHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiLGHoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:44:10 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EB33B2;
        Tue,  6 Dec 2022 23:44:08 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRq6Z3XHxz8R03x;
        Wed,  7 Dec 2022 15:44:06 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B77i1YT066091;
        Wed, 7 Dec 2022 15:44:01 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:44:03 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:44:03 +0800 (CST)
X-Zmail-TransId: 2af963904443ffffffffaf5897d8
X-Mailer: Zmail v1.0
Message-ID: <202212071544032182658@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>,
        <u.kleine-koenig@pengutronix.de>, <benjamin.mugnier@foss.st.com>,
        <peda@axentia.se>, <ye.xingchen@zte.com.cn>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGxpZ2h0OiBsdHI1MDE6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B77i1YT066091
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63904446.001 by FangMail milter!
X-FangMail-Envelope: 1670399046/4NRq6Z3XHxz8R03x/63904446.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63904446.001/4NRq6Z3XHxz8R03x
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
 drivers/iio/light/ltr501.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index bdbd918213e4..436f060a34e2 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1116,9 +1116,9 @@ static ssize_t ltr501_show_proximity_scale_avail(struct device *dev,
 	for (i = 0; i < info->ps_gain_tbl_size; i++) {
 		if (info->ps_gain[i].scale == LTR501_RESERVED_GAIN)
 			continue;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
-				 info->ps_gain[i].scale,
-				 info->ps_gain[i].uscale);
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
+				     info->ps_gain[i].scale,
+				     info->ps_gain[i].uscale);
 	}

 	buf[len - 1] = '\n';
@@ -1138,9 +1138,9 @@ static ssize_t ltr501_show_intensity_scale_avail(struct device *dev,
 	for (i = 0; i < info->als_gain_tbl_size; i++) {
 		if (info->als_gain[i].scale == LTR501_RESERVED_GAIN)
 			continue;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
-				 info->als_gain[i].scale,
-				 info->als_gain[i].uscale);
+		len += sysfs_emit_at(buf, len, "%d.%06d ",
+				     info->als_gain[i].scale,
+				     info->als_gain[i].uscale);
 	}

 	buf[len - 1] = '\n';
-- 
2.25.1
