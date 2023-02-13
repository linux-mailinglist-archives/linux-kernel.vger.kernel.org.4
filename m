Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFE4694A60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjBMPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBMPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:09:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDAC1BD4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:09:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F11ADCE0E93
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414AFC433D2;
        Mon, 13 Feb 2023 15:08:49 +0000 (UTC)
Date:   Mon, 13 Feb 2023 10:08:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [GIT PULL] tracing: Make trace_define_field_ext() static
Message-ID: <20230213100836.33d2b0b0@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing: Make trace_define_field_ext() static

Just after the fix to TASK_COMM_LEN not converted to its value in
trace_events was pulled, the kernel test robot reported that the helper
function trace_define_field_ext() added to that change was only used in
the file it was defined in but was not declared static. Make it a local
function.


Please pull the latest trace-v6.2-rc7-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.2-rc7-2

Tag SHA1: 3883ec09ec4e45286f3c09d4a88dbde8b328573c
Head SHA1: 70b5339caf847b8b6097b6dfab0c5a99b40713c8


Steven Rostedt (Google) (1):
      tracing: Make trace_define_field_ext() static

----
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 70b5339caf847b8b6097b6dfab0c5a99b40713c8
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Sun Feb 12 20:11:42 2023 -0500

    tracing: Make trace_define_field_ext() static
    
    trace_define_field_ext() is not used outside of trace_events.c, it should
    be static.
    
    Link: https://lore.kernel.org/oe-kbuild-all/202302130750.679RaRog-lkp@intel.com/
    
    Fixes: b6c7abd1c28a ("tracing: Fix TASK_COMM_LEN in trace event format file")
    Reported-by: Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6a4696719297..6a942fa275c7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -155,7 +155,7 @@ int trace_define_field(struct trace_event_call *call, const char *type,
 }
 EXPORT_SYMBOL_GPL(trace_define_field);
 
-int trace_define_field_ext(struct trace_event_call *call, const char *type,
+static int trace_define_field_ext(struct trace_event_call *call, const char *type,
 		       const char *name, int offset, int size, int is_signed,
 		       int filter_type, int len)
 {
