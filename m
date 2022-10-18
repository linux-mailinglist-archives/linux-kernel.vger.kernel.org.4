Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABD602CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiJRNVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJRNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:20:57 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A5C8958
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:20:55 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id f22so9578040qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PX4pHfoVlPrXyEFQ1vXdFbAyOB+LHOVxTyBiqphn7oI=;
        b=A74K/McHbdP8YT6t0aRhsRhj+u0fviNeBmAq2GQ6xsWAbpHUpoBwYdRS4GiyozuGcK
         SCHa+LI9AhuwErrYk6W8GullKH6V6DXjedUTQLXf9iaOH6lGv6ljTnxXiWQzEm4yLCb7
         8Krla3yXwpZ5fkVIoY7o14DqQpzEMp40hlG7RyBzmQHwowuvRWsBOUoWqBlF2N9uicHC
         EjALIfjHuA4esyPsdumxYC0FM+j+T0eIwxOHWuJgu/pKwSHqcygYzuiztGmnqS3mSs6+
         SYSLGIH7NZGqhnv2Oc5AV1XQoEcF7yrEIXqWV9gZ0AMRrDq3XhmAROSFVj5Npg+VEPbt
         sIHQ==
X-Gm-Message-State: ACrzQf0seF538o10AbLDxH1AwAiP9ejXjVCdK/MizEmGXu+tjX0l2B9P
        oxTgv7/LkU9NsNGzZ6jv8URd9nHNRLekpDK6
X-Google-Smtp-Source: AMsMyM73pdC1VCR+6iQuzDVnCfbuufUbM/W1PGjk/fJoI/sIb8chAUsIzFtGSJ3NlY/z1GpBIOOTeg==
X-Received: by 2002:ac8:57c4:0:b0:39c:c931:4f71 with SMTP id w4-20020ac857c4000000b0039cc9314f71mr2046411qta.15.1666099254272;
        Tue, 18 Oct 2022 06:20:54 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x7-20020ac85387000000b0039cc944ebdasm1912426qtp.54.2022.10.18.06.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:20:54 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 81so16935485ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:20:54 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr2207331ybb.604.1666098944657; Tue, 18
 Oct 2022 06:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com> <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Oct 2022 15:15:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
Message-ID: <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Tue, Oct 18, 2022 at 10:21 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Sep 6, 2022 at 1:10 AM Yury Norov <yury.norov@gmail.com> wrote:
> > The size of cpumasks is hard-limited by compile-time parameter NR_CPUS,
> > but defined at boot-time when kernel parses ACPI/DT tables, and stored in
> > nr_cpu_ids. In many practical cases, number of CPUs for a target is known
> > at compile time, and can be provided with NR_CPUS.
> >
> > In that case, compiler may be instructed to rely on NR_CPUS as on actual
> > number of CPUs, not an upper limit. It allows to optimize many cpumask
> > routines and significantly shrink size of the kernel image.
> >
> > This patch adds FORCE_NR_CPUS option to teach the compiler to rely on
> > NR_CPUS and enable corresponding optimizations.
> >
> > If FORCE_NR_CPUS=y, kernel will not set nr_cpu_ids at boot, but only check
> > that the actual number of possible CPUs is equal to NR_CPUS, and WARN if
> > that doesn't hold.
> >
> > The new option is especially useful in embedded applications because
> > kernel configurations are unique for each SoC, the number of CPUs is
> > constant and known well, and memory limitations are typically harder.
> >
> > For my 4-CPU ARM64 build with NR_CPUS=4, FORCE_NR_CPUS=y saves 46KB:
> >   add/remove: 3/4 grow/shrink: 46/729 up/down: 652/-46952 (-46300)
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
>
> Thanks for your patch, which is now commit 6f9c07be9d020489
> ("lib/cpumask: add FORCE_NR_CPUS config option") in v6.1-rc1.
>
> FORCE_NR_CPUS is enabled for e.g. an allmodconfig kernel, which I
> believe now makes it unsafe to boot such a kernel on any system that
> does not have exactly CONFIG_NR_CPUS CPU cores?
>
> If my assumption is true, this really needs some protection to prevent
> enabling this option inadvertently, as it is quite common to boot
> allmodconfig kernels for testing.

Moreover, this cannot be used on all systems.  E.g. on Icicle Kit with
Microchip PolarFire SoC, CONFIG_NR_CPUS needs to be larger than 4,
as the system has actually 5 CPU cores (1xE51 and 4xU54), but Linux
runs only on 4 of them.  So you cannot use FORCE_NR_CPUS=y.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
