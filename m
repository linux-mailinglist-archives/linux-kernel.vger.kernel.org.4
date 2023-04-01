Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39246D3120
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDANqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDANqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5708D1C1C9;
        Sat,  1 Apr 2023 06:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E56F260A6E;
        Sat,  1 Apr 2023 13:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445ADC433D2;
        Sat,  1 Apr 2023 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680356773;
        bh=2caHwm/Q0yptshRVPEBUR7yOaQ1LLmmc8uhEFSqrOLE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o+FiH4jkKQ9OgmV8Zq0Va+wolCyShP8eZDpzcHzs65DpqXHEbiHrTvPsAy/MRjtMu
         A6dp1eu9mdL6yEmCaus46dkWnCMwDG8Xxc0D0LOqx6vJusIxEz3FUIXHhyhb+EZfyC
         cCjO57yX6kfZfMlyG0ucjHWybVIbj5XC8UpDC2qLhlfnqqAC7gsQTzi3WKFUWE0WR3
         UwL/tAU7GNP+8wBLv5h3fN4gEW+lpcP6TlkZPT+GrgYa+3U1shGZUeTRdxY9LCh36w
         CH/7S2W87qU7LYQi/0j+77Q9QNWEeEhoN7a1pYvfvsqLO8UPWF4GExzWOHtdJjR5cQ
         sz9h6esSIrqFQ==
Date:   Sat, 1 Apr 2023 22:46:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 09/10] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230401224609.bebb256be8e6da55f0358ea9@kernel.org>
In-Reply-To: <20230329081454.05133571@rorschach.local.home>
References: <167526695292.433354.8949652607331707144.stgit@mhiramat.roam.corp.google.com>
        <167526703341.433354.12634235635015890994.stgit@mhiramat.roam.corp.google.com>
        <20230329081454.05133571@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 08:14:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  2 Feb 2023 00:57:13 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add fprobe events for tracing function entry and exit instead of kprobe
> > events. With this change, we can continue to trace function entry/exit
> > even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
> > CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> > it is not available if the architecture only supports
> > CONFIG_DYNAMIC_FTRACE_WITH_ARGS. And that means kprobe events can not
> > probe function entry/exit effectively on such architecture.
> > But this can be solved if the dynamic events supports fprobe events.
> > 
> > The fprobe event is a new dynamic events which is only for the function
> > (symbol) entry and exit. This event accepts non register fetch arguments
> > so that user can trace the function arguments and return values.
> > 
> 
> Hi Masami,
> 
> After applying this patch I get a bunch of these:
> 
> /work/git/linux-trace.git/kernel/trace/trace_fprobe.c:117:1: error: redefinition of ‘fetch_store_strlen_user’
>   117 | fetch_store_strlen_user(unsigned long addr)
>       | ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from /work/git/linux-trace.git/kernel/trace/trace_fprobe.c:16:
> /work/git/linux-trace.git/kernel/trace/trace_probe_kernel.h:15:1: note: previous definition of ‘fetch_store_strlen_user’ with type ‘int(long unsigned int)’
>    15 | fetch_store_strlen_user(unsigned long addr)
>       | ^~~~~~~~~~~~~~~~~~~~~~~
> /work/git/linux-trace.git/kernel/trace/trace_fprobe.c: In function ‘fetch_store_strlen_user’:
> /work/git/linux-trace.git/kernel/trace/trace_fprobe.c:119:16: error: implicit declaration of function ‘kern_fetch_store_strlen_user’; did you mean ‘fetch_store_strlen_user’? [-Werror=implicit-function-declaration]
>   119 |         return kern_fetch_store_strlen_user(addr);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                fetch_store_strlen_user
> /work/git/linux-trace.git/kernel/trace/trace_fprobe.c: At top level:
> /work/git/linux-trace.git/kernel/trace/trace_fprobe.c:124:1: error: redefinition of ‘fetch_store_strlen’
>   124 | fetch_store_strlen(unsigned long addr)
>       | ^~~~~~~~~~~~~~~~~~
> /work/git/linux-trace.git/kernel/trace/trace_probe_kernel.h:32:1: note: previous definition of ‘fetch_store_strlen’ with type ‘int(long unsigned int)’
>    32 | fetch_store_strlen(unsigned long addr)
>       | ^~~~~~~~~~~~~~~~~~
> /work/git/linux-trace.git/kernel/trace/trace_fprobe.c: In function ‘fetch_store_strlen’:
> /work/git/linux-trace.git/kernel/trace/trace_fprobe.c:126:16: error: implicit declaration of function ‘kern_fetch_store_strlen’; did you mean ‘fetch_store_strlen’? [-Werror=implicit-function-declaration]
>   126 |         return kern_fetch_store_strlen(addr);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~
>       |                fetch_store_strlen
> 
> 
> Can you rebase it on the latest changes (on top of trace/for-next)?

OK, let me update it.

> 
> BTW, I've applied patches 1-8 and I'm currently running them through my
> tests. So if you do rebase, just send patches 9 and 10. I'm hoping to
> post a for-next series later today, that will include those other
> patches.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
