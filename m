Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2FC602E44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJROVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJROVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B21E715
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E603615B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB3C433C1;
        Tue, 18 Oct 2022 14:20:59 +0000 (UTC)
Date:   Tue, 18 Oct 2022 10:21:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] ftrace,kcfi: Separate ftrace_stub() and
 ftrace_stub_graph()
Message-ID: <20221018102100.5aa55644@gandalf.local.home>
In-Reply-To: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
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

On Tue, 18 Oct 2022 14:35:15 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Different function signatures means they needs to be different
> functions; otherwise CFI gets upset.

This is due to this commit:

commit b83b43ffc6e4b514ca034a0fbdee01322e2f7022
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Tue Oct 15 09:00:55 2019 -0400

    fgraph: Fix function type mismatches of ftrace_graph_return using ftrace_stub
    
    The C compiler is allowing more checks to make sure that function pointers
    are assigned to the correct prototype function. Unfortunately, the function
    graph tracer uses a special name with its assigned ftrace_graph_return
    function pointer that maps to a stub function used by the function tracer
    (ftrace_stub). The ftrace_graph_return variable is compared to the
    ftrace_stub in some archs to know if the function graph tracer is enabled or
    not. This means we can not just simply create a new function stub that
    compares it without modifying all the archs.
    
    Instead, have the linker script create a function_graph_stub that maps to
    ftrace_stub, and this way we can define the prototype for it to match the
    prototype of ftrace_graph_return, and make the compiler checks all happy!


Perhaps its time to just modify all the archs and get rid of that hack.

Ideally, all the archs should be switched over to the FTRACE_WITH_ARGS and
we can get rid of all of this. But that may be asking for too many ponies.

At the very least, perhaps we should just make all the archs define a
ftrace_stub_graph that need it and add a new CONFIG_HAVE.. that allows us to
remove some of this from the core code.

-- Steve
