Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08816B6778
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 16:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCLPRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCLPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 11:17:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D15034C17
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IH05YOgC0QbKFuRXRx3ttoZaPTMeWV+ZwKWO+BlyXxk=; b=amM6TfmJG4jTYObvckO8fAvhA3
        WDorHtYAF5ZPcIU20YE5rVyVHhPhC4UXrda+dIcQllC/bGvFFd6Z2u++dT49G4tt6oDgW4jn5yyON
        IFFj8Hecck7389vdagrJGn/hgWHiVY/azGWZTCmzfiinZ01sEXs2YZ7eT9Z2cDs5XSz66U901i8lf
        dJouaIhQCorUpDTOzfZ6QT0hbguAWZ7eisWhYF1xOX7jratfBFtQrkqLDVkLhC6qf3DotolXcf/gM
        5Qlxxavl5JCbqQ7dsff8XKFhFBMI2hT+tFhIxloduYb728LADvAkLAA9EGdMVK/WBBsuZFCS5DVGc
        3z0vb4RQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pbNS1-001355-3B;
        Sun, 12 Mar 2023 15:17:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F341F3006C4;
        Sun, 12 Mar 2023 16:17:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE5C120831B6A; Sun, 12 Mar 2023 16:17:31 +0100 (CET)
Date:   Sun, 12 Mar 2023 16:17:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
Message-ID: <20230312151731.GB1757905@hirez.programming.kicks-ass.net>
References: <cover.1678474914.git.jpoimboe@kernel.org>
 <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
 <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
 <20230311012004.vyc4kdlqjsv4zliw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311012004.vyc4kdlqjsv4zliw@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 05:20:04PM -0800, Josh Poimboeuf wrote:
> On Fri, Mar 10, 2023 at 09:59:26PM +0100, Peter Zijlstra wrote:
> > > -#define __static_call_cond(name)					\
> > > -({									\
> > > -	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
> > > -	if (!func)							\
> > > -		func = &__static_call_nop;				\
> > > -	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
> > > -})
> > 
> > So a sufficiently clever compiler can optimize the above to avoid the
> > actual indirect call (and resulting CFI violation, see below), because
> > __static_call_nop() is inline and hence visible as an empty stub
> > function. Currently none of the compilers are that clever :/
> 
> I won't hold my breath waiting for theoretical optimizations.

Well, I'm thinking the clang folks might like this option to unbreak the
arm64 build. At least here they have a fighting chance of actually doing
the right thing.

Let me Cc some actual compiler folks.

> > This will break ARM64 I think, they don't HAVE_STATIC_CALL but do have
> > CLANG_CFI, which means the above will end up being a runtime indirect
> > call to a non-matching signature function.
> > 
> > Now, I suppose we don't actually have this happen in current code by the
> > simple expedient of not actually having any static_call_cond() usage
> > outside of arch code.
> > 
> > (/me git-grep's some and *arrrggh* trusted-keys)
> > 
> > I really don't think we can do this though, must not promote CFI
> > violations.
> 
> Ouch, so static_call_cond() and __static_call_return0() are broken today
> on CFI_CLANG + arm64.

Yes. Now __static_call_return0() should really only happen when
HAVE_STATIC_CALL per the definition only being available in that case.

And static_call_cond() as implemented today *might* just be fixable by
the compiler.

> Some ideas:
> 
>   1) Implement HAVE_STATIC_CALL for arm64.  IIRC, this wasn't worth the
>      effort due to restricted branch ranges and CFI fun.

The powerpc32 thing did it, iirc a similar approach could work for arm.
But this would basically mandate HAVE_STATIC_CALL for CFI_CLANG.

> 
>   2) Create yet another "tier" of static call implementations, for
>      arches which can have the unfortunate combo of CFI_CLANG +
>      !HAVE_STATIC_CALL.  CONFIG_ALMOST_DONT_HAVE_STATIC_CALL?
> 
>      The arch can define ARCH_DEFINE_STATIC_CALL_NOP() which uses inline
>      asm to create a CFI-compliant NOP/BUG/whatever version of the
>      function (insert lots of hand-waving).  Is the kcfi hash available
>      to inline asm at build time?

Yes, clang creates magic symbol for everything it sees a declaration
for. This symbols can be referenced from asm, linking will make it all
work.

And yes, C sucks, you can't actually create a function definition from a
type :/ Otherwise this could be trivially fixable.

>   3) Use a jump label to bypass the static call instead of calling
>      __static_call_nop().  NOTE: I couldn't figure out how to do this
>      without angering the compiler, unless we want to change
>      static_call() back to the old-school interface:
> 
>         static_call(foo, args...)
> 
> Is it Friday yet?

Always right :-)

And yes, the whole premise of all this is that we let the compiler
generate the actuall CALL and then have objtool scan the output and
report the locations of them. There is no way to intercept this at the
compiler level.
