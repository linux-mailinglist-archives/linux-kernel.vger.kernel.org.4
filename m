Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5408A5FCE0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJLWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJLWCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F7D12571F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81DF8B81C21
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1800DC433D6;
        Wed, 12 Oct 2022 22:00:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oijmV-0049Ax-1l;
        Wed, 12 Oct 2022 18:00:51 -0400
Message-ID: <20221012220051.382750692@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Oct 2022 17:59:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-linus][PATCH 1/5] ftrace: Fix char print issue in print_ip_ins()
References: <20221012215911.735621065@goodmis.org>
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

When ftrace bug happened, following log shows every hex data in
problematic ip address:
  actual:   ffffffe8:6b:ffffffd9:01:21

But so many 'f's seem a little confusing, and that is because format
'%x' being used to print signed chars in array 'ins'. As suggested
by Joe, change to use format "%*phC" to print array 'ins'.

After this patch, the log is like:
  actual:   e8:6b:d9:01:21

Link: https://lkml.kernel.org/r/20221011120352.1878494-1-zhengyejian1@huawei.com

Fixes: 6c14133d2d3f ("ftrace: Do not blindly read the ip address in ftrace_bug()")
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 83362a155791..75c16215d065 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2028,7 +2028,6 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 static void print_ip_ins(const char *fmt, const unsigned char *p)
 {
 	char ins[MCOUNT_INSN_SIZE];
-	int i;
 
 	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
 		printk(KERN_CONT "%s[FAULT] %px\n", fmt, p);
@@ -2036,9 +2035,7 @@ static void print_ip_ins(const char *fmt, const unsigned char *p)
 	}
 
 	printk(KERN_CONT "%s", fmt);
-
-	for (i = 0; i < MCOUNT_INSN_SIZE; i++)
-		printk(KERN_CONT "%s%02x", i ? ":" : "", ins[i]);
+	pr_cont("%*phC", MCOUNT_INSN_SIZE, ins);
 }
 
 enum ftrace_bug_type ftrace_bug_type;
-- 
2.35.1
