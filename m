Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46B06CD936
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjC2MPT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjC2MPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:15:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CE4C00;
        Wed, 29 Mar 2023 05:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C32D9B820CA;
        Wed, 29 Mar 2023 12:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40CCC433EF;
        Wed, 29 Mar 2023 12:15:03 +0000 (UTC)
Date:   Wed, 29 Mar 2023 08:14:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 09/10] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-ID: <20230329081454.05133571@rorschach.local.home>
In-Reply-To: <167526703341.433354.12634235635015890994.stgit@mhiramat.roam.corp.google.com>
References: <167526695292.433354.8949652607331707144.stgit@mhiramat.roam.corp.google.com>
        <167526703341.433354.12634235635015890994.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Feb 2023 00:57:13 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add fprobe events for tracing function entry and exit instead of kprobe
> events. With this change, we can continue to trace function entry/exit
> even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
> CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
> it is not available if the architecture only supports
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS. And that means kprobe events can not
> probe function entry/exit effectively on such architecture.
> But this can be solved if the dynamic events supports fprobe events.
> 
> The fprobe event is a new dynamic events which is only for the function
> (symbol) entry and exit. This event accepts non register fetch arguments
> so that user can trace the function arguments and return values.
> 

Hi Masami,

After applying this patch I get a bunch of these:

/work/git/linux-trace.git/kernel/trace/trace_fprobe.c:117:1: error: redefinition of ‘fetch_store_strlen_user’
  117 | fetch_store_strlen_user(unsigned long addr)
      | ^~~~~~~~~~~~~~~~~~~~~~~
In file included from /work/git/linux-trace.git/kernel/trace/trace_fprobe.c:16:
/work/git/linux-trace.git/kernel/trace/trace_probe_kernel.h:15:1: note: previous definition of ‘fetch_store_strlen_user’ with type ‘int(long unsigned int)’
   15 | fetch_store_strlen_user(unsigned long addr)
      | ^~~~~~~~~~~~~~~~~~~~~~~
/work/git/linux-trace.git/kernel/trace/trace_fprobe.c: In function ‘fetch_store_strlen_user’:
/work/git/linux-trace.git/kernel/trace/trace_fprobe.c:119:16: error: implicit declaration of function ‘kern_fetch_store_strlen_user’; did you mean ‘fetch_store_strlen_user’? [-Werror=implicit-function-declaration]
  119 |         return kern_fetch_store_strlen_user(addr);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                fetch_store_strlen_user
/work/git/linux-trace.git/kernel/trace/trace_fprobe.c: At top level:
/work/git/linux-trace.git/kernel/trace/trace_fprobe.c:124:1: error: redefinition of ‘fetch_store_strlen’
  124 | fetch_store_strlen(unsigned long addr)
      | ^~~~~~~~~~~~~~~~~~
/work/git/linux-trace.git/kernel/trace/trace_probe_kernel.h:32:1: note: previous definition of ‘fetch_store_strlen’ with type ‘int(long unsigned int)’
   32 | fetch_store_strlen(unsigned long addr)
      | ^~~~~~~~~~~~~~~~~~
/work/git/linux-trace.git/kernel/trace/trace_fprobe.c: In function ‘fetch_store_strlen’:
/work/git/linux-trace.git/kernel/trace/trace_fprobe.c:126:16: error: implicit declaration of function ‘kern_fetch_store_strlen’; did you mean ‘fetch_store_strlen’? [-Werror=implicit-function-declaration]
  126 |         return kern_fetch_store_strlen(addr);
      |                ^~~~~~~~~~~~~~~~~~~~~~~
      |                fetch_store_strlen


Can you rebase it on the latest changes (on top of trace/for-next)?

BTW, I've applied patches 1-8 and I'm currently running them through my
tests. So if you do rebase, just send patches 9 and 10. I'm hoping to
post a for-next series later today, that will include those other
patches.

-- Steve
