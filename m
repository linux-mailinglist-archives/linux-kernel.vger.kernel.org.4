Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED532702C24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbjEOMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbjEOMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75826A1;
        Mon, 15 May 2023 04:57:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C6062312;
        Mon, 15 May 2023 11:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2534C433D2;
        Mon, 15 May 2023 11:57:03 +0000 (UTC)
Date:   Mon, 15 May 2023 07:57:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v10 07/11] tracing/probes: Add $args meta argument for
 all function args
Message-ID: <20230515075701.6f49b3e7@gandalf.local.home>
In-Reply-To: <168407353144.941486.592643565749157905.stgit@mhiramat.roam.corp.google.com>
References: <168407346448.941486.15681419068846125595.stgit@mhiramat.roam.corp.google.com>
        <168407353144.941486.592643565749157905.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2023 23:12:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add the '$args' meta fetch argument for function-entry probe events. This
> will be expanded to the all arguments of the function and the tracepoint
> using BTF function argument information.
> 
> e.g.
>  #  echo 'p vfs_read $args' >> dynamic_events
>  #  echo 'f vfs_write $args' >> dynamic_events
>  #  echo 't sched_overutilized_tp $args' >> dynamic_events
>  # cat dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
> f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
> t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> 
> NOTE: This is not like other $-vars, you can not use this $args as a
> part of fetch args, e.g. specifying name "foo=$args" and using it in
> dereferences "+0($args)" will lead a parse error.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v10:
>  - Change $$args to $args so that user can use $$ for current task's pid.

I hate coming up with new apis, because you never know if what you pick is
correct ;-) And then you are stuck with whatever you decided on. :-/

I know I suggested $args, but since it is special, should we call it
 "$arg*" ?

That way it follows bash wildcard semantics?

 #  echo 'p vfs_read $arg*' >> dynamic_events

I think that is more along the lines of what people would expect.

What do you think?

-- Steve


> Changes in v6:
>  - update patch description.
> ---
>  kernel/trace/trace_fprobe.c |   21 ++++++++-
>  kernel/trace/trace_kprobe.c |   23 ++++++++--
>  kernel/trace/trace_probe.c  |   98 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |   10 ++++
>  4 files changed, 144 insertions(+), 8 deletions(-)
> 
>
