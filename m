Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F2631646
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKTUMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKTUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:12:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC3027D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D4B60D29
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C9C4314A;
        Sun, 20 Nov 2022 20:12:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1owqfu-00DiY3-1z;
        Sun, 20 Nov 2022 15:12:22 -0500
Message-ID: <20221120201222.492058544@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 20 Nov 2022 15:12:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Li Huafei <lihuafei1@huawei.com>
Subject: [for-linus][PATCH 5/7] kprobes: Skip clearing aggrprobes post_handler in kprobe-on-ftrace
 case
References: <20221120201156.868430827@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Huafei <lihuafei1@huawei.com>

In __unregister_kprobe_top(), if the currently unregistered probe has
post_handler but other child probes of the aggrprobe do not have
post_handler, the post_handler of the aggrprobe is cleared. If this is
a ftrace-based probe, there is a problem. In later calls to
disarm_kprobe(), we will use kprobe_ftrace_ops because post_handler is
NULL. But we're armed with kprobe_ipmodify_ops. This triggers a WARN in
__disarm_kprobe_ftrace() and may even cause use-after-free:

  Failed to disarm kprobe-ftrace at kernel_clone+0x0/0x3c0 (error -2)
  WARNING: CPU: 5 PID: 137 at kernel/kprobes.c:1135 __disarm_kprobe_ftrace.isra.21+0xcf/0xe0
  Modules linked in: testKprobe_007(-)
  CPU: 5 PID: 137 Comm: rmmod Not tainted 6.1.0-rc4-dirty #18
  [...]
  Call Trace:
   <TASK>
   __disable_kprobe+0xcd/0xe0
   __unregister_kprobe_top+0x12/0x150
   ? mutex_lock+0xe/0x30
   unregister_kprobes.part.23+0x31/0xa0
   unregister_kprobe+0x32/0x40
   __x64_sys_delete_module+0x15e/0x260
   ? do_user_addr_fault+0x2cd/0x6b0
   do_syscall_64+0x3a/0x90
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   [...]

For the kprobe-on-ftrace case, we keep the post_handler setting to
identify this aggrprobe armed with kprobe_ipmodify_ops. This way we
can disarm it correctly.

Link: https://lore.kernel.org/all/20221112070000.35299-1-lihuafei1@huawei.com/

Fixes: 0bc11ed5ab60 ("kprobes: Allow kprobes coexist with livepatch")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cd9f5a66a690..3050631e528d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1766,7 +1766,13 @@ static int __unregister_kprobe_top(struct kprobe *p)
 				if ((list_p != p) && (list_p->post_handler))
 					goto noclean;
 			}
-			ap->post_handler = NULL;
+			/*
+			 * For the kprobe-on-ftrace case, we keep the
+			 * post_handler setting to identify this aggrprobe
+			 * armed with kprobe_ipmodify_ops.
+			 */
+			if (!kprobe_ftrace(ap))
+				ap->post_handler = NULL;
 		}
 noclean:
 		/*
-- 
2.35.1


