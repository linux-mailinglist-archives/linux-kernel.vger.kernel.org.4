Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416BF66880A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjALX7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjALX7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:59:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CDF65B0;
        Thu, 12 Jan 2023 15:59:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E1F0621DE;
        Thu, 12 Jan 2023 23:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59626C433D2;
        Thu, 12 Jan 2023 23:59:27 +0000 (UTC)
Date:   Thu, 12 Jan 2023 18:59:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] tracing: Add creation of instances at boot command
 line
Message-ID: <20230112185925.5a51843e@gandalf.local.home>
In-Reply-To: <Y8CWodcFALp3MEBM@google.com>
References: <20230111145636.450953217@goodmis.org>
        <20230111145842.376427803@goodmis.org>
        <Y8CWodcFALp3MEBM@google.com>
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

On Thu, 12 Jan 2023 16:24:17 -0700
Ross Zwisler <zwisler@google.com> wrote:

> On Wed, Jan 11, 2023 at 09:56:37AM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Add kernel command line to add tracing instances. This only creates
> > instances at boot but still does not enable any events to them. Later
> > changes will extend this command line to add enabling of events, filters,
> > and triggers. As well as possibly redirecting trace_printk()!
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  6 +++
> >  kernel/trace/trace.c                          | 51 +++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 6cfa6e3996cf..cec486217ccc 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6272,6 +6272,12 @@
> >  			comma-separated list of trace events to enable. See
> >  			also Documentation/trace/events.rst
> >  
> > +	trace_instance=[instance-info]
> > +			[FTRACE] Create an ring buffer instance early in boot up.
> > +			This will be listed in:
> > +
> > +				/sys/kernel/tracing/instances  
> 
> Should this be "/sys/kernel/debug/tracing/instances"?

No, the /sys/kernel/debug/tracing is deprecated. It only exists for
backward compatibility. If it's still in documentation, it should be
updated.

> 
> Ditto for the text for 'ftrace_boot_snapshot':
> 
> 	ftrace_boot_snapshot
> 			[FTRACE] On boot up, a snapshot will be taken of the
> 			ftrace ring buffer that can be read at:
> 			/sys/kernel/tracing/snapshot.
> 
> Everywhere else we use /sys/kernel/debug/tracing, though we do use
> /sys/kernel/tracing in Documentation/trace/ftrace.txt ?

Right, that's because it was missed when I was updating it ;-)

All documentation that references /sys/kernel/debug/tracing should be
replaced with /sys/kernel/tracing.

> 
> I guess either works, but having just 1 or the other will help us not confuse
> users.

Agreed. Want to send a clean up patch? ;-)

> 
> > +
> >  	trace_options=[option-list]
> >  			[FTRACE] Enable or disable tracer options at boot.
> >  			The option-list is a comma delimited list of options
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index a555a861b978..34ed504ffca9 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -48,6 +48,9 @@
> >  #include <linux/fsnotify.h>
> >  #include <linux/irq_work.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/workqueue.h>  
> 
> Duplicate include 1 line above.

Good catch.

> 
> > +
> > +#include <asm/setup.h> /* COMMAND_LINE_SIZE */
> >  
> >  #include "trace.h"
> >  #include "trace_output.h"
> > @@ -186,6 +189,9 @@ static char *default_bootup_tracer;
> >  static bool allocate_snapshot;
> >  static bool snapshot_at_boot;
> >  
> > +static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
> > +static int boot_instance_index;
> > +
> >  static int __init set_cmdline_ftrace(char *str)
> >  {
> >  	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
> > @@ -239,6 +245,23 @@ static int __init boot_snapshot(char *str)
> >  __setup("ftrace_boot_snapshot", boot_snapshot);
> >  
> >  
> > +static int __init boot_instance(char *str)
> > +{
> > +	char *slot = boot_instance_info + boot_instance_index;
> > +	int left = COMMAND_LINE_SIZE - boot_instance_index;  
> 
> A bit safer to use sizeof(boot_instance_info) instead of COMMAND_LINE_SIZE,
> so we can change the allocation size of boot_instance_info without having to
> keep them in sync.

Either way is fine. I wouldn't make this change if it was the only thing I
needed to fix, but as I need to get rid of the extra "workqueue.h", I can
make this change too.

> 
> These are mostly nits, you can add:
> 
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Thanks!

-- Steve
