Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDB6DBE50
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 04:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDIC2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 22:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDIC2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 22:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86559EE;
        Sat,  8 Apr 2023 19:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBCA960B76;
        Sun,  9 Apr 2023 02:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA72AC433EF;
        Sun,  9 Apr 2023 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681007316;
        bh=cVM9AQdC8fERYzKAP4b8qgin6kb00dHQoiudcmM67Kc=;
        h=From:To:Cc:Subject:Date:From;
        b=YL6UoNE4UOqxWO0btsl854aWVZUbhPDqousyhhFcRUd3gvUe2MYZTM1THXsyYnk6m
         QaRUNoUa3scudLcmgJVehdlZSvAaz+TyZ+totE4haQ+VGoEp+Hw5NmcCzjwUdyqpZo
         Bqlp0FJ/sjOSUuGgrQcQKQ7h64hAUX5glssIWDVigrtlJs67rm8t7/vBAujOd0+XAT
         bM3fvFy/JbCkceEjJ+g/qvUbiuJkfPdisBqWBWVjc3yrFK0/AJljic1DUhUM+pvw/5
         nOll+Zeqp/GdotEfUGhFGabZ2xRjrnFEcuXwoOwIUTtMkJjZZEGVBhWWSy+Xl3TDjl
         kF/7lKcPl0Y/w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <error27@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fprobe: Initialize ret valiable to fix smatch error
Date:   Sun,  9 Apr 2023 11:28:31 +0900
Message-Id: <168100731160.79534.374827110083836722.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The commit 39d954200bf6 ("fprobe: Skip exit_handler if entry_handler returns
!0") introduced a hidden dependency of 'ret' local variable in the
fprobe_handler(), Smatch warns the `ret` can be accessed without
initialization.

	kernel/trace/fprobe.c:59 fprobe_handler()
	error: uninitialized symbol 'ret'.

kernel/trace/fprobe.c
    49                 fpr->entry_ip = ip;
    50                 if (fp->entry_data_size)
    51                         entry_data = fpr->data;
    52         }
    53
    54         if (fp->entry_handler)
    55                 ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);

ret is only initialized if there is an ->entry_handler

    56
    57         /* If entry_handler returns !0, nmissed is not counted. */
    58         if (rh) {

rh is only true if there is an ->exit_handler.  Presumably if you have
and ->exit_handler that means you also have a ->entry_handler but Smatch
is not smart enough to figure it out.

--> 59                 if (ret)
                           ^^^
Warning here.

    60                         rethook_recycle(rh);
    61                 else
    62                         rethook_hook(rh, ftrace_get_regs(fregs), true);
    63         }
    64 out:
    65         ftrace_test_recursion_unlock(bit);
    66 }


Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/85429a5c-a4b9-499e-b6c0-cbd313291c49@kili.mountain
Fixes: 39d954200bf6 ("fprobe: Skip exit_handler if entry_handler returns !0")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9abb3905bc8e..293184227394 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -27,7 +27,7 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
 	void *entry_data = NULL;
-	int bit, ret;
+	int bit, ret = 0;
 
 	fp = container_of(ops, struct fprobe, ops);
 	if (fprobe_disabled(fp))

