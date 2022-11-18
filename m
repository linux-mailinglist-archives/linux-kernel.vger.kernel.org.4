Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6614762F432
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbiKRMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiKRMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:09:06 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11588FF91
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:09:05 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id h132so5136721oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCzTYL6+A9+c/OQXUxxh/ho9MD1U9c5KOoJmc89sICU=;
        b=nCutx/9t0DzmESVrNrT+RdN7oAOvcFuTJsMiOPipkb31APMfTMpKM9WRTkqwPEUdzv
         sx/s6MKFyMn3oFZQv5dT6mRqtfYoYhNfUmzvrrJZLfLYM6P0Yzv8NkuRksBwa25wcNpR
         lQJGgIDLc6gmvCnG6RtDvkFJU4sm7PW+Z2g2sh4YyY3UqsJQy1UNwpqtHNYTMan5xl8E
         gXQC0Hzxp3LP+/ewzZStegQGoxDUYpl+SdLxbocGeQ/wQBLKR1tdHaW0C6Yslyj7ys3R
         GwqkKfH8meJ8PoW+95ieyKEmlktov0qrV/7O88Hd/LHxEcAfakKV9ySL63jdfpp3AVWO
         wRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCzTYL6+A9+c/OQXUxxh/ho9MD1U9c5KOoJmc89sICU=;
        b=2uix1vtT5KI8MucDXS/d6GxPWpuAYxjgLFwLNOQ7bexmZkMOHcOHatU0jIGyYIjYDO
         c05zPlSj/dqfY4CkuWNlWtufkGqGshzoUGXquxOtCfdtoJd3GrECJ2mRSslzIyAR84SF
         xch5/aI1rroG7mhke+DD8zo5tPaneKPJq5Lyf/GeaHa7ga2Fz3PYEJ/YR5t3B7NBMiHC
         iggZBjNvx0yLZ7loAGpb2Ix/keU0TjHdGOilhGDDEFTctH5dRz9bL5dZGqDvyH3Rw/DR
         i1WXkxVd6mDZVkTPizlnuhuuQzaN//ze+7gg7v7TR98s9PRO8huFJyZ05iiREbQ1uDEX
         OdnA==
X-Gm-Message-State: ANoB5pkmbTnXZScjkODAnTBUC/6NGoBSWIgRnQq3AmQVtey2mlc86fqa
        kXZjJtrmoP5JXKKPpACFiM1StcAtDxwJLov2KBU=
X-Google-Smtp-Source: AA0mqf6cK0xqX6QZpu1HVIxlG8w2JzoenkhhdJXwngv+pP88Kcboxnm6Ie8Tb+GM8dpLEAfyNDct4qIXz+4CqdsLFXI=
X-Received: by 2002:aca:4545:0:b0:359:f445:e03e with SMTP id
 s66-20020aca4545000000b00359f445e03emr3302916oia.180.1668773345225; Fri, 18
 Nov 2022 04:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20221114120453.3233-1-xuewen.yan@unisoc.com> <20221117170028.04fd7013@gandalf.local.home>
In-Reply-To: <20221117170028.04fd7013@gandalf.local.home>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 18 Nov 2022 20:08:54 +0800
Message-ID: <CAB8ipk8xXWzc_PurHwVPd9-azN4B5OD=MYQP+Oze1kmbom0avQ@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Use cpu_active_mask to prevent
 rto_push_irq_work's dead loop
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, ke.wang@unisoc.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 6:16 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 14 Nov 2022 20:04:53 +0800
> Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> > +++ b/kernel/sched/rt.c
> > @@ -2219,6 +2219,7 @@ static int rto_next_cpu(struct root_domain *rd)
> >  {
> >       int next;
> >       int cpu;
> > +     struct cpumask tmp_cpumask;
>
> If you have a machine with thousands of CPUs, this will likely kill the
> stack.
Ha, I did not take it into account. Thanks=EF=BC=81

>
> >
> >       /*
> >        * When starting the IPI RT pushing, the rto_cpu is set to -1,
> > @@ -2238,6 +2239,11 @@ static int rto_next_cpu(struct root_domain *rd)
> >               /* When rto_cpu is -1 this acts like cpumask_first() */
> >               cpu =3D cpumask_next(rd->rto_cpu, rd->rto_mask);
> >
> > +             cpumask_and(&tmp_cpumask, rd->rto_mask, cpu_active_mask);
> > +             if (rd->rto_cpu =3D=3D -1 && cpumask_weight(&tmp_cpumask)=
 =3D=3D 1 &&
> > +                 cpumask_test_cpu(smp_processor_id(), &tmp_cpumask))
> > +                     break;
> > +
>
> Kill the above.
>
> >               rd->rto_cpu =3D cpu;
> >
> >               if (cpu < nr_cpu_ids) {
>
> Why not just add here:
>
>                         if (!cpumask_test_cpu(cpu, cpu_active_mask))
>                                 continue;
>                         return cpu;
>                 }
>
> ?
Let's consider this scenario:
the online_cpu_mask is 0x03(cpu0/1)=EF=BC=8Cthe active_cpu_mask is
0x01(cpu0)=EF=BC=8Cthe rto cpu is cpu0,
the rto_mask is 0x01, and the irq cpu is cpu0, as a result,  the first
loop, the rto_cpu would be -1,
but the loop < rto_loop_next, on  next loop, because of the rto_cpu is
-1, so the next rto cpu would
be cpu0 still, as a result, the cpu0 would push rt tasks to
cpu1(inactive cpu) while running in the irq_work.

So we should judge whether the current cpu(the only one active cpu) is
the next loop's cpu.

Thanks=EF=BC=81

>
> -- Steve
