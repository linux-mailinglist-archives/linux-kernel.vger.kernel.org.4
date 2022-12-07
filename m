Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F376454B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLGHhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLGHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:36:35 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA693057A;
        Tue,  6 Dec 2022 23:36:21 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRpxc3WY4z4xVnm;
        Wed,  7 Dec 2022 15:36:20 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B77a2Qs054104;
        Wed, 7 Dec 2022 15:36:02 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:36:05 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:36:05 +0800 (CST)
X-Zmail-TransId: 2af96390426508a78d7d
X-Mailer: Zmail v1.0
Message-ID: <202212071536050872424@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <tomasz.duszynski@octakon.com>, <lars@metafoo.de>,
        <andriy.shevchenko@linux.intel.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGNoZW1pY2FsOiBzY2QzMDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77a2Qs054104
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63904274.001 by FangMail milter!
X-FangMail-Envelope: 1670398580/4NRpxc3WY4z4xVnm/63904274.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63904274.001/4NRpxc3WY4z4xVnm
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
 drivers/iio/chemical/scd30_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 682fca39d14d..76a48dbdfe2e 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -354,7 +354,7 @@ static ssize_t sampling_frequency_available_show(struct device *dev, struct devi
 	ssize_t len = 0;

 	do {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ", 1000000000 / i);
+		len += sysfs_emit_at(buf, len, "0.%09u ", 1000000000 / i);
 		/*
 		 * Not all values fit PAGE_SIZE buffer hence print every 6th
 		 * (each frequency differs by 6s in time domain from the
-- 
2.25.1
