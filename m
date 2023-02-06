Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9668C27F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBFQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBFQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:07:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8882CFFE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:07:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D383DB81261
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6351CC4339E;
        Mon,  6 Feb 2023 16:07:27 +0000 (UTC)
Date:   Mon, 6 Feb 2023 11:07:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jpoimboe@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        erhard_f@mailbox.org, mhiramat@kernel.org, sandipan.das@amd.com
Subject: Re: [PATCH v1.1 3/3] x86/static_call: Add support for Jcc
 tail-calls
Message-ID: <20230206110714.49fd7261@rorschach.local.home>
In-Reply-To: <CAKwvOdmE4bHdOr4TCm0EKrqKjMWk52NAkEOOd9JgsbUFaknOrw@mail.gmail.com>
References: <20230123205915.751729592@infradead.org>
        <20230123210607.173715335@infradead.org>
        <20230123174431.4421dfdf@gandalf.local.home>
        <Y8/X6fdRT80jssIf@hirez.programming.kicks-ass.net>
        <20230124100753.13608e1f@gandalf.local.home>
        <Y9Kdg9QjHkr9G5b5@hirez.programming.kicks-ass.net>
        <CAKwvOdmE4bHdOr4TCm0EKrqKjMWk52NAkEOOd9JgsbUFaknOrw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 10:14:49 -0800
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Jan 26, 2023 at 7:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jan 24, 2023 at 10:07:53AM -0500, Steven Rostedt wrote:  
> > > On Tue, 24 Jan 2023 14:06:49 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >  
> > > > > Just to confirm, as it's not clear if this is the static call site or one
> > > > > of the functions that is being called.  
> > > >
> > > > Ah, you've not looked at enough asm then? ;-) Yes this is the static
> > > > call site, see the __SCT_ target (instruction at 0x35d).  
> > >
> > > Yeah, could you specify it a bit more in the change log such that those
> > > looking back at this don't have to have that requirement of staring at
> > > enough asm ;-)  
> >
> > How's this then?

Better :-)

Anyway... Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> >
> > ---
> > Subject: x86/static_call: Add support for Jcc tail-calls
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri Jan 20 16:40:33 CET 2023
> >
> > Clang likes to create conditional tail calls like:
> >
> > 0000000000000350 <amd_pmu_add_event>:
> > 350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
> > 355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
> > 35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
> > 363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4  
> 
> If it helps reduce the line width in the commit message to focus on
> just the instructions, lately I've been using
> `--no-addresses --no-show-raw-insn` flags to llvm-objdump.

Actually, I like the full output. Even if we do reduce it, it will
still be over 80.

-- Steve
