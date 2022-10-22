Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93D608DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJVO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJVO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:57:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D4159949
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LfDdHQU4IT/hl9I/5HNnFT18wMtiD3dXD2LsNJVhO5Y=; b=dCyf9vlwvONBM4zSIsCL3Xkogn
        uhuZ7ki2qrs2doVxqulA1AE2JiYuCjEPz8IdtufwRps7O4skItg4W7b6DhivXsWUeYn06jdrezoRA
        cc7FhdHqiTTUJQZ/QiyFGxrzCbiOsWlEinzkbqP+vuySr6F7BFXavWD5WcH7D5AJ7DAQYWEyJ4Al6
        cMkJduq0RcpDGmDYiho+MtfVYgU0GUYFB9bOtkbiV0CidzQmY7ghM3dDUCh0iNOYrx0syawZm2wHw
        ZbW9EWrjF8WGHfM82My18SxLd9yLHpd0t7+tJQnWYbJHrLeqsnHx+9WC9uCpPZRfwChIclGKOGh4Z
        nIO6WG2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omFwD-00DzS4-Nz; Sat, 22 Oct 2022 14:57:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C40E30035C;
        Sat, 22 Oct 2022 16:57:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 192882C30ED69; Sat, 22 Oct 2022 16:57:19 +0200 (CEST)
Date:   Sat, 22 Oct 2022 16:57:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fangrui Song <maskray@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: kCFI && patchable-function-entry=M,N
Message-ID: <Y1QEzk/A41PKLEPe@hirez.programming.kicks-ass.net>
References: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:56:20PM +0100, Mark Rutland wrote:
> Hi,
> 
> For arm64, I'd like to use -fatchable-function-entry=M,N (where N > 0), for our
> ftrace implementation, which instruments *some* but not all functions.
> Unfortuntately, this doesn't play nicely with -fsanitize=kcfi, as instrumented
> and non-instrumented functions don't agree on where the type hash should live
> relative to the function entry point, making them incompatible with one another.
> AFAICT, there's no mechanism today to get them to agree.
> 
> Today we use -fatchable-function-entry=2, which happens to avoid this.

> ... but I understand that for x86, folk want the pre-function NOPs to
> fall-through into the body of the function.

Yep.

> Is there any mechanism today that we could use to solve this, or could we
> extend clang to have some options to control this behaviour?

So the main pain-point for you is differentiating between function with
notrace and those without it, right?

That is; suppose you (like x86) globally do:
-fpatchable-function-entry=4,2 to get a consistent function signature,
you're up a creek because you use the __patchable_function_entries
section to drive ftrace and now every function will have it.

So perhaps something like:

 -fpatchable-function-entry=N,M,sectionname

would help, then you can have notrace be the same layout, except a
different section. Eg. something like:

 #define notrace __attribute__((patchable_function_entry(4,2,__notrace_function_entries)))

It does make the whole: CFLAGS_REMOVE_file.o = $(CC_FLAGS_FTRACE)
a bit of a pain, but I've long favoured removing all that and having
explitic notrace attributes on all relevant functions.

Then again; perhaps it could be made to work by ensuring CFLAGS starts
with:

 -fpatchable-function-entry=4,2,__notrace_function_entries

and have CC_FLAGS_FTRACE include (and hence override with)

 -fpatchable-function-entry=4,2,__ftrace_function_entries

assuming that with duplicate argument the last is effective.
