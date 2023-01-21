Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8667677B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAUQtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:49:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D128D27;
        Sat, 21 Jan 2023 08:49:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A819601BC;
        Sat, 21 Jan 2023 16:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EF2C433D2;
        Sat, 21 Jan 2023 16:49:06 +0000 (UTC)
Date:   Sat, 21 Jan 2023 11:49:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [tip:sched/core] [tracing, hardirq]  9aedeaed6f:
 WARNING:suspicious_RCU_usage
Message-ID: <20230121114904.13d6825d@gandalf.local.home>
In-Reply-To: <Y8pkFhi32XhvCVOo@hirez.programming.kicks-ass.net>
References: <202301192148.58ece903-oliver.sang@intel.com>
        <Y8llrdNT6RD/0dbq@hirez.programming.kicks-ass.net>
        <20230119112433.611fa273@gandalf.local.home>
        <Y8pkFhi32XhvCVOo@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 10:51:18 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > does trigger the issue, you can then bisect the functions with the script:
> > 
> >   scripts/tracing/ftrace-bisect.sh  
> 
> Pff, that all sounds like actual work :-)
> 
> Instead I did me the below hack and added my early_printk() hacks and
> that got me a usable backtrace.

Well, if you system is still running after the issue, then sure. I created
this when it would cause a triple fault reboot. In which case, there was no
real debugging output to use.

-- Steve


> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 5e7ead52cfdb..7defc6e24f8f 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -646,6 +646,9 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>  		return;
>  
> +	if (WARN_ONCE(!rcu_is_watching(), "RCU not on for: %pS\n", (void *)ip))
> +		return;
> +
>  	bit = ftrace_test_recursion_trylock(ip, *parent);
>  	if (bit < 0)
>  		return;

