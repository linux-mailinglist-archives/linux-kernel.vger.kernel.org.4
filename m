Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299B05BE24B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiITJrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiITJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:47:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65256B643
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=azdZdV3AR7IkkOYGI+SGk1E2LDC8whYXJpybxcPmEwI=; b=XPVXBMb5gW7SHWTkad7kpCKKkN
        vft8+a694wRB5sCZUJNkkJg48FPFKl4TxgeTBvuwVGxXsuHoEBZfRRcccrK9YpZ8Enc4ZJqUuH0/5
        Jydc4lbYoc/mxqgqLxesz18zSebwo+qYFK5qSzzuvPPvMTQyTFqzQZJr+ZVnWohuO2BVUwqA/ibiI
        1mne6WRcjM87dEPdWROzgYVffKUurDrkZ+Mczpg32fu+pORpf5s5dNwSqg+3kiRVTMydYIkFmd4SH
        +gVKo+u1/9l2zD4xj/2OlHVnYJBRj1D2drSx0tLjR3oxdWv5OrKv/mzqLAd7dyWKbFuopHTTI98D8
        ecrN+zbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaZqU-005QN5-QI; Tue, 20 Sep 2022 09:47:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52A943001FD;
        Tue, 20 Sep 2022 11:47:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E8392BAC7A86; Tue, 20 Sep 2022 11:47:11 +0200 (CEST)
Date:   Tue, 20 Sep 2022 11:47:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] x86/syscalls: allow tracing of __do_sys_[syscall]
 functions
Message-ID: <YymMH7UnCyqruuch@hirez.programming.kicks-ass.net>
References: <20220913135213.720368-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913135213.720368-1-namit@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 06:52:13AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Tracing - through ftrace function tracer and kprobes - of certain common
> syscall functions is currently disabled. Setting kprobes on these
> functions is specifically useful for debugging of syscall failures.
> 
> Such tracing is disabled since __do_sys_[syscall] functions are declared
> as "inline".  "inline" in the kernel is actually defined as a macro that
> in addition to using the inline keyword also disables tracing (notrace).
> According to the comments in the code, tracing inline functions can
> wreck havoc, which is probably true in some cases.
> 
> In practice, however, this might be too extensive. The compiler regards
> the "inline" keyword only as a hint, which it is free to ignore. In
> fact, in my builds gcc ignores the "inline" hint for many
> __do_sys_[syscall] since some of these functions are quite big and
> called from multiple locations (for compat). As a result, these
> functions cannot be traced.
> 
> There are 3 possible solutions for enabling the tracing of
> __do_sys_[syscall]:
> 
> 1. Mark __do_sys_[syscall] as __always_inline instead of inline. This
>    would increase the executable size, which might not be desired.
> 
> 2. Remove the inline hint from __do_sys_[syscall]. Again, it might
>    affect the generated code, inducing function call overhead for some
>    syscalls.
> 
> 3. Remove "notrace" from the "inline" macro definition, and require
>    functions that cannot be traced to be marked explicitly as "notrace".
>    This might be the most correct solution, which would also enable tracing
>    of additional useful functions. But finding the functions that cannot
>    be traced is not easy without some automation.
> 
> 4. Avoid the use of "notrace" specifically for __do_sys_[syscall].
> 
> Use the last approach to enable the tracing of __do_sys_[syscall]
> functions. Introduce an "inline_trace" macro that sets the "__inline"
> keyword without "notrace". Use it for the syscall wrappers.
> 
> This enables the tracing of 54 useful functions on my build, for
> instance, __do_sys_vmsplice(), __do_sys_mremap() and
> __do_sys_process_madvise().
> 
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>

So at least for x86 these functions cannot be inlined, at all times the
syscalls are laundered through the syscall table.

It is very hard to take the address of an inline function and stuff it
in a table.

Additionally, all indirect syscall table calls are in instrumentable
code, so tracing should not be an issue -- again speaking for x86.

For the above suggestions:

  #1 above should refuse to build IMO, one shouldn't be allowed to take
  the address of an __always_inline function.

  #2 purely x86 speaking -- I don't see an issue with just taking the
  'inline' keyword away entirely.

  #3 I think Steve's concern is that the tracability of a function then
  depends on the compiler's whim -- but yeah, who cares ;-)

  #4 not a fan, but I also don't see anything wrong with it -- from x86
  pov.


IOW, please figure out why these things are inline to begin with; this
might require auditing all architecture syscall code. While doing that
audit, make sure to determine if all of them can handle tracing at these
points.

