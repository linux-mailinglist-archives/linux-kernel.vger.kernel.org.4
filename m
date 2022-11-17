Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFA62D9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiKQLsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiKQLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:48:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6659179
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:48:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668685697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQRVxv4eDJN1w5/JmXIKbLq1cQLNQYpFeLVVJODDHV4=;
        b=og2a+MD1g6dE80MLtdn0Iy7bvkmimzOmW6gGuLVNBJGUcnMNjoeO/NgpKBw8kKMSUL52dj
        lPgoRhPZyjHAOHHWbwk2GoIZuprGLMHaiCmyIdC2Scav2SYT8hlSZ5lIsgkmMtf58ANgVI
        7jopDWcL0LONzmMrK5WAJX8FBcDxWPR6FDrGRPoA1nF0mDzhVpSIqxLDqUkqpfbienga7Y
        V5KTbcamtxRe65doq9mZgPBlmSlt6TrGL4JlkP9t3+xqnBe8AdDDRJ92JC1sFBR6A1O3P8
        VyUBU+P20EEbKx+WXizKUEl4uXTXDxM6CAcIGub8AxfHfBq9jWmJN1CuRSGpfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668685697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQRVxv4eDJN1w5/JmXIKbLq1cQLNQYpFeLVVJODDHV4=;
        b=fFbYefAwWydI9Eoyrx/NoI9ndxShrxy+0QsiypTqReObRJ6SiOI4J14NnipkDct+WqWhAS
        8KIMQVKuuTDKQUDw==
To:     Richard Biener <rguenther@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
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
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 00/46] gcc-LTO support for the kernel
In-Reply-To: <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
 <Y3XwkFWJhcwApm4I@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.77.849.2211170847400.3995@jbgna.fhfr.qr>
Date:   Thu, 17 Nov 2022 12:48:17 +0100
Message-ID: <87iljdn6ny.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17 2022 at 08:50, Richard Biener wrote:
> On Thu, 17 Nov 2022, Peter Zijlstra wrote:
>> Seconded; I really hate all the ugly required for the GCC-LTO
>> 'solution'. There not actually being any benefit just makes it a very
>> simple decision to drop all these patches on the floor.
>
> I'd say that instead a prerequesite for the series would be to actually
> enforce hidden visibility for everything not part of the kernel module
> API so the compiler can throw away unused functions.  Currently it has
> to keep everything because with a shared object there might be external
> references to everything exported from individual TUs.
>
> There was a size benefit mentioned for module-less monolithic kernels
> as likely used in embedded setups, not sure if that's enough motivation
> to properly annotate symbols with visibility - and as far as I understand
> all these 'required' are actually such fixes.

To accomodate a broken tool which cannot figure out which functions are
referenced in the final lump and which are not, right?

Can we pretty please fix the tool instead of proliferating the
brokenness?

Thanks,

        tglx
