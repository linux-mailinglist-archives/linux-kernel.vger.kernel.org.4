Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D327E6C9620
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjCZPXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44E1992;
        Sun, 26 Mar 2023 08:23:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6840B80C73;
        Sun, 26 Mar 2023 15:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970E6C433D2;
        Sun, 26 Mar 2023 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679844229;
        bh=FyoyS6JmF8HdnDmT5bIJ+3QIdLa9Vz5VvRmgD1HKOFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i3fpC1ot2ttQYib1GNMfE/or2qPX67mZyWoDFRfx3DFd6eqWJxKbJT0lQUMxfBDNv
         uPkDiiB/oK1WMp5WPDMteQ6G6lutLUV5CMGgYLzjvd7r14zxi2+JRDc+gyvQm16LkX
         KmxHcrjuJitydDaAIOiyWxXA0xmOmA/9q6gg4g3baPReSAIxVzodAny0vXat8ubI5y
         stl3I1lNusBk4gMBtyd4SrpBkeOxvgVCJOgI9DzYYa7X4Mkv1gDbUqKnyV7/Ext99C
         UATNEJ8ftNZovBAv6Wy2kmkjdXj5n6mczj+QpW0C0qAT4kJD7KQ0i0od/Yl8ka8YCx
         UNlPDvIGxJxvA==
Date:   Sun, 26 Mar 2023 23:23:43 +0800
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        brauner@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/11] tracing/user_events: Remote write ABI
Message-Id: <20230326232343.736eee853dcc72f26458c848@kernel.org>
In-Reply-To: <20230324223028.172-1-beaub@linux.microsoft.com>
References: <20230324223028.172-1-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 15:30:17 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> As part of the discussions for user_events aligned with user space
> tracers, it was determined that user programs should register a aligned
> value to set or clear a bit when an event becomes enabled. Currently a
> shared page is being used that requires mmap(). Remove the shared page
> implementation and move to a user registered address implementation.
> 
> In this new model during the event registration from user programs 3 new
> values are specified. The first is the address to update when the event
> is either enabled or disabled. The second is the bit to set/clear to
> reflect the event being enabled. The third is the size of the value at
> the specified address.
> 
> This allows for a local 32/64-bit value in user programs to support
> both kernel and user tracers. As an example, setting bit 31 for kernel
> tracers when the event becomes enabled allows for user tracers to use
> the other bits for ref counts or other flags. The kernel side updates
> the bit atomically, user programs need to also update these values
> atomically.
> 
> User provided addresses must be aligned on a natural boundary, this
> allows for single page checking and prevents odd behaviors such as a
> enable value straddling 2 pages instead of a single page.
> 
> When page faults are encountered they are done asyncly via a workqueue.
> If the page faults back in, the write update is attempted again. If the
> page cannot fault-in, then we log and wait until the next time the event
> is enabled/disabled. This is to prevent possible infinite loops resulting
> from bad user processes unmapping or changing protection values after
> registering the address.

This series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for the series.

Thank you!

> 
> Change history
> 
> V9:
> Updated documentation to include __packed attributed in example payload.
> 
> Removed boot argument for max events, since sysctl can now be set via
> kernel boot parameters.
> 
> V8:
> Rebase to 6.2-rc8.
> 
> V7:
> Rebase to 6.2-rc4.
> 
> Added flags to register ioctl, validates it's 0 for now. Future patches
> will enable other types of formats/options as needed.
> 
> V6:
> Rebase to 6.2-rc2.
> 
> Fixed small typos, code style.
> 
> Changed from synchronize_rcu() to queue_rcu_work() to allow an rcu
> delay asyncly when mm is being removed and in an appropriate context
> for mmdrop().
> 
> V5:
> GFP_NOWAIT is still needed in user_event_enabler_dup(), due to rcu lock.
> 
> V4:
> Rebase to 6.1-rc7.
> 
> Moved user_events_fork() out of task signal lock and dropped use of
> GFP_NOWAIT. All allocations are now GFP_KERNEL or GFP_KERNEL_ACCOUNT.
> 
> Added boot parameter user_events_max= to limit global events.
> 
> Added sysctl value kernel.user_events_max to limit global events.
> 
> Added cgroup tracking of memory allocated for events.
> 
> V3:
> Rebase to 6.1-rc6.
> 
> Removed RFC tag on series.
> 
> Updated documentation to reflect ABI changes.
> 
> Added self-test for ABI specific clone/fork cases.
> 
> Moved user_event_mm removal into do_exit() to ensure RSS task accounting
> is done properly in async fault paths. Also lets us remove the delayed
> mmdrop(), saving memory in each user_event_mm struct.
> 
> Fixed timing window where task exits, but write could be in-progress.
> During exit we now take mmap_write_lock to ensure we drain writes.
> 
> V2:
> Rebase to 6.1-rc5.
> 
> Added various comments based on feedback.
> 
> Added enable_size to register struct, allows 32/64 bit addresses
> as long as the enable_bit fits and the address is naturally aligned.
> 
> Changed user_event_enabler_write to accept a new flag indicating if a
> fault fixup should be done or not. This allows user_event_enabler_create
> to return back failures to the user ioctl reg call and retry to fault
> in data.
> 
> Added tracking fork/exec/exit of tasks to have the user_event_mm lifetime
> tied more to the task than the file. This came with extra requirements
> around when you can lock, such as softirq cases, as well as a RCU
> pattern to ensure fork/exec/exit take minimal lock times.
> 
> Changed enablers to use a single word-aligned value for saving the bit
> to set and any flags, such as faulting asyncly or being freed. This was
> required to ensure atomic bit set/test for fork cases where taking the
> event_mutex is not a good scalability decision.
> 
> Added unregister IOCTL, since file lifetime no longer limits the enable
> time for any events (the mm does).
> 
> Updated sample code to reflect the new remote write based ABI.
> 
> Updated self-test code to reflect the new remote write based ABI.
> 
> Beau Belgrave (11):
>   tracing/user_events: Split header into uapi and kernel
>   tracing/user_events: Track fork/exec/exit for mm lifetime
>   tracing/user_events: Use remote writes for event enablement
>   tracing/user_events: Fixup enable faults asyncly
>   tracing/user_events: Add ioctl for disabling addresses
>   tracing/user_events: Update self-tests to write ABI
>   tracing/user_events: Add ABI self-test
>   tracing/user_events: Use write ABI in example
>   tracing/user_events: Update documentation for ABI
>   tracing/user_events: Charge event allocs to cgroups
>   tracing/user_events: Limit global user_event count
> 
>  Documentation/trace/user_events.rst           | 179 ++--
>  fs/exec.c                                     |   2 +
>  include/linux/sched.h                         |   5 +
>  include/linux/user_events.h                   | 101 ++-
>  include/uapi/linux/user_events.h              |  81 ++
>  kernel/exit.c                                 |   2 +
>  kernel/fork.c                                 |   2 +
>  kernel/trace/Kconfig                          |   5 +-
>  kernel/trace/trace_events_user.c              | 851 +++++++++++++++---
>  samples/user_events/example.c                 |  47 +-
>  tools/testing/selftests/user_events/Makefile  |   2 +-
>  .../testing/selftests/user_events/abi_test.c  | 226 +++++
>  .../testing/selftests/user_events/dyn_test.c  |   2 +-
>  .../selftests/user_events/ftrace_test.c       | 162 ++--
>  .../testing/selftests/user_events/perf_test.c |  39 +-
>  15 files changed, 1306 insertions(+), 400 deletions(-)
>  create mode 100644 include/uapi/linux/user_events.h
>  create mode 100644 tools/testing/selftests/user_events/abi_test.c
> 
> 
> base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
