Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61B66454E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLGHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLGHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:52:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403AA185;
        Tue,  6 Dec 2022 23:52:38 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRqJP4cf9z5BNS0;
        Wed,  7 Dec 2022 15:52:37 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B77qTYw072323;
        Wed, 7 Dec 2022 15:52:29 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:52:31 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:52:31 +0800 (CST)
X-Zmail-TransId: 2af96390463f7919a463
X-Mailer: Zmail v1.0
Message-ID: <202212071552316472938@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>,
        <u.kleine-koenig@pengutronix.de>, <luca.ceresoli@bootlin.com>,
        <ojeda@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IG1hZ25ldG9tZXRlcjogbWFnMzExMDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpwqBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77qTYw072323
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63904645.002 by FangMail milter!
X-FangMail-Envelope: 1670399557/4NRqJP4cf9z5BNS0/63904645.002/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63904645.002/4NRqJP4cf9z5BNS0
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
 drivers/iio/magnetometer/mag3110.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 661176a885ad..6dcc68093535 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -121,8 +121,7 @@ static ssize_t mag3110_show_int_plus_micros(char *buf,
 	size_t len = 0;

 	while (n-- > 0)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			"%d.%06d ", vals[n][0], vals[n][1]);
+		len += sysfs_emit_at(buf, len, "%d.%06d ", vals[n][0], vals[n][1]);

 	/* replace trailing space by newline */
 	buf[len - 1] = '\n';
-- 
2.25.1
