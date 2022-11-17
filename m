Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6F62DF88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiKQPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbiKQPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:20:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570D182
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:15:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20EFD62011
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C7C4314E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668698146;
        bh=RwPjK46hBhG/z8KciffmJpXKpjhudjj/pqsOhf2NjpQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iAZZYVLsfizMLK1l17ZafaWzd2HLx8Fqt2UJiYqVORIj1kO6q1KX9JDRj5DQLCH0F
         hl2iVIhDVqwfkaHQrEKRWnwhYvCjU2gWWq+MPUmUxsWbARYjbTPQ8iqp78lc/JmEIL
         6AqAxxWUdpjpJW+4eIxBseZrzg8GfjV5LSjxCNbJTj4H1bmte5weihTpDRB16ztJWk
         b5V1wf8CLMnOe0OvdethLoxxSaDiYtKNecB0KuM8ejmhzlnsl/hF3fRdMNiSiP+mTT
         iAh9ODEgYDj83sGVH9xhyiB8AuIEYRNL/uae+iAoKsHTAUjIVb/td8S9QIAek+iaRN
         VMu2X9DazKgwg==
Received: by mail-lf1-f51.google.com with SMTP id a29so3260867lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:15:46 -0800 (PST)
X-Gm-Message-State: ANoB5pmSQ27g4XTOCShuMO7A3xjeQQLzpW39VxaNn8VUB3xgbEvfDqSQ
        t9s/pqBuaoQQEthn5RvFdLtNb3YA/B1MJhLiinc=
X-Google-Smtp-Source: AA0mqf6JVPD5+t8a9KiypIcTcOL9vsDv7da9Egtsi3sHH+7+mLqZkj8vPRe3fYDoZyhYAYVBejehTnbXMsFbLeq+qws=
X-Received: by 2002:ac2:5ec9:0:b0:4a2:2aad:95c4 with SMTP id
 d9-20020ac25ec9000000b004a22aad95c4mr1209490lfq.110.1668698144338; Thu, 17
 Nov 2022 07:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org> <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
 <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net> <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
 <Y3YeQMAqCecwrIN1@hirez.programming.kicks-ass.net> <CAMj1kXEkUN6ySsyaLVKqNzhRmfw9CfPYyQd_efRgLjCT9dS-yg@mail.gmail.com>
 <nycvar.YFH.7.77.849.2211171331410.3995@jbgna.fhfr.qr>
In-Reply-To: <nycvar.YFH.7.77.849.2211171331410.3995@jbgna.fhfr.qr>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Nov 2022 16:15:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHkPm0okDHMZLcxjrtWRSHsUEimQLn_v7HRWrSaqfsipA@mail.gmail.com>
Message-ID: <CAMj1kXHkPm0okDHMZLcxjrtWRSHsUEimQLn_v7HRWrSaqfsipA@mail.gmail.com>
Subject: Re: [PATCH 00/46] gcc-LTO support for the kernel
To:     Richard Biener <rguenther@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 at 14:55, Richard Biener <rguenther@suse.de> wrote:
>
> On Thu, 17 Nov 2022, Ard Biesheuvel wrote:
>
...
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
>         static void * __used __attrs \
>                 __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
> #define __ADDRESSABLE(sym) \
>         ___ADDRESSABLE(sym, __section(".discard.addressable"))
>
> that should be enough to force LTO keeping 'sym' - unless there's
> a linker script that discards .discard.addressable which I fear LTO
> will notice, losing the effect.  A more direct way would be to attach
> __used to 'sym' directly.  __ADDRESSABLE doesn't seem to be used
> directly but instead I see cases like
>
> #define __define_initcall_stub(__stub, fn)                      \
>         int __init __stub(void);                                \
>         int __init __stub(void)                                 \
>         {                                                       \
>                 return fn();                                    \
>         }                                                       \
>         __ADDRESSABLE(__stub)
>
> where one could have added __used to the __stub prototypes instead?
>

Probably, yes.

But my point was not really about the implementation of those things,
more about whether we could redefine them to something else that would
help the compiler infer that this symbol needs to be retained.

asmlinkage in particular seems relevant, which is currently only used
for C++ inclusion or for setting regparm{0} on i386.
