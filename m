Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405FF6427BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLELnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiLELmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:42:21 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609A1A212;
        Mon,  5 Dec 2022 03:42:10 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQhV92nnZz8RTZG;
        Mon,  5 Dec 2022 19:42:09 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 2B5Bg4xo053795;
        Mon, 5 Dec 2022 19:42:04 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 5 Dec 2022 19:42:08 +0800 (CST)
Date:   Mon, 5 Dec 2022 19:42:08 +0800 (CST)
X-Zmail-TransId: 2b04638dd91003fa7628
X-Mailer: Zmail v1.0
Message-ID: <202212051942082259437@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <steve.wahl@hpe.com>
Cc:     <mike.travis@hpe.com>, <dimitri.sivanich@hpe.com>,
        <russ.anderson@hpe.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <andy.shevchenko@gmail.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIHg4Ni9wbGF0Zm9ybS91djogdXNlIHN0cnNjcHkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B5Bg4xo053795
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638DD911.001 by FangMail milter!
X-FangMail-Envelope: 1670240529/4NQhV92nnZz8RTZG/638DD911.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DD911.001/4NQhV92nnZz8RTZG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.
---
change for v2
 - fix the mistake and make the code better and simpler,
thanks to Andy Shevchenko.
---

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/x86/platform/uv/uv_nmi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index a60af0230e27..d94140842aa3 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -205,11 +205,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 	char arg[ACTION_LEN], *p;

 	/* (remove possible '\n') */
-	strncpy(arg, val, ACTION_LEN - 1);
-	arg[ACTION_LEN - 1] = '\0';
-	p = strchr(arg, '\n');
-	if (p)
-		*p = '\0';
+	strscpy(arg, val, strnchrnul(val, ACTION_LEN, '\n') - val);

 	for (i = 0; i < n; i++)
 		if (!strcmp(arg, valid_acts[i].action))
-- 
2.15.2
