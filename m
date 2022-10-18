Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CB602CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJRN1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiJRN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:26:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FCF55A157
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:26:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B135113E;
        Tue, 18 Oct 2022 06:26:20 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3685F3F792;
        Tue, 18 Oct 2022 06:26:13 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:26:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] ftrace,kcfi: Separate ftrace_stub() and
 ftrace_stub_graph()
Message-ID: <Y06pb6NseR0YxFir@lakrids>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
 <Y06ntk9uY5re23WX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06ntk9uY5re23WX@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:18:46PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 02:35:16PM +0200, Peter Zijlstra wrote:
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -162,6 +162,16 @@
> >  #define PATCHABLE_DISCARDS	*(__patchable_function_entries)
> >  #endif
> >  
> > +#ifndef ARCH_SUPPORTS_CFI_CLANG
> 
> #ifndef CONFIG_ARCH_..
> 
> works much better as we found.
> 
> > +/*
> > + * Simply points to ftrace_stub, but with the proper protocol.
> > + * Defined by the linker script in linux/vmlinux.lds.h
> > + */
> > +#define	FTRACE_STUB_HACK	ftrace_stub_graph = ftrace_stub;
> > +#else
> > +#define FTRACE_STUB_HACK
> > +#endif
> 
> Fixed up version available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/urgent

Thanks for this!

I've just tested that branch, (HEAD commit 586edc9c16e747ce). With kCFI
enabled I can run the ftrace boot tests and ftrace selftests without
issues.

FWIW:

  Reviewed-by: Mark Rutland <mark.rutland@arm.com>
  Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.
