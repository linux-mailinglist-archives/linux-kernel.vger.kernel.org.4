Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F74701DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjENON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbjENONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C55940E9;
        Sun, 14 May 2023 07:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6ECD617C2;
        Sun, 14 May 2023 14:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDB4C433D2;
        Sun, 14 May 2023 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684073564;
        bh=8hzLLyA5q1ixa5JK95GZiCskCkJKBzPXwx+Fsa6/ktI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tm5bQDhYr4knnUM5sgyN7PDqn612c3HGLrvO3L/TuHQ3Qu5dAGRBFxByKaGKeRsCR
         1r+4q8OYMCltxFUJlty8Wz4VoUhhNV21y7s3YfAm84ZcjOPzvIq5S+mACQZ6gbUWUA
         xCkWDdYTsNwMNY/ZTrIkEoQmG2Ck8hznqI14+5WaSfkuqoHwXqUsh25GhMKgI6fF7K
         YgNWG/PYK+hCLn8esifY/g0yRh3znUsRrqZOeVyg2ke05Rnuxgex2teE8PQmJGUmbK
         joX1HhVKZzajc+/yAYG23dKiW5jVyQKnHac6P2+0xn7ROdIP+fWuOT9XJ2ygJi/5vX
         b5Ly6cRdQSU4g==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v10 10/11] selftests/ftrace: Add BTF arguments test cases
Date:   Sun, 14 May 2023 23:12:40 +0900
Message-ID:  <168407356004.941486.11852338667282609345.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To:  <168407346448.941486.15681419068846125595.stgit@mhiramat.roam.corp.google.com>
References:  <168407346448.941486.15681419068846125595.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add test cases to check the BTF arguments correctly supported.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v10:
 - Change $$args to $args
 - Add new error patterns
 - Fix non BTF case
Changes in v7:
 - Add BTF void retval test case
---
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   13 +++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   13 +++++
 3 files changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
new file mode 100644
index 000000000000..be1be6526108
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
@@ -0,0 +1,54 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove probes with BTF arguments
+# requires: dynamic_events "<argname>":README
+
+KPROBES=
+FPROBES=
+
+if grep -qF "p[:[<group>/][<event>]] <place> [<args>]" README ; then
+  KPROBES=yes
+fi
+if grep -qF "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README ; then
+  FPROBES=yes
+fi
+
+if [ -z "$KPROBES" -a "$FPROBES" ] ; then
+  exit_unsupported
+fi
+
+echo 0 > events/enable
+echo > dynamic_events
+
+TP=kfree
+
+if [ "$FPROBES" ] ; then
+echo "f:fpevent $TP object" >> dynamic_events
+echo "t:tpevent $TP ptr" >> dynamic_events
+
+grep -q "fpevent.*object=object" dynamic_events
+grep -q "tpevent.*ptr=ptr" dynamic_events
+
+echo > dynamic_events
+
+echo "f:fpevent $TP "'$args' >> dynamic_events
+echo "t:tpevent $TP "'$args' >> dynamic_events
+
+grep -q "fpevent.*object=object" dynamic_events
+grep -q "tpevent.*ptr=ptr" dynamic_events
+! grep -q "tpevent.*_data" dynamic_events
+fi
+
+echo > dynamic_events
+
+if [ "$KPROBES" ] ; then
+echo "p:kpevent $TP object" >> dynamic_events
+grep -q "kpevent.*object=object" dynamic_events
+
+echo > dynamic_events
+
+echo "p:kpevent $TP "'$args' >> dynamic_events
+grep -q "kpevent.*object=object" dynamic_events
+fi
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 549daa162d84..3b92f03d7418 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -85,4 +85,17 @@ fi
 # %return suffix errors
 check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 
+# BTF arguments errors
+if grep -q "<argname>" README; then
+check_error 'f vfs_read args=^$args'		# BAD_VAR_ARGS
+check_error 'f vfs_read +0(^$args)'		# BAD_VAR_ARGS
+check_error 'f vfs_read $args ^$args'		# DOUBLE_ARGS
+check_error 'f vfs_read%return ^$args'		# NOFENTRY_ARGS
+check_error 'f vfs_read ^hoge'			# NO_BTFARG
+check_error 'f kfree%return ^$retval'		# NO_RETVAL
+else
+check_error 'f vfs_read ^$args'			# NOSUP_BTFARG
+check_error 't kfree ^$args'			# NOSUP_BTFARG
+fi
+
 exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 97c08867490a..ed8aec676c21 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -103,4 +103,17 @@ check_error 'p vfs_read^%hoge'		# BAD_ADDR_SUFFIX
 check_error 'p ^vfs_read+10%return'	# BAD_RETPROBE
 fi
 
+# BTF arguments errors
+if grep -q "<argname>" README; then
+check_error 'p vfs_read args=^$args'		# BAD_VAR_ARGS
+check_error 'p vfs_read +0(^$args)'		# BAD_VAR_ARGS
+check_error 'p vfs_read $args ^$args'		# DOUBLE_ARGS
+check_error 'r vfs_read ^$args'			# NOFENTRY_ARGS
+check_error 'p vfs_read+8 ^$args'		# NOFENTRY_ARGS
+check_error 'p vfs_read ^hoge'			# NO_BTFARG
+check_error 'r kfree ^$retval'			# NO_RETVAL
+else
+check_error 'p vfs_read ^$args'			# NOSUP_BTFARG
+fi
+
 exit 0

