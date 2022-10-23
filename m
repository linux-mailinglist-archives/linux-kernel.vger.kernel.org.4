Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7656093D9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJWOTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJWOTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:19:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C35A205EE;
        Sun, 23 Oct 2022 07:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 459B7B80BA4;
        Sun, 23 Oct 2022 14:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D382C433D6;
        Sun, 23 Oct 2022 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666534777;
        bh=BnCoxBwqfVc8mFv8C62qIS6ajfq0d32muTzGWdCbdAI=;
        h=From:To:Cc:Subject:Date:From;
        b=Y0L8rl4P597U5ntLRnqmjYUc1GxXaTJjP0slOO9rCSXIEeo6MM60IHlVlADpFBubO
         AEjoaDrSL9R4//f7gEV/V4hqYIQ4yhIo06nUKzW1rX8xUsuJ2znO1WvrvZZCcI38fU
         9YcLW144r6XxEiNdMEI7FloRu28GmFB/iRBWbfXHGEtsfMkb+WD3GZB5Mm+Kidlp/8
         SOeMQI0XWZJXPbcnWqBacQhamrGQThrbUY5IQBdIvuBQHJ0lTzyALvv4w6Rgf/Bb7S
         v2MZv7PAFofFAjNM81A0knT/lg7VequCzByU1ZJRFQBajhqjcmShNlIfQXLAYL39RL
         7S9Ug7CNVlHKA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] tracing/fprobe: Fix to check whether fprobe is registered correctly
Date:   Sun, 23 Oct 2022 23:19:33 +0900
Message-Id:  <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since commit ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag
for fprobe") introduced fprobe_kprobe_handler() for fprobe::f_op::func,
unregister_fprobe() fails to unregister the registered if user specifies
FPROBE_FL_KPROBE_SHARED flag.
To check it correctly, it should confirm the fprobe::f_op::func is either
fprobe_handler() or fprobe_kprobe_handler().

Fixes: ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index aac63ca9c3d1..9000d8ea6274 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -301,7 +301,8 @@ int unregister_fprobe(struct fprobe *fp)
 {
 	int ret;
 
-	if (!fp || fp->ops.func != fprobe_handler)
+	if (!fp || (fp->ops.func != fprobe_handler &&
+		    fp->ops.func != fprobe_kprobe_handler))
 		return -EINVAL;
 
 	/*

