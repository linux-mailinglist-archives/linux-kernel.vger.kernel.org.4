Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606DC629CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKOPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKOPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:07:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493F42A979
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:07:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBFF661821
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC88DC433C1;
        Tue, 15 Nov 2022 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668524830;
        bh=V0uefWu1DX6KAvP4QTw78/qaBGs1+4nzlfeQamjzlxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KfwEt77/1sYpz62Y+7ILUy4llvWM4CTiELpOGYTf3rXykScbf7Q4oec+/bQTKxRkl
         GIb43VbKNuBZcqmrsgCBZ32wzWd2LTEm3/+5ZLmSUwwW0WjL3RBefSAniRVwZuwT9h
         gG8ephjOmisvTlVdVb4bx75+9YOzVjwQGC8ZKK4eVBMBrMKwNV9gR/KRe35iROxmhV
         lSeX1JD2N5XdkGF9pQbyI7zI0sD9MBK6vcg5Y/u/wvOORyDQljZfClKko1/XmRmLTL
         U8iI2Owsh7n/OFcHxVdZTtgu7HJiA3PWSD2f3BLbWNvgV44L1B62r8oJMPLfyJvIpm
         tZwn3o2AnVt9g==
Date:   Wed, 16 Nov 2022 00:07:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianlin Lv <iecedge@gmail.com>, alison.schofield@intel.com,
        davidgow@google.com, thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
Message-Id: <20221116000707.a8a692e377d8daaf3764ee64@kernel.org>
In-Reply-To: <20221114220216.05dd0541@gandalf.local.home>
References: <20221102160236.11696-1-iecedge@gmail.com>
        <20221114122255.72588f45@gandalf.local.home>
        <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
        <20221114220216.05dd0541@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 22:02:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 15 Nov 2022 10:38:34 +0800
> Jianlin Lv <iecedge@gmail.com> wrote:
> 
> > On Tue, Nov 15, 2022 at 1:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed,  2 Nov 2022 16:02:36 +0000
> > > Jianlin Lv <iecedge@gmail.com> wrote:
> > >  
> > > > In the case of keeping the system running, the preferred method for
> > > > tracing the kernel is dynamic tracing (kprobe), but the drawback of
> > > > this method is that events are lost, especially when tracing packages
> > > > in the network stack.  
> > >
> > > I'm not against this change, but the above is where I'm a bit confused. How
> > > are events more likely to be lost with kprobes over a static event?  
> > 
> > We have encountered a case of kprobes missing event, detailed
> > information can refer to the following link:
> > https://github.com/iovisor/bcc/issues/4198
> > 
> > Replacing kprobe with ’bpf + raw tracepoint‘,  no missing events occur.
> > 
> 
> Masami,
> 
> What's the reason that kprobes are not re-entrant when using ftrace?

I think we had discussed this issue when I drop the irq_disable() from
kprobe ftrace handler on x86, see commit a19b2e3d7839 ("kprobes/x86:
 Remove IRQ disabling from ftrace-based/optimized kprobes").

Anyway, kprobes itself is not re-entrant (and no need to be re-entrant
when using int3) because it uses a per-cpu variable to memorize the
current running kprobes while processing the int3 handling and the 
singlestep (trap) handling so that it can go back to the correct track
safely. It also has a single-stage "backup" (see save_previous_kprobe())
for unexpectedly re-entrant kprobes (e.g. call a probed function from
kprobe user handler.)

Thus the kprobe user doesn't need to write a re-entrant handler code.
Since kprobes on function entry is transparently changed to the ftrace,
we have to keep this limitation on the kprobes on ftrace.

BTW, now the kprobe_ftrace_handler() uses ftrace_test_recursion_trylock()
to avoid ftrace recursion, is that OK for this case?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
