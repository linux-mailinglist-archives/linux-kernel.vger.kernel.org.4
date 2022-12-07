Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718636450D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLGBOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiLGBOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:14:39 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4434C25C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:14:38 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRfT92XxWz4xVnK;
        Wed,  7 Dec 2022 09:14:37 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 2B71EN5C058547;
        Wed, 7 Dec 2022 09:14:23 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 7 Dec 2022 09:14:24 +0800 (CST)
Date:   Wed, 7 Dec 2022 09:14:24 +0800 (CST)
X-Zmail-TransId: 2b04638fe8f0ffffffff9ff87117
X-Mailer: Zmail v1.0
Message-ID: <202212070914242210002@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <arnd@arndb.de>
Cc:     <u.kleine-koenig@pengutronix.de>,
        <wsa+renesas@sang-engineering.com>, <benjamin.mugnier@foss.st.com>,
        <andriy.shevchenko@linux.intel.com>, <error27@gmail.com>,
        <justinstitt@google.com>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1pc2M6IGVlcHJvbS9pZHRfODlocGVzeDogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mCiBzdHJuY3B5KCnCoA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B71EN5C058547
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638FE8FD.000 by FangMail milter!
X-FangMail-Envelope: 1670375677/4NRfT92XxWz4xVnK/638FE8FD.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638FE8FD.000/4NRfT92XxWz4xVnK
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
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 drivers/misc/eeprom/idt_89hpesx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 4e07ee9cb500..57b985fe59f4 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -941,8 +941,7 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 			goto free_buf;
 		}
 		/* Copy the register address to the substring buffer */
-		strncpy(csraddr_str, buf, csraddr_len);
-		csraddr_str[csraddr_len] = '\0';
+		strscpy(csraddr_str, buf, csraddr_len + 1);
 		/* Register value must follow the colon */
 		csrval_str = colon_ch + 1;
 	} else /* if (str_colon == NULL) */ {
-- 
2.15.2
