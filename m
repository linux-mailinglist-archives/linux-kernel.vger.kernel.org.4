Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EBB701B49
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjENDCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENDCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A81BD8;
        Sat, 13 May 2023 20:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA00460B38;
        Sun, 14 May 2023 03:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B317C433D2;
        Sun, 14 May 2023 03:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684033360;
        bh=mJ7FROF21hftwJgCmZhoKpXoDuToifD8eM33mGLt0mQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=prQ4Wm9AAnZCqvzAN1GjX1iBSQn2GOEr1SLXvSKe9p0dqi0+vgKKeojIyijzqwBXM
         nEFNUGuJHEvUGJl8v3186cvW6GqYvbUdioSpLPX5nNCmPOk1957meNjwQQBu5U47To
         zw0EpK+E3hf16xPGKAobx/HB7fUUqCaSoyPOgCs52QHRuL+HpWZTR6lMBG4JMiakSy
         9ypg6FN2zZsEHp7nH6ESpULUWvu/ou4Yqwxcc/1r16c2upH0WV2FGxWsuHpkrzxGJ4
         QVSwNYhvodTHW42w1qQ89L9XdcVMZhKFaiLRsQlBTVqxND9Csuf6ctEk1OwyELPJeg
         KuHMZIwBB2hIg==
Date:   Sun, 14 May 2023 12:02:36 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 07/11] tracing/probes: Add $$args meta argument for
 all function args
Message-Id: <20230514120236.25fd2bcb174da8ff95ba89c1@kernel.org>
In-Reply-To: <20230505174856.04ca1e6a@gandalf.local.home>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
        <168299390127.3242086.2714570777321787734.stgit@mhiramat.roam.corp.google.com>
        <20230505174856.04ca1e6a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 17:48:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 May 2023 11:18:21 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add the '$$args' meta fetch argument for function-entry probe events. This
> 
> Hmm, couldn't we just use $args ? That would be different from $arg1,
> $arg2, etc.
> 
> The $$ to me would be either the bash pid of current, or perhaps it would
> be just to use a dollar sign. I don't see the precedence of $$args being a
> "full expand".

OK, I just thought it required a bit special prefix because it will be
expanded to several arguments (it is different from other $-params) and,
internally, it should be handled in the different path from the other
$-params. But the latter is internal reason, we should not care about that.
(of course I will leave a comment it.)

Thank you!

> 
> -- Steve
> 
> 
> > will be expanded to the all arguments of the function and the tracepoint
> > using BTF function argument information.
> > 
> > e.g.
> >  #  echo 'p vfs_read $$args' >> dynamic_events
> >  #  echo 'f vfs_write $$args' >> dynamic_events
> >  #  echo 't sched_overutilized_tp $$args' >> dynamic_events
> >  # cat dynamic_events
> > p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
> > f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
> > t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
