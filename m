Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6F768A7CF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 03:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBDC3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 21:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBDC3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 21:29:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4A74C15;
        Fri,  3 Feb 2023 18:29:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819AA6204D;
        Sat,  4 Feb 2023 02:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4882FC433D2;
        Sat,  4 Feb 2023 02:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675477775;
        bh=A31zSwlgRwgvDbdSE2DEbrUbqrKSeAqq7FjkMqnStZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sys04XZk8jqh8pRKO4mghhMIaZOJaNysJlIGALRMdUzBCxAI7G298EYXo2zlMRvSr
         v1L58VM1ZHs7x81UItVoBpt9wcZHmGDg5tNF+6JViYATk8zllrsyuNPci/+h9ThQNC
         KW//e75t+wHxZCqRUkgsCKq4iGfhZGkJ2TH63kQJ9oR+CjCAQa7/KkH2zX9Gq7ZUzT
         JuXMK4xLEjNS6GRz1ijKyXH/9LrhEwsou1WQe6fwvelXFDxVFZwSA9iJKcPffsY87l
         1jDSihH/HYx9/w9lxJwcSwTV40QPZPI04Z41AbBuYIqH66hVf0PVr4wNkI33bF0LF/
         Ts2VwRwiP4moA==
Date:   Fri, 3 Feb 2023 18:29:32 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: Re: [PATCH 05/22] csky/cpu: Make sure arch_cpu_idle_dead() doesn't
 return
Message-ID: <20230204022932.k24laszjs3v4bc3v@treble>
References: <cover.1675461757.git.jpoimboe@kernel.org>
 <f860f3a1c1a53c437a99abc53e8f1a798aef6881.1675461757.git.jpoimboe@kernel.org>
 <CAJF2gTSKe3ve4_rsOYpmSBOyUSU5rpLHyijn9i2-i+WfLqxzYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTSKe3ve4_rsOYpmSBOyUSU5rpLHyijn9i2-i+WfLqxzYw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 09:12:31AM +0800, Guo Ren wrote:
> On Sat, Feb 4, 2023 at 6:05 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > arch_cpu_idle_dead() doesn't return.  Make that more explicit with a
> > BUG().
> >
> > BUG() is preferable to unreachable() because BUG() is a more explicit
> > failure mode and avoids undefined behavior like falling off the edge of
> > the function into whatever code happens to be next.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/csky/kernel/smp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
> > index b45d1073307f..0ec20efaf5fd 100644
> > --- a/arch/csky/kernel/smp.c
> > +++ b/arch/csky/kernel/smp.c
> > @@ -317,5 +317,7 @@ void arch_cpu_idle_dead(void)
> >                 "jmpi   csky_start_secondary"
> >                 :
> >                 : "r" (secondary_stack));
> > +
> > +       BUG();
> Why not:
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f26ab2675f7d..1d3bf903add2 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -285,6 +285,7 @@ static void do_idle(void)
>                         tick_nohz_idle_stop_tick();
>                         cpuhp_report_idle_dead();
>                         arch_cpu_idle_dead();
> +                       BUG();

Without the BUG() in csky arch_cpu_idle_dead(), the compiler will warn
about arch_cpu_idle_dead() returning, because it's marked __noreturn but
doesn't clearly return (as far as the compiler knows).

And we want it marked __noreturn so we'll be more likely to catch such
bugs at build time.

And as a bonus we get better code generation and clearer code semantics
which helps both humans and tooling understand the intent of the code.

-- 
Josh
