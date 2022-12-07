Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513A36451B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiLGCEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:04:51 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD30E45EF5;
        Tue,  6 Dec 2022 18:04:50 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRgb53wCQz4xVnZ;
        Wed,  7 Dec 2022 10:04:49 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B724bCU036189;
        Wed, 7 Dec 2022 10:04:37 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 10:04:38 +0800 (CST)
Date:   Wed, 7 Dec 2022 10:04:38 +0800 (CST)
X-Zmail-TransId: 2af9638ff4b6fffffffffe10df3e
X-Mailer: Zmail v1.0
Message-ID: <202212071004382475676@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>, <jic23@kernel.org>
Cc:     <lars@metafoo.de>, <hdegoede@redhat.com>, <haibo.chen@nxp.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IG1tYTg0NTI6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B724bCU036189
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638FF4C1.001 by FangMail milter!
X-FangMail-Envelope: 1670378689/4NRgb53wCQz4xVnZ/638FF4C1.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638FF4C1.001/4NRgb53wCQz4xVnZ
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
 drivers/iio/accel/mma8452.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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
