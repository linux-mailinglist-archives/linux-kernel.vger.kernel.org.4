Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49EC68DC71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjBGPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjBGPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:06:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655415C93
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 559A260DD1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AD8C433D2;
        Tue,  7 Feb 2023 15:06:10 +0000 (UTC)
Date:   Tue, 7 Feb 2023 10:06:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shiju Jose <shiju.jose@huawei.com>, mchehab@kernel.org
Subject: [ GIT PULL] tracing: Allow poll() and select() to not block
Message-ID: <20230207100608.203ef0f1@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing: Fix small regression in poll() and select()

With the fix that made poll() and select() block if read would block
caused a slight regression in rasdaemon, as it needed that kind
of behavior. Add a way to make that behavior come back by writing
zero into the "buffer_percentage", which means to never block on read,
poll or select.


Please pull the latest trace-v6.2-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.2-rc6

Tag SHA1: d35c826e198a367e8eda280b42dc0b408bd2ccef
Head SHA1: 3e46d910d8acf94e5360126593b68bf4fee4c4a1


Shiju Jose (1):
      tracing: Fix poll() and select() do not work on per_cpu trace_pipe and trace_pipe_raw

----
 kernel/trace/trace.c | 3 ---
 1 file changed, 3 deletions(-)
---------------------------
commit 3e46d910d8acf94e5360126593b68bf4fee4c4a1
Author: Shiju Jose <shiju.jose@huawei.com>
Date:   Thu Feb 2 18:23:09 2023 +0000

    tracing: Fix poll() and select() do not work on per_cpu trace_pipe and trace_pipe_raw
    
    poll() and select() on per_cpu trace_pipe and trace_pipe_raw do not work
    since kernel 6.1-rc6. This issue is seen after the commit
    42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
    polling block on watermark").
    
    This issue is firstly detected and reported, when testing the CXL error
    events in the rasdaemon and also erified using the test application for poll()
    and select().
    
    This issue occurs for the per_cpu case, when calling the ring_buffer_poll_wait(),
    in kernel/trace/ring_buffer.c, with the buffer_percent > 0 and then wait until the
    percentage of pages are available. The default value set for the buffer_percent is 50
    in the kernel/trace/trace.c.
    
    As a fix, allow userspace application could set buffer_percent as 0 through
    the buffer_percent_fops, so that the task will wake up as soon as data is added
    to any of the specific cpu buffer.
    
    Link: https://lore.kernel.org/linux-trace-kernel/20230202182309.742-2-shiju.jose@huawei.com
    
    Cc: <mhiramat@kernel.org>
    Cc: <mchehab@kernel.org>
    Cc: <linux-edac@vger.kernel.org>
    Cc: stable@vger.kernel.org
    Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
    Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 78ed5f1baa8c..c9e40f692650 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9148,9 +9148,6 @@ buffer_percent_write(struct file *filp, const char __user *ubuf,
 	if (val > 100)
 		return -EINVAL;
 
-	if (!val)
-		val = 1;
-
 	tr->buffer_percent = val;
 
 	(*ppos)++;
