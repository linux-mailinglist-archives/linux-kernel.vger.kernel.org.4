Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B98B7065E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjEQK7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEQK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3E59FF;
        Wed, 17 May 2023 03:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E0964547;
        Wed, 17 May 2023 10:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C8AC433EF;
        Wed, 17 May 2023 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321157;
        bh=Rr6xQgk50Y4ZGBCzUd1zUs+X3lNoqxnJIVxDwxiF6LU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thZMnliCQHj/O5mAIGFfQJfpbvfatklDohgA5pu2nfHfa99YO26XY9RDTH0pS9Hgy
         sFIMMIcMRYMuwUCtda83QPyApSgcrTum+TV7VCWC2htCxAmfA0qsJjq7UBZFketPxv
         pVEYI2rR4mta9KvXZaZqM7wlt2A1B/vX0rCabk55EkoUrx4LqtclqAQQduPiuwrr3g
         iCINjux6kOT6ELPB4uLTQ/5vtsVZeAXXp0gnQ7RGHNPRdz8LZoTHMZ+9jhAbzsX54S
         qrey5x43BmWDpcvBM8FZc/+RpPacgToEcGYLW5PYmEeTTPC6KO9vKp6RHjY0Vmnfkt
         fz8awZm022Pig==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v11 03/11] selftests/ftrace: Add fprobe related testcases
Date:   Wed, 17 May 2023 19:59:13 +0900
Message-ID:  <168432115391.1351929.18155967148867279954.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To:  <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
References:  <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
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

Add syntax error testcase and add-remove testcase for fprobe events.
This ensures that the fprobe events can be added/removed and parser
handles syntax errors correctly.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 ++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   88 ++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
new file mode 100644
index 000000000000..53e0d5671687
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove fprobe events
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+PLACE=$FUNCTION_FORK
+
+echo "f:myevent1 $PLACE" >> dynamic_events
+echo "f:myevent2 $PLACE%return" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/fprobes/myevent1
+test -d events/fprobes/myevent2
+
+echo "-:myevent2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+! grep -q myevent2 dynamic_events
+
+echo > dynamic_events
+
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
new file mode 100644
index 000000000000..549daa162d84
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -0,0 +1,88 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event parser error log check
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
+}
+
+check_error 'f^100 vfs_read'		# MAXACT_NO_KPROBE
+check_error 'f^1a111 vfs_read'		# BAD_MAXACT
+check_error 'f^100000 vfs_read'		# MAXACT_TOO_BIG
+
+check_error 'f ^non_exist_func'		# BAD_PROBE_ADDR (enoent)
+check_error 'f ^vfs_read+10'		# BAD_PROBE_ADDR
+check_error 'f:^/bar vfs_read'		# NO_GROUP_NAME
+check_error 'f:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
+
+check_error 'f:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
+check_error 'f:^ vfs_read'		# NO_EVENT_NAME
+check_error 'f:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
+check_error 'f:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
+
+check_error 'f vfs_read ^$retval'	# RETVAL_ON_PROBE
+check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
+
+check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
+
+check_error 'f vfs_read ^$none_var'	# BAD_VAR
+check_error 'f vfs_read ^%rax'		# BAD_VAR
+
+check_error 'f vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
+check_error 'f vfs_read ^@+10'		# FILE_ON_KPROBE
+
+grep -q "imm-value" README && \
+check_error 'f vfs_read arg1=\^x'	# BAD_IMM
+grep -q "imm-string" README && \
+check_error 'f vfs_read arg1=\"abcd^'	# IMMSTR_NO_CLOSE
+
+check_error 'f vfs_read ^+0@0)'		# DEREF_NEED_BRACE
+check_error 'f vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
+check_error 'f vfs_read +0(+0(@0^)'	# DEREF_OPEN_BRACE
+
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
+check_error 'f vfs_read +0(^$comm)'	# COMM_CANT_DEREF
+fi
+
+check_error 'f vfs_read ^&1'		# BAD_FETCH_ARG
+
+
+# We've introduced this limitation with array support
+if grep -q ' <type>\\\[<array-size>\\\]' README; then
+check_error 'f vfs_read +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 'f vfs_read +0(@11):u8[10^'		# ARRAY_NO_CLOSE
+check_error 'f vfs_read +0(@11):u8[10]^a'	# BAD_ARRAY_SUFFIX
+check_error 'f vfs_read +0(@11):u8[^10a]'	# BAD_ARRAY_NUM
+check_error 'f vfs_read +0(@11):u8[^256]'	# ARRAY_TOO_BIG
+fi
+
+check_error 'f vfs_read @11:^unknown_type'	# BAD_TYPE
+check_error 'f vfs_read $stack0:^string'	# BAD_STRING
+check_error 'f vfs_read @11:^b10@a/16'		# BAD_BITFIELD
+
+check_error 'f vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
+check_error 'f vfs_read ^=@11'			# NO_ARG_NAME
+check_error 'f vfs_read ^var.1=@11'		# BAD_ARG_NAME
+check_error 'f vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
+check_error 'f vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 'f vfs_read arg1=^'			# NO_ARG_BODY
+
+
+# multiprobe errors
+if grep -q "Create/append/" README && grep -q "imm-value" README; then
+echo "f:fprobes/testevent $FUNCTION_FORK" > dynamic_events
+check_error '^f:fprobes/testevent do_exit%return'	# DIFF_PROBE_TYPE
+
+# Explicitly use printf "%s" to not interpret \1
+printf "%s" "f:fprobes/testevent $FUNCTION_FORK abcd=\\1" > dynamic_events
+check_error "f:fprobes/testevent $FUNCTION_FORK ^bcd=\\1"	# DIFF_ARG_TYPE
+check_error "f:fprobes/testevent $FUNCTION_FORK ^abcd=\\1:u8"	# DIFF_ARG_TYPE
+check_error "f:fprobes/testevent $FUNCTION_FORK ^abcd=\\\"foo\"" # DIFF_ARG_TYPE
+check_error "^f:fprobes/testevent $FUNCTION_FORK abcd=\\1"	# SAME_PROBE
+fi
+
+# %return suffix errors
+check_error 'f vfs_read^%hoge'		# BAD_ADDR_SUFFIX
+
+exit 0

