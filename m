Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F9750085
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjGLH5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjGLH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:57:26 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C61992
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:57:22 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4R197c6YGRzbhY8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:57:16 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4R197P6mhYz6Jqrv
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:57:05 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4R197L5Y8zz5R9jt;
        Wed, 12 Jul 2023 15:57:02 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 36C7utTv023239;
        Wed, 12 Jul 2023 15:56:55 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid32;
        Wed, 12 Jul 2023 15:56:58 +0800 (CST)
Date:   Wed, 12 Jul 2023 15:56:58 +0800 (CST)
X-Zmail-TransId: 2af964ae5cca56f-ed69e
X-Mailer: Zmail v1.0
Message-ID: <202307121556582695428@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <linus.walleij@linaro.org>, <linux@armlinux.org.uk>,
        <rmk+kernel@armlinux.org.uk>
Cc:     <lihuafei1@huawei.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEFSTTogdW53aW5kOiB1c2UgZXhfZnJhbWUgd2l0aCBDT05GSUdfVU5XSU5ERVJfRlJBTUVfUE9JTlRFUg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 36C7utTv023239
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64AE5CDB.000/4R197c6YGRzbhY8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>

We define ex_frame with CONFIG_UNWINDER_FRAME_POINTER in struct stackframe,
struct stackframe
{
	......
#ifdef CONFIG_UNWINDER_FRAME_POINTER
	bool ex_frame;
#endif
};
but we just use ex_frame without CONFIG_UNWINDER_FRAME_POINTER in return_address()
and unwind_frame(). 
so when we config CONFIG_FRAME_POINTER=y and CONFIG_ARM_UNWIND=n, compile failed:
arch/arm/kernel/stacktrace.c: In function 'unwind_frame':
arch/arm/kernel/stacktrace.c:44:11: error: 'struct stackframe' has no member named 'ex_frame'
  if (frame->ex_frame) {
           ^~
arch/arm/kernel/stacktrace.c:57:8: error: 'struct stackframe' has no member named 'ex_frame'
   frame->ex_frame = false;
        ^~
arch/arm/kernel/stacktrace.c:67:8: error: 'struct stackframe' has no member named 'ex_frame'
   frame->ex_frame = true;
        ^~
		
Maybe we should fix it.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 arch/arm/kernel/return_address.c | 2 ++
 arch/arm/kernel/stacktrace.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/kernel/return_address.c b/arch/arm/kernel/return_address.c
index ac15db6..dae49e7 100644
--- a/arch/arm/kernel/return_address.c
+++ b/arch/arm/kernel/return_address.c
@@ -47,7 +47,9 @@ void *return_address(unsigned int level)
 	frame.kr_cur = NULL;
 	frame.tsk = current;
 #endif
+#ifdef CONFIG_UNWINDER_FRAME_POINTER
 	frame.ex_frame = false;
+#endif

 	walk_stackframe(&frame, save_return_addr, &data);

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 620aa82..338f552 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -82,6 +82,7 @@ int notrace unwind_frame(struct stackframe *frame)
 	if (frame_pointer_check(frame))
 		return -EINVAL;

+#ifdef CONFIG_UNWINDER_FRAME_POINTER
 	/*
 	 * When we unwind through an exception stack, include the saved PC
 	 * value into the stack trace.
@@ -102,6 +103,7 @@ int notrace unwind_frame(struct stackframe *frame)
 		frame->ex_frame = false;
 		return 0;
 	}
+#endif

 	/* restore the registers from the stack frame */
 #ifdef CONFIG_CC_IS_CLANG
@@ -119,8 +121,10 @@ int notrace unwind_frame(struct stackframe *frame)
 					(void *)frame->fp, &frame->kr_cur);
 #endif

+#ifdef CONFIG_UNWINDER_FRAME_POINTER
 	if (in_entry_text(frame->pc))
 		frame->ex_frame = true;
+#endif

 	return 0;
 }
-- 
1.8.3.1
