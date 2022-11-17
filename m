Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E362D9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiKQLnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiKQLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:43:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32BA4B981
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JX9mNjEmsW62eiRcIwZIkLu17ge5BNv5zRaNDLlV3HA=; b=LR9+2Dbxn89cUivADHS7D5DKys
        x2PgMJmDClYkJp08aWpXORlJnAKNtEhPYEFZN2hArX4/xkpGd6vmAm1k6Drpm41sCe7N0aEj1wUYL
        acovvXKvD8/h/uxHjmXd6etyht1uEZF8lparJpiuS8IjceYaVZZo59bpwM/xID54k+sZTSYEmFLEw
        13d5JkUUq+jEzV6j7SkBFWXnkScvv5eGPbBx7c0mdu3wjsQ6SQjuqn8tGt4SyKP4yUgD0bdSucRTC
        zfLtH2RLWwlfgks2NQaq/9pnQyQeCzmW3320KncHbTGYNsH3gu48JN9a4uBP+nJNqB86sPAplf+CV
        QLHL8PnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovdIO-000y4h-2a; Thu, 17 Nov 2022 11:43:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1447C300462;
        Thu, 17 Nov 2022 12:42:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3DB420B639A1; Thu, 17 Nov 2022 12:42:56 +0100 (CET)
Date:   Thu, 17 Nov 2022 12:42:56 +0100
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
        Richard Biener <RGuenther@suse.com>,
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
Message-ID: <Y3YeQMAqCecwrIN1@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
 <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:50:59AM +0000, Richard Biener wrote:
> On Thu, 17 Nov 2022, Peter Zijlstra wrote:
> 
> > On Mon, Nov 14, 2022 at 08:40:50PM +0100, Ard Biesheuvel wrote:
> > > On Mon, 14 Nov 2022 at 12:44, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > this is the first call for comments (and kbuild complaints) for this
> > > > support of gcc (full) LTO in the kernel. Most of the patches come from
> > > > Andi. Me and Martin rebased them to new kernels and fixed the to-use
> > > > known issues. Also I updated most of the commit logs and reordered the
> > > > patches to groups of patches with similar intent.
> > > >
> > > > The very first patch comes from Alexander and is pending on some x86
> > > > queue already (I believe). I am attaching it only for completeness.
> > > > Without that, the kernel does not boot (LTO reorders a lot).
> > > >
> > > > In our measurements, the performance differences are negligible.
> > > >
> > > > The kernel is bigger with gcc LTO due to more inlining.
> > > 
> > > OK, so if I understand this correctly:
> > > - the performance is the same
> > > - the resulting image is bigger
> > > - we need a whole lot of ugly hacks to placate the linker.
> > > 
> > > Pardon my cynicism, but this cover letter does not mention any
> > > advantages of LTO, so what is the point of all of this?
> > 
> > Seconded; I really hate all the ugly required for the GCC-LTO
> > 'solution'. There not actually being any benefit just makes it a very
> > simple decision to drop all these patches on the floor.
> 
> I'd say that instead a prerequesite for the series would be to actually
> enforce hidden visibility for everything not part of the kernel module
> API so the compiler can throw away unused functions.  Currently it has
> to keep everything because with a shared object there might be external
> references to everything exported from individual TUs.

I'm not sure what you're on about; only symbols annotated with
EXPORT_SYMBOL*() are accessible from modules (aka DSOs) and those will
have their address taken. You can feely eliminate any unused symbol.

> There was a size benefit mentioned for module-less monolithic kernels
> as likely used in embedded setups, not sure if that's enough motivation
> to properly annotate symbols with visibility - and as far as I understand
> all these 'required' are actually such fixes.

I'm not seeing how littering __visible is useful or desired, doubly so
for that static hack, that's just a crude work around for GCC LTO being
inferior for not being able to read inline asm.
