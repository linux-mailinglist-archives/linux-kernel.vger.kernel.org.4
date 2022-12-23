Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6C654B30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiLWClF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiLWClD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:41:03 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938211928A;
        Thu, 22 Dec 2022 18:41:02 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NdWdT2kFBz4xVnK;
        Fri, 23 Dec 2022 10:41:01 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 2BN2esCr070573;
        Fri, 23 Dec 2022 10:40:54 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 23 Dec 2022 10:40:56 +0800 (CST)
Date:   Fri, 23 Dec 2022 10:40:56 +0800 (CST)
X-Zmail-TransId: 2b0463a515387568e84e
X-Mailer: Zmail v1.0
Message-ID: <202212231040562072342@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <james.bottomley@hansenpartnership.com>
Cc:     <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBhcmlzYzogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BN2esCr070573
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63A5153D.000 by FangMail milter!
X-FangMail-Envelope: 1671763261/4NdWdT2kFBz4xVnK/63A5153D.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63A5153D.000/4NdWdT2kFBz4xVnK
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
 drivers/parisc/pdc_stable.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index d6af5726ddf3..403bca0021c5 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -274,8 +274,7 @@ pdcspath_hwpath_write(struct pdcspath_entry *entry, const char *buf, size_t coun

 	/* We'll use a local copy of buf */
 	count = min_t(size_t, count, sizeof(in)-1);
-	strncpy(in, buf, count);
-	in[count] = '\0';
+	strscpy(in, buf, count + 1);
 	
 	/* Let's clean up the target. 0xff is a blank pattern */
 	memset(&hwpath, 0xff, sizeof(hwpath));
@@ -388,8 +387,7 @@ pdcspath_layer_write(struct pdcspath_entry *entry, const char *buf, size_t count

 	/* We'll use a local copy of buf */
 	count = min_t(size_t, count, sizeof(in)-1);
-	strncpy(in, buf, count);
-	in[count] = '\0';
+	strscpy(in, buf, count + 1);
 	
 	/* Let's clean up the target. 0 is a blank pattern */
 	memset(&layers, 0, sizeof(layers));
@@ -756,8 +754,7 @@ static ssize_t pdcs_auto_write(struct kobject *kobj,

 	/* We'll use a local copy of buf */
 	count = min_t(size_t, count, sizeof(in)-1);
-	strncpy(in, buf, count);
-	in[count] = '\0';
+	strscpy(in, buf, count + 1);

 	/* Current flags are stored in primary boot path entry */
 	pathentry = &pdcspath_entry_primary;
-- 
2.15.2
