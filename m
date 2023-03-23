Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E926C70B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjCWTGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCWTGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:06:32 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA21433447;
        Thu, 23 Mar 2023 12:06:15 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6ED2920FC0DB;
        Thu, 23 Mar 2023 12:06:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6ED2920FC0DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679598374;
        bh=jStO72Hs7cVaK8SkPkYiudO/0xi1GXAc/o+i9vlfzSc=;
        h=From:To:Cc:Subject:Date:From;
        b=n+Ep6hq05Ge8yhttJ0tYsNztk3TGsbFOUD85GissmA3FineoEUTw/24DW8Vy+Y/9c
         Gjl3YY+2nQqprSHE5L4OTGnAKlQB+alRX2l85xly9D1BwsBwVAH6uKoZBlPBDRbz1c
         0DkRTakedH+kCzMfO6UCybjzJnqOe3z6eAyrzDvU=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 00/11] tracing/user_events: Remote write ABI
Date:   Thu, 23 Mar 2023 12:05:59 -0700
Message-Id: <20230323190610.251-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending to get to right mailing list for patchwork queue]

As part of the discussions for user_events aligned with user space
tracers, it was determined that user programs should register a aligned
value to set or clear a bit when an event becomes enabled. Currently a
shared page is being used that requires mmap(). Remove the shared page
implementation and move to a user registered address implementation.

In this new model during the event registration from user programs 3 new
values are specified. The first is the address to update when the event
is either enabled or disabled. The second is the bit to set/clear to
reflect the event being enabled. The third is the size of the value at
the specified address.

This allows for a local 32/64-bit value in user programs to support
both kernel and user tracers. As an example, setting bit 31 for kernel
tracers when the event becomes enabled allows for user tracers to use
the other bits for ref counts or other flags. The kernel side updates
the bit atomically, user programs need to also update these values
atomically.

User provided addresses must be aligned on a natural boundary, this
allows for single page checking and prevents odd behaviors such as a
enable value straddling 2 pages instead of a single page.

When page faults are encountered they are done asyncly via a workqueue.
If the page faults back in, the write update is attempted again. If the
page cannot fault-in, then we log and wait until the next time the event
is enabled/disabled. This is to prevent possible infinite loops resulting
from bad user processes unmapping or changing protection values after
registering the address.

Change history

V8:
Rebase to 6.2-rc8.

V7:
Rebase to 6.2-rc4.

Added flags to register ioctl, validates it's 0 for now. Future patches
will enable other types of formats/options as needed.

V6:
Rebase to 6.2-rc2.

Fixed small typos, code style.

Changed from synchronize_rcu() to queue_rcu_work() to allow an rcu
delay asyncly when mm is being removed and in an appropriate context
for mmdrop().

V5:
GFP_NOWAIT is still needed in user_event_enabler_dup(), due to rcu lock.

V4:
Rebase to 6.1-rc7.

Moved user_events_fork() out of task signal lock and dropped use of
GFP_NOWAIT. All allocations are now GFP_KERNEL or GFP_KERNEL_ACCOUNT.

Added boot parameter user_events_max= to limit global events.

Added sysctl value kernel.user_events_max to limit global events.

Added cgroup tracking of memory allocated for events.

V3:
Rebase to 6.1-rc6.

Removed RFC tag on series.

Updated documentation to reflect ABI changes.

Added self-test for ABI specific clone/fork cases.

Moved user_event_mm removal into do_exit() to ensure RSS task accounting
is done properly in async fault paths. Also lets us remove the delayed
mmdrop(), saving memory in each user_event_mm struct.

Fixed timing window where task exits, but write could be in-progress.
During exit we now take mmap_write_lock to ensure we drain writes.

V2:
Rebase to 6.1-rc5.

Added various comments based on feedback.

Added enable_size to register struct, allows 32/64 bit addresses
as long as the enable_bit fits and the address is naturally aligned.

Changed user_event_enabler_write to accept a new flag indicating if a
fault fixup should be done or not. This allows user_event_enabler_create
to return back failures to the user ioctl reg call and retry to fault
in data.

Added tracking fork/exec/exit of tasks to have the user_event_mm lifetime
tied more to the task than the file. This came with extra requirements
around when you can lock, such as softirq cases, as well as a RCU
pattern to ensure fork/exec/exit take minimal lock times.

Changed enablers to use a single word-aligned value for saving the bit
to set and any flags, such as faulting asyncly or being freed. This was
required to ensure atomic bit set/test for fork cases where taking the
event_mutex is not a good scalability decision.

Added unregister IOCTL, since file lifetime no longer limits the enable
time for any events (the mm does).

Updated sample code to reflect the new remote write based ABI.

Updated self-test code to reflect the new remote write based ABI.

Beau Belgrave (11):
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

 Documentation/trace/user_events.rst           | 177 ++--
 fs/exec.c                                     |   2 +
 include/linux/sched.h                         |   5 +
 include/linux/user_events.h                   | 101 +-
 include/uapi/linux/user_events.h              |  81 ++
 kernel/exit.c                                 |   2 +
 kernel/fork.c                                 |   2 +
 kernel/trace/Kconfig                          |   5 +-
 kernel/trace/trace_events_user.c              | 863 +++++++++++++++---
 samples/user_events/example.c                 |  47 +-
 tools/testing/selftests/user_events/Makefile  |   2 +-
 .../testing/selftests/user_events/abi_test.c  | 226 +++++
 .../testing/selftests/user_events/dyn_test.c  |   2 +-
 .../selftests/user_events/ftrace_test.c       | 162 ++--
 .../testing/selftests/user_events/perf_test.c |  39 +-
 15 files changed, 1317 insertions(+), 399 deletions(-)
 create mode 100644 include/uapi/linux/user_events.h
 create mode 100644 tools/testing/selftests/user_events/abi_test.c


base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
-- 
2.25.1

