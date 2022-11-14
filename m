Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944CF627D38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbiKNL7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiKNL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:58:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A622122B35
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:56:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 599A1B80E7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC95C43147
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668427017;
        bh=rHSkLT53Nv/ib2Ggyg8R8XnjvwWSO7MjKfJFJvq+vrM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K61oir9HYVf2Kl8Zg7LLJaR9C4ZmEHf6qzWLLS9AMF8wizEZ8H7/a4VX1r88AuAYx
         0WUKhMnd/CEWXm7qXAVA9jBoOv1hObLlJpp5jLUNvWvwst134qw+2z1Dqv8ZijsjLd
         gyzi69ytG0c8KQN43Wm1pt7oxyBpUJ0fFzFPXk9jxqwRqBnR5TxjMZuzodU29ldtby
         M4kMNecm6R0aYj9hJIPpVTmhBzr7z3YaUIDCKVj1t2qVvwBBKjm/t1oEsJwSGXUZuK
         8TrVHBzxBjoihN7Bog9oMGJZKMTkwhmP2ajAsuGZwRECrQRXKsjpG2nZR5AAoz4U5E
         RyObfa0MZQyyQ==
Received: by mail-lf1-f50.google.com with SMTP id j4so18931799lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:56:56 -0800 (PST)
X-Gm-Message-State: ANoB5pnDwJNiOytS3PEzBsiEDNbmBjfvybLcnTARtd76pMPmk7U0Fxay
        AbWeyALn67pDDGthZnv4eolRks5rZiSwQAu+/Y8=
X-Google-Smtp-Source: AA0mqf7AocsadZ4cituWmBvSQIrolicmS9m21JD/aN183U53PFdMtTMBKNIlujCeLMb2MSkJgqsghK2SQHhMZaSGfQ4=
X-Received: by 2002:ac2:5044:0:b0:4b0:cca8:bdb3 with SMTP id
 a4-20020ac25044000000b004b0cca8bdb3mr4165197lfm.539.1668427014943; Mon, 14
 Nov 2022 03:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org>
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Nov 2022 12:56:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFqNvs2OvLJLi2CQYtPe4_BquHQg55F8J=oO76N9wRT9g@mail.gmail.com>
Message-ID: <CAMj1kXFqNvs2OvLJLi2CQYtPe4_BquHQg55F8J=oO76N9wRT9g@mail.gmail.com>
Subject: Re: [PATCH 00/46] gcc-LTO support for the kernel
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Borislav Petkov <bp@alien8.de>
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

You didn't cc me on that patch so I will reply here: I don't think
this is the right solution.
On x86, there is a lot of stuff injected into .head.text that simply
does not belong there, and getting rid of the __head annotation and
dropping __HEAD from the Xen pvh head.S file would be a much better
solution.
