Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74761FC66
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiKGR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiKGR7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:59:06 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422529C87
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:55:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id l2so7298307qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=txnqL8BcE2RRAo21gLgkdDMpojWqsMMMnFuwGP+yEnI=;
        b=Bn/PA42/xq/GpLo/zOBhqTPpFJHuoYg09pjDkvjl0BPNa37aNPb4KczjBKqfEdRyYX
         3OPYpwkgNHcwInED8kN5kZ0Ja+ghNCnEXmbS0DcRAdcXFIXI+B1qMbHIOFTBzdsf8vAz
         AjNccSZTYJFTgWippEn+/nYATOaqZs+mK45kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txnqL8BcE2RRAo21gLgkdDMpojWqsMMMnFuwGP+yEnI=;
        b=uZaRo7Ep/9C4CBpEM208t0Ty523wO4v6jiTh/kjdrphYghGfv61O7msoANF68bxDHd
         nFdagi/f+WSUj5etEU0fZ62+Xrj4j8iuwygkQqfKsUtAR1Guvc4P/TDYCumhQv8tMSmn
         G6rXfmcEBG9JfR4JRBcyHTO6JzUk82aBcDDrz7MoOH0bBpd8zcHYI+xGFCabmv/iJ/yR
         6vzfM80MzKjiUfNn+c2L9V7roVx4y6SAQXQRGZLskfC1QivYJSpVhQZM3TfkaKftKfci
         8yPiwFZPB9yokjQx5Ees7OPRCIY6fSo4reQlDqg7mMllNHPdSyg2jcZHp5bLxLpXuoHe
         Semw==
X-Gm-Message-State: ACrzQf0t6Jvt3X0kmciyKiaWga/Smss36IFqgAuTWbAjmsd9NoFax0if
        QPS/wbz+/mWrBOJi2N6Vw0HWcNIyu6a+Og==
X-Google-Smtp-Source: AMsMyM6+nVWU7Puml6DGWwPwDYwPJXXiqdChPF9BCLw/1+7EWkz5azGIC/lIP+oFYcVwppxABzre4w==
X-Received: by 2002:ac8:6b46:0:b0:3a5:57f1:5159 with SMTP id x6-20020ac86b46000000b003a557f15159mr17301584qts.421.1667843756161;
        Mon, 07 Nov 2022 09:55:56 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bj17-20020a05620a191100b006ef1a8f1b81sm7358928qkb.5.2022.11.07.09.55.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:55:53 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3321c2a8d4cso111876357b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:55:50 -0800 (PST)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr41550793ywf.441.1667843750307; Mon, 07
 Nov 2022 09:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20221019225939.1646349-1-yury.norov@gmail.com>
 <xhsmhtu3evcme.mognet@vschneid.remote.csb> <Y2WT5qVi+YU2VEXU@yury-laptop> <xhsmhzgd3lyqx.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhzgd3lyqx.mognet@vschneid.remote.csb>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 09:55:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSVUpjh0UZW+w0C633gQo=-JhGH9ja8kUmRW0TUcSMpw@mail.gmail.com>
Message-ID: <CAHk-=wjSVUpjh0UZW+w0C633gQo=-JhGH9ja8kUmRW0TUcSMpw@mail.gmail.com>
Subject: Re: [PATCH v2] cpumask: limit visibility of FORCE_NR_CPUS
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 4:45 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
> True, this would have been neater as a single config, but AIUI it's a
> required "trick" for allyesconfig. I would have expected other configs to
> have hit similar issues in the past, but didn't find any.

Actually, the standard trick for allmodconfig and allyesconfig is to
use the "COMPILE_TEST" config variable.

It's basically a variable for "I'm not going to *run* the result, but
I want to make sure to get build coverage".

And both allmodconfig and allyesconfig set that config option.

In most cases, the "COMPILE_TEST" config variable is used to enable
things that wouldn't make sense on the chosen hardware platform, so
you have things like

        depends on ARCH_DAVINCI || COMPILE_TEST

because some driver only makes sense on ARCH_DAVINCI, but people still
want the build coverage.

But sometimes it's used the other way around, so fro example on x86 we have

     config X86_DECODER_SELFTEST

which explicitly depends on COMPILE_TEST *not* being set, because it's
a test that takes forever to run (particularly for huge kernels), and
so it's actually disabled for the  common all{yes,mod}config cases.

Same goes for things like LTO_CLANG_FULL. It's just expensive for big
build tests, plus causes too many issues for now.

End result: if some option actually *reduces* test coverage, or has
some other reason why it makes no sense for build tests, use that

        depends on !COMPILE_TEST

to not have allmodconfig and allyesconfig pick it.

                    Linus
