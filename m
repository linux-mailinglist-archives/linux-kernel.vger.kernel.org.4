Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D51874B2F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjGGORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGGORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8DD125;
        Fri,  7 Jul 2023 07:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA77619D3;
        Fri,  7 Jul 2023 14:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61B6C433C7;
        Fri,  7 Jul 2023 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688739461;
        bh=74TZJ8DeE44QYRS49fC72fWhJ1prqaoZEaYSRbQGNqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R/zk6E3JYbftUInhMFoZYTLJTS9Ver38FrAGJYGDLg48/1nqGS/SziwjqaI0uQ8mF
         9uLLO7Cp94P6wOdloklj2Y/7wrSRJt7CEE0DXPQ2KSBBrbXG+mYq6wLslX/vTfI+1W
         pgq6NN6xNIFIcguJ639U3T/ObwuslPK5zEjXdlTFPNrJMc+jdRCDoMCiT4GP4oMufr
         x6Cim/0DLMaOFwwTK3vOt8fmQO3/TnbVISve1eyccMtkGCkMoKGsy5ufum64rvMcyu
         0KyIrk7yPq+zWMhYfRTNEs5ovJGutkCRmo8w8bkGnE8D5Q8BUg4Vq2a/jG8QT6c535
         LnQlVdhJcw2rA==
Date:   Fri, 7 Jul 2023 23:17:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v11 02/11] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230707231730.7e2d176d729718a9ba51255a@kernel.org>
In-Reply-To: <20230608165234.0c00c146@gandalf.local.home>
References: <168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com>
        <168432114441.1351929.4695419422051966931.stgit@mhiramat.roam.corp.google.com>
        <20230608165234.0c00c146@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 16:52:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 17 May 2023 19:59:04 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
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
> > The fprobe events syntax is here;
> > 
> >  f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
> >  f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]
> 
> I finally got around to look at these (I know you already queued them), but
> looking at the above, the "%return" is redundant.
> 
> > 
> > E.g.
> > 
> >  # echo 'f vfs_read $arg1'  >> dynamic_events
> >  # echo 'f vfs_read%return $retval'  >> dynamic_events
> >  # cat dynamic_events
> >  f:fprobes/vfs_read__entry vfs_read arg1=$arg1
> >  f:fprobes/vfs_read__exit vfs_read%return arg1=$retval
> 
> Can't we just have:
> 
>   f:fprobes/vfs_read__entry vfs_read arg1=$arg1
>   f:fprobes/vfs_read__exit vfs_read arg1=$retval
> 
> Where if "$retval" is specified, it automatically becomes a return? If
> anything else is specified, it errors out. That is, if $retval is
> specified, it becomes a return probe, as a return probe can only have
> $retval. If anything else is specified, it errors out if $retval is also
> specified.

Hmm, current implementation design doesn't allow that.
It parses the 'place' and 'args' sequencially because what 'args' is
available depends on the place.

> 
> Now if it's a void function, and you just want to make it a return then we
> can have your:
> 
>   f:fprobes/vfs_read__exit vfs_read%return
> 
> Thoughts?

But this sounds useful. Let me try to scan the argument to find $retval.

Thank you,

> 
> -- Steve
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
