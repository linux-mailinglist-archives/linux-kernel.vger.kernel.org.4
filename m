Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9DC5EC8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiI0QBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiI0QBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8732B114B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DCE61A85
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DABEC43140;
        Tue, 27 Sep 2022 16:01:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2g-00G2o8-0M;
        Tue, 27 Sep 2022 12:02:42 -0400
Message-ID: <20220927160241.746173925@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/20] selftests/ftrace: Add eprobe syntax error testcase
References: <20220927160216.349640304@goodmis.org>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add a syntax error test case for eprobe as same as kprobes.

Link: https://lkml.kernel.org/r/165932115471.2850673.8014722990775242727.stgit@devnote2

Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../test.d/dynevent/eprobes_syntax_errors.tc  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
new file mode 100644
index 000000000000..fc1daac7f066
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Event probe event parser error log check
+# requires: dynamic_events events/syscalls/sys_enter_openat "<attached-group>.<attached-event> [<args>]":README error_log
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'event_probe' "$1" 'dynamic_events'
+}
+
+check_error 'e ^a.'			# NO_EVENT_INFO
+check_error 'e ^.b'			# NO_EVENT_INFO
+check_error 'e ^a.b'			# BAD_ATTACH_EVENT
+check_error 'e syscalls/sys_enter_openat ^foo'	# BAD_ATTACH_ARG
+check_error 'e:^/bar syscalls/sys_enter_openat'	# NO_GROUP_NAME
+check_error 'e:^12345678901234567890123456789012345678901234567890123456789012345/bar syscalls/sys_enter_openat'	# GROUP_TOO_LONG
+
+check_error 'e:^foo.1/bar syscalls/sys_enter_openat'	# BAD_GROUP_NAME
+check_error 'e:^ syscalls/sys_enter_openat'		# NO_EVENT_NAME
+check_error 'e:foo/^12345678901234567890123456789012345678901234567890123456789012345 syscalls/sys_enter_openat'	# EVENT_TOO_LONG
+check_error 'e:foo/^bar.1 syscalls/sys_enter_openat'	# BAD_EVENT_NAME
+
+check_error 'e:foo/bar syscalls/sys_enter_openat arg=^dfd'	# BAD_FETCH_ARG
+check_error 'e:foo/bar syscalls/sys_enter_openat ^arg=$foo'	# BAD_ATTACH_ARG
+
+check_error 'e:foo/bar syscalls/sys_enter_openat if ^'	# NO_EP_FILTER
+
+exit 0
-- 
2.35.1
