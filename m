Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD63A5EEB36
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiI2BtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiI2Bsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:48:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62B311F111;
        Wed, 28 Sep 2022 18:48:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y20so7615plb.2;
        Wed, 28 Sep 2022 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/OCOFJ8yv8vLyEipobOYLNhRBPMRQlwFwa2A4JKCMIw=;
        b=l29wlCP/wt3ggiGMnqSwW33X979kGAbDJ14z7ZLpEYdQhusOJ6foHm3gsVG2w5KWSX
         deeKGiHkwjR7xNdSnc7Y0hcn6NCgAj5qoqvioaiNcjsVfskqDdOTZPUcaBgQBrriRRGa
         SlWLGTZNqQTHA3+1PTFg4zv/VdjUOh9bNwFVQ3fDU7hFF1nwXXy7NbzwYK0L9M3kIzO/
         YRtlJho4GEKPjBJlav4+XWAk1W7krE0NNPB5BS4JuZNlJnkOYsk5QQc7+yqr/lySA/GQ
         +HbZUTXq6E4LMCCf+RDXrlzTpfVDE/OMYaPV640DDuRkKLsgo6Og6HB4qMxX9ALTggfq
         hBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/OCOFJ8yv8vLyEipobOYLNhRBPMRQlwFwa2A4JKCMIw=;
        b=HPy+tiLQCpp02FuDyiTc2JJ7GhbxftdB4btLX3xJjZIjulLYwsMakDgumlXqs0lIhr
         rMhrZrWxSVQvEqTENmDWaSeEnzDqOwxGilAcy0sVX5KK7qPFGQQaNZG9bQZ+C5kfQ9bJ
         Kj2Pu/kfUTRjA6myF6nTaFQKKJ2WvxTangk1DQDDujjggarHoJ1WmFmPbi1OczPTDvWF
         jToHWtSYcmmKwVROO19F2QZI/A47OE9vgClkQGOu0IjMU/ahUNSeUXwDzmlrhRBHAT1u
         7CrfnQyrOJr8oeO3h+HMKTkox/eOPQzN9abErsnrSRatGvGjDUf906JsWVOl21etszbN
         g1dg==
X-Gm-Message-State: ACrzQf2OUjKxrejAqPNJCrWOvbAd7/SLqOO66HwLjIk2UYg9t/MHbysK
        r9ytqhqK4aUq2Y1aHoCOble3kAsMW3vsDf7Wkg5pUqlTyYDzt7/5
X-Google-Smtp-Source: AMsMyM5eSe8qr+SOZYpqgNu5YozB6o1FE/ZaJbYMxTVONq7cvElElHohBasaenz9QOFMfVGK/ysLqRHd6/63N8OsfW8=
X-Received: by 2002:a17:90b:33c9:b0:200:9ec2:f2eb with SMTP id
 lk9-20020a17090b33c900b002009ec2f2ebmr1013554pjb.29.1664416117307; Wed, 28
 Sep 2022 18:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014823.11439-1-zhouzhouyi@gmail.com> <CN6WCMKCWHOG.LT2QV3910UJ2@bobo>
 <CAABZP2wYcNXkTo=tgX-ARziwgD2rng+-wCZ-qfQ6M30+vmLEug@mail.gmail.com> <CN7OZ6TMLLFS.2HER50Q3SO480@bobo>
In-Reply-To: <CN7OZ6TMLLFS.2HER50Q3SO480@bobo>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 29 Sep 2022 09:48:26 +0800
Message-ID: <CAABZP2xu5w9Ec8LmTUrF31KhY3HCcBjQYSk4xo14bdB9mxOz+A@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC] powerpc: avoid lockdep when we are offline
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:51 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Wed Sep 28, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > Thank Nick for reviewing my patch
> >
> > On Tue, Sep 27, 2022 at 12:25 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > On Tue Sep 27, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > > > This is second version of my fix to PPC's  "WARNING: suspicious RCU usage",
> > > > I improved my fix under Paul E. McKenney's guidance:
> > > > Link: https://lore.kernel.org/lkml/20220914021528.15946-1-zhouzhouyi@gmail.com/T/
> > > >
> > > > During the cpu offlining, the sub functions of xive_teardown_cpu will
> > > > call __lock_acquire when CONFIG_LOCKDEP=y. The latter function will
> > > > travel RCU protected list, so "WARNING: suspicious RCU usage" will be
> > > > triggered.
> > > >
> > > > Avoid lockdep when we are offline.
> > >
> > > I don't see how this is safe. If RCU is no longer watching the CPU then
> > > the memory it is accessing here could be concurrently freed. I think the
> > > warning is valid.
> > Agree
> > >
> > > powerpc's problem is that cpuhp_report_idle_dead() is called before
> > > arch_cpu_idle_dead(), so it must not rely on any RCU protection there.
> > > I would say xive cleanup just needs to be done earlier. I wonder why it
> > > is not done in __cpu_disable or thereabouts, that's where the interrupt
> > > controller is supposed to be stopped.
> > Yes, I learn flowing events sequence from kgdb debugging
> > __cpu_disable -> pseries_cpu_disable -> set_cpu_online(cpu, false)  =
> > leads to =>  do_idle: if (cpu_is_offline(cpu) -> arch_cpu_idle_dead
> > so xive cleanup should be done in pseries_cpu_disable.
>
> It's a good catch and a reasonable approach to the problem.
Thank Nick for your encouragement ;-)
>
> > But as a beginner, I afraid that I am incompetent to do above
> > sophisticated work without error although I am very like to,
> > Could any expert do this for us?
>
> This will be difficult for anybody, it's tricky code. I'm not an
> expert at it.
>
> It looks like the interrupt controller disable split has been there
> since long before xive. I would try just move them together than see
> if that works.
Yes, I use "git blame" (I learned "git blame" from Paul E. McKenny ;-)
) to see the same.
and anticipate your great works!
>
> Documentation/core-api/cpu_hotplug.rst says that __cpu_disable should
> shut down the interrupt handler. So if there is a complication it
> would probably be from powerpc-specific CPU hotplug  or interrupt
> code.
Thank Nick for your guidance! I studied
Documentation/core-api/cpu_hotplug.rst this morning.
I also found X86 shut down the interrupt handler in __cpu_disable
according to above document.

Many Thanks
Zhouyi
>
> Thanks,
> Nick
>
