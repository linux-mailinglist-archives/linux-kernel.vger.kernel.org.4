Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C421602F67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJRPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJRPP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:15:57 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD70386F98
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:15:56 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id o2so8802971qkk.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/y9qyGY5iRRsI0juheW5gC+VHaPihspfGREH3Qe0x8o=;
        b=404InUcM5IWIcXu/0AG8cxoKTDAEf0p6SbVk3gCRKnBY3NgPZSO1XeF90vGh50Vs2b
         sTHvsMlVrXKk9/9Pkl5+PKcTv2VDUhknobmOAByLyKpufjY0NgJTjSi7gRF5K3xlFl3t
         Y4qM6hQbQLn569kjORI1elTZSZuwheJJNZVXJnrlJ+FwfWDo4vqMuRahdXam7QPrGWPI
         XZoACmgSSctrqwCcYvRSnepfvUnCTyInUvhH6x3xxu1hpCkx2uOmQ8tCBvNTXw4cnf8S
         cWwMEQZi7NkvTQM1Ll9kAE4e5ZMOc9T+YANRx99loMgxhPyM5F+2z2s2dkY+iHaxB6nl
         Wnaw==
X-Gm-Message-State: ACrzQf12XyxpLvrS+k3EUUuAz8JKkg+xwO85BebVVRkiEz1w0rBvsuZv
        qi1bna26qWakMm4jgwaLuiZYweZ8IvkuU3Bp
X-Google-Smtp-Source: AMsMyM4PNVz3ioMra06j6XcnMHxq2LkQFDL04Y0MgO5iU4h8Of/CBRVVzYtOJHQvbX8j256dFkW7Dg==
X-Received: by 2002:a05:620a:2698:b0:6cf:38bb:f705 with SMTP id c24-20020a05620a269800b006cf38bbf705mr2228231qkp.130.1666106155627;
        Tue, 18 Oct 2022 08:15:55 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id bp17-20020a05620a459100b006ce3f1af120sm2653982qkb.44.2022.10.18.08.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 08:15:55 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id t186so17329028yba.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:15:54 -0700 (PDT)
X-Received: by 2002:a25:687:0:b0:6c2:2b0c:26e with SMTP id 129-20020a250687000000b006c22b0c026emr2856337ybg.202.1666106154019;
 Tue, 18 Oct 2022 08:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com> <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
 <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
 <mvmlepdb66h.fsf@suse.de> <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
 <Y065nbfVQwZhwt51@yury-laptop> <Y067uYGTaA93Hn3z@smile.fi.intel.com> <Y06/SipcWdh4uIqd@yury-laptop>
In-Reply-To: <Y06/SipcWdh4uIqd@yury-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Oct 2022 17:15:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjViT8-VMPuKZz2O1sudy5ogHpzVYM_P+isjRRUNgirw@mail.gmail.com>
Message-ID: <CAMuHMdVjViT8-VMPuKZz2O1sudy5ogHpzVYM_P+isjRRUNgirw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuri,

On Tue, Oct 18, 2022 at 5:01 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Tue, Oct 18, 2022 at 05:44:09PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 18, 2022 at 07:35:09AM -0700, Yury Norov wrote:
> > > On Tue, Oct 18, 2022 at 03:50:31PM +0200, Geert Uytterhoeven wrote:
> >
> > ...
> >
> > > For those who choose FORCE_NR_CPUS, it's required to set NR_CPUS
> > > to a value that matches to what's parsed from DT.
> > >
> > > Can you please look at the draft below that disables FORCE_NR_CPUS
> > > in allmodconfig? If it's OK with you, I'll send a patch. If you think
> > > that there are architectures where it's not possible to set correct
> > > NR_CPUS at compile time for some reason, I'll add ARCH_UNFORCE_NR_CPUS
> > > option.
> >
> > Instead you may simply add
> >
> >       depends on CONFIG_$ARCH/$MACHINE=n
> >
> > and so on to the FORCE_NR_CPUS, no?
>
> Yes, if there's just one machine like that. If there's many of them, the
> 'depends' list would be too long.
>
> I hope there's no such a weird machines, and we don't need that at
> all. Let's see what Geert will say.

I haven't tried the patch from your other email yet, but I did try
CONFIG_NR_CPUS=4 and CONFIG_FORCE_NR_CPUS=y on
Icicle earlier today.

There was no warning, as the number of CPUs did match, but the
fourth CPU (cpu@4, i.e. the fifth core in DT) failed to come online:

    CPU3: failed to come online
    smp: Brought up 1 node, 3 CPUs

BTW, it behaves the same with CONFIG_FORCE_NR_CPUS=n.
Increasing CONFIG_NR_CPUS (before I used 8) makes the fourth
CPU core come online again.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
