Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF03740033
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjF0P61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjF0P6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410492D63
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6ED6118B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC47C433C0;
        Tue, 27 Jun 2023 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687881501;
        bh=Y74UB6OZyQ4Kef5eKxwjNQANfzqcJ4v1SWBb6wuLiwg=;
        h=Date:From:To:Cc:Subject:From;
        b=K0QTwxmTf6nM2VMg1tzJTje2AgKgGtvxKO8j8kwenqeIF97/q30J5dGKQL+z7+Jfo
         X7d8bgu2MqWyf/3ku5do9k+6FGVqK1qh6O/Q0r1PodNrsEgIMn0D5+aOslpFJGAlJC
         QyPRwl8WJ5pz2FwHh7AXWcEzbxgQ5vTD7auqsuxVK/gJ2QL1ONtA9UvcIp/r2Wbex4
         iQJlSVltyDjQwqGI5UoWx+n1TqRxS03mRgApARS3Hts1eqVi02o65iOsRst0RrcFEb
         1qDD8T4xo80mvOaQJUnOd4s1Sh6lACzUNu7LsOlsg0Ikqt/yfb8r7GYR9aTo6gPVoc
         MU06JMHo/2UNw==
Date:   Wed, 28 Jun 2023 00:58:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        Masami Hiramatsu (Google) <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Probes update for v6.5
Message-Id: <20230628005818.c8df3a79955c7585d979419b@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probes updates for v6.5:

- fprobe: Pass return address to the fprobe entry/exit callbacks so that
  the callbacks don't need to analyze pt_regs/stack to find the function
  return address.

- kprobe events: cleanup usage of TPARG_FL_FENTRY and TPARG_FL_RETURN
  flags so that those are not set at once.

- fprobe events:
 . Add a new fprobe events for tracing arbitrary function entry and
   exit as a trace event.
 . Add a new tracepoint events for tracing raw tracepoint as a trace
   event. This allows user to trace non user-exposed tracepoints.
 . Move eprobe's event parser code into probe event common file.
 . Introduce BTF (BPF type format) support to kernel probe (kprobe,
   fprobe and tracepoint probe) events so that user can specify traced
   function arguments by name. This also applies the type of argument
   when fetching the argument.
 . Introduce '$arg*' wildcard support if BTF is available. This expands
   the '$arg*' meta argument to all function argument automatically.
 . Check the return value types by BTF. If the function returns 'void',
   '$retval' is rejected.
 . Add some selftest script for fprobe events, tracepoint events and
   BTF support.
 . Update documentation about the fprobe events.
 . Some fixes for above features, document and selftests.

- selftests for ftrace (except for new fprobe events):
 . Add a test case for multiple consecutive probes in a function which
   checks if ftrace based kprobe, optimized kprobe and normal kprobe
   can be defined in the same target function.
 . Add a test case for optimized probe, which checks whether kprobe
   can be optimized or not.


Please pull the latest probes-v6.5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.5

Tag SHA1: 08bb7e2de7f32619cd100419e719ef96d6cf0aab
Head SHA1: 53431798f4bb60d214ae1ec4a79eefdd414f577b


Akanksha J N (2):
      selftests/ftrace: Add new test case which adds multiple consecutive probes in a function
      selftests/ftrace: Add new test case which checks for optimized probes

Masami Hiramatsu (Google) (15):
      fprobe: Pass return address to the handlers
      tracing/probes: Avoid setting TPARG_FL_FENTRY and TPARG_FL_RETURN
      tracing/probes: Add fprobe events for tracing function entry and exit.
      selftests/ftrace: Add fprobe related testcases
      tracing/probes: Add tracepoint support on fprobe_events
      tracing/probes: Move event parameter fetching code to common parser
      tracing/probes: Support function parameters if BTF is available
      tracing/probes: Add $arg* meta argument for all function args
      tracing/probes: Add BTF retval type support
      selftests/ftrace: Add tracepoint probe test case
      selftests/ftrace: Add BTF arguments test cases
      Documentation: tracing/probes: Add fprobe event tracing document
      tracing/probes: Fix to return NULL and keep using current argc
      Documentation: Fix typo of reference file name
      tracing/probes: Fix tracepoint event with $arg* to fetch correct argument

----
 Documentation/trace/fprobetrace.rst                |  188 +++
 Documentation/trace/index.rst                      |    1 +
 Documentation/trace/kprobetrace.rst                |    2 +
 include/linux/fprobe.h                             |   11 +-
 include/linux/rethook.h                            |    2 +-
 include/linux/trace_events.h                       |    3 +
 include/linux/tracepoint-defs.h                    |    1 +
 include/linux/tracepoint.h                         |    5 +
 kernel/kprobes.c                                   |    1 +
 kernel/trace/Kconfig                               |   26 +
 kernel/trace/Makefile                              |    1 +
 kernel/trace/bpf_trace.c                           |    6 +-
 kernel/trace/fprobe.c                              |   17 +-
 kernel/trace/rethook.c                             |    3 +-
 kernel/trace/trace.c                               |   13 +-
 kernel/trace/trace.h     Linus,

Probes updates for v6.5:

- fprobe: Pass return address to the fprobe entry/exit callbacks so that
  the callbacks don't need to analyze pt_regs/stack to find the function
  return address.

- kprobe events: cleanup usage of TPARG_FL_FENTRY and TPARG_FL_RETURN
  flags so that those are not set at once.

- fprobe events:
 . Add a new fprobe events for tracing arbitrary function entry and
   exit as a trace event.
 . Add a new tracepoint events for tracing raw tracepoint as a trace
   event. This allows user to trace non user-exposed tracepoints.
 . Move eprobe's event parser code into probe event common file.
 . Introduce BTF (BPF type format) support to kernel probe (kprobe,
   fprobe and tracepoint probe) events so that user can specify traced
   function arguments by name. This also applies the type of argument
   when fetching the argument.
 . Introduce '$arg*' wildcard support if BTF is available. This expands
   the '$arg*' meta argument to all function argument automatically.
 . Check the return value types by BTF. If the function returns 'void',
   '$retval' is rejected.
 . Add some selftest script for fprobe events, tracepoint events and
   BTF support.
 . Update documentation about the fprobe events.
 . Some fixes for above features, document and selftests.

- selftests for ftrace (except for new fprobe events):
 . Add a test case for multiple consecutive probes in a function which
   checks if ftrace based kprobe, optimized kprobe and normal kprobe
   can be defined in the same target function.
 . Add a test case for optimized probe, which checks whether kprobe
   can be optimized or not.


Please pull the latest probes-v6.5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.5

Tag SHA1: 08bb7e2de7f32619cd100419e719ef96d6cf0aab
Head SHA1: 53431798f4bb60d214ae1ec4a79eefdd414f577b


Akanksha J N (2):
      selftests/ftrace: Add new test case which adds multiple consecutive probes in a function
      selftests/ftrace: Add new test case which checks for optimized probes

Masami Hiramatsu (Google) (15):
      fprobe: Pass return address to the handlers
      tracing/probes: Avoid setting TPARG_FL_FENTRY and TPARG_FL_RETURN
      tracing/probes: Add fprobe events for tracing function entry and exit.
      selftests/ftrace: Add fprobe related testcases
      tracing/probes: Add tracepoint support on fprobe_events
      tracing/probes: Move event parameter fetching code to common parser
      tracing/probes: Support function parameters if BTF is available
      tracing/probes: Add $arg* meta argument for all function args
      tracing/probes: Add BTF retval type support
      selftests/ftrace: Add tracepoint probe test case
      selftests/ftrace: Add BTF arguments test cases
      Documentation: tracing/probes: Add fprobe event tracing document
      tracing/probes: Fix to return NULL and keep using current argc
      Documentation: Fix typo of reference file name
      tracing/probes: Fix tracepoint event with $arg* to fetch correct argument

----
 Documentation/trace/fprobetrace.rst                |  188 +++
 Documentation/trace/index.rst                      |    1 +
 Documentation/trace/kprobetrace.rst                |    2 +
 include/linux/fprobe.h                             |   11 +-
 include/linux/rethook.h                            |    2 +-
 include/linux/trace_events.h                       |    3 +
 include/linux/tracepoint-defs.h                    |    1 +
 include/linux/tracepoint.h                         |    5 +
 kernel/kprobes.c                                   |    1 +
 kernel/trace/Kconfig                               |   26 +
 kernel/trace/Makefile                              |    1 +
 kernel/trace/bpf_trace.c                           |    6 +-
 kernel/trace/fprobe.c                              |   17 +-
 kernel/trace/rethook.c                             |    3 +-
 kernel/trace/trace.c                               |   13 +-
 kernel/trace/trace.h                               |   11 +
 kernel/trace/trace_eprobe.c                        |   44 +-
 kernel/trace/trace_fprobe.c                        | 1199 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c                        |   35 +-
 kernel/trace/trace_probe.c                         |  659 +++++++++--
 kernel/trace/trace_probe.h                         |   49 +-
 kernel/trace/trace_uprobe.c                        |    8 +-
 lib/test_fprobe.c                                  |   10 +-
 samples/fprobe/fprobe_example.c                    |    6 +-
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   58 +
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 +
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |  111 ++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 ++
 .../ftrace/test.d/kprobe/kprobe_insn_boundary.tc   |   19 +
 .../ftrace/test.d/kprobe/kprobe_opt_types.tc       |   34 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   16 +-
 32 files changed, 2510 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/trace/fprobetrace.rst
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc                          |   11 +
 kernel/trace/trace_eprobe.c                        |   44 +-
 kernel/trace/trace_fprobe.c                        | 1199 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c                        |   35 +-
 kernel/trace/trace_probe.c                         |  659 +++++++++--
 kernel/trace/trace_probe.h                         |   49 +-
 kernel/trace/trace_uprobe.c                        |    8 +-
 lib/test_fprobe.c                                  |   10 +-
 samples/fprobe/fprobe_example.c                    |    6 +-
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   58 +
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 +
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |  111 ++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 ++
 .../ftrace/test.d/kprobe/kprobe_insn_boundary.tc   |   19 +
 .../ftrace/test.d/kprobe/kprobe_opt_types.tc       |   34 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   16 +-
 32 files changed, 2510 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/trace/fprobetrace.rst
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_insn_boundary.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
