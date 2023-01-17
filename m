Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9430670D95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjAQXdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAQXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:32:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070A5D11B;
        Tue, 17 Jan 2023 12:52:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 895B8B81A22;
        Tue, 17 Jan 2023 20:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A04C433D2;
        Tue, 17 Jan 2023 20:52:04 +0000 (UTC)
Date:   Tue, 17 Jan 2023 15:52:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, will@kernel.org
Subject: Re: [PATCH v2 4/8] ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <20230117155203.3a66744e@gandalf.local.home>
In-Reply-To: <20230113180355.2930042-5-mark.rutland@arm.com>
References: <20230113180355.2930042-1-mark.rutland@arm.com>
        <20230113180355.2930042-5-mark.rutland@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 18:03:51 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Architectures without dynamic ftrace trampolines incur an overhead when
> multiple ftrace_ops are enabled with distinct filters. in these cases,
> each call site calls a common trampoline which uses
> ftrace_ops_list_func() to iterate over all enabled ftrace functions, and
> so incurs an overhead relative to the size of this list (including RCU
> protection overhead).
> 
> Architectures with dynamic ftrace trampolines avoid this overhead for
> call sites which have a single associated ftrace_ops. In these cases,
> the dynamic trampoline is customized to branch directly to the relevant
> ftrace function, avoiding the list overhead.
> 
> On some architectures it's impractical and/or undesirable to implement
> dynamic ftrace trampolines. For example, arm64 has limited branch ranges
> and cannot always directly branch from a call site to an arbitrary
> address (e.g. from a kernel text address to an arbitrary module
> address). Calls from modules to core kernel text can be indirected via
> PLTs (allocated at module load time) to address this, but the same is
> not possible from calls from core kernel text.
> 
> Using an indirect branch from a call site to an arbitrary trampoline is
> possible, but requires several more instructions in the function
> prologue (or immediately before it), and/or comes with far more complex
> requirements for patching.
> 
> Instead, this patch adds a new option, where an architecture can
> associate each call site with a pointer to an ftrace_ops, placed at a
> fixed offset from the call site. A shared trampoline can recover this
> pointer and call ftrace_ops::func() without needing to go via
> ftrace_ops_list_func(), avoiding the associated overhead.
> 
> This avoids issues with branch range limitations, and avoids the need to
> allocate and manipulate dynamic trampolines, making it far simpler to
> implement and maintain, while having similar performance
> characteristics.
> 
> Note that this allows for dynamic ftrace_ops to be invoked directly from
> an architecture's ftrace_caller trampoline, whereas existing code forces
> the use of ftrace_ops_get_list_func(), which is in part necessary to
> permit the ftrace_ops to be freed once unregistereed *and* to avoid
> branch/address-generation range limitation on some architectures (e.g.
> where ops->func is a module address, and may be outside of the direct
> branch range for callsites within the main kernel image).
> 
> The CALL_OPS approach avoids this problems and is safe as:
> 
> * The existing synchronization in ftrace_shutdown() using
>   ftrace_shutdown() using synchronize_rcu_tasks_rude() (and
>   synchronize_rcu_tasks()) ensures that no tasks hold a stale reference
>   to an ftrace_ops (e.g. in the middle of the ftrace_caller trampoline,
>   or while invoking ftrace_ops::func), when that ftrace_ops is
>   unregistered.
> 
>   Arguably this could also be relied upon for the existing scheme,
>   permitting dynamic ftrace_ops to be invoked directly when ops->func is
>   in range, but this will require additional logic to handle branch
>   range limitations, and is not handled by this patch.
> 
> * Each callsite's ftrace_ops pointer literal can hold any valid kernel
>   address, and is updated atomically. As an architecture's ftrace_caller
>   trampoline will atomically load the ops pointer then derefrence
>   ops->func, there is no risk of invoking ops->func with a mismatches
>   ops pointer, and updates to the ops pointer do not require special
>   care.
> 
> A subsequent patch will implement architectures support for arm64. There
> should be no functional change as a result of this patch alone.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florent Revest <revest@chromium.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Will Deacon <will@kernel.org>
> ---
> 

Looks good. Looking through it, I don't see any issues. Although I didn't
test it ;-)

I probably should, but in the mean time (as my tests are currently
broken)...

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
