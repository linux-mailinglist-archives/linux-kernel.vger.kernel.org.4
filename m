Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0162D506
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiKQI2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiKQI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:28:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138C8729BE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NNbNOwbcUMHNS/7bdatGU27KOLFjcCDm3+xJi7GtDC0=; b=hC6iPKJY6glbHhdE1Bp6WRha0d
        mKKJIGEP/FeAZFXUUpITJng8JyaIqt05TwzACd5kfaZvY16QEljkpXzta4UQPAGHZVKc2TH6dzpsz
        To87fPuqRA6/wX7/x6AUC1baXFt5U/sRlXEmwwmx/nakdSHiUgWC+9rX7u46XyckUspnh36tlIsP1
        DBR7jgtp+xmeDzKhbgmJ3JisEDbdyaI+Kdvrs3FwPlMwSqkH8+W2jsu4ZZnngc71AhFKvIXgvVcvj
        XP+jt9ha75z0rB+tJxeubQNq0A4z11aFRQoXHwGiPnmqNFnKwSm7fDc844P/Xx5OvNrIvr3sT4o/E
        Vf/RCLTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovaFj-000nuI-38; Thu, 17 Nov 2022 08:28:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55722300E52;
        Thu, 17 Nov 2022 09:28:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3896C200FC693; Thu, 17 Nov 2022 09:28:00 +0100 (CET)
Date:   Thu, 17 Nov 2022 09:28:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
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
Message-ID: <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:40:50PM +0100, Ard Biesheuvel wrote:
> On Mon, 14 Nov 2022 at 12:44, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> >
> > Hi,
> >
> > this is the first call for comments (and kbuild complaints) for this
> > support of gcc (full) LTO in the kernel. Most of the patches come from
> > Andi. Me and Martin rebased them to new kernels and fixed the to-use
> > known issues. Also I updated most of the commit logs and reordered the
> > patches to groups of patches with similar intent.
> >
> > The very first patch comes from Alexander and is pending on some x86
> > queue already (I believe). I am attaching it only for completeness.
> > Without that, the kernel does not boot (LTO reorders a lot).
> >
> > In our measurements, the performance differences are negligible.
> >
> > The kernel is bigger with gcc LTO due to more inlining.
> 
> OK, so if I understand this correctly:
> - the performance is the same
> - the resulting image is bigger
> - we need a whole lot of ugly hacks to placate the linker.
> 
> Pardon my cynicism, but this cover letter does not mention any
> advantages of LTO, so what is the point of all of this?

Seconded; I really hate all the ugly required for the GCC-LTO
'solution'. There not actually being any benefit just makes it a very
simple decision to drop all these patches on the floor.


