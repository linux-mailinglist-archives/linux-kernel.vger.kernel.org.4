Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2D6C541A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCVSur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVSup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:50:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495E5D76D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1687EB81DC0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3390EC433D2;
        Wed, 22 Mar 2023 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679511041;
        bh=zQDvsghz0LmDmBxSWBS2Kvsa2ABxPjyk3rrZe6mRZCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqpHxo3dshaTsJE/R0fawh3YJebvXIERECmodzRObOzeqtVPFeA7UF6qL3bS/5umk
         Z9Q6u6m4iJiJx9gzkDQLMtqDW9PRfR2se7KabHDAkob+nYVzz2ZMb1cDBgvsj7vb99
         FIvGT+VBGlI7ynidoqAffUXObJVCwKT+CHsHB6nWOp0X54lk/R14ORKno58s9sQ/VP
         AZmcDtXakOgo7hGKGhkxGPq4XRoYb8qVfGBmCy+VyC/4NQ1sUvUpnrbLkilqhVAgJP
         MSZM85i7Z8SNu7i/83ujd/MsVvOF+M9HY5wieE5H68ZtVQXwuPTJCQIcmx5qL95Ma3
         c/aSHEJb0lGDA==
Date:   Wed, 22 Mar 2023 11:50:39 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 11/11] static_call: Remove DEFINE_STATIC_CALL_RET0()
Message-ID: <20230322185039.rqwudvaqgotfnrv5@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <8aab02492c2bf512c7ffe458e41acc1b930ed2dc.1679456900.git.jpoimboe@kernel.org>
 <692cf38b-4c13-f776-4b96-5161a4cae4ae@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <692cf38b-4c13-f776-4b96-5161a4cae4ae@csgroup.eu>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:04:31PM +0000, Christophe Leroy wrote:
> Le 22/03/2023 à 05:00, Josh Poimboeuf a écrit :
> > NULL and RET0 static calls are both slightly different ways of nopping a
> > static call.  A not-insignificant amount of code and complexity is spent
> > maintaining them separately.  It's also somewhat tricky for the user who
> > has to try to remember to use the correct one for the given function
> > type.
> > 
> > Simplify things all around by just combining them, such that NULL static
> > calls always return 0.
> > 
> > While it doesn't necessarily make sense for void-return functions to
> > return 0, it's pretty much harmless.  The return value register is
> > already callee-clobbered, and an extra "xor %eax, %eax" shouldn't affect
> > performance (knock on wood).
> 
> In the case of powerpc, which implements out-of-line static calls for 
> now, it is more than just an extra instruction. It requires a jump to 
> the couple instructions that clear ret reg and rets. For the 8xx it also 
> means cache miss as the cache lines are 16 bytes. So what was just one 
> cycle return instruction becomes a 3 cycles + 1 cache miss. It is not a 
> show-stopper for that change, but I think it was worth mentioning.

Good point.  I should mention that (if we keep the patch).

> > This "do nothing return 0" default should work for the vast majority of
> > NULL cases.  Otherwise it can be easily overridden with a user-specified
> > function which panics or returns 0xdeadbeef or does whatever one wants.
> > 
> > This simplifies the static call code and also tends to help simplify
> > users' code as well.
> 
> I'd have expected DEFINE_STATIC_CALL_RET0() to remain, to make it clear 
> that it returns 0. As you explained, it doesn't matter what NULL 
> returns, but returning 0 is vital four RET0 cases. So I would have 
> dropped DEFINE_STATIC_CALL_NULL() and retained DEFINE_STATIC_CALL_RET0().

The issue is static_call_update().  It takes NULL as an input, which
comes in handy for many static call users.  So it makes sense to have
NULL mean "nop (and return 0 if needed)".

IMO it becomes more confusing to have two interfaces (NULL and RET0)
meaning the same thing.

-- 
Josh
