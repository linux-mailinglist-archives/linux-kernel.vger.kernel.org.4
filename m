Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6167B5F7906
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJGNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJGNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:31:01 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84B114DCE;
        Fri,  7 Oct 2022 06:30:59 -0700 (PDT)
Received: from [192.168.0.7] (ip5f5aef11.dynamic.kabel-deutschland.de [95.90.239.17])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3449A61EA1929;
        Fri,  7 Oct 2022 15:30:57 +0200 (CEST)
Message-ID: <9af98779-6964-e971-41ba-667c9cd34e60@molgen.mpg.de>
Date:   Fri, 7 Oct 2022 15:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: How to trace serial console init during boot-time?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


I am trying to do boot-time tracing of `univ8250_console_init()`:

     [    0.126636] ftrace: allocating 41793 entries in 164 pages
     [    0.132446] ftrace: allocated 164 pages with 3 groups
     […]
     [    0.167334] calling  con_init+0x0/0x239 @ 0
     [    0.170217] Console: colour VGA+ 80x25
     [    0.190381] printk: console [tty0] enabled
     [    0.190484] initcall con_init+0x0/0x239 returned 0 after 0 usecs
     [    0.190487] calling  hvc_console_init+0x0/0x18 @ 0
     [    0.190489] initcall hvc_console_init+0x0/0x18 returned 0 after 
0 usecs
     [    0.190491] calling  univ8250_console_init+0x0/0x2b @ 0
     [    1.488645] printk: console [ttyS0] enabled
     [    1.492945] initcall univ8250_console_init+0x0/0x2b returned 0 
after 0 usecs
     […]
     [    1.670397] calling  trace_init_perf_perm_irq_work_exit+0x0/0x17 @ 1
     [    1.670399] initcall trace_init_perf_perm_irq_work_exit+0x0/0x17 
returned 0 after 0 usecs
     […]
     [    1.673339] calling  trace_init_flags_sys_enter+0x0/0x13 @ 1
     [    1.673342] initcall trace_init_flags_sys_enter+0x0/0x13 
returned 0 after 0 usecs
     [    1.673344] calling  trace_init_flags_sys_exit+0x0/0x13 @ 1
     [    1.673346] initcall trace_init_flags_sys_exit+0x0/0x13 returned 
0 after 0 usecs
     [    1.673348] calling  cpu_stop_init+0x0/0x87 @ 1
     [    1.673364] initcall cpu_stop_init+0x0/0x87 returned 0 after 0 usecs
     [    1.673366] calling  init_kprobes+0x0/0x149 @ 1
     [    1.673495] initcall init_kprobes+0x0/0x149 returned 0 after 0 usecs
     [    1.673497] calling  init_events+0x0/0x4d @ 1
     [    1.673502] initcall init_events+0x0/0x4d returned 0 after 0 usecs
     [    1.673504] calling  init_trace_printk+0x0/0xc @ 1
     [    1.673505] initcall init_trace_printk+0x0/0xc returned 0 after 
0 usecs
     [    1.673507] calling  event_trace_enable_again+0x0/0x23 @ 1
     [    1.673508] initcall event_trace_enable_again+0x0/0x23 returned 
0 after 0 usecs

The function `univ8250_console_init()` is not available in 
`/sys/kernel/debug/tracing/available_filter_functions`, so I’d like to 
trace `univ8250_console_setup()`:

     initcall_debug log_buf_len=32M trace_buf_size=262144K 
trace_clock=global 
trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time 
ftrace=fun
ction_graph ftrace_graph_max_depth=2 
ftrace_graph_filter=univ8250_console_setup tp_printk

Unfortunately, `/sys/kernel/debug/tracing/trace` is empty, so I guess 
the console happens before ftrace is available?

Is there another way to trace the serial console init, without having to 
add print statements?


Kind regards,

Paul


PS: We boot our systems generally with the serial console enabled 
`console=ttyS0`, and noticed that initializing the console takes at 
least one second.

$ dmesg | grep -e 'DMI:' -e 'printk: console'
[    0.000000] DMI: Dell Inc. PowerEdge R7525/05Y13N, BIOS 2.7.3 03/30/2022
[    2.691432] printk: console [tty0] enabled
[    5.414384] printk: console [ttyS0] enabled

$ dmesg | grep -e 'DMI:' -e 'printk:'
[    0.000000] DMI: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.22.0 
07/13/2022
[    0.146953] printk: console [tty0] enabled
[    1.374382] printk: console [ttyS0] enabled

$ dmesg | grep -e 'DMI:' -e 'printk: console'
[    0.000000] DMI: Dell Inc. PowerEdge R7425/08V001, BIOS 1.6.7 10/29/2018
[    1.589543] printk: console [tty0] enabled
[    3.057770] printk: console [ttyS0] enabled

$ dmesg | grep -e 'DMI:' -e 'printk: console'
[    0.000000] DMI: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 
Plus, BIOS A42 12/03/2021
[    5.171202] printk: console [tty0] enabled
[    8.066602] printk: console [ttyS0] enabled
