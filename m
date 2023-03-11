Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4AD6B5750
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCKBUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCKBUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:20:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E3612A4EE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20A3AB8245D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B341C433D2;
        Sat, 11 Mar 2023 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678497606;
        bh=sKbG3MQKdPbLwJTx2MzYM40c5a0enhMPpaVRIoJw/M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckHF6AhTt1wbxFGpg/Qaj0hXwrFs04EIiBrppjDl44XXSzNMlzwC8vjG5uFrIYzld
         1VHtYd6ynCEG6Kiyj8RkTR7gP/iQzOeR4Uh6qDB3y62/5wgA1XZP4N4b6zp7ZnXAZ6
         10MWsaj2msH47qw/qIayeZW1Jhq3dddsIZgj72Va7L7k5TaNR/v+Yt1oJPBFsG+zqu
         n/lrBGsujFZiOJsyAoa1UIXBM7goexqU+jZVNzy344KGBvM4OpsQMVgHFawTVNYXhV
         W9IvNXggzEhP20wgs0N9SNEIR2rHlcxwM4k2+zAvFMv3xGFvwGPgXbjQMv0yaNLzqS
         SnyBCuczdjJGg==
Date:   Fri, 10 Mar 2023 17:20:04 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [RFC][PATCH 1/5] static_call: Make NULL static calls consistent
Message-ID: <20230311012004.vyc4kdlqjsv4zliw@treble>
References: <cover.1678474914.git.jpoimboe@kernel.org>
 <016c1e9cbdf726a885a406ff6baed85087ad1213.1678474914.git.jpoimboe@kernel.org>
 <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310205926.GB1605437@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:59:26PM +0100, Peter Zijlstra wrote:
> > -#define __static_call_cond(name)					\
> > -({									\
> > -	void *func = READ_ONCE(STATIC_CALL_KEY(name).func);		\
> > -	if (!func)							\
> > -		func = &__static_call_nop;				\
> > -	(typeof(STATIC_CALL_TRAMP(name))*)func;				\
> > -})
> 
> So a sufficiently clever compiler can optimize the above to avoid the
> actual indirect call (and resulting CFI violation, see below), because
> __static_call_nop() is inline and hence visible as an empty stub
> function. Currently none of the compilers are that clever :/

I won't hold my breath waiting for theoretical optimizations.

> This will break ARM64 I think, they don't HAVE_STATIC_CALL but do have
> CLANG_CFI, which means the above will end up being a runtime indirect
> call to a non-matching signature function.
> 
> Now, I suppose we don't actually have this happen in current code by the
> simple expedient of not actually having any static_call_cond() usage
> outside of arch code.
> 
> (/me git-grep's some and *arrrggh* trusted-keys)
> 
> I really don't think we can do this though, must not promote CFI
> violations.

Ouch, so static_call_cond() and __static_call_return0() are broken today
on CFI_CLANG + arm64.

Some ideas:

  1) Implement HAVE_STATIC_CALL for arm64.  IIRC, this wasn't worth the
     effort due to restricted branch ranges and CFI fun.

  2) Create yet another "tier" of static call implementations, for
     arches which can have the unfortunate combo of CFI_CLANG +
     !HAVE_STATIC_CALL.  CONFIG_ALMOST_DONT_HAVE_STATIC_CALL?

     The arch can define ARCH_DEFINE_STATIC_CALL_NOP() which uses inline
     asm to create a CFI-compliant NOP/BUG/whatever version of the
     function (insert lots of hand-waving).  Is the kcfi hash available
     to inline asm at build time?

  3) Use a jump label to bypass the static call instead of calling
     __static_call_nop().  NOTE: I couldn't figure out how to do this
     without angering the compiler, unless we want to change
     static_call() back to the old-school interface:

        static_call(foo, args...)

Is it Friday yet?

-- 
Josh
