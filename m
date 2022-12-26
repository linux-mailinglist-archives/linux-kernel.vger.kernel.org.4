Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5386561F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiLZKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 05:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLZKkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 05:40:10 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6EC10DF;
        Mon, 26 Dec 2022 02:40:07 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NgZ6s5zfdz4xVnH;
        Mon, 26 Dec 2022 18:40:05 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2BQAe1xc048557;
        Mon, 26 Dec 2022 18:40:01 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 26 Dec 2022 18:40:04 +0800 (CST)
Date:   Mon, 26 Dec 2022 18:40:04 +0800 (CST)
X-Zmail-TransId: 2b0363a97a04fffffffff67e1b98
X-Mailer: Zmail v1.0
Message-ID: <202212261840048448622@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <james.bottomley@hansenpartnership.com>
Cc:     <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIHBhcmlzYzogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BQAe1xc048557
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63A97A05.000 by FangMail milter!
X-FangMail-Envelope: 1672051205/4NgZ6s5zfdz4xVnH/63A97A05.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A97A05.000/4NgZ6s5zfdz4xVnH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL-terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
change for v2
 - sizeof(in) is better and simplified, thanks for Helge Deller.
---
 drivers/parisc/pdc_stable.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index d6af5726ddf3..d3075445260b 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry *entry, const char *buf, size_t coun

 	/* We'll use a local copy of buf */
 	count = min_t(size_t, count, sizeof(in)-1);
-	strncpy(in, buf, count);
-	in[count] = '\0';
+	strscpy(in, buf, sizeof(in));
 	
 	/* Let's clean up the target. 0xff is a blank pattern */
 	memset(&hwpath, 0xff, sizeof(hwpath));
@@ -388,8 +387,7 @@ pdcspath_layer_write(struct pdcspath_entry *entry, const char *buf, size_t count

 	/* We'll use a local copy of buf */
 	count = min_t(size_t, count, sizeof(in)-1);
-	strncpy(in, buf, count);
-	in[count] = '\0';
+	strscpy(in, buf, sizeof(in));
 	
 	/* Let's clean up the target. 0 is a blank pattern */
 	memset(&layers, 0, sizeof(layers));
@@ -756,8 +754,7 @@ static ssize_t pdcs_auto_write(struct kobject *kobj,

 	/* We'll use a local copy of buf */
 	count = min_t(size_t, count, sizeof(in)-1);
-	strncpy(in, buf, count);
-	in[count] = '\0';
+	strscpy(in, buf, sizeof(in));

 	/* Current flags are stored in primary boot path entry */
 	pathentry = &pdcspath_entry_primary;
-- 
2.15.2
