Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6E7289B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjFHUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjFHUwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FC7E61;
        Thu,  8 Jun 2023 13:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C2864EA2;
        Thu,  8 Jun 2023 20:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC6EC433EF;
        Thu,  8 Jun 2023 20:52:36 +0000 (UTC)
Date:   Thu, 8 Jun 2023 16:52:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v11 02/11] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-ID: <20230608165234.0c00c146@gandalf.local.home>
In-Reply-To: <168432114441.1351929.4695419422051966931.stgit@mhiramat.roam.corp.google.com>
References: <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
        <168432114441.1351929.4695419422051966931.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 19:59:04 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Add fprobe events for tracing function entry and exit instead of kprobe
> events. With this change, we can continue to trace function entry/exit
> even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
> CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> it is not available if the architecture only supports
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS. And that means kprobe events can not
> probe function entry/exit effectively on such architecture.
> But this can be solved if the dynamic events supports fprobe events.
> 
> The fprobe event is a new dynamic events which is only for the function
> (symbol) entry and exit. This event accepts non register fetch arguments
> so that user can trace the function arguments and return values.
> 
> The fprobe events syntax is here;
> 
>  f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
>  f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]

I finally got around to look at these (I know you already queued them), but
looking at the above, the "%return" is redundant.

> 
> E.g.
> 
>  # echo 'f vfs_read $arg1'  >> dynamic_events
>  # echo 'f vfs_read%return $retval'  >> dynamic_events
>  # cat dynamic_events
>  f:fprobes/vfs_read__entry vfs_read arg1=$arg1
>  f:fprobes/vfs_read__exit vfs_read%return arg1=$retval

Can't we just have:

  f:fprobes/vfs_read__entry vfs_read arg1=$arg1
  f:fprobes/vfs_read__exit vfs_read arg1=$retval

Where if "$retval" is specified, it automatically becomes a return? If
anything else is specified, it errors out. That is, if $retval is
specified, it becomes a return probe, as a return probe can only have
$retval. If anything else is specified, it errors out if $retval is also
specified.

Now if it's a void function, and you just want to make it a return then we
can have your:

  f:fprobes/vfs_read__exit vfs_read%return

Thoughts?

-- Steve



