Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37A37486D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjGEOul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGEOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A98CE;
        Wed,  5 Jul 2023 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VYEraWXOTwXpHX08kViCcw6mgtGGGRN9twNakSMbyfw=; b=jt6iNqxvKQ2q+v9qNnQo70qyB9
        v2RbXHTP2ulOP2uawfD/i3PEhhnOL1/uhgCpCy6DPPudEYrQfbkd7snGg8RgNYZktPxyV276BsxLu
        EoOiaxGEHQmBMetHd7sfCq6mrGB51Xxv+2tbPwudEZsfu1gfunH9Xw9V7qoNyMJM+cO+BEheCfCme
        Lk77TyxlBwPoUE52nzqSPZ2gQfzII4W74erfoC//X2hg14e22E52GNJyF3fOCZMBkwXLhqAFgFIRU
        lcGVLtQXtfqCpvx4g9LoUzk6/GS0hzp56820u+WydJfAWo86PEFVJdi4ENrRrRFbdaDpXhShXxO1R
        r2ycMHew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qH3pj-00AAK1-Oi; Wed, 05 Jul 2023 14:50:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2460E300274;
        Wed,  5 Jul 2023 16:50:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 038C52025BA45; Wed,  5 Jul 2023 16:50:17 +0200 (CEST)
Date:   Wed, 5 Jul 2023 16:50:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-ID: <20230705145017.GC4253@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
 <20230705081547.25130-3-petr.pavlu@suse.com>
 <20230705085857.GG462772@hirez.programming.kicks-ass.net>
 <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:20:38PM +0900, Masami Hiramatsu wrote:
> On Wed, 5 Jul 2023 10:58:57 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Jul 05, 2023 at 10:15:47AM +0200, Petr Pavlu wrote:
> > > Functions can_optimize() and insn_is_indirect_jump() consider jumps to
> > > the range [__indirect_thunk_start, __indirect_thunk_end] as indirect
> > > jumps and prevent use of optprobes in functions containing them.
> > 
> > Why ?!? I mean, doing an opt-probe of an indirect jump/call instruction
> > itself doesn't really make sense and I can see why you'd want to not do
> > that. But why disallow an opt-probe if there's one in the function as a
> > whole, but not the probe target?
> 
> Here we need to clarify the reason why functions which have indirect jumps
> are not allowed to use opt-probe. Since optprobe can replace multiple 
> instructions with a jump, if any jmp (is used for jump inside same function)
> jumps to the second and subsequent instructions replaced by optprobe's jump,
> that target instruction can not be optimized.
> 
> The problem of indirect jump (which jumps to the same function) is that
> we don't know which addresses will be the target of the indirect jump.
> So, for safety, I disallow optprobe for such function. In that case, normal
> kprobe is used because it replaces only one instruction.

Ah, you're worried about jump-tables; you don't want to optimize across
a jump-table target because then things go *boom*.

There's two things:

 - when X86_KERNEL_IBT=y any indirect jump target should be an ENDBR
   instruction, so jump-table targets can be easily detected.

 - when RETPOLINE=y || X86_KERNEL_IBT=y we have jump-tables disabled,
   search for -fno-jump-table in arch/x86/Makefile.

At some point in the future we should be able to allow jump-tables for
RETPOLINE=n && IBT=y builds (provided the compilers behave), but we
currently don't bother to find out.

Therefore, when either CONFIG option is found, you can assume that any
indirect jump will be to another function.

> If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
> If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
> So the functions only have indirect call still allow optprobe.

With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
C indirect jump.
