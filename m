Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1A64549F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLGHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLGHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:32:35 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F9BA5;
        Tue,  6 Dec 2022 23:32:33 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRpsC68D9z4xVng;
        Wed,  7 Dec 2022 15:32:31 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B77WOZ0050816;
        Wed, 7 Dec 2022 15:32:24 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:32:27 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:32:27 +0800 (CST)
X-Zmail-TransId: 2af96390418b25a70f55
X-Mailer: Zmail v1.0
Message-ID: <202212071532270902318@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <lars@metafoo.de>, <andriy.shevchenko@linux.intel.com>,
        <michael.hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGFkYzogYWRpLWF4aS1hZGM6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXRfYXQoKSBBUEk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77WOZ0050816
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6390418F.000 by FangMail milter!
X-FangMail-Envelope: 1670398351/4NRpsC68D9z4xVng/6390418F.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6390418F.000/4NRpsC68D9z4xVng
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
 drivers/iio/adc/adi-axi-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index e8a8ea4140f1..20a6e7463552 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -240,8 +240,7 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 	for (i = 0; i < conv->chip_info->num_scales; i++) {
 		const unsigned int *s = conv->chip_info->scale_table[i];

-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "%u.%06u ", s[0], s[1]);
+		len += sysfs_emit_at(buf, len, "%u.%06u ", s[0], s[1]);
 	}
 	buf[len - 1] = '\n';

-- 
2.25.1
