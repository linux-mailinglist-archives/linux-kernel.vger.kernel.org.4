Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2694A62D57D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiKQIvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiKQIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:51:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339D51301
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:51:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A2822228B5;
        Thu, 17 Nov 2022 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668675060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbgsIrs+bZ9iovtRdSQCKoVjk+AKuPaJdvditHit2RA=;
        b=AY3fjItgBpSZyc9SXC/fV8iI0exxRfeouBLgpNBBGTwdMxzCbmb1Ld3pi2GGVupI4DILJ7
        FTrwQOUQliqufCT8DYtfJLhuhI9goiKF7wbLitOj5Sy+19XlqFEu5vetAlgRTwFPCDVjpx
        HsXjYwnMmRmBzWqxGh2OfekNMFmM3Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668675060;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbgsIrs+bZ9iovtRdSQCKoVjk+AKuPaJdvditHit2RA=;
        b=j+8OvQeIpYpnk0GD8bGyWYZgelfz3m0h+Ifhiy4UMsxavf7ByLKHVQJUleUUDdDYih5oda
        Rj0N7YwnZCDpSWDQ==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D52B42C141;
        Thu, 17 Nov 2022 08:50:59 +0000 (UTC)
Date:   Thu, 17 Nov 2022 08:50:59 +0000 (UTC)
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
In-Reply-To: <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
References: <20221114114344.18650-1-jirislaby@kernel.org> <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com> <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net>
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

> On Mon, Nov 14, 2022 at 08:40:50PM +0100, Ard Biesheuvel wrote:
> > On Mon, 14 Nov 2022 at 12:44, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > this is the first call for comments (and kbuild complaints) for this
> > > support of gcc (full) LTO in the kernel. Most of the patches come from
> > > Andi. Me and Martin rebased them to new kernels and fixed the to-use
> > > known issues. Also I updated most of the commit logs and reordered the
> > > patches to groups of patches with similar intent.
> > >
> > > The very first patch comes from Alexander and is pending on some x86
> > > queue already (I believe). I am attaching it only for completeness.
> > > Without that, the kernel does not boot (LTO reorders a lot).
> > >
> > > In our measurements, the performance differences are negligible.
> > >
> > > The kernel is bigger with gcc LTO due to more inlining.
> > 
> > OK, so if I understand this correctly:
> > - the performance is the same
> > - the resulting image is bigger
> > - we need a whole lot of ugly hacks to placate the linker.
> > 
> > Pardon my cynicism, but this cover letter does not mention any
> > advantages of LTO, so what is the point of all of this?
> 
> Seconded; I really hate all the ugly required for the GCC-LTO
> 'solution'. There not actually being any benefit just makes it a very
> simple decision to drop all these patches on the floor.

I'd say that instead a prerequesite for the series would be to actually
enforce hidden visibility for everything not part of the kernel module
API so the compiler can throw away unused functions.  Currently it has
to keep everything because with a shared object there might be external
references to everything exported from individual TUs.

There was a size benefit mentioned for module-less monolithic kernels
as likely used in embedded setups, not sure if that's enough motivation
to properly annotate symbols with visibility - and as far as I understand
all these 'required' are actually such fixes.

Richard.
