Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3826C7439
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCWXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D656EA9;
        Thu, 23 Mar 2023 16:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE34E62903;
        Thu, 23 Mar 2023 23:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9B9C433EF;
        Thu, 23 Mar 2023 23:43:57 +0000 (UTC)
Date:   Thu, 23 Mar 2023 19:43:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, kpsingh@kernel.org, jolsa@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/7] Refactor ftrace direct call APIs
Message-ID: <20230323194355.3f714774@gandalf.local.home>
In-Reply-To: <20230321140424.345218-1-revest@chromium.org>
References: <20230321140424.345218-1-revest@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So I applied this to my for-next branch as the first patches starting from
v6.3-rc3. Last commit (patch 7) is fee86a4ed536f4e521f3a4530242e152dd2a466b

The branch is here:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
    trace/for-next

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=trace/for-next&id=fee86a4ed536f4e521f3a4530242e152dd2a466b

Since that commit only contains the updates for the direct trampolines that
ARM64 needs, and I'm not going to rebase that branch, you can just merge it
into the ARM64 tree so that you can base your changes on it. Make sure you
merge that commit, not the branch, as I have more tracing specific patches
on top of that commit.

Make sure to write a nice change log message in why you are merging that
branch, so that Linus knows about it. I'm Cc'ing Linus now so that he's
aware, but the change log should remind him why you pulled in my branch.

Again, at the above mentioned commit, that branch only contains the updates
you need to make the direct trampolines work on ARM64.

-- Steve


On Tue, 21 Mar 2023 15:04:17 +0100
Florent Revest <revest@chromium.org> wrote:

> Differences since v1 [1]:
> - Use a READ_ONCE() to read the direct call address in call_direct_funcs
> - Added an Acked-by from Mark
> 
> This series refactors ftrace direct call APIs in preparation for arm64 support.
> It is roughly a subset of [2] rebased on v6.3-rc2 and meant to be taken by
> Steven's tree before all the arm64 specific bits.
> 
> The first patch was suggested by Steven in a review of [1], it makes it more
> obvious to the caller that filters probably need to be freed when unregistering
> a direct call.
> 
> The next three patches consolidate the two existing ftrace APIs for registering
> direct calls. They are only split to make the reviewer's life easier.
> Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
> from samples and selftests, there are no users of the _ftrace_direct API left
> in-tree so this deletes it and renames the _ftrace_direct_multi API to
> _ftrace_direct for simplicity.
> 
> The main benefit of this refactoring is that, with the API that's left, an
> ftrace_ops backing a direct call will only ever point to one direct call. We can
> therefore store the direct called trampoline address in the ops (patch 5) and,
> in the future arm64 series, look it up from the ftrace trampoline. (in the
> meantime, it makes call_direct_funcs a bit simpler too)
> 
> Ftrace direct calls technically don't need DYNAMIC_FTRACE_WITH_REGS so this
> extends its support to DYNAMIC_FTRACE_WITH_ARGS (patch 6). arm64 won't support
> DYNAMIC_FTRACE_WITH_REGS.
> 
> Finally, it fixes the ABI of the stub direct call trampoline used in ftrace
> selftests.
> 
> This has been tested on x86_64 with:
> 1- CONFIG_FTRACE_SELFTEST
> 2- samples/ftrace/*.ko
> 
> 1: https://lore.kernel.org/all/20230316173811.1223508-1-revest@chromium.org/T/#t
> 2: https://lore.kernel.org/all/20230207182135.2671106-1-revest@chromium.org/T/#t
> 
> Florent Revest (6):
>   ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
>   ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
>   ftrace: Remove the legacy _ftrace_direct API
>   ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
>   ftrace: Store direct called addresses in their ops
>   ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
> 
> Mark Rutland (1):
>   ftrace: selftest: remove broken trace_direct_tramp
> 
>  arch/s390/kernel/mcount.S                   |   5 +
>  arch/x86/kernel/ftrace_32.S                 |   5 +
>  arch/x86/kernel/ftrace_64.S                 |   4 +
>  include/linux/ftrace.h                      |  61 +--
>  kernel/bpf/trampoline.c                     |  12 +-
>  kernel/trace/Kconfig                        |   2 +-
>  kernel/trace/ftrace.c                       | 438 ++------------------
>  kernel/trace/trace_selftest.c               |  19 +-
>  samples/Kconfig                             |   2 +-
>  samples/ftrace/ftrace-direct-modify.c       |  10 +-
>  samples/ftrace/ftrace-direct-multi-modify.c |   9 +-
>  samples/ftrace/ftrace-direct-multi.c        |   5 +-
>  samples/ftrace/ftrace-direct-too.c          |  10 +-
>  samples/ftrace/ftrace-direct.c              |  10 +-
>  14 files changed, 101 insertions(+), 491 deletions(-)
> 

