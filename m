Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3E707C64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjERI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjERI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:58:15 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558601BE9
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:58:13 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QMP5H3blQz5B14p;
        Thu, 18 May 2023 16:58:11 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 34I8w3fT024754;
        Thu, 18 May 2023 16:58:04 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Thu, 18 May 2023 16:58:06 +0800 (CST)
Date:   Thu, 18 May 2023 16:58:06 +0800 (CST)
X-Zmail-TransId: 2afb6465e89e473-3b03c
X-Mailer: Zmail v1.0
Message-ID: <202305181658063480018@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>
Cc:     <linus.walleij@linaro.org>, <lihuafei1@huawei.com>,
        <broonie@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?wqBbUEFUQ0ggbGludXgtbmV4dF0gQVJNOiB1bndpbmQ6IHVzZSBleF9mcmFtZSB3aXRoIENPTkZJR19VTldJTkRFUl9GUkFNRV9QT0lOVEVS?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 34I8w3fT024754
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6465E8A3.000/4QMP5H3blQz5B14p
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
but we just use ex_frame without CONFIG_UNWINDER_FRAME_POINTER in
return_address() and unwind_frame(). 
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
