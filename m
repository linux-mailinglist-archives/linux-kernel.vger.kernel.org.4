Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B296EA017
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjDTXlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDTXlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD358196;
        Thu, 20 Apr 2023 16:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7597560B39;
        Thu, 20 Apr 2023 23:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2D6C433D2;
        Thu, 20 Apr 2023 23:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682034070;
        bh=bxHX0V8P90wfHHqEbZEWbg7aUtLdsEqx9+BhsFR5TaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mEoKCQ6TLLL3gSv9jQziwMAMOrckYftB6CgBhzMbtDwvgXpeB82plRKFJXbcLWjsc
         bx5qMTlBrgGeJQM8G8uEaWf5IOBQOthQZ7TRY/70+fPxbXkBSPp5MRJufJjp/829Lh
         7zsHPcck+0SQ4R6SojQxnw6p+FJQyJLaYzBk1wI01DF47hPjOH6jXkFEJ+U19IP+DC
         x4W2b6dJtDZBJ3BqSsuRirgU6ZfbtNZGCziF3NySh7VbJILfJyqpV7BofT75mcgJtR
         gGXDJikAdkjvd1i2DXBBmeFRsrSh3/lqIWEkYZJueJP8S0K3E91v/M5ZxvCXFOFXEd
         cwYBAy3Goa5Og==
Date:   Fri, 21 Apr 2023 08:41:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 2/9] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230421084106.5a02844971e18cdd8ad163be@kernel.org>
In-Reply-To: <20230420184932.pgv5wiqqt4fzswdk@MacBook-Pro-6.local>
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
        <168198995084.1795549.16754963116067902376.stgit@mhiramat.roam.corp.google.com>
        <20230420184932.pgv5wiqqt4fzswdk@MacBook-Pro-6.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 11:49:32 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Apr 20, 2023 at 08:25:50PM +0900, Masami Hiramatsu (Google) wrote:
> > +static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +			    struct pt_regs *regs)
> > +{
> > +	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > +	struct fentry_trace_entry_head *entry;
> > +	struct hlist_head *head;
> > +	int size, __size, dsize;
> > +	int rctx;
> > +
> > +	if (bpf_prog_array_valid(call)) {
> > +		unsigned long orig_ip = instruction_pointer(regs);
> > +		int ret;
> > +
> > +		ret = trace_call_bpf(call, regs);
> 
> Please do not call bpf from fprobe.
> There is no use case for it.

OK.

> 
> > +
> > +		/*
> > +		 * We need to check and see if we modified the pc of the
> > +		 * pt_regs, and if so return 1 so that we don't do the
> > +		 * single stepping.
> > +		 */
> > +		if (orig_ip != instruction_pointer(regs))
> > +			return 1;
> > +		if (!ret)
> > +			return 0;
> > +	}
> > +
> > +	head = this_cpu_ptr(call->perf_events);
> > +	if (hlist_empty(head))
> > +		return 0;
> > +
> > +	dsize = __get_data_size(&tf->tp, regs);
> > +	__size = sizeof(*entry) + tf->tp.size + dsize;
> > +	size = ALIGN(__size + sizeof(u32), sizeof(u64));
> > +	size -= sizeof(u32);
> > +
> > +	entry = perf_trace_buf_alloc(size, NULL, &rctx);
> > +	if (!entry)
> > +		return 0;
> > +
> > +	entry->ip = entry_ip;
> > +	memset(&entry[1], 0, dsize);
> > +	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > +	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
> > +			      head, NULL);
> > +	return 0;
> > +}
> > +NOKPROBE_SYMBOL(fentry_perf_func);
> > +
> > +static void
> > +fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +		unsigned long ret_ip, struct pt_regs *regs)
> > +{
> > +	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > +	struct fexit_trace_entry_head *entry;
> > +	struct hlist_head *head;
> > +	int size, __size, dsize;
> > +	int rctx;
> > +
> > +	if (bpf_prog_array_valid(call) && !trace_call_bpf(call, regs))
> > +		return;
> 
> Same here.
> These two parts look like copy-paste from kprobes.
> I suspect this code wasn't tested at all.

OK, I missed to test that bpf part. I thought bpf could be appended to
any "trace-event" (looks like trace-event), isn't it?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
