Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EEC6454EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLGHyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLGHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:54:09 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA792EF79;
        Tue,  6 Dec 2022 23:54:08 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NRqL56ytjz4y0v3;
        Wed,  7 Dec 2022 15:54:05 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B77rrUm078208;
        Wed, 7 Dec 2022 15:53:53 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:53:55 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:53:55 +0800 (CST)
X-Zmail-TransId: 2af96390469377a9d449
X-Mailer: Zmail v1.0
Message-ID: <202212071553556022992@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <lars@metafoo.de>, <andriy.shevchenko@linux.intel.com>,
        <miquel.raynal@bootlin.com>, <nuno.sa@analog.com>,
        <wsa+renesas@sang-engineering.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IHN0X3NlbnNvcnM6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B77rrUm078208
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6390469D.001 by FangMail milter!
X-FangMail-Envelope: 1670399645/4NRqL56ytjz4y0v3/6390469D.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6390469D.001/4NRqL56ytjz4y0v3
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
 drivers/iio/common/st_sensors/st_sensors_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index c77d7bdcc121..44e374f84197 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -628,8 +628,7 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
 		if (sdata->sensor_settings->odr.odr_avl[i].hz == 0)
 			break;

-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				sdata->sensor_settings->odr.odr_avl[i].hz);
+		len += sysfs_emit_at(buf, len, "%d ", sdata->sensor_settings->odr.odr_avl[i].hz);
 	}
 	buf[len - 1] = '\n';

@@ -651,7 +650,7 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
 		q = sdata->sensor_settings->fs.fs_avl[i].gain / 1000000;
 		r = sdata->sensor_settings->fs.fs_avl[i].gain % 1000000;

-		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ", q, r);
+		len += sysfs_emit_at(buf, len, "%u.%06u ", q, r);
 	}
 	buf[len - 1] = '\n';

-- 
2.25.1
