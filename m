Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A3602F19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJRPCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiJRPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:02:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD667DBE47
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RyIN6JcFg11ojzMKFfKwxH5Uo96sHRxGb3mptzdSb68=; b=qioJ/9DaWHLiLNU//OmTvUAmrM
        TfpzgyChNc8/dNQe071xKgd/iBSsxtS0V8payuKcGzHvthcnAXde8M1uaekZ28QOYsb9ajBiljb8p
        MUscjhvALz0v5YeBWW//1MfOEy5UnfwX43/OUJpYH3ilTz9d7nL9demNOhhWc3+EiYXfqaLdh9vdj
        0ntFZcqiiQCbBCEjcnTjpKrQRUcmRtKdNSczUr+mGiO6LFo/dWpW58SUVbcz7uDJ6yuL5jFGK1cHH
        JAAMreNyiEHYpBH4dmrdc3CXl46RlPWnQkqfxl3M9vUsav7p/ey/HOgK2e1GLLkGA4z424e9/Xipc
        jFaNKvVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oko78-004Vq6-9t; Tue, 18 Oct 2022 15:02:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E510330008D;
        Tue, 18 Oct 2022 17:02:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C499B29AECB82; Tue, 18 Oct 2022 17:02:41 +0200 (CEST)
Date:   Tue, 18 Oct 2022 17:02:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] ftrace,kcfi: Separate ftrace_stub() and
 ftrace_stub_graph()
Message-ID: <Y07AEa7A73f1nDL1@hirez.programming.kicks-ass.net>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
 <20221018102100.5aa55644@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018102100.5aa55644@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:21:00AM -0400, Steven Rostedt wrote:
> On Tue, 18 Oct 2022 14:35:15 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Different function signatures means they needs to be different
> > functions; otherwise CFI gets upset.
> 
> This is due to this commit:
> 
> commit b83b43ffc6e4b514ca034a0fbdee01322e2f7022
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Tue Oct 15 09:00:55 2019 -0400
> 
>     fgraph: Fix function type mismatches of ftrace_graph_return using ftrace_stub
>     
>     The C compiler is allowing more checks to make sure that function pointers
>     are assigned to the correct prototype function. Unfortunately, the function
>     graph tracer uses a special name with its assigned ftrace_graph_return
>     function pointer that maps to a stub function used by the function tracer
>     (ftrace_stub). The ftrace_graph_return variable is compared to the
>     ftrace_stub in some archs to know if the function graph tracer is enabled or
>     not. This means we can not just simply create a new function stub that
>     compares it without modifying all the archs.
>     
>     Instead, have the linker script create a function_graph_stub that maps to
>     ftrace_stub, and this way we can define the prototype for it to match the
>     prototype of ftrace_graph_return, and make the compiler checks all happy!
> 
> 
> Perhaps its time to just modify all the archs and get rid of that hack.

Ideally yes, but given kCFI is in Linus' tree now, I didn't feel like
fixing up all archs in a hurry.

Mark mentioned that most archs can probably move to a common empty C
function for each stub.
