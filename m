Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F7629CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKOPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKOPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:01:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AAC248E2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8CFEB81923
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CEFC433D6;
        Tue, 15 Nov 2022 15:01:05 +0000 (UTC)
Date:   Tue, 15 Nov 2022 10:01:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, will@kernel.org
Subject: Re: [PATCH v2 0/4] arm64/ftrace: move to DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <20221115100148.08475da0@gandalf.local.home>
In-Reply-To: <20221103170520.931305-1-mark.rutland@arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
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

Were there any "expected" failures?

> 
> I plan to build atop this with subsequent patches to add per-callsite
> ftrace_ops, and I'm sending these patches on their own as I think they
> make sense regardless.
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


So I ran this on top of my code through all my ftrace tests (for x86) and
it didn't cause any regressions.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
