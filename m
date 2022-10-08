Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3E5F8763
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 22:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJHUnl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 8 Oct 2022 16:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJHUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 16:43:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807D36408;
        Sat,  8 Oct 2022 13:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BD9AB80BA9;
        Sat,  8 Oct 2022 20:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C03C433C1;
        Sat,  8 Oct 2022 20:43:30 +0000 (UTC)
Date:   Sat, 8 Oct 2022 16:43:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to trace serial console init during boot-time?
Message-ID: <20221008164326.00b70ee4@rorschach.local.home>
In-Reply-To: <9af98779-6964-e971-41ba-667c9cd34e60@molgen.mpg.de>
References: <9af98779-6964-e971-41ba-667c9cd34e60@molgen.mpg.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 15:30:56 +0200
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Linux folks,
> 
> 
> I am trying to do boot-time tracing of `univ8250_console_init()`:
> 
>      [    0.126636] ftrace: allocating 41793 entries in 164 pages
>      [    0.132446] ftrace: allocated 164 pages with 3 groups
>      […]
>      [    0.167334] calling  con_init+0x0/0x239 @ 0
>      [    0.170217] Console: colour VGA+ 80x25
>      [    0.190381] printk: console [tty0] enabled
>      [    0.190484] initcall con_init+0x0/0x239 returned 0 after 0 usecs
>      [    0.190487] calling  hvc_console_init+0x0/0x18 @ 0
>      [    0.190489] initcall hvc_console_init+0x0/0x18 returned 0 after 
> 0 usecs
>      [    0.190491] calling  univ8250_console_init+0x0/0x2b @ 0
>      [    1.488645] printk: console [ttyS0] enabled
>      [    1.492945] initcall univ8250_console_init+0x0/0x2b returned 0 
> after 0 usecs
>      […]
>      [    1.670397] calling  trace_init_perf_perm_irq_work_exit+0x0/0x17 @ 1
>      [    1.670399] initcall trace_init_perf_perm_irq_work_exit+0x0/0x17 
> returned 0 after 0 usecs
>      […]
>      [    1.673339] calling  trace_init_flags_sys_enter+0x0/0x13 @ 1
>      [    1.673342] initcall trace_init_flags_sys_enter+0x0/0x13 
> returned 0 after 0 usecs
>      [    1.673344] calling  trace_init_flags_sys_exit+0x0/0x13 @ 1
>      [    1.673346] initcall trace_init_flags_sys_exit+0x0/0x13 returned 
> 0 after 0 usecs
>      [    1.673348] calling  cpu_stop_init+0x0/0x87 @ 1
>      [    1.673364] initcall cpu_stop_init+0x0/0x87 returned 0 after 0 usecs
>      [    1.673366] calling  init_kprobes+0x0/0x149 @ 1
>      [    1.673495] initcall init_kprobes+0x0/0x149 returned 0 after 0 usecs
>      [    1.673497] calling  init_events+0x0/0x4d @ 1
>      [    1.673502] initcall init_events+0x0/0x4d returned 0 after 0 usecs
>      [    1.673504] calling  init_trace_printk+0x0/0xc @ 1
>      [    1.673505] initcall init_trace_printk+0x0/0xc returned 0 after 
> 0 usecs
>      [    1.673507] calling  event_trace_enable_again+0x0/0x23 @ 1
>      [    1.673508] initcall event_trace_enable_again+0x0/0x23 returned 
> 0 after 0 usecs
> 
> The function `univ8250_console_init()` is not available in 
> `/sys/kernel/debug/tracing/available_filter_functions`, so I’d like to 
> trace `univ8250_console_setup()`:
> 
>      initcall_debug log_buf_len=32M trace_buf_size=262144K 
> trace_clock=global 
> trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time 
> ftrace=fun
> ction_graph ftrace_graph_max_depth=2 
> ftrace_graph_filter=univ8250_console_setup tp_printk
> 
> Unfortunately, `/sys/kernel/debug/tracing/trace` is empty, so I guess 
> the console happens before ftrace is available?

"function" tracing is enabled by then (I just tested it), but
"function_graph" is not. Function graph requires trace events enabled,
but I could see what happens if I do enabled it ;-)

> 
> Is there another way to trace the serial console init, without having to 
> add print statements?
> 

Use "ftrace=function" but then you will get everything. You could add a
"set_filter=<func>:traceoff" to set a trigger that would disable
tracing, if you can find a function that would be good to stop tracing
with.

Otherwise, I could take a look to see what it takes to get function
graph tracing working that early.

-- Steve
