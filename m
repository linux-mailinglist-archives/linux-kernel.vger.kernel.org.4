Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436C47492BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjGFArg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjGFArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA8171D;
        Wed,  5 Jul 2023 17:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4491617D1;
        Thu,  6 Jul 2023 00:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767ECC433C7;
        Thu,  6 Jul 2023 00:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688604449;
        bh=lQCNaknqsctPMwh5xkWdlQlbt6s32SgZ8UYnURcKZCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hZcKKxeaPoG3PuRs06XSBFbd4rJPydqxtqdf4lYwf1diJLXcuY6dQaQCpGsT15gV/
         5seM9FMnXK5j7ufmpvUR69zsDEZOBWP42gPwolTlZoYxhZpbjUPOQZ+G6VmyHTbJn6
         ixetbr9rKUM7b1vn06K/UEqBlACKm/vnkscGhgcCe9J/zMPr0PluFHMLielLMFKpMk
         8Avwn8m0L905PX4grCVms6QD88A1BfOT2sU80hYlTHKWDPkNecs3LsMT92fqVxFDSu
         P3Mtn1GMRoPlyyjmgyrhDkbWTTLGHZZP3x4/PFzBbZhFJNuKY5VI0aXGl522bZ5hJg
         9vM9a+hovUZuw==
Date:   Thu, 6 Jul 2023 09:47:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-Id: <20230706094723.6934105e03f652923796bf7e@kernel.org>
In-Reply-To: <20230705145017.GC4253@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
        <20230705081547.25130-3-petr.pavlu@suse.com>
        <20230705085857.GG462772@hirez.programming.kicks-ass.net>
        <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
        <20230705145017.GC4253@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 16:50:17 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 05, 2023 at 11:20:38PM +0900, Masami Hiramatsu wrote:
> > On Wed, 5 Jul 2023 10:58:57 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Jul 05, 2023 at 10:15:47AM +0200, Petr Pavlu wrote:
> > > > Functions can_optimize() and insn_is_indirect_jump() consider jumps to
> > > > the range [__indirect_thunk_start, __indirect_thunk_end] as indirect
> > > > jumps and prevent use of optprobes in functions containing them.
> > > 
> > > Why ?!? I mean, doing an opt-probe of an indirect jump/call instruction
> > > itself doesn't really make sense and I can see why you'd want to not do
> > > that. But why disallow an opt-probe if there's one in the function as a
> > > whole, but not the probe target?
> > 
> > Here we need to clarify the reason why functions which have indirect jumps
> > are not allowed to use opt-probe. Since optprobe can replace multiple 
> > instructions with a jump, if any jmp (is used for jump inside same function)
> > jumps to the second and subsequent instructions replaced by optprobe's jump,
> > that target instruction can not be optimized.
> > 
> > The problem of indirect jump (which jumps to the same function) is that
> > we don't know which addresses will be the target of the indirect jump.
> > So, for safety, I disallow optprobe for such function. In that case, normal
> > kprobe is used because it replaces only one instruction.
> 
> Ah, you're worried about jump-tables; you don't want to optimize across
> a jump-table target because then things go *boom*.
> 
> There's two things:
> 
>  - when X86_KERNEL_IBT=y any indirect jump target should be an ENDBR
>    instruction, so jump-table targets can be easily detected.
> 
>  - when RETPOLINE=y || X86_KERNEL_IBT=y we have jump-tables disabled,
>    search for -fno-jump-table in arch/x86/Makefile.
> 
> At some point in the future we should be able to allow jump-tables for
> RETPOLINE=n && IBT=y builds (provided the compilers behave), but we
> currently don't bother to find out.
> 
> Therefore, when either CONFIG option is found, you can assume that any
> indirect jump will be to another function.

OK, I confirmed that '-fno-jump-tables' is set when X86_KERNEL_IBT=y || RETPOLINE=y
so we can skip this indirect jump check. That makes things simpler.

> 
> > If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
> > If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
> > So the functions only have indirect call still allow optprobe.
> 
> With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
> C indirect jump.

If I understand correctly, kCFI is enabled by CFI_CLANG, and clang is not
using jump-tables by default, so we can focus on gcc. In that case
current check still work, correct?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
