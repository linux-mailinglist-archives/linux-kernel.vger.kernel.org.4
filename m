Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E973E6B8F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCNKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:07:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D4D637F0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UhNG5EsPzvXcugPTgElM83NtlmYHJO2EfIokoYjYuVg=; b=FuwWuRz3CXDjwatUD38yQSf3gr
        gO4RvOZE0ZKdrF8lY9fjGq/Z/JuUBLen4d1TZUfTusEo+MoX+Fc0Op/k6nfVLttBz8Ls6G2d4znBV
        6Tg88rFC85VmI1KVNQ821lN/AyAO0lFNbXKYAeIayKSD06dp2QqIsrEl6s8neBKwk4lUjdgr7gI7q
        OAlhLy1MFVNSbePiCBfz2iIUwQ07hprSp4twRNFOnzOZEEwJn7g4QsHfMcxL2cf6mwNyJjJkMQL5S
        buOwN7Ya3xO4hY2iQ7gJTQ/lkt0zSWqNQxujsEN5fGGsvLmGi/9/BwYLTlg2JgY2Osn9wB/rrJUrz
        RAGtJftA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc1YS-001jpU-12;
        Tue, 14 Mar 2023 10:06:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CE9B300269;
        Tue, 14 Mar 2023 11:06:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B34223B4E89C; Tue, 14 Mar 2023 11:06:51 +0100 (CET)
Date:   Tue, 14 Mar 2023 11:06:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
Message-ID: <20230314100651.GD1845660@hirez.programming.kicks-ass.net>
References: <cover.1678474914.git.jpoimboe@kernel.org>
 <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
 <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
 <20230311012004.vyc4kdlqjsv4zliw@treble>
 <20230312151731.GB1757905@hirez.programming.kicks-ass.net>
 <CABCJKuezD9sXTUTCecARUzfig+B=VirGBiVNM5bADvKLG3+YYw@mail.gmail.com>
 <20230314015836.p3l43w7ez7qzxylr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314015836.p3l43w7ez7qzxylr@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 06:58:36PM -0700, Josh Poimboeuf wrote:
> On Mon, Mar 13, 2023 at 10:48:58AM -0700, Sami Tolvanen wrote:
> > On Sun, Mar 12, 2023 at 8:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Fri, Mar 10, 2023 at 05:20:04PM -0800, Josh Poimboeuf wrote:
> > > >   2) Create yet another "tier" of static call implementations, for
> > > >      arches which can have the unfortunate combo of CFI_CLANG +
> > > >      !HAVE_STATIC_CALL.  CONFIG_ALMOST_DONT_HAVE_STATIC_CALL?
> > > >
> > > >      The arch can define ARCH_DEFINE_STATIC_CALL_NOP() which uses inline
> > > >      asm to create a CFI-compliant NOP/BUG/whatever version of the
> > > >      function (insert lots of hand-waving).  Is the kcfi hash available
> > > >      to inline asm at build time?
> > >
> > > Yes, clang creates magic symbol for everything it sees a declaration
> > > for. This symbols can be referenced from asm, linking will make it all
> > > work.
> > >
> > > And yes, C sucks, you can't actually create a function definition from a
> > > type :/ Otherwise this could be trivially fixable.
> > 
> > Wouldn't creating a separate inline assembly nop function that
> > references the CFI hash of another function with the correct type
> > potentially solve this issue like Josh suggested?

Yes it would, and the below looks about right. It's just a shame the C
language itself cannot sanely express that. Also, having a ton of silly
little nop functions is daft, but alas.

> Right, I was thinking something like this, where the nop function gets
> generated by DEFINE_STATIC_CALL().
> 
> Completely untested of course...
> 
> #define STATIC_CALL_NOP_PREFIX		__SCN__
> #define STATIC_CALL_NOP(name)		__PASTE(STATIC_CALL_NOP_PREFIX, name)
> #define STATIC_CALL_NOP_STR(name)	__stringify(STATIC_CALL_NOP(name))
> 
> #define ARCH_DEFINE_STATIC_CALL_NOP(name, func)				\
> 	asm(".align 4						\n"	\

IIRC arm64 just changed (or is about to) their alignment muck. I think
you can write this like:

	    ".balign " __stringify(CONFIG_FUNCTION_ALIGNMENT) " \n"	\

or somesuch...

> 	    ".word __kcfi_typeid_" STATIC_CALL_NOP_STR(name) "  \n"	\
> 	    ".globl " STATIC_CALL_NOP_STR(name) "		\n"	\
> 	    STATIC_CALL_NOP_STR(name) ":			\n"	\
> 	    "bti c						\n"	\
> 	    "mov x0, xzr					\n"	\
> 	    "ret						\n"	\
> 	    ".type " STATIC_CALL_NOP_STR(name) ", @function	\n"	\
> 	    ".size " STATIC_CALL_NOP_STR(name) ", . - " STATIC_CALL_NOP_STR(name) " \n")
> 
> #define DECLARE_STATIC_CALL(name, func)					\
> 	extern struct static_call_key STATIC_CALL_KEY(name);		\
> 	extern typeof(func) STATIC_CALL_TRAMP(name)			\
> 	extern typeof(func) STATIC_CALL_NOP(name)
> 
> #define DEFINE_STATIC_CALL(name, _func, _func_init)			\
> 	DECLARE_STATIC_CALL(name, _func);				\
> 	ARCH_DEFINE_STATIC_CALL_NOP(name);				\
> 	struct static_call_key STATIC_CALL_KEY(name) = {		\
> 		.func = _func_init,					\
> 	}
> -- 
> Josh
