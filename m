Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB76CF373
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjC2Tpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC2Tpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51773A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2E861CEA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E09CC433EF;
        Wed, 29 Mar 2023 19:45:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbjx-002Re8-0V;
        Wed, 29 Mar 2023 15:45:49 -0400
Message-ID: <20230329194516.146147554@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/25] tracing: Updates for 6.4
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 88fe1ec75fcb296579e05eaf3807da3ee83137e4


Beau Belgrave (12):
      tracing/user_events: Split header into uapi and kernel
      tracing/user_events: Track fork/exec/exit for mm lifetime
      tracing/user_events: Use remote writes for event enablement
      tracing/user_events: Fixup enable faults asyncly
      tracing/user_events: Add ioctl for disabling addresses
      tracing/user_events: Update self-tests to write ABI
      tracing/user_events: Add ABI self-test
      tracing/user_events: Use write ABI in example
      tracing/user_events: Update documentation for ABI
      tracing/user_events: Charge event allocs to cgroups
      tracing/user_events: Limit global user_event count
      tracing/user_events: Align structs with tabs for readability

Masami Hiramatsu (Google) (7):
      fprobe: Pass entry_data to handlers
      lib/test_fprobe: Add private entry_data testcases
      fprobe: Add nr_maxactive to specify rethook_node pool size
      lib/test_fprobe: Add a test case for nr_maxactive
      fprobe: Skip exit_handler if entry_handler returns !0
      lib/test_fprobe: Add a testcase for skipping exit_handler
      docs: tracing: Update fprobe documentation

Ross Zwisler (3):
      selftests: use canonical ftrace path
      leaking_addresses: also skip canonical ftrace path
      tools/kvm_stat: use canonical ftrace path

Steven Rostedt (Google) (3):
      tracing: Add "fields" option to show raw trace event fields
      tracing/user_events: Use print_format_fields() for trace output
      tracing: Unbreak user events

----
 Documentation/trace/fprobe.rst                    |  16 +-
 Documentation/trace/ftrace.rst                    |   6 +
 Documentation/trace/user_events.rst               | 167 ++--
 fs/exec.c                                         |   2 +
 include/linux/fprobe.h                            |  10 +-
 include/linux/sched.h                             |   5 +
 include/linux/user_events.h                       | 101 ++-
 include/uapi/linux/user_events.h                  |  81 ++
 kernel/exit.c                                     |   2 +
 kernel/fork.c                                     |   2 +
 kernel/trace/Kconfig                              |   6 +-
 kernel/trace/bpf_trace.c                          |  17 +-
 kernel/trace/fprobe.c                             |  32 +-
 kernel/trace/trace.c                              |   7 +-
 kernel/trace/trace.h                              |   2 +
 kernel/trace/trace_events_user.c                  | 932 +++++++++++++++++-----
 kernel/trace/trace_output.c                       | 168 ++++
 kernel/trace/trace_output.h                       |   2 +
 lib/test_fprobe.c                                 | 105 ++-
 samples/fprobe/fprobe_example.c                   |   7 +-
 samples/user_events/example.c                     |  45 +-
 scripts/leaking_addresses.pl                      |   1 +
 tools/kvm/kvm_stat/kvm_stat                       |   2 +-
 tools/testing/selftests/mm/protection_keys.c      |   4 +-
 tools/testing/selftests/user_events/Makefile      |   2 +-
 tools/testing/selftests/user_events/abi_test.c    | 226 ++++++
 tools/testing/selftests/user_events/dyn_test.c    |   2 +-
 tools/testing/selftests/user_events/ftrace_test.c | 162 ++--
 tools/testing/selftests/user_events/perf_test.c   |  39 +-
 29 files changed, 1692 insertions(+), 461 deletions(-)
 create mode 100644 include/uapi/linux/user_events.h
 create mode 100644 tools/testing/selftests/user_events/abi_test.c
