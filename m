Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAC5B5C11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiILORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiILORo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:17:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A6032DBE;
        Mon, 12 Sep 2022 07:17:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 83F981FE0C;
        Mon, 12 Sep 2022 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662992257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqrvhpQ3mWLng9d136pXVwJMtcUckHlUhJDrbKwYJQM=;
        b=vMKXme+PgvRpa3Z7Okaijg3N67WXXkLEkIJXgyMGnTS6M7WKze0pDdwQd2PYEatmG/aTis
        9a7oEvrIi4xvVlHPLjA7xGRVgwr+zn/NNPFnU9UXFD2BRXZpF5NYRraVEYDi+TjwIhgLdi
        ypVCEZfqASkmSotrmG/z0eTZeo6mw8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662992257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqrvhpQ3mWLng9d136pXVwJMtcUckHlUhJDrbKwYJQM=;
        b=zDMIZbA7baVaORTiOesIp3hbiC2yrR/6dPTJYWIHURHCV6K1K6WO56Dx9oEhsuf2efml0u
        P5bpPhVy4QN0ulAw==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D36E22C141;
        Mon, 12 Sep 2022 14:17:36 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id C8A21636D; Mon, 12 Sep 2022 14:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id C6955607D;
        Mon, 12 Sep 2022 14:17:36 +0000 (UTC)
Date:   Mon, 12 Sep 2022 14:17:36 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-toolchains@vger.kernel.org,
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
In-Reply-To: <Yx8PcldkdOLN8eaw@nazgul.tnic>
Message-ID: <alpine.LSU.2.20.2209121200120.8265@wotan.suse.de>
References: <20220909180704.jwwed4zhwvin7uyi@treble> <Yx8PcldkdOLN8eaw@nazgul.tnic>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Mon, 12 Sep 2022, Borislav Petkov wrote:

> Micha, any opinions on the below are appreciated.
> 
> On Fri, Sep 09, 2022 at 11:07:04AM -0700, Josh Poimboeuf wrote:

> > difficult to ensure correctness.  Also, due to kernel live patching, the
> > kernel relies on 100% correctness of unwinding metadata, whereas the
> > toolchain treats it as a best effort.

Unwinding certainly is not best effort.  It's 100% reliable as far as the 
source language or compilation options require.  But as it doesn't 
touch the discussed features I won't belabor that point.

I will mention that objtool's existence is based on mistrust, of persons 
(not correctly annotating stuff) and of tools (not correctly heeding those 
annotations).  The mistrust in persons is understandable and can be dealt 
with by tools, but the mistrust in tools can't be fixed by making tools 
more complicated by emitting even more information; there's no good reason 
to assume that one piece of info can be trusted more than other pieces.  
So, if you mistrust the tools you have already lost.  That's somewhat 
philosophical, so I won't beat that horse much more either.

Now, recovering the CFG.  I'll switch order of your two items:

2) noreturn function

> >   .pushsection .annotate.noreturn
> >     .quad func1
> >     .quad func2
> >     .quad func3
> >   .popsection

This won't work for indirect calls to noreturn functions:

  void (* __attribute__((noreturn)) noretptr)(void);
  int callnoret (int i)
  {
    noretptr();
    return i + 32;
  }

The return statement is unreachable (and removed by GCC).  To know that 
you would have to mark the call statements, not the individual functions.  
All schemes that mark functions that somehow indicates a meaningful 
difference in the calling sequence (e.g. the ABI of functions) have the 
same problem: it's part of the call expressions type, not of individual 
decls.

Second problem: it's not extensible.  Today it's noreturn functions you 
want to know, and tomorrow?  So, add a flag word per entry, define bit 0 
for now to be NORETURN, and see what comes.  Add a header with a version 
(and/or identifier) as well and it's properly extensible.  For easy 
linking and identifying the blobs in the linked result include a length in 
the header.  If this were in an allocated section it would be a good idea 
to refer to the symbols in a PC-relative manner, so as to not result in 
runtime relocations.  In this case, as it's within a non-alloc section 
that doesn't matter.  So:

.section .annotate.functions
.long 1       # version
.long 0xcafe  # ident
.long 2f-1f   # length
1:
.quad func1, 1   # noreturn
.quad func2, 1   # noreturn
.quad func3, 32  # something_else_but_not_noreturn
...
2:
.long 1b-2b   # align and "checksum"

It might be that the length-and-header scheme is cumbersome if you need to 
write those section commands by hand, in which case another scheme might 
be preferrable, but it should somehow be self-delimiting.

For the above problem of indirect calls to noreturns, instead do:

  .text
  noretcalllabel:
    call noreturn
  othercall:
    call really_special_thing
  .section .annotate.noretcalls
  .quad noretcalllabel, 1  # noreturn call
  .quad othercall, 32      # call to some special(-ABI?) function

Same thoughts re extensibility and self-delimitation apply.

1) jump tables

> > Create an .annotate.jump_table section which is an array of the
> > following variable-length structure:
> > 
> >   struct annotate_jump_table {
> > 	void *indirect_jmp;
> > 	long num_targets;
> > 	void *targets[];
> >   };

It's very often the case that the compiler already emits what your 
.targets[] member would encode, just at some unknown place, length and 
encoding.  So you would save space if you instead only remember the 
encoding and places of those jump tables:

struct {
  void *indirect_jump;
  long num_tables;
  struct {
    unsigned num_entries;
    unsigned encoding;
    void *start_of_table;
  } tables[];
};

The usual encodings are: direct, PC-relative, relative-to-start-of-table.  
Usually for a specific jump instruction there's only one table, so 
optimizing for that makes sense.  For strange unthought-of cases it's 
probably a good idea to have your initial scheme as fallback, which could 
be indicated by a special .encoding value.

> > For example, given the following switch statement code:
> > 
> >   .Lswitch_jmp:
> > 	// %rax is .Lcase_1 or .Lcase_2
> > 	jmp %rax

So, usually %rax would point into a table (somewhere in .rodata/.text) 
that looks like so:

.Ljump_table:
 .quad .Lcase_1 - .Ljump_table
 .quad .Lcase_2 - .Ljump_table

(for position-independend code)

and hence you would emit this as annotation:

.quad .Lswitch_jmp
.quad 1                   # only a single table
.long 2                   # with two entries
.long RELATIVE_TO_START   # all entries are X - start_of_table
.quad .Ljump_table

In this case you won't save anything of course, but as soon as there's a 
meaningful number of cases you will.

Again, if that info would be put into an allocated section you would want 
to use relative encodings of the addresses to avoid runtime relocs.  And 
the remarks about self-delimitation and extensibility also apply here.

> > Alternatives
> > ------------
> > 
> > Another idea which has been floated in the past is for objtool to read
> > DWARF (or .eh_frame) to help it figure out the control flow.  That
> > hasn't been tried yet, but would be considerably more difficult and
> > fragile IMO.

While noreturn functions are marked in the debug info, noreturn 
function types currently aren't quite correct.  And jump-tables aren't 
marked at all, so that would lose.


Ciao,
Michael.
