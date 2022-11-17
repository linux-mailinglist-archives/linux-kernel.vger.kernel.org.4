Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B662DE74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiKQOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiKQOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:40:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C1769EC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:40:16 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 784F022789;
        Thu, 17 Nov 2022 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668696015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1kqm4NTuLqt4P5j0+BjzYHODH2usXp2+Kg4xoCqgvs=;
        b=Vlyas2QBo5dYyEWniYISh4gjJGw9UvUDJHmTlnKu38fYLU8fN9nL67Tfik1kocLVd6Xr+y
        sM6nTwVV25KlhpWxqkJzS2nFvwYiPOjW2CafRLRe+OpSH6A+pfefFJ075TfjeU/H3Za7oi
        rLfeC4ChFoJafD/LrKutFDVzcXxEhnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668696015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1kqm4NTuLqt4P5j0+BjzYHODH2usXp2+Kg4xoCqgvs=;
        b=QnDENqFIA3AkfxbL5NOqeccDMU0aBYI8wyXJa6sED6R2lKp0ET2fghrZQhiI2PJD7i0tlP
        Lt6OnsPZR4h0oRBA==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E30C92C141;
        Thu, 17 Nov 2022 14:40:14 +0000 (UTC)
Date:   Thu, 17 Nov 2022 14:40:14 +0000 (UTC)
From:   Richard Biener <rguenther@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Don Zickus <dzickus@redhat.com>, Hao Luo <haoluo@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Hubicka <jh@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Jiri Kosina <jikos@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Martin Liska <mliska@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Miroslav Benes <mbenes@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 00/46] gcc-LTO support for the kernel
In-Reply-To: <Y3ZGAf2rdV1Ia5P3@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.77.849.2211171434440.3995@jbgna.fhfr.qr>
References: <20221114114344.18650-1-jirislaby@kernel.org> <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com> <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net> <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
 <Y3YeQMAqCecwrIN1@hirez.programming.kicks-ass.net> <CAMj1kXEkUN6ySsyaLVKqNzhRmfw9CfPYyQd_efRgLjCT9dS-yg@mail.gmail.com> <nycvar.YFH.7.77.849.2211171331410.3995@jbgna.fhfr.qr> <Y3ZGAf2rdV1Ia5P3@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Peter Zijlstra wrote:

> On Thu, Nov 17, 2022 at 01:55:07PM +0000, Richard Biener wrote:
> 
> > > > I'm not sure what you're on about; only symbols annotated with
> > > > EXPORT_SYMBOL*() are accessible from modules (aka DSOs) and those will
> > > > have their address taken. You can feely eliminate any unused symbol.
> > 
> > But IIRC that's not reflected on the ELF level by making EXPORT_SYMBOL*()
> > symbols public and the rest hidden - instead all symbols global in the C TUs
> > will become public and the module dynamic loader details are hidden from
> > GCCs view of the kernel image as ELF relocatable object.
> 
> It is reflected by keeping their address in __ksymtab_$foo sections, as
> such their address 'escapes'.

That's not enough to make symbols not appearing in __ksymtab_$foo
sections eliminatable.

> > > We have an __ADDRESSABLE() macro and asmlinkage modifier to annotate
> > > symbols that may appear to the compiler as though they are never
> > > referenced.
> > > 
> > > Would it be possible to repurpose those so that the LTO code knows
> > > which symbols it must not remove?
> > 
> > I find
> > 
> > /*
> >  * Force the compiler to emit 'sym' as a symbol, so that we can reference
> >  * it from inline assembler. Necessary in case 'sym' could be inlined
> >  * otherwise, or eliminated entirely due to lack of references that are
> >  * visible to the compiler.
> >  */
> > #define ___ADDRESSABLE(sym, __attrs) \
> > 	static void * __used __attrs \
> > 		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
> > #define __ADDRESSABLE(sym) \
> > 	___ADDRESSABLE(sym, __section(".discard.addressable"))
> > 
> > that should be enough to force LTO keeping 'sym' - unless there's
> > a linker script that discards .discard.addressable which I fear LTO
> > will notice, losing the effect.
> 
> The initial LTO link pass will not discard .discard sections in order to
> generate a regular ELF object file. This object file is then fed to
> objtool and the kallsyms tool and eventually linked with the linker
> script in a multi-stage link pass.
> 
> Also see scripts/link-vmlinux.sh for all the horrible details.
> 
> > The folks who worked on LTO enablement of the kernel should know the
> > real issue better - I understand asm()s are a pain because GCC
> > refuses to parse the assembler string heuristically for used
> > symbols (but it can never be more than heuristics). 
> 
> I don't understand why it can't be more than heuristics; eventually the
> asm() contents end up in a real assembler and it has to make sense.
> 
> Might as well parse it directly -- isn't that what clang-ias does?

GCC doesn't have an integrated assembler and the actual assembler text
that's emitted is not known at the stage we need to know the symbol.
Which means for GCC it would be heuristics.

> > The issue with asm()s is not so much elimination (__used solves that)
> > but that GCC can end up moving the asm() and the refered to symbols to
> > different link-time units causing unresolved symbols for non-global
> > symbols.  -fno-toplevel-reorder should fix that at some cost.
> 
> I thought the whole point of LTO was that there was only a single link
> time unit, translate all the tus into intermadiate gunk and then collect
> the whole lot in one go.

that's what it does, but it fans out to parallelize the final compile,
dividing the whole lot again which is where this problem can appear
if GCC doesn't see that asm() X uses symbol Y.

Richard.

-- 
Richard Biener <rguenther@suse.de>
SUSE Software Solutions Germany GmbH, Frankenstrasse 146, 90461 Nuernberg,
Germany; GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman;
HRB 36809 (AG Nuernberg)
