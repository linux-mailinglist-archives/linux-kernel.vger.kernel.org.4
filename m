Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1271EF63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFAQok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:44:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5F4D1;
        Thu,  1 Jun 2023 09:44:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-256932cea7aso486171a91.3;
        Thu, 01 Jun 2023 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685637877; x=1688229877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOp7/nMgaW7yHE0keyiurjcES8fNy663ug95scQDyMY=;
        b=eALrAI7rPO+MlILfilEuAPfO9e3Cu8jf2choRj4ehiDdTUU0kKY2JAr7wX9ppqhlAI
         VCY2+0dSwUwStwp0CmMhAjb7jHobY6tF1Er46hSrmYtknAYvhen2RnbBKQCycnoHcoFV
         XJZk5xXwZZcTl0IPsXD4ntxQgl3hUccY8XYs7hstkbbJL6NSzIuimRSf/ZgUrOt3rvQR
         79+3DxEiJ7jbadxzZL5m80tSQ65+eqpy90yiN9eVSHK7swjgIMKwPqwMilUBn2Qwbl5N
         NlQ2q/kZwPTKkI2l1pI+h5IAHjP/+2zMc6H5wvKUa1cw5abSqmIS0FIc4bX4Q3P5UVTV
         NfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637877; x=1688229877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOp7/nMgaW7yHE0keyiurjcES8fNy663ug95scQDyMY=;
        b=AleSyFevm38HrAgE00ZpaNC0p53hRMUoEgR+u3zsCOHUnn8ZB70VZElphKazq8BeRp
         DXtb00mbNduBRTfjmXyqv3C8P5oOtKfhltqaKMUwEIieLQtNHTO2M/vlTjuA1X6B8QWI
         +3vdmPnjuriGDsCK7f3UXx7FuzvsolMmOs3Rqv5pohxsp+GA6EiiBEx0yFcQNhIKU25c
         jsu2wNq7ZToDCag+WXi9tNvhlfCLu4Lbc8zyTSU5jT0WJSVtjAjV0ivTHecXJrED3opl
         SZ7vlwoNZeAwbcDo7VjarwLIQg8gPsUvRvyGJt2lrjcSyV9Y9d4mUKjR7xG9YWgCtTFc
         bdgg==
X-Gm-Message-State: AC+VfDyfFIp8U8jpM1X8veKym9fkjWIlvmX58zd+TLl0pF/q5A3xsUlH
        IYcRwNdkZObk9bX0j9PQ2dVNIyqy6o2a5v/P88E=
X-Google-Smtp-Source: ACHHUZ5U+MUxgoohtljuBTQ9XwuDukyXFy8b6J+sfIXD+KPvuu9y+m1mQhYWlmW36yU7dxk8Dg2kJZOtoP7efcYKDjA=
X-Received: by 2002:a17:90a:1601:b0:250:85ba:6c3d with SMTP id
 n1-20020a17090a160100b0025085ba6c3dmr12426pja.6.1685637876987; Thu, 01 Jun
 2023 09:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com> <20230601111326.GV4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230601111326.GV4253@hirez.programming.kicks-ass.net>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Fri, 2 Jun 2023 00:44:25 +0800
Message-ID: <CADjb_WQcP2TUH98=W9YqnbkBSKOxEp0_8jB_af7E3-ghXf1awg@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 8:11=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Jun 01, 2023 at 03:03:39PM +0530, K Prateek Nayak wrote:
[...]
> > I wonder if extending SIS_UTIL for SIS_NODE would help some of these
> > cases but I've not tried tinkering with it yet. I'll continue
> > testing on other NPS modes which would decrease the search scope.
> > I'll also try running the same bunch of workloads on an even larger
> > 4th Generation EPYC server to see if the behavior there is similar.
>
> > >  /*
> > > + * For the multiple-LLC per node case, make sure to try the other LL=
C's if the
> > > + * local LLC comes up empty.
> > > + */
> > > +static int
> > > +select_idle_node(struct task_struct *p, struct sched_domain *sd, int=
 target)
> > > +{
> > > +   struct sched_domain *parent =3D sd->parent;
> > > +   struct sched_group *sg;
> > > +
> > > +   /* Make sure to not cross nodes. */
> > > +   if (!parent || parent->flags & SD_NUMA)
> > > +           return -1;
> > > +
> > > +   sg =3D parent->groups;
> > > +   do {
> > > +           int cpu =3D cpumask_first(sched_group_span(sg));
> > > +           struct sched_domain *sd_child;
> > > +
> > > +           sd_child =3D per_cpu(sd_llc, cpu);
> > > +           if (sd_child !=3D sd) {
> > > +                   int i =3D select_idle_cpu(p, sd_child, test_idle_=
cores(cpu), cpu);
>
> Given how SIS_UTIL is inside select_idle_cpu() it should already be
> effective here, no?
>
I'm thinking of this scenario, when the system is overloaded and with
SIS_NODE disabled,
the SIS_UTIL could scan for example 4 CPUs and terminates, then wakeup
on local LLC.
When SIS_NODE is enabled, it could scan for 4 * number_of_llc_domain
CPUs.  The more
CPU it scans, the more likely it can find an idle CPU.
This seems to be a question of: what type of wakee is prefered to be
put on a non-idle CPU from local LLC,
or  an idle CPU  from remote LLC. It seems to depend on the working
set and task duration.


thanks,
Chenyu
