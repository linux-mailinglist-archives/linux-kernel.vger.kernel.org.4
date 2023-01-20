Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77816751A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjATJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjATJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:52:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBFA5CFF;
        Fri, 20 Jan 2023 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NXj6U+8rYRpDaWLV8kgbTbPFTvM3jXfrajkYp/fZG0U=; b=dVQS34+x8iFkZumz6p35uxZSD0
        f67QJmMNy6x2BCpTi7MARlbQNW/MAUmFq0j9xSA6PSa+uGIqQL1g9fvsqGsd6mNhCNNwmhx8m48RP
        lgS5IRpACgwXX3fUK6siLwzmvGgX5O423D5R6HAn7S75500I1jz9uYeR7w2chZZ2jcLg7HGITY2id
        aj+QF5/fdnIZuvS1o6qLDikF/H/N4sgunP2Fikb68wKaFZus2zI4d4dZdH5wimOjpEBen91Wz5MbI
        nBZ3/2/HU0Tvb7RwbrBxvomrTsMe+FkzYjkj+duS8y7cX8yi/kBKYT5+rtFdFM2cOk+KBDcNvp/MW
        +9ENBfJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIo3N-001pwh-Q5; Fri, 20 Jan 2023 09:51:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 012DD30036B;
        Fri, 20 Jan 2023 10:51:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49F032133D201; Fri, 20 Jan 2023 10:51:18 +0100 (CET)
Date:   Fri, 20 Jan 2023 10:51:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [tip:sched/core] [tracing, hardirq]  9aedeaed6f:
 WARNING:suspicious_RCU_usage
Message-ID: <Y8pkFhi32XhvCVOo@hirez.programming.kicks-ass.net>
References: <202301192148.58ece903-oliver.sang@intel.com>
 <Y8llrdNT6RD/0dbq@hirez.programming.kicks-ass.net>
 <20230119112433.611fa273@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119112433.611fa273@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:24:33AM -0500, Steven Rostedt wrote:
> On Thu, 19 Jan 2023 16:45:49 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Steve, what's the easiest way to figure out what triggers this? Put a
> > printk() in prepare_ftrace_return() or so?
> 
> Does it only trigger if all functions are enabled when running function
> graph tracer?
> 
> That is, if you just trace one function, say "schedule" does it
> have an issue?
> 
>  trace-cmd start -p function_graph -l schedule
> 
> And then run your code, and it doesn't trigger, but:
> 
> 
>  trace-cmd reset # make sure schedule is no longer filtered
>  trace-cmd start -p function_graph
> 
> does trigger the issue, you can then bisect the functions with the script:
> 
>   scripts/tracing/ftrace-bisect.sh

Pff, that all sounds like actual work :-)

Instead I did me the below hack and added my early_printk() hacks and
that got me a usable backtrace.

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 5e7ead52cfdb..7defc6e24f8f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -646,6 +646,9 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
+	if (WARN_ONCE(!rcu_is_watching(), "RCU not on for: %pS\n", (void *)ip))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, *parent);
 	if (bit < 0)
 		return;
