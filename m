Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524A56451AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiLGCCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLGCBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:01:51 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74F532D5;
        Tue,  6 Dec 2022 18:01:50 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRgWc3dRsz5BNRf;
        Wed,  7 Dec 2022 10:01:48 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl2.zte.com.cn with SMTP id 2B721eZ1033016;
        Wed, 7 Dec 2022 10:01:40 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 10:01:39 +0800 (CST)
Date:   Wed, 7 Dec 2022 10:01:39 +0800 (CST)
X-Zmail-TransId: 2af9638ff403ffffffffc1f06b83
X-Mailer: Zmail v1.0
Message-ID: <202212071001393275575@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>, <andriy.shevchenko@linux.intel.com>
Cc:     <lars@metafoo.de>, <michael.hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGFkeGwzNzI6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B721eZ1033016
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638FF40C.000 by FangMail milter!
X-FangMail-Envelope: 1670378508/4NRgWc3dRsz5BNRf/638FF40C.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638FF40C.000/4NRgWc3dRsz5BNRf
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
 1 file changed, 1 insertion(+), 2 deletions(-)

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

-- 
2.25.1
