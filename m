Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EC95B68F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiIMHsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiIMHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:48:43 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BF5A3C8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:48:39 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef37.dynamic.kabel-deutschland.de [95.90.239.55])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 974D461EA1932;
        Tue, 13 Sep 2022 09:48:35 +0200 (CEST)
Message-ID: <fe5695d3-b645-08a4-848e-262e291aea76@molgen.mpg.de>
Date:   Tue, 13 Sep 2022 09:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: `switch_ldt()` fills up trace file
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Using `bootgraph.py -f -manual` [1] to generate the Linux CLI line for 
tracing the boot, and changing `do_one_initcall` to `dell_init` to trace 
`drivers/platform/x86/dell/dell-laptop.c`, `switch_ldt();` fills up the 
trace file. Is that expected, and can I work around it?

```
# boot-091222-181507 dellxps139360 boot 5.19.0-1-amd64
# sysinfo | man:Dell Inc. | plat:XPS 13 9360 | cpu:Intel(R) Core(TM) 
i7-7500U CPU @ 2.70GHz | bios:2.21.0 | biosdate:06/02/2022 | numcpu:4 | 
memsz:15959616 | memfr:11084888 | os:Debian GNU/Linux bookworm/sid
# command | analyze_boot.py -f
# kparams | BOOT_IMAGE=/vmlinuz-5.19.0-1-amd64 
root=UUID=fe58fd63-a3e1-4670-b648-45c6a324394a ro initcall_debug 
log_buf_len=32M trace_buf_size=524288K trace_clock=global 
trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,funcgraph-duration,funcgraph-proc,funcgraph-tail,nofuncgraph-overhead,context-info,graph-time 
ftrace=function_graph ftrace_graph_max_depth=5 
ftrace_graph_filter=dell_init cryptomgr.notests
# tracer: function_graph
#
#     TIME        CPU  TASK/PID         DURATION 
FUNCTION CALLS
#      |          |     |    |           |   |                     |   | 
   |   |
     0.516713 |   0)   systemd-1    |   1.671 us    |  switch_ldt();
     0.516715 |   0)   systemd-1    |   0.207 us    |  switch_ldt();
     0.516716 |   0)   systemd-1    |   0.170 us    |  switch_ldt();
[…]
```


Kind regards,

Paul


[1]: https://github.com/intel/pm-graph
