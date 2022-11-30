Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8E63D011
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiK3ICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiK3ICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:02:01 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E142F7A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:01:58 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NMWrP1Z55z4xyCY;
        Wed, 30 Nov 2022 16:01:57 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2AU81dm3026906;
        Wed, 30 Nov 2022 16:01:39 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 30 Nov 2022 16:01:41 +0800 (CST)
Date:   Wed, 30 Nov 2022 16:01:41 +0800 (CST)
X-Zmail-TransId: 2b0463870de5ffffffffa0535c37
X-Mailer: Zmail v1.0
Message-ID: <202211301601416229001@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <pmladek@suse.com>
Cc:     <senozhatsky@chromium.org>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHByaW50azogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cmxjcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AU81dm3026906
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63870DF5.000 by FangMail milter!
X-FangMail-Envelope: 1669795317/4NMWrP1Z55z4xyCY/63870DF5.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63870DF5.000/4NMWrP1Z55z4xyCY
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
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9ec101766471..7decf1e9c486 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2480,7 +2480,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		return -E2BIG;
 	if (!brl_options)
 		preferred_console = i;
-	strlcpy(c->name, name, sizeof(c->name));
+	strscpy(c->name, name, sizeof(c->name));
 	c->options = options;
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
-- 
2.15.2
