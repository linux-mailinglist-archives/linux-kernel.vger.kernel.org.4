Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1B6B87EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCNB6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCNB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:58:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CE51633C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9234C615AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89529C4339C;
        Tue, 14 Mar 2023 01:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678759119;
        bh=G8RSycebZt3dD6O9pae5i1zOll+TP4NQkVvirx16U5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJ6o60P6vfHynwVAWVlEdshVJuLRDXM4LsT42GrnKOP7BRLiEhk9eVDo1najCZVtt
         AskJmJQ6fL5AQDDlKg5B90ToUmqTTsQnTXxilOFMwlc6Uu4mADASUiDzTdGSLiE7fX
         JItVplN7N/csXBVs4YkgahhIl2hLxQXbKJcnMktx//aV5IVN6X9Wcozz189Bu5t/gs
         fhGLZTXOFXcfGnL/aycIT7CbzrtxPeOjVimVcuvxxb+SQnp3EuAcDyZRxOEq7z5gMh
         I9j3plRrm8iHZWFwlbJtEj3YiJl2iLeksTYBnsihqWI1/6Vya2KCezcnrlBuBHSt+Z
         jD7kN20O4kQJA==
Date:   Mon, 13 Mar 2023 18:58:36 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
Message-ID: <20230314015836.p3l43w7ez7qzxylr@treble>
References: <cover.1678474914.git.jpoimboe@kernel.org>
 <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
 <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
 <20230311012004.vyc4kdlqjsv4zliw@treble>
 <20230312151731.GB1757905@hirez.programming.kicks-ass.net>
 <CABCJKuezD9sXTUTCecARUzfig+B=VirGBiVNM5bADvKLG3+YYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKuezD9sXTUTCecARUzfig+B=VirGBiVNM5bADvKLG3+YYw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:48:58AM -0700, Sami Tolvanen wrote:
> On Sun, Mar 12, 2023 at 8:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Mar 10, 2023 at 05:20:04PM -0800, Josh Poimboeuf wrote:
> > >   2) Create yet another "tier" of static call implementations, for
> > >      arches which can have the unfortunate combo of CFI_CLANG +
> > >      !HAVE_STATIC_CALL.  CONFIG_ALMOST_DONT_HAVE_STATIC_CALL?
> > >
> > >      The arch can define ARCH_DEFINE_STATIC_CALL_NOP() which uses inline
> > >      asm to create a CFI-compliant NOP/BUG/whatever version of the
> > >      function (insert lots of hand-waving).  Is the kcfi hash available
> > >      to inline asm at build time?
> >
> > Yes, clang creates magic symbol for everything it sees a declaration
> > for. This symbols can be referenced from asm, linking will make it all
> > work.
> >
> > And yes, C sucks, you can't actually create a function definition from a
> > type :/ Otherwise this could be trivially fixable.
> 
> Wouldn't creating a separate inline assembly nop function that
> references the CFI hash of another function with the correct type
> potentially solve this issue like Josh suggested?

Right, I was thinking something like this, where the nop function gets
generated by DEFINE_STATIC_CALL().

Completely untested of course...

#define STATIC_CALL_NOP_PREFIX		__SCN__
#define STATIC_CALL_NOP(name)		__PASTE(STATIC_CALL_NOP_PREFIX, name)
#define STATIC_CALL_NOP_STR(name)	__stringify(STATIC_CALL_NOP(name))

#define ARCH_DEFINE_STATIC_CALL_NOP(name, func)				\
	asm(".align 4						\n"	\
	    ".word __kcfi_typeid_" STATIC_CALL_NOP_STR(name) "  \n"	\
	    ".globl " STATIC_CALL_NOP_STR(name) "		\n"	\
	    STATIC_CALL_NOP_STR(name) ":			\n"	\
	    "bti c						\n"	\
	    "mov x0, xzr					\n"	\
	    "ret						\n"	\
	    ".type " STATIC_CALL_NOP_STR(name) ", @function	\n"	\
	    ".size " STATIC_CALL_NOP_STR(name) ", . - " STATIC_CALL_NOP_STR(name) " \n")

#define DECLARE_STATIC_CALL(name, func)					\
	extern struct static_call_key STATIC_CALL_KEY(name);		\
	extern typeof(func) STATIC_CALL_TRAMP(name)			\
	extern typeof(func) STATIC_CALL_NOP(name)

#define DEFINE_STATIC_CALL(name, _func, _func_init)			\
	DECLARE_STATIC_CALL(name, _func);				\
	ARCH_DEFINE_STATIC_CALL_NOP(name);				\
	struct static_call_key STATIC_CALL_KEY(name) = {		\
		.func = _func_init,					\
	}
-- 
Josh
