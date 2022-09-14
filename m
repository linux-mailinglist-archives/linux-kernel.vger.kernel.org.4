Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7B5B7DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiINAEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiINAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:04:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E75E3B;
        Tue, 13 Sep 2022 17:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98951B81098;
        Wed, 14 Sep 2022 00:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC58AC433D6;
        Wed, 14 Sep 2022 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663113868;
        bh=IbWNm8TWsEybLA/doTsC+NxWcZ1R8re59yUytTi7OY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDLq/igGJLGYY/AdwxwVSROLBHeKWkQ8QyVf9+jd7610F7bQfNQ/9U6vyJjm6rlxJ
         ZWw6rgtoYqfoRcQ6Z95emsdgXICVpZ3vBqoWu5gFQjIrs+m1GPrpl7hupdT/uI+hVl
         5N1n+lhXwm1KsBlmlwjqBpUEuGPcpoNMHMKniM/b/CQFuVn+35/ClDrPcSdRZ1Ilnq
         srSwuqcjpy45BKBEUZjzUq1KvF/HxBWlRcLve3c1WcXlqZLqUpZTw1ZppL6VOZzkib
         rMGs4tzZunJAXrKQ6lth+b5E58NISRrkzNZFV5OBiJAlJXQiPJTcGhiSIZcxeSiV4B
         q34X3slfeMqqQ==
Date:   Wed, 14 Sep 2022 01:04:16 +0100
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michael Matz <matz@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>, linux-toolchains@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, "Jose E. Marchesi" <jemarch@gnu.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] Objtool toolchain proposal:
 -fannotate-{jump-table,noreturn}
Message-ID: <20220914000416.daxbgccbxwpknn2q@treble>
References: <20220909180704.jwwed4zhwvin7uyi@treble>
 <Yx8PcldkdOLN8eaw@nazgul.tnic>
 <alpine.LSU.2.20.2209121200120.8265@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.2209121200120.8265@wotan.suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:17:36PM +0000, Michael Matz wrote:
> Hey,

Hi Michael,

Thanks for looking at this.

> On Mon, 12 Sep 2022, Borislav Petkov wrote:
> 
> > Micha, any opinions on the below are appreciated.
> > 
> > On Fri, Sep 09, 2022 at 11:07:04AM -0700, Josh Poimboeuf wrote:
> 
> > > difficult to ensure correctness.  Also, due to kernel live patching, the
> > > kernel relies on 100% correctness of unwinding metadata, whereas the
> > > toolchain treats it as a best effort.
> 
> Unwinding certainly is not best effort.  It's 100% reliable as far as the 
> source language or compilation options require.  But as it doesn't 
> touch the discussed features I won't belabor that point.

Ok, maybe I had the wrong impression about the reliability of DWARF.

> I will mention that objtool's existence is based on mistrust, of persons 
> (not correctly annotating stuff) and of tools (not correctly heeding those 
> annotations).  The mistrust in persons is understandable and can be dealt 
> with by tools, but the mistrust in tools can't be fixed by making tools 
> more complicated by emitting even more information; there's no good reason 
> to assume that one piece of info can be trusted more than other pieces.  
> So, if you mistrust the tools you have already lost.  That's somewhat 
> philosophical, so I won't beat that horse much more either.

Maybe this is semantics, but I wouldn't characterize objtool's existence
as being based on the mistrust of tools.  It's main motivation is to
fill in the toolchain's blind spots in asm and inline-asm, which exist
by design.

(Objtool has actually found many compiler bugs, but that's a side
benefit and not its reason for existence.)

I understand the concern about trusting one piece of info more than
others, but we have to trust the toolchain.  Also, objtool does a lot of
consistency checks, and experience shows that if there's a bug in the
existing jump table or noreturn detection logic, it almost always
quickly surfaces as an objtool warning: unreachable instruction, stack
state mismatch, falling through the end of a function, etc.

> Now, recovering the CFG.  I'll switch order of your two items:
> 
> 2) noreturn function
> 
> > >   .pushsection .annotate.noreturn
> > >     .quad func1
> > >     .quad func2
> > >     .quad func3
> > >   .popsection
> 
> This won't work for indirect calls to noreturn functions:
> 
>   void (* __attribute__((noreturn)) noretptr)(void);
>   int callnoret (int i)
>   {
>     noretptr();
>     return i + 32;
>   }
> 
> The return statement is unreachable (and removed by GCC).  To know that 
> you would have to mark the call statements, not the individual functions.  
> All schemes that mark functions that somehow indicates a meaningful 
> difference in the calling sequence (e.g. the ABI of functions) have the 
> same problem: it's part of the call expressions type, not of individual 
> decls.
>
> Second problem: it's not extensible.  Today it's noreturn functions you 
> want to know, and tomorrow?  So, add a flag word per entry, define bit 0 
> for now to be NORETURN, and see what comes.  Add a header with a version 
> (and/or identifier) as well and it's properly extensible.  For easy 
> linking and identifying the blobs in the linked result include a length in 
> the header.  If this were in an allocated section it would be a good idea 
> to refer to the symbols in a PC-relative manner, so as to not result in 
> runtime relocations.  In this case, as it's within a non-alloc section 
> that doesn't matter.  So:
> 
> .section .annotate.functions
> .long 1       # version
> .long 0xcafe  # ident
> .long 2f-1f   # length
> 1:
> .quad func1, 1   # noreturn
> .quad func2, 1   # noreturn
> .quad func3, 32  # something_else_but_not_noreturn
> ...
> 2:
> .long 1b-2b   # align and "checksum"
> 
> It might be that the length-and-header scheme is cumbersome if you need to 
> write those section commands by hand, in which case another scheme might 
> be preferrable, but it should somehow be self-delimiting.
> 
> For the above problem of indirect calls to noreturns, instead do:
> 
>   .text
>   noretcalllabel:
>     call noreturn
>   othercall:
>     call really_special_thing
>   .section .annotate.noretcalls
>   .quad noretcalllabel, 1  # noreturn call
>   .quad othercall, 32      # call to some special(-ABI?) function
> 
> Same thoughts re extensibility and self-delimitation apply.

Hm, I didn't know noreturn function pointers were a thing.  Annotating
the call site instead of the function would be fine.

I'm thinking PC-relative relocs are a good idea regardless, it makes the
binary smaller even if the section isn't allocatable.

As far as extending goes, I had been thinking future annotation types
would just go in new sections, e.g. .annotate.retpolinecalls, each
section with its own format.  And that has the benefit of being a
simpler and easier to parse format (no headers, versions, lengths, etc).
But either way is fine I think.

> 
> 1) jump tables
> 
> > > Create an .annotate.jump_table section which is an array of the
> > > following variable-length structure:
> > > 
> > >   struct annotate_jump_table {
> > > 	void *indirect_jmp;
> > > 	long num_targets;
> > > 	void *targets[];
> > >   };
> 
> It's very often the case that the compiler already emits what your 
> .targets[] member would encode, just at some unknown place, length and 
> encoding.  So you would save space if you instead only remember the 
> encoding and places of those jump tables:
> 
> struct {
>   void *indirect_jump;
>   long num_tables;
>   struct {
>     unsigned num_entries;
>     unsigned encoding;
>     void *start_of_table;
>   } tables[];
> };
> 
> The usual encodings are: direct, PC-relative, relative-to-start-of-table.  
> Usually for a specific jump instruction there's only one table, so 
> optimizing for that makes sense.  For strange unthought-of cases it's 
> probably a good idea to have your initial scheme as fallback, which could 
> be indicated by a special .encoding value.
> 
> > > For example, given the following switch statement code:
> > > 
> > >   .Lswitch_jmp:
> > > 	// %rax is .Lcase_1 or .Lcase_2
> > > 	jmp %rax
> 
> So, usually %rax would point into a table (somewhere in .rodata/.text) 
> that looks like so:
> 
> .Ljump_table:
>  .quad .Lcase_1 - .Ljump_table
>  .quad .Lcase_2 - .Ljump_table
> 
> (for position-independend code)
> 
> and hence you would emit this as annotation:
> 
> .quad .Lswitch_jmp
> .quad 1                   # only a single table
> .long 2                   # with two entries
> .long RELATIVE_TO_START   # all entries are X - start_of_table
> .quad .Ljump_table
> 
> In this case you won't save anything of course, but as soon as there's a 
> meaningful number of cases you will.

As a user of the data, I would prefer a simpler format (something like
my original scheme) which uses more space, rather than needing headers,
fallback scheme, encodings, blob lengths, etc just to save some
non-allocatable bytes.  But the above seems fine.

-- 
Josh
