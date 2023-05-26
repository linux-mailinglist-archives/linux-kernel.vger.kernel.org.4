Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E973711ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 06:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjEZEUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 00:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbjEZEUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 00:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACFC1AC;
        Thu, 25 May 2023 21:19:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22158636DD;
        Fri, 26 May 2023 04:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09347C433EF;
        Fri, 26 May 2023 04:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685074777;
        bh=bIXnGsRyG1pDUZS2D/Yu8JUvsilyESO73q+7l1elRaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJDWVKOWD/9SQbwq9TPKWNEhQhSTMDFp2dz0JSfAMmB3eaeA5mOev9Km33voGji3g
         /Ldg+GhmodG8HjgaJk1+6nvvhAWDQWlXvRDoaj5KfFuKiWfx10q+vFYOlQRX85ho8w
         RoJVev7rhTpszRvi0t2PL9pQBgMPGX1d5d2APuXDtYdWGiA8SUfQs+5P/PUeutDVjW
         jypXM9Z70AXT6xOaNU5n6PpuOi6dfGUREsh1+4eVIllx4zJldiHZXOkrddhjUphKo8
         Tw/oyBYSz2rMQuv9ieW7LXOVVzt73iAlQm6y6EWqumhLaM1r6CFJ3aCd82een9sRvl
         BsKOAo6ixAf3w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v13 10/12] selftests/ftrace: Add tracepoint probe test case
Date:   Fri, 26 May 2023 12:19:32 +0800
Message-ID:  <168507477214.913472.11218388626709005588.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
References:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add test cases for tracepoint probe events.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v12:
 - Fix to remove buggy space in requires line.
---
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |    2 
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 +++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    2 
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 ++++++++++++++++++++
 4 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 53e0d5671687..dc25bcf4f9e2 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Generic dynamic event - add/remove fprobe events
-# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
 
 echo 0 > events/enable
 echo > dynamic_events
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
new file mode 100644
index 000000000000..155792eaeee5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Generic dynamic event - add/remove tracepoint probe events
+# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]":README
+
+echo 0 > events/enable
+echo > dynamic_events
+
+TRACEPOINT1=kmem_cache_alloc
+TRACEPOINT2=kmem_cache_free
+
+echo "t:myevent1 $TRACEPOINT1" >> dynamic_events
+echo "t:myevent2 $TRACEPOINT2" >> dynamic_events
+
+grep -q myevent1 dynamic_events
+grep -q myevent2 dynamic_events
+test -d events/tracepoints/myevent1
+test -d events/tracepoints/myevent2
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
index 48e7a1a6aae3..4065a21efea1 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Fprobe event parser error log check
-# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]": README
+# requires: dynamic_events "f[:[<group>/][<event>]] <func-name>[%return] [<args>]":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
new file mode 100644
index 000000000000..da117b8f1d12
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
@@ -0,0 +1,82 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Tracepoint probe event parser error log check
+# requires: dynamic_events "t[:[<group>/][<event>]] <tracepoint> [<args>]":README
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'trace_fprobe' "$1" 'dynamic_events'
+}
+
+check_error 't^100 kfree'		# BAD_MAXACT_TYPE
+
+check_error 't ^non_exist_tracepoint'	# NO_TRACEPOINT
+check_error 't:^/bar kfree'		# NO_GROUP_NAME
+check_error 't:^12345678901234567890123456789012345678901234567890123456789012345/bar kfree'	# GROUP_TOO_LONG
+
+check_error 't:^foo.1/bar kfree'	# BAD_GROUP_NAME
+check_error 't:^ kfree'			# NO_EVENT_NAME
+check_error 't:foo/^12345678901234567890123456789012345678901234567890123456789012345 kfree'	# EVENT_TOO_LONG
+check_error 't:foo/^bar.1 kfree'	# BAD_EVENT_NAME
+
+check_error 't kfree ^$retval'		# RETVAL_ON_PROBE
+check_error 't kfree ^$stack10000'	# BAD_STACK_NUM
+
+check_error 't kfree ^$arg10000'	# BAD_ARG_NUM
+
+check_error 't kfree ^$none_var'	# BAD_VAR
+check_error 't kfree ^%rax'		# BAD_VAR
+
+check_error 't kfree ^@12345678abcde'	# BAD_MEM_ADDR
+check_error 't kfree ^@+10'		# FILE_ON_KPROBE
+
+grep -q "imm-value" README && \
+check_error 't kfree arg1=\^x'	# BAD_IMM
+grep -q "imm-string" README && \
+check_error 't kfree arg1=\"abcd^'	# IMMSTR_NO_CLOSE
+
+check_error 't kfree ^+0@0)'		# DEREF_NEED_BRACE
+check_error 't kfree ^+0ab1(@0)'	# BAD_DEREF_OFFS
+check_error 't kfree +0(+0(@0^)'	# DEREF_OPEN_BRACE
+
+if grep -A1 "fetcharg:" README | grep -q '\$comm' ; then
+check_error 't kfree +0(^$comm)'	# COMM_CANT_DEREF
+fi
+
+check_error 't kfree ^&1'		# BAD_FETCH_ARG
+
+
+# We've introduced this limitation with array support
+if grep -q ' <type>\\\[<array-size>\\\]' README; then
+check_error 't kfree +0(^+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(+0(@0))))))))))))))'	# TOO_MANY_OPS?
+check_error 't kfree +0(@11):u8[10^'		# ARRAY_NO_CLOSE
+check_error 't kfree +0(@11):u8[10]^a'		# BAD_ARRAY_SUFFIX
+check_error 't kfree +0(@11):u8[^10a]'		# BAD_ARRAY_NUM
+check_error 't kfree +0(@11):u8[^256]'		# ARRAY_TOO_BIG
+fi
+
+check_error 't kfree @11:^unknown_type'		# BAD_TYPE
+check_error 't kfree $stack0:^string'		# BAD_STRING
+check_error 't kfree @11:^b10@a/16'		# BAD_BITFIELD
+
+check_error 't kfree ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
+check_error 't kfree ^=@11'			# NO_ARG_NAME
+check_error 't kfree ^var.1=@11'		# BAD_ARG_NAME
+check_error 't kfree var1=@11 ^var1=@12'	# USED_ARG_NAME
+check_error 't kfree ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
+check_error 't kfree arg1=^'			# NO_ARG_BODY
+
+
+# multiprobe errors
+if grep -q "Create/append/" README && grep -q "imm-value" README; then
+echo "t:tracepoint/testevent kfree" > dynamic_events
+check_error '^f:tracepoint/testevent kfree'	# DIFF_PROBE_TYPE
+
+# Explicitly use printf "%s" to not interpret \1
+printf "%s" "t:tracepoints/testevent kfree abcd=\\1" > dynamic_events
+check_error "t:tracepoints/testevent kfree ^bcd=\\1"	# DIFF_ARG_TYPE
+check_error "t:tracepoints/testevent kfree ^abcd=\\1:u8"	# DIFF_ARG_TYPE
+check_error "t:tracepoints/testevent kfree ^abcd=\\\"foo\"" # DIFF_ARG_TYPE
+check_error "^t:tracepoints/testevent kfree abcd=\\1"	# SAME_PROBE
+fi
+
+exit 0

