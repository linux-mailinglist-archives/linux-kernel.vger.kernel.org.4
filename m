Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68562DE25
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiKQOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKQOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:32:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9BA7343E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xczmDwmQvJMb2yHeLKnzAiVojFRoCjmU/lJyxAeUCfo=; b=DlrPE0ohbgfwGz+QbRL4xQODrz
        uCzWMWCyxRepnrE0xrZVut1sTeol+lTRUp7OVRc66PN/4w/zsjLkbv/6n55nxn/gHHISzcJ/fFX6o
        d5OC99H+jke3vttkc11eJdmeG0EemdehGvn+OHHTxZE7vWCzl4wu402nEA2jb2vyQ/f5+kCjrXQ8J
        l4viWrts58wE9VTEjaMkqJGvqvF7KXadIP49CrSblduJFd5J4sDGmDUr8nvyT7sabuHfTgYWMnStB
        JPgBXWQmQI+g+YTi6icWI/3ec9s7Cl8kwbg89T7h938nIZXW5bYAQE9uUYhqYsq95JRx3U/R/T3Ry
        iOFqIjfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovfwQ-001hS9-9W; Thu, 17 Nov 2022 14:32:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9A81300454;
        Thu, 17 Nov 2022 15:32:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD3D12C12E8FD; Thu, 17 Nov 2022 15:32:33 +0100 (CET)
Date:   Thu, 17 Nov 2022 15:32:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Richard Biener <rguenther@suse.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <Y3ZGAf2rdV1Ia5P3@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
 <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
 <Y3YeQMAqCecwrIN1@hirez.programming.kicks-ass.net>
 <CAMj1kXEkUN6ySsyaLVKqNzhRmfw9CfPYyQd_efRgLjCT9dS-yg@mail.gmail.com>
 <nycvar.YFH.7.77.849.2211171331410.3995@jbgna.fhfr.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.77.849.2211171331410.3995@jbgna.fhfr.qr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 01:55:07PM +0000, Richard Biener wrote:

> > > I'm not sure what you're on about; only symbols annotated with
> > > EXPORT_SYMBOL*() are accessible from modules (aka DSOs) and those will
> > > have their address taken. You can feely eliminate any unused symbol.
> 
> But IIRC that's not reflected on the ELF level by making EXPORT_SYMBOL*()
> symbols public and the rest hidden - instead all symbols global in the C TUs
> will become public and the module dynamic loader details are hidden from
> GCCs view of the kernel image as ELF relocatable object.

It is reflected by keeping their address in __ksymtab_$foo sections, as
such their address 'escapes'.

> > We have an __ADDRESSABLE() macro and asmlinkage modifier to annotate
> > symbols that may appear to the compiler as though they are never
> > referenced.
> > 
> > Would it be possible to repurpose those so that the LTO code knows
> > which symbols it must not remove?
> 
> I find
> 
> /*
>  * Force the compiler to emit 'sym' as a symbol, so that we can reference
>  * it from inline assembler. Necessary in case 'sym' could be inlined
>  * otherwise, or eliminated entirely due to lack of references that are
>  * visible to the compiler.
>  */
> #define ___ADDRESSABLE(sym, __attrs) \
> 	static void * __used __attrs \
> 		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
> #define __ADDRESSABLE(sym) \
> 	___ADDRESSABLE(sym, __section(".discard.addressable"))
> 
> that should be enough to force LTO keeping 'sym' - unless there's
> a linker script that discards .discard.addressable which I fear LTO
> will notice, losing the effect.

The initial LTO link pass will not discard .discard sections in order to
generate a regular ELF object file. This object file is then fed to
objtool and the kallsyms tool and eventually linked with the linker
script in a multi-stage link pass.

Also see scripts/link-vmlinux.sh for all the horrible details.

> The folks who worked on LTO enablement of the kernel should know the
> real issue better - I understand asm()s are a pain because GCC
> refuses to parse the assembler string heuristically for used
> symbols (but it can never be more than heuristics). 

I don't understand why it can't be more than heuristics; eventually the
asm() contents end up in a real assembler and it has to make sense.

Might as well parse it directly -- isn't that what clang-ias does?

> The issue with asm()s is not so much elimination (__used solves that)
> but that GCC can end up moving the asm() and the refered to symbols to
> different link-time units causing unresolved symbols for non-global
> symbols.  -fno-toplevel-reorder should fix that at some cost.

I thought the whole point of LTO was that there was only a single link
time unit, translate all the tus into intermadiate gunk and then collect
the whole lot in one go.
