Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18FC628988
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiKNTlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:41:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BD639A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ECF8B8121C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F52C43150
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668454864;
        bh=Yjhrm1mQ85dvzm5GMKPRvPsHrvN6TqeEv0uHN02KC6E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gn1WBypSvjJPpzlJ1rm4/5OxXED9DYHuwe6qMg3AHoom2A8QCVb2rX2SLhrFKojEA
         A3ExNZHAvbSMJrb53EyX+a/5ArAvW4B00alUx1a90yXKOxqr8hZPDrkQwUUDsnFK+1
         0ghR2MdkSw4W4UxfMLgaDuXfdjTu9ctL5rMStGS/FwrGFB9QofJ+kY4MMtag1yTonQ
         BWcneVBSAsohLgIYXEzZictjHufXFA3t+Tr+aahhM1Z2nmyM1hrSNq0xY/BDpKwZsx
         bu/RL6mgFcME0RZrJqFqeRiyJFIr6795ymZ7H3UajjmbQqlY/NF5q38MGGfP22wtJP
         FOZcqNPdvz/0w==
Received: by mail-lj1-f182.google.com with SMTP id l8so14629243ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:41:04 -0800 (PST)
X-Gm-Message-State: ANoB5pn2RFzp6ad6m2Xnnn0ZHIkdSIZ83bmICuM7lyPk/N4mZZIy/PHu
        wjZL/QejglT5K7L6N9te+aM832ILKGVlzi1ZMak=
X-Google-Smtp-Source: AA0mqf7rtKr7xo6Am07iOSYE/iscRus1GuK+IwLKZdryln58hhCMAte7WsTFQH87tSL83fPSLKoApw8zKgRxr2TQ0ck=
X-Received: by 2002:a2e:2d09:0:b0:277:72a:41a5 with SMTP id
 t9-20020a2e2d09000000b00277072a41a5mr5233918ljt.352.1668454861882; Mon, 14
 Nov 2022 11:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org>
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Nov 2022 20:40:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
Message-ID: <CAMj1kXEMejnuMx1LJbfJj1+RUmZzZJNSmOVu_tWAbU6RXGqA3A@mail.gmail.com>
Subject: Re: [PATCH 00/46] gcc-LTO support for the kernel
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, 14 Nov 2022 at 12:44, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> Hi,
>
> this is the first call for comments (and kbuild complaints) for this
> support of gcc (full) LTO in the kernel. Most of the patches come from
> Andi. Me and Martin rebased them to new kernels and fixed the to-use
> known issues. Also I updated most of the commit logs and reordered the
> patches to groups of patches with similar intent.
>
> The very first patch comes from Alexander and is pending on some x86
> queue already (I believe). I am attaching it only for completeness.
> Without that, the kernel does not boot (LTO reorders a lot).
>
> In our measurements, the performance differences are negligible.
>
> The kernel is bigger with gcc LTO due to more inlining.

OK, so if I understand this correctly:
- the performance is the same
- the resulting image is bigger
- we need a whole lot of ugly hacks to placate the linker.

Pardon my cynicism, but this cover letter does not mention any
advantages of LTO, so what is the point of all of this?

(On Clang, LTO was needed for CFI, but this is not even the case anymore)
