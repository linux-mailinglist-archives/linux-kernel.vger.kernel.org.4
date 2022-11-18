Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6818062EA04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbiKRAEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiKRAEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:04:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775023F051
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:04:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22F0622C6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C89C433D6;
        Fri, 18 Nov 2022 00:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668729848;
        bh=mK0fXfcmMTUtxxGFZQCuyZs069DXktNhvNUJRupxs30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=juXNzO82X3euW+WCpC/AAzcm6Z+0/8bDpiNs7f1fNI4RqG3gGpX87WAxGBmLicHoq
         mwqorWSamkKf8YJI4xh+DWN0yT1TC2r7Piy1lW/J4kxF5QTjxp684pgAnSBkZ18Bvd
         YiTZBygFAyEz4SewKQ2YLj+BaSKaHRHllPruU0RNhzZIhscDyYoLBq3By3s4u0SdUv
         IMFGxYA03geBYR1GrfyWAH63pKM49x/2YeoS8UOEElzPzYbAfYmmymu1LML8KyoFGo
         qsEs32ebovRYzqr2AwzIesUVRe2em6asFJKEqx1/2Ue0+zpyBLCqdwZlk7QatyZDRp
         6X/fYCKTm18Yw==
Date:   Fri, 18 Nov 2022 09:04:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH v2 0/4] arm64/ftrace: move to DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20221118090405.5dc0c9f2caaec4e9720a47cd@kernel.org>
In-Reply-To: <20221103170520.931305-1-mark.rutland@arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Nov 2022 17:05:16 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> This series replaces arm64's support for FTRACE_WITH_REGS with support
> for FTRACE_WITH_ARGS. This removes some overhead and complexity, and
> removes some latent issues with inconsistent presentation of struct
> pt_regs (which can only be reliably saved/restored at exception
> boundaries).
> 
> The existing FTRACE_WITH_REGS support was added for two major reasons:
> 
> (1) To make it possible to use the ftrace graph tracer with pointer
>     authentication, where it's necessary to snapshot/manipulate the LR
>     before it is signed by the instrumented function.
> 
> (2) To make it possible to implement LIVEPATCH in future, where we need
>     to hook function entry before an instrumented function manipulates
>     the stack or argument registers. Practically speaking, we need to
>     preserve the argument/return registers, PC, LR, and SP.
> 
> Neither of these requires the full set of pt_regs, and only requires us
> to save/restore a subset of registers used for passing
> arguments/return-values and context/return information (which is the
> minimum set we always need to save/restore today).
> 
> As there is no longer a need to save different sets of registers for
> different features, we no longer need distinct `ftrace_caller` and
> `ftrace_regs_caller` trampolines. This allows the trampoline assembly to
> be simpler, and simplifies code which previously had to handle the two
> trampolines.
> 
> I've tested this with the ftrace selftests, where there are no
> unexpected failures.
> 
> I plan to build atop this with subsequent patches to add per-callsite
> ftrace_ops, and I'm sending these patches on their own as I think they
> make sense regardless.

Thanks! this series looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

So it is the good time to rewrite the new fprobe event handler
based on these interfaces :)

> 
> Since v1 [1]:
> * Change ifdeferry per Steve's request
> * Add ftrace_regs_query_register_offset() per Masami's request
> * Fix a bunch of typos
> 
> [1] https://lore.kernel.org/lkml/20221024140846.3555435-1-mark.rutland@arm.com
> 
> This series can be found in my 'arm64/ftrace/minimal-regs' branch on
> kernel.org:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
>   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
> 
> This version is tagged as:
> 
>   arm64-ftrace-minimal-regs-20221103
> 
> Thanks,
> Mark.
> 
> Mark Rutland (4):
>   ftrace: pass fregs to arch_ftrace_set_direct_caller()
>   ftrace: rename ftrace_instruction_pointer_set() ->
>     ftrace_regs_set_instruction_pointer()
>   ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
>   ftrace: arm64: move from REGS to ARGS
> 
>  arch/arm64/Kconfig                |  18 +++--
>  arch/arm64/Makefile               |   2 +-
>  arch/arm64/include/asm/ftrace.h   |  72 ++++++++++++++++--
>  arch/arm64/kernel/asm-offsets.c   |  13 ++++
>  arch/arm64/kernel/entry-ftrace.S  | 117 ++++++++++++------------------
>  arch/arm64/kernel/ftrace.c        |  82 ++++++++++++---------
>  arch/arm64/kernel/module.c        |   3 -
>  arch/powerpc/include/asm/ftrace.h |  24 +++++-
>  arch/s390/include/asm/ftrace.h    |  29 +++++++-
>  arch/x86/include/asm/ftrace.h     |  49 +++++++++----
>  include/linux/ftrace.h            |  47 +++++++++---
>  kernel/livepatch/patch.c          |   2 +-
>  kernel/trace/Kconfig              |   6 +-
>  kernel/trace/ftrace.c             |   3 +-
>  14 files changed, 309 insertions(+), 158 deletions(-)
> 
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
