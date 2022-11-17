Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB662D9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiKQLuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiKQLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:49:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D47E54B22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:49:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A878B82008
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB9EC43151
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685768;
        bh=/gvUDPMaBmVufSBFDI6VBbgyRnWOM3lrsRBBcgosYTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QESBDutZsdoSjbOM8sJbjS6yhsbNYzatlVYgRgEvDZ3r9fHuow3Bx6XmRrKxlS9xI
         +ilgZj+qGMqmQPHC2BhoP7MIzSEMzmBZ0wAKIB19Lu9J1sUMHfbckiNHtOrhIV++v/
         3qxbMIHXDbqGkFkLjPJhaIPBCXBGsFSOuHGXAbwrubaFy6dzah6vMpN/3Ocdj1Pbl+
         HFgYHLiHw22rMzNa2Rkkn8aBQi2AtDL7lvJo3vBrm8qT0kGO+3kxepssM7GQiOGdA6
         j2y/R7cLMSGYkIPvph+/o9ez1i07ahx4hRymnCKfypMOzrFp5HMdsenoeW4c33B2GB
         HZM9d/LgLpHag==
Received: by mail-lj1-f171.google.com with SMTP id s24so2335181ljs.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:49:27 -0800 (PST)
X-Gm-Message-State: ANoB5pnylcW5rlW0Hd47gt2zNcbp27I6LB9rwaTlxajspHrGWc/keMMv
        oQXYCm0vpoU7ARFD0nicxO2Q9r03vfkMsZhUrKc=
X-Google-Smtp-Source: AA0mqf6J84v+AALfD357A0LOsPLpe35ohYYvXYy8HiIo8l6yPvfp+xzAFd3daq77YO1trjeLIREPDUyWrJg1VPD30Tw=
X-Received: by 2002:a05:651c:1603:b0:26d:d603:8df2 with SMTP id
 f3-20020a05651c160300b0026dd6038df2mr807834ljq.189.1668685765600; Thu, 17 Nov
 2022 03:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org> <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
 <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net> <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
 <Y3YeQMAqCecwrIN1@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3YeQMAqCecwrIN1@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Nov 2022 12:49:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEkUN6ySsyaLVKqNzhRmfw9CfPYyQd_efRgLjCT9dS-yg@mail.gmail.com>
Message-ID: <CAMj1kXEkUN6ySsyaLVKqNzhRmfw9CfPYyQd_efRgLjCT9dS-yg@mail.gmail.com>
Subject: Re: [PATCH 00/46] gcc-LTO support for the kernel
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Biener <rguenther@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 at 12:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 17, 2022 at 08:50:59AM +0000, Richard Biener wrote:
> > On Thu, 17 Nov 2022, Peter Zijlstra wrote:
> >
> > > On Mon, Nov 14, 2022 at 08:40:50PM +0100, Ard Biesheuvel wrote:
> > > > On Mon, 14 Nov 2022 at 12:44, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > this is the first call for comments (and kbuild complaints) for this
> > > > > support of gcc (full) LTO in the kernel. Most of the patches come from
> > > > > Andi. Me and Martin rebased them to new kernels and fixed the to-use
> > > > > known issues. Also I updated most of the commit logs and reordered the
> > > > > patches to groups of patches with similar intent.
> > > > >
> > > > > The very first patch comes from Alexander and is pending on some x86
> > > > > queue already (I believe). I am attaching it only for completeness.
> > > > > Without that, the kernel does not boot (LTO reorders a lot).
> > > > >
> > > > > In our measurements, the performance differences are negligible.
> > > > >
> > > > > The kernel is bigger with gcc LTO due to more inlining.
> > > >
> > > > OK, so if I understand this correctly:
> > > > - the performance is the same
> > > > - the resulting image is bigger
> > > > - we need a whole lot of ugly hacks to placate the linker.
> > > >
> > > > Pardon my cynicism, but this cover letter does not mention any
> > > > advantages of LTO, so what is the point of all of this?
> > >
> > > Seconded; I really hate all the ugly required for the GCC-LTO
> > > 'solution'. There not actually being any benefit just makes it a very
> > > simple decision to drop all these patches on the floor.
> >
> > I'd say that instead a prerequesite for the series would be to actually
> > enforce hidden visibility for everything not part of the kernel module
> > API so the compiler can throw away unused functions.  Currently it has
> > to keep everything because with a shared object there might be external
> > references to everything exported from individual TUs.
>
> I'm not sure what you're on about; only symbols annotated with
> EXPORT_SYMBOL*() are accessible from modules (aka DSOs) and those will
> have their address taken. You can feely eliminate any unused symbol.
>
> > There was a size benefit mentioned for module-less monolithic kernels
> > as likely used in embedded setups, not sure if that's enough motivation
> > to properly annotate symbols with visibility - and as far as I understand
> > all these 'required' are actually such fixes.
>
> I'm not seeing how littering __visible is useful or desired, doubly so
> for that static hack, that's just a crude work around for GCC LTO being
> inferior for not being able to read inline asm.

We have an __ADDRESSABLE() macro and asmlinkage modifier to annotate
symbols that may appear to the compiler as though they are never
referenced.

Would it be possible to repurpose those so that the LTO code knows
which symbols it must not remove?
