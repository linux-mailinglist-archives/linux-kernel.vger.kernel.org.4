Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54916451AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLGCDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLGCDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:03:35 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0B31EDC;
        Tue,  6 Dec 2022 18:03:34 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NRgYd031tz501Qj;
        Wed,  7 Dec 2022 10:03:33 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B723I0T034447;
        Wed, 7 Dec 2022 10:03:18 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 10:03:19 +0800 (CST)
Date:   Wed, 7 Dec 2022 10:03:19 +0800 (CST)
X-Zmail-TransId: 2af9638ff4670360af95
X-Mailer: Zmail v1.0
Message-ID: <202212071003192805636@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andriy.shevchenko@linux.intel.com>, <jic23@kernel.org>
Cc:     <lars@metafoo.de>, <u.kleine-koenig@pengutronix.de>,
        <petrm@nvidia.com>, <olteanv@gmail.com>,
        <ddrokosov@sberdevices.ru>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGJtYTE4MDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B723I0T034447
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638FF475.000 by FangMail milter!
X-FangMail-Envelope: 1670378613/4NRgYd031tz501Qj/638FF475.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638FF475.000/4NRgYd031tz501Qj
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
 drivers/iio/accel/bma180.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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

-- 
2.25.1
