Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0952D6454B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLGHhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiLGHhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:37:46 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654A15A29;
        Tue,  6 Dec 2022 23:37:43 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRpzB4NJ6z4xVnf;
        Wed,  7 Dec 2022 15:37:42 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B77bc9r055311;
        Wed, 7 Dec 2022 15:37:38 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 7 Dec 2022 15:37:40 +0800 (CST)
Date:   Wed, 7 Dec 2022 15:37:40 +0800 (CST)
X-Zmail-TransId: 2af9639042c45db7c2cb
X-Mailer: Zmail v1.0
Message-ID: <202212071537405832465@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jic23@kernel.org>
Cc:     <lars@metafoo.de>, <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpaW86IGhlYWx0aDogYWZlNDQweDogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B77bc9r055311
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 639042C6.000 by FangMail milter!
X-FangMail-Envelope: 1670398662/4NRpzB4NJ6z4xVnf/639042C6.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 639042C6.000/4NRpzB4NJ6z4xVnf
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
 drivers/iio/health/afe440x.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
index 0adea0047eba..7750b1adc423 100644
--- a/drivers/iio/health/afe440x.h
+++ b/drivers/iio/health/afe440x.h
@@ -122,9 +122,7 @@ static ssize_t _name ## _show(struct device *dev,			\
 	int i;								\
 									\
 	for (i = 0; i < ARRAY_SIZE(_table); i++)			\
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06u ", \
-				 _table[i].integer,			\
-				 _table[i].fract);			\
+		len += sysfs_emit_at(buf, len, "%d.%06u ", _table[i].integer, _table[i].fract); \
 									\
 	buf[len - 1] = '\n';						\
 									\
-- 
2.25.1
