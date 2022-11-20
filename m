Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA338631638
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKTUIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKTUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B079F1E713
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76E660D2E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1287C433D6;
        Sun, 20 Nov 2022 20:07:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1owqbH-00Di9F-2U;
        Sun, 20 Nov 2022 15:07:35 -0500
Message-ID: <20221120200735.618733319@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 20 Nov 2022 15:07:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 12/13] tracing: Fix potential null-pointer-access of entry in list
 tr->err_log
References: <20221120200700.725968899@goodmis.org>
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

From: Zheng Yejian <zhengyejian1@huawei.com>

Entries in list 'tr->err_log' will be reused after entry number
exceed TRACING_LOG_ERRS_MAX.

The cmd string of the to be reused entry will be freed first then
allocated a new one. If the allocation failed, then the entry will
still be in list 'tr->err_log' but its 'cmd' field is set to be NULL,
later access of 'cmd' is risky.

Currently above problem can cause the loss of 'cmd' information of first
entry in 'tr->err_log'. When execute `cat /sys/kernel/tracing/error_log`,
reproduce logs like:
  [   37.495100] trace_kprobe: error: Maxactive is not for kprobe(null) ^
  [   38.412517] trace_kprobe: error: Maxactive is not for kprobe
    Command: p4:myprobe2 do_sys_openat2
            ^

Link: https://lore.kernel.org/linux-trace-kernel/20221114104632.3547266-1-zhengyejian1@huawei.com

Fixes: 1581a884b7ca ("tracing: Remove size restriction on tracing_log_err cmd strings")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5bd202d6d79a..a7fe0e115272 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7803,6 +7803,7 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
 						   int len)
 {
 	struct tracing_log_err *err;
+	char *cmd;
 
 	if (tr->n_err_log_entries < TRACING_LOG_ERRS_MAX) {
 		err = alloc_tracing_log_err(len);
@@ -7811,12 +7812,12 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
 
 		return err;
 	}
-
+	cmd = kzalloc(len, GFP_KERNEL);
+	if (!cmd)
+		return ERR_PTR(-ENOMEM);
 	err = list_first_entry(&tr->err_log, struct tracing_log_err, list);
 	kfree(err->cmd);
-	err->cmd = kzalloc(len, GFP_KERNEL);
-	if (!err->cmd)
-		return ERR_PTR(-ENOMEM);
+	err->cmd = cmd;
 	list_del(&err->list);
 
 	return err;
-- 
2.35.1


