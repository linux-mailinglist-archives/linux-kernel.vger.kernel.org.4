Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1B6454C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiLGHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLGHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:42:55 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE8D17048;
        Tue,  6 Dec 2022 23:42:52 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRq572jwxz8QrkZ;
        Wed,  7 Dec 2022 15:42:51 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B77giPi061070;
        Wed, 7 Dec 2022 15:42:44 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:42:47 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:42:47 +0800 (CST)
X-Zmail-TransId: 2af9639043f7fffffffff4886c2e
X-Mailer: Zmail v1.0
Message-ID: <202212071542472012621@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <ktsai@capellamicro.com>, <andriy.shevchenko@linux.intel.com>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGxpZ2h0OiBjbTMyMzI6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77giPi061070
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 639043FB.000 by FangMail milter!
X-FangMail-Envelope: 1670398971/4NRq572jwxz8QrkZ/639043FB.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 639043FB.000/4NRq572jwxz8QrkZ
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
 drivers/iio/light/cm3232.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 43e492f5051d..e5ff14a825bf 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -291,10 +291,10 @@ static ssize_t cm3232_get_it_available(struct device *dev,
 	int i, len;

 	for (i = 0, len = 0; i < ARRAY_SIZE(cm3232_als_it_scales); i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",
-			cm3232_als_it_scales[i].val,
-			cm3232_als_it_scales[i].val2);
-	return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");
+		len += sysfs_emit_at(buf, len, "%u.%06u ",
+				     cm3232_als_it_scales[i].val,
+				     cm3232_als_it_scales[i].val2);
+	return len + sysfs_emit_at(buf, len, "\n");
 }

 static const struct iio_chan_spec cm3232_channels[] = {
-- 
2.25.1
