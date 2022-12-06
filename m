Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C98644287
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiLFLxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiLFLxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:53:32 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961B21C;
        Tue,  6 Dec 2022 03:53:31 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NRJhn3r8Xz4y0vM;
        Tue,  6 Dec 2022 19:53:29 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B6BrHVh085625;
        Tue, 6 Dec 2022 19:53:17 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 6 Dec 2022 19:53:20 +0800 (CST)
Date:   Tue, 6 Dec 2022 19:53:20 +0800 (CST)
X-Zmail-TransId: 2af9638f2d301b4bd45d
X-Mailer: Zmail v1.0
Message-ID: <202212061953201070549@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <michael.hennerich@analog.com>, <lars@metafoo.de>,
        <andriy.shevchenko@linux.intel.com>,
        <u.kleine-koenig@pengutronix.de>, <jk@codeconstruct.com.au>,
        <wsa@kernel.org>, <ddrokosov@sberdevices.ru>,
        <hdegoede@redhat.com>, <haibo.chen@nxp.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGFjY2VsOiBDb252ZXJ0IHRvIHVzZSBzeXNmc19lbWl0X2F0KCkgQVBJ?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B6BrHVh085625
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638F2D39.002 by FangMail milter!
X-FangMail-Envelope: 1670327609/4NRJhn3r8Xz4y0vM/638F2D39.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638F2D39.002/4NRJhn3r8Xz4y0vM
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
 drivers/iio/accel/adxl372.c | 3 +--
 drivers/iio/accel/bma180.c  | 3 +--
 drivers/iio/accel/mma8452.c | 5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index c4193286eb05..15bcb0d75b8f 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -970,8 +970,7 @@ static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
 	size_t len = 0;

 	for (i = 0; i <= st->odr; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "%d ", adxl372_bw_freq_tbl[i]);
+		len += sysfs_emit_at(buf, len, "%d ", adxl372_bw_freq_tbl[i]);

 	buf[len - 1] = '\n';

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index eb697eeb4301..9e3e5dfdded7 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -488,8 +488,7 @@ static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned int n,
 	for (i = 0; i < n; i++) {
 		if (!vals[i])
 			continue;
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			micros ? "0.%06d " : "%d ", vals[i]);
+		len += sysfs_emit_at(buf, len, micros ? "0.%06d " : "%d ", vals[i]);
 	}
 	buf[len - 1] = '\n';

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index f97fb68e3a71..7ba3c743e6f6 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -266,8 +266,7 @@ static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*vals)[2],
 	size_t len = 0;

 	while (n-- > 0)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
-				 vals[n][0], vals[n][1]);
+		len += sysfs_emit_at(buf, len, "%d.%06d ", vals[n][0], vals[n][1]);

 	/* replace trailing space by newline */
 	buf[len - 1] = '\n';
@@ -423,7 +422,7 @@ static ssize_t mma8452_show_os_ratio_avail(struct device *dev,

 		val = mma8452_os_ratio[j][i];

-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", val);
+		len += sysfs_emit_at(buf, len, "%d ", val);
 	}
 	buf[len - 1] = '\n';

-- 
2.25.1
