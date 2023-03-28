Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB01F6CCA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjC1TAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1TAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:00:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19626A8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:00:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t10so53662055edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680030036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaFE8MJ/rJnWu49G6qaf7Zeu9SjJjHyr+HaKIIGZlo8=;
        b=hGNPwQWTEYe3CZmGYHi60X2aSfRWtVK8WiJ7nu3mjdJk4YmjuiqYe9pQ+CDJlPYyxd
         /pi9trbtJtSOm7MifwcGnSBImrwX+6Z42snV0nbBlJ7UXJ/eKh48Yn/EV7NYVDSmmbPt
         Rb0l9k4E3FCIRsq0+yQqNxV2ey483qI2f6DnbBWaNsDKB3buuC+B9cupFif5N8kLGalN
         EqIH5K8IIPJWWoiCFHfQlnBM7LhKzgagHTbCa9LC7C/ObuzCHw9amKjqLxPdo/JKx3RO
         c+XsEE64L2GpM8WO4QZD+clco6JbOEINCGSlyDLrWKVTxZp91kvGAVcL2J04SbpNs5mz
         w6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680030036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaFE8MJ/rJnWu49G6qaf7Zeu9SjJjHyr+HaKIIGZlo8=;
        b=7e4/XlU3QEEWNYIWBZuA7Ib2W8srSSmfvZSPWQDIfAhNuEWtCXtSlM8SjgOnyyRnGS
         +MRDS2b+Cw1MnWovtLrHPoLtoTWEzo/6FFFayPKZtVyQL1KbS5cjvfhPfu4eMFNuJD+g
         z6ql2LebIIQ75o6/bje4DDu7bQICrj2JYkD409Z6H0i6hb8VHrUSE0i+q8ce6YAE0ZRy
         N1tF9j1y4Esz5yxAFwcHK+yvI9UYtulh5vjxFvoshdqSjMlcoiBu9XVjQ4eRm2f1TU7I
         1NY0EAToCJKsvFiUL2cIECUyZYQ5ZbhfCsXxQ9FSX4lDXzrYn3SD7ESOjfZjSHaY4yBZ
         Kdvw==
X-Gm-Message-State: AAQBX9cU9IH9EOpdhfDVYq90LZ/jpEyGkpCUsIntc3eoUWfKsiDS4yze
        Pb9AQTo0/e6OdS38Q7Hbz7IZALYzUkYix+h6U8Xofw==
X-Google-Smtp-Source: AKy350Yhk/i0+JPviKO6ga1I/DH2EtAh9hdlzqBienFUiCmmezrhPlteMpnkr+v35C7I9/6s8VzBjh8YFxr470tp00Q=
X-Received: by 2002:a50:d756:0:b0:4fc:e5c:902 with SMTP id i22-20020a50d756000000b004fc0e5c0902mr8274473edj.8.1680030035893;
 Tue, 28 Mar 2023 12:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-5-yosryahmed@google.com> <ZCMojk50vjiK6mBe@cmpxchg.org>
In-Reply-To: <ZCMojk50vjiK6mBe@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Mar 2023 11:59:59 -0700
Message-ID: <CAJD7tkYA=0rKSmtQzYQpZ2DuUoJq0bQcVqPgSpVEs0M4zAktnw@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:49=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Mar 28, 2023 at 06:16:33AM +0000, Yosry Ahmed wrote:
> > rstat flushing is too expensive to perform in irq context.
> > The previous patch removed the only context that may invoke an rstat
> > flush from irq context, add a WARN_ON_ONCE() to detect future
> > violations, or those that we are not aware of.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  kernel/cgroup/rstat.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index d3252b0416b6..c2571939139f 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgroup=
 *cgrp, bool may_sleep)
> >  {
> >       int cpu;
> >
> > +     /* rstat flushing is too expensive for irq context */
> > +     WARN_ON_ONCE(!in_task());
> >       lockdep_assert_held(&cgroup_rstat_lock);
>
> This seems a bit arbitrary. Why is an irq caller forbidden, but an
> irq-disabled, non-preemptible section caller is allowed? The latency
> impact on the system would be the same, right?

Thanks for taking a look.

So in the first patch series the initial purpose was to make sure
cgroup_rstat_lock was never acquired in an irq context, so that we can
stop disabling irqs while holding it. Tejun disagreed with this
approach though.

We currently have one caller that calls flushing with irqs disabled
(mem_cgroup_usage()) -- so we cannot forbid such callers (yet), but I
thought we can at least forbid callers from irq context now (or catch
those that we are not aware of), and then maybe forbid irqs_disabled()
contexts as well we can get rid of that callsite.

WDYT?
