Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F36FC9E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjEIPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjEIPIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:08:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B27C3C3B;
        Tue,  9 May 2023 08:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB4862EDE;
        Tue,  9 May 2023 15:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D5CC433EF;
        Tue,  9 May 2023 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683644925;
        bh=T9KFHDYYM0c4PV+Z2aMfqPPqiVr9JLfTv51Lf3v+Y+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y7VYuOnopAMNMopzSNbyQ23zxRhoZfdzcY2y1gPfUrJMrSqTqoriOSp9Rk9QCN19F
         Y2OiTAJ6yQhlh0NKMkfkXemcCUDUyvsWn2nxEZg+Xnzyi6vnIWj6wVw2/iWr3kQpL0
         mxXm9M8tEbU60b+1hOsi7OMUYj5mXugExEobKwLSa9ONokuVEzpssSBg1mLNHgVHZG
         YsDc0iTdaaIiyJmgGlynW/xJ+UDvRvm9S62H4fcwyq7Y/LIB72xtOTT83J5Olz7PdY
         G2sqEanDENqvaz8Gm7TgEfIQVPXtnJlZ0rZPmBwUXJoyDpe5tx/lTHv19YDKZSXyXj
         RISXiJcS3v80A==
Date:   Wed, 10 May 2023 00:08:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 02/11] tracing/probes: Add fprobe events for
 tracing function entry and exit.
Message-Id: <20230510000839.0d223bfd5ba9e556f302596d@kernel.org>
In-Reply-To: <20230505121212.7569c9b9@gandalf.local.home>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
        <168299385687.3242086.18384268741128867952.stgit@mhiramat.roam.corp.google.com>
        <20230505121212.7569c9b9@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 12:12:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 May 2023 11:17:36 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > new file mode 100644
> > index 000000000000..0049d9ef2402
> > --- /dev/null
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -0,0 +1,1053 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Fprobe-based tracing events
> > + * Copyright (C) 2022 Google LLC.
> > + */
> > +#define pr_fmt(fmt)	"trace_fprobe: " fmt
> > +
> > +#include <linux/fprobe.h>
> > +#include <linux/module.h>
> > +#include <linux/rculist.h>
> > +#include <linux/security.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include "trace_dynevent.h"
> > +#include "trace_probe.h"
> > +#include "trace_probe_kernel.h"
> > +#include "trace_probe_tmpl.h"
> > +
> > +#define FPROBE_EVENT_SYSTEM "fprobes"
> > +#define RETHOOK_MAXACTIVE_MAX 4096
> > +
> > +static int trace_fprobe_create(const char *raw_command);
> > +static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
> > +static int trace_fprobe_release(struct dyn_event *ev);
> > +static bool trace_fprobe_is_busy(struct dyn_event *ev);
> > +static bool trace_fprobe_match(const char *system, const char *event,
> > +			int argc, const char **argv, struct dyn_event *ev);
> > +
> > +static struct dyn_event_operations trace_fprobe_ops = {
> > +	.create = trace_fprobe_create,
> > +	.show = trace_fprobe_show,
> > +	.is_busy = trace_fprobe_is_busy,
> > +	.free = trace_fprobe_release,
> > +	.match = trace_fprobe_match,
> > +};
> > +
> > +/*
> > + * Fprobe event core functions
> > + */
> > +struct trace_fprobe {
> > +	struct dyn_event	devent;
> > +	struct fprobe		fp;
> > +	const char		*symbol;
> > +	struct trace_probe	tp;
> > +};
> > +
> > +static bool is_trace_fprobe(struct dyn_event *ev)
> > +{
> > +	return ev->ops == &trace_fprobe_ops;
> > +}
> > +
> > +static struct trace_fprobe *to_trace_fprobe(struct dyn_event *ev)
> > +{
> > +	return container_of(ev, struct trace_fprobe, devent);
> > +}
> > +
> > +/**
> > + * for_each_trace_fprobe - iterate over the trace_fprobe list
> > + * @pos:	the struct trace_fprobe * for each entry
> > + * @dpos:	the struct dyn_event * to use as a loop cursor
> > + */
> > +#define for_each_trace_fprobe(pos, dpos)	\
> > +	for_each_dyn_event(dpos)		\
> > +		if (is_trace_fprobe(dpos) && (pos = to_trace_fprobe(dpos)))
> > +
> > +static bool trace_fprobe_is_return(struct trace_fprobe *tf)
> > +{
> > +	return tf->fp.exit_handler != NULL;
> > +}
> > +
> > +static const char *trace_fprobe_symbol(struct trace_fprobe *tf)
> > +{
> > +	return tf->symbol ? tf->symbol : "unknown";
> > +}
> > +
> > +static bool trace_fprobe_is_busy(struct dyn_event *ev)
> > +{
> > +	struct trace_fprobe *tf = to_trace_fprobe(ev);
> > +
> > +	return trace_probe_is_enabled(&tf->tp);
> > +}
> > +
> > +static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
> > +					    int argc, const char **argv)
> > +{
> > +	char buf[MAX_ARGSTR_LEN + 1];
> > +
> > +	if (!argc)
> > +		return true;
> > +
> > +	snprintf(buf, sizeof(buf), "%s", trace_fprobe_symbol(tf));
> > +	if (strcmp(buf, argv[0]))
> > +		return false;
> > +	argc--; argv++;
> > +
> > +	return trace_probe_match_command_args(&tf->tp, argc, argv);
> > +}
> > +
> > +static bool trace_fprobe_match(const char *system, const char *event,
> > +			int argc, const char **argv, struct dyn_event *ev)
> > +{
> > +	struct trace_fprobe *tf = to_trace_fprobe(ev);
> > +
> > +	return (event[0] == '\0' ||
> > +		strcmp(trace_probe_name(&tf->tp), event) == 0) &&
> > +	    (!system || strcmp(trace_probe_group_name(&tf->tp), system) == 0) &&
> > +	    trace_fprobe_match_command_head(tf, argc, argv);
> 
> The above is really hard to read, and Linus hates these kinds of
> statements. Please break it up (the compiler should do the right thing).
> 
> Reversing the tests to return false:
> 
> 	if (event[0] != '\0' &&
> 	    strcmp(trace_probe_name(&tf->tp), event) != 0))
> 		return false;
> 
> 	if (system && strcmp(trace_probe_group_name(&tf->tp), system) != 0))
> 		return false;
> 
> 	return trace_fprobe_match_command_head(tf, argc, argv);
> 

OK, I'll clean it up.

> 
> > +}
> > +
> > +static bool trace_fprobe_is_registered(struct trace_fprobe *tf)
> > +{
> > +	return fprobe_is_registered(&tf->fp);
> > +}
> > +
> > +/* Note that we don't verify it, since the code does not come from user space */
> 
> Verify what?
> 
> Hmm, I see this is a copy of the comment from both trace_kprobe.c and
> trace_uprobe.c. I think this requires a bit more explanation (and also in
> those locations as well).

Yeah, sorry about this comment. I meant that this fetch process (will run
on probe handlers) did not verify the fetch_insn code because it should be
generated by parser.

/*
 * Note that we don't verify the fetch_insn code, since it does not come
 * from user space.
 */

> 
> > +static int
> > +process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> > +		   void *base)
> > +{
> > +	struct pt_regs *regs = rec;
> > +	unsigned long val;
> > +
> > +retry:
> > +	/* 1st stage: get value from context */
> > +	switch (code->op) {
> > +	case FETCH_OP_REG:
> > +		val = regs_get_register(regs, code->param);
> > +		break;
> > +	case FETCH_OP_STACK:
> > +		val = regs_get_kernel_stack_nth(regs, code->param);
> > +		break;
> > +	case FETCH_OP_STACKP:
> > +		val = kernel_stack_pointer(regs);
> > +		break;
> > +	case FETCH_OP_RETVAL:
> > +		val = regs_return_value(regs);
> > +		break;
> 
> 
> > +	case FETCH_OP_IMM:
> > +		val = code->immediate;
> > +		break;
> > +	case FETCH_OP_COMM:
> > +		val = (unsigned long)current->comm;
> > +		break;
> > +	case FETCH_OP_DATA:
> > +		val = (unsigned long)code->data;
> > +		break;
> 
> These are new and not part of trace_kprobe.c. Should we have a version that
> the two could share?

Oh, I remember that I missed one series which did that.

https://lore.kernel.org/lkml/20230103223202.7963bfb62b4ae5827e51ee30@kernel.org/T/

Let's pick it.

> 
> Probably a helper function that can be called by these two.
> 
> > +#ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > +	case FETCH_OP_ARG:
> > +		val = regs_get_kernel_argument(regs, code->param);
> > +		break;
> > +#endif
> > +	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
> > +		code++;
> > +		goto retry;
> > +	default:
> > +		return -EILSEQ;
> > +	}
> > +	code++;
> > +
> > +	return process_fetch_insn_bottom(code, val, dest, base);
> > +}
> > +NOKPROBE_SYMBOL(process_fetch_insn)
> > +
> > +/* function entry handler */
> > +static nokprobe_inline void
> > +__fentry_trace_func(struct trace_fprobe *tf, unsigned long entry_ip,
> > +		    struct pt_regs *regs,
> > +		    struct trace_event_file *trace_file)
> > +{
> > +	struct fentry_trace_entry_head *entry;
> > +	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
> > +	struct trace_event_buffer fbuffer;
> > +	int dsize;
> > +
> > +	WARN_ON(call != trace_file->event_call);
> 
>  WARN_ON_ONCE()?
> 
> And if you are doing the check, perhaps even:
> 
> 	if (WARN_ON_ONCE(call != trace_file->event_call))
> 		return;

OK.

Thank you!

> 
> -- Steve
> 
> > +
> > +	if (trace_trigger_soft_disabled(trace_file))
> > +		return;
> > +
> > +	dsize = __get_data_size(&tf->tp, regs);
> > +
> > +	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
> > +					   sizeof(*entry) + tf->tp.size + dsize);
> > +	if (!entry)
> > +		return;
> > +
> > +	fbuffer.regs = regs;
> > +	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
> > +	entry->ip = entry_ip;
> > +	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> > +
> > +	trace_event_buffer_commit(&fbuffer);
> > +}
> > +


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
