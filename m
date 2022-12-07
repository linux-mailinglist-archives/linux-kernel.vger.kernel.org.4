Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08CE6454D9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLGHtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:49:48 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178E2F392;
        Tue,  6 Dec 2022 23:49:47 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRqF62c6lz4xVnR;
        Wed,  7 Dec 2022 15:49:46 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B77nWYg072212;
        Wed, 7 Dec 2022 15:49:33 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:49:34 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:49:34 +0800 (CST)
X-Zmail-TransId: 2af96390458effffffff95f94637
X-Mailer: Zmail v1.0
Message-ID: <202212071549349412843@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andy.shevchenko@gmail.com>
Cc:     <jic23@kernel.org>, <lars@metafoo.de>, <linmq006@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IG1hZ25ldG9tZXRlcjogYm1jMTUwX21hZ246IENvbnZlcnQgdG8gdXNlwqBzeXNmc19lbWl0X2F0KCkgQVBJ?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B77nWYg072212
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6390459A.002 by FangMail milter!
X-FangMail-Envelope: 1670399386/4NRqF62c6lz4xVnR/6390459A.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6390459A.002/4NRqF62c6lz4xVnR
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
 drivers/iio/magnetometer/bmc150_magn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 06d5a1ef1fbd..1398684a7f30 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -598,8 +598,7 @@ static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
 	for (i = 0; i < ARRAY_SIZE(bmc150_magn_samp_freq_table); i++) {
 		if (bmc150_magn_samp_freq_table[i].freq > data->max_odr)
 			break;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 bmc150_magn_samp_freq_table[i].freq);
+		len += sysfs_emit_at(buf, len, "%d ", bmc150_magn_samp_freq_table[i].freq);
 	}
 	/* replace last space with a newline */
 	buf[len - 1] = '\n';
-- 
2.25.1
