Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC8641484
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLCGYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiLCGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:24:21 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE61C23D2;
        Fri,  2 Dec 2022 22:24:20 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NPKXM0Jvqz5BNS0;
        Sat,  3 Dec 2022 14:24:19 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 2B36OF6L089225;
        Sat, 3 Dec 2022 14:24:15 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 3 Dec 2022 14:24:17 +0800 (CST)
Date:   Sat, 3 Dec 2022 14:24:17 +0800 (CST)
X-Zmail-TransId: 2b04638aeb9173903db7
X-Mailer: Zmail v1.0
Message-ID: <202212031424175433783@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <steve.wahl@hpe.com>
Cc:     <mike.travis@hpe.com>, <dimitri.sivanich@hpe.com>,
        <russ.anderson@hpe.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHg4Ni9wbGF0Zm9ybS91djogdXNlIHN0cnNjcHkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B36OF6L089225
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638AEB93.000 by FangMail milter!
X-FangMail-Envelope: 1670048659/4NPKXM0Jvqz5BNS0/638AEB93.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638AEB93.000/4NPKXM0Jvqz5BNS0
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
 arch/x86/platform/uv/uv_nmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index a60af0230e27..1b0c8062c731 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -205,8 +205,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 	char arg[ACTION_LEN], *p;

 	/* (remove possible '\n') */
-	strncpy(arg, val, ACTION_LEN - 1);
-	arg[ACTION_LEN - 1] = '\0';
+	strscpy(arg, val, ACTION_LEN - 1);
 	p = strchr(arg, '\n');
 	if (p)
 		*p = '\0';
@@ -959,7 +958,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)

 		/* Unexpected return, revert action to "dump" */
 		if (master)
-			strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
+			strscpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
 	}

 	/* Pause as all CPU's enter the NMI handler */
-- 
2.15.2
