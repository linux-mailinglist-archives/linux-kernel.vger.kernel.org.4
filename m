Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA65EC788
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiI0PWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiI0PW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:22:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355C1406DC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A26F4B81B2B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7F4C433C1;
        Tue, 27 Sep 2022 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664292145;
        bh=QmLw/TjdTbZMk0yxbSJlr4Sq2FohgZRJCVBwkR7Rxow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kq2hZQmaa5BVFRi8SYTc/sPtaiRrDaGI1e/k738eny5YzoA+lDsX3pLzZkS6mT7gH
         Y/zWuYNZnPqy0dbG+pHRaNZUoemRv/h29eR5nU9QDIZ6tGdUhGKCkOTaJz/sHobyx5
         sgaomVNSSGcgJoJfNKz9YULPxBB8E62SaqyiTp/t4xGRpNqqbAdmB1XzesAZorm3kl
         Y9zWe1o3P+hkS1kTYhgIXTG9la3OF9RjXx6o9WkaEIOUDc9nBFGXJt/NPRcKxEmBNi
         13nWxfqCkq9tJKj9+dQwJ/525RWu0cSDO6XhJPxr02AgxkxuwoKYw+WZaX6VLoVEEi
         KH6mbVzuTrxGw==
Date:   Wed, 28 Sep 2022 00:22:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Liao Chang <liaochang1@huawei.com>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: Mark ftrace mcount handler functions nokprobe
Message-Id: <20220928002221.ddda8e26e3034180e33ad24e@kernel.org>
In-Reply-To: <20220926143723.73032f8c@gandalf.local.home>
References: <20220919084533.42318-1-liaochang1@huawei.com>
        <20220926143723.73032f8c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 14:37:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 19 Sep 2022 16:45:33 +0800
> Liao Chang <liaochang1@huawei.com> wrote:
> 
> > Mark ftrace mcount handler functions nokprobe since probing on these
> > functions probably reaches mcount recursivly during kprobe breakpoint
> > handler for some architecture(tested for riscv, arm64), and reenter
> > kprobe is treated as a fatal error, causes kernel panic.
> 
> This looks to me that the affected archs should be made more robust for this
> case than to add this to the generic code.

Yeah, kprobes (arch specific code) itself shouldn't be traced by ftrace usually.

Thank you,

> 
> -- Steve
> 
> 
> > 
> > Pesudo code below demonstrate this problem:
> > 
> >   mcount
> >     function_trace_call (probed)
> >       arch_breakpoint_handler
> >         arch_setup_singlestep [mcount]
> >           function_trace_call (probed)
> >             arch_breakpoint_handler
> >               reenter_kprobe
> >                 BUG
> > 
> > Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > ---
> >  kernel/trace/trace_functions.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > index 9f1bfbe105e8..440a678a8c7c 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/ftrace.h>
> >  #include <linux/slab.h>
> >  #include <linux/fs.h>
> > +#include <linux/kprobes.h>
> >  
> >  #include "trace.h"
> >  
> > @@ -194,6 +195,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
> >  
> >  	ftrace_test_recursion_unlock(bit);
> >  }
> > +NOKPROBE_SYMBOL(function_trace_call);
> >  
> >  #ifdef CONFIG_UNWINDER_ORC
> >  /*
> > @@ -245,6 +247,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
> >  	atomic_dec(&data->disabled);
> >  	local_irq_restore(flags);
> >  }
> > +NOKPROBE_SYMBOL(function_stack_trace_call);
> >  
> >  static inline bool is_repeat_check(struct trace_array *tr,
> >  				   struct trace_func_repeats *last_info,
> > @@ -321,6 +324,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
> >  out:
> >  	ftrace_test_recursion_unlock(bit);
> >  }
> > +NOKPROBE_SYMBOL(function_no_repeats_trace_call);
> >  
> >  static void
> >  function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
> > @@ -363,6 +367,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
> >  	atomic_dec(&data->disabled);
> >  	local_irq_restore(flags);
> >  }
> > +NOKPROBE_SYMBOL(function_stack_no_repeats_trace_call);
> >  
> >  static struct tracer_opt func_opts[] = {
> >  #ifdef CONFIG_STACKTRACE
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
