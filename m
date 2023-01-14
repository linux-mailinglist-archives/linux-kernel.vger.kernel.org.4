Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E446D66A918
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 05:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjANEEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 23:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjANEEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 23:04:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FDE9C;
        Fri, 13 Jan 2023 20:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19A48B800C1;
        Sat, 14 Jan 2023 04:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D56C433EF;
        Sat, 14 Jan 2023 04:04:07 +0000 (UTC)
Date:   Fri, 13 Jan 2023 23:04:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] tracing: Allow boot instances to have snapshot
 buffers
Message-ID: <20230113230406.6a8cd992@gandalf.local.home>
In-Reply-To: <Y8HyaeNeWvDlBshg@google.com>
References: <20230111145636.450953217@goodmis.org>
        <20230111145842.847715402@goodmis.org>
        <Y8HyaeNeWvDlBshg@google.com>
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

On Fri, 13 Jan 2023 17:08:09 -0700
Ross Zwisler <zwisler@google.com> wrote:

> > +++ b/kernel/trace/trace.c
> > @@ -192,6 +192,9 @@ static bool snapshot_at_boot;
> >  static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
> >  static int boot_instance_index;
> >  
> > +static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;  
> 
> For x86 machines at least COMMAND_LINE_SIZE is pretty big (2048), so between
> boot_instance_info and boot_snapshot_info we are using an entire 4k of memory.
> It seems unlikely that any user would need a string this long for these
> options.  Should we trim this down to something smaller?

They are both empty (BSS) and initdata. So they get allocated at boot up
and freed at the end of boot.

> 
> > +static int boot_snapshot_index;
> > +
> >  static int __init set_cmdline_ftrace(char *str)
> >  {
> >  	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
> > @@ -228,9 +231,22 @@ __setup("traceoff_on_warning", stop_trace_on_warning);
> >  
> >  static int __init boot_alloc_snapshot(char *str)
> >  {
> > -	allocate_snapshot = true;
> > -	/* We also need the main ring buffer expanded */
> > -	ring_buffer_expanded = true;
> > +	char *slot = boot_snapshot_info + boot_snapshot_index;
> > +	int left = COMMAND_LINE_SIZE - boot_snapshot_index;  
> 
> sizeof(boot_snapshot_info) is a bit safer than COMMAND_LINE_SIZE so they don't
> get out of sync, plus we may also want to shrink it a bit as mentioned above.

Yeah, I'm willing to do this (as mentioned before).

> 
> Just two nits, other than that you can add:
> 
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Thanks!

-- Steve
