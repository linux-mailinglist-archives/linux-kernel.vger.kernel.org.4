Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE87101E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjEYAGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjEYAGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:06:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ACA99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:06:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so29975e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684973179; x=1687565179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6y2T4aCSu8SfDSRBVPepEbUZJ4FOAswZ/Dl6ph/P2s=;
        b=v+vO3KtaS1phlSRKZZTGgXkFjboXX+ks0HNH3n7OjahS6jWuOyvj4JYDBxU23rtCWg
         Fp1UWOKeqYywgSV6DmVfOrcxrkG6eXiguVqbW7ZKksZs0voPMobLhAf3gotaqsY9owb3
         9X3cfSg/vIokAMjOHvsi92+EvuAAAaz4T88xN0DBiWM1hFPeqs/CLZpodOKq1yuNKQoX
         BVHeg088hhk/1wz1f4nyds+aPVygeeY4I3qtgkFU+jqqcsM4ig0zFKZbaqSGhIVTvUZx
         QcKg+RPeOlW+Q7zHmORd137a9edoq1A14wYmAPvtxyiEjMz24ldKpN8Qxucn+i/Iuzi1
         0IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684973179; x=1687565179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6y2T4aCSu8SfDSRBVPepEbUZJ4FOAswZ/Dl6ph/P2s=;
        b=C9EoTwU9uyQ6cJBQTo2Wmze+XZCZyKpVb8Wr3FqDrcgnRKrD28NQ4ktHLBon2mJB2R
         D51pSrFGI3C819x+EwrunKCiDmYydfkYPE7WlxtAgd32rmrvzrqTi1MLv77uKqeqJu+x
         wgAoLYAR/18U4zYCmiq8FMcdy8WIQtwtVN2sAfuMO8QovWg4WOJDzeA51R4jB+1Z2evO
         CZ4cXluH9PqoH8j0QYTahlYwioOG6xMuNnVX6cc3aebIzCPuSd593DVeS1ZGkDJyv0j9
         nuDxkvaLNl+IquGAzfr8n69Qxff99TwQnZDjbqoD6EXSRSb0Z5Og8DWR6DuYslBgWbN6
         anCA==
X-Gm-Message-State: AC+VfDxp8wh8ybQ1T7Z7bRS6lkkGaWq+wWpidM3CeQRCjbHYV6ZwrkKo
        hAFSKtkDF7GPYWvaPRhDCmeV1hvkYwDkhtJrlTsuIg==
X-Google-Smtp-Source: ACHHUZ4sbjWspZgkEqrDsqh2MBrtkkcJLNCg8xRKWlGgbq3vGNreJBWEEaxV6Ez7gN0v+6CNpWC+8TKIU4z94zmy9VY=
X-Received: by 2002:a05:600c:1c93:b0:3f4:2736:b5eb with SMTP id
 k19-20020a05600c1c9300b003f42736b5ebmr25661wms.1.1684973179281; Wed, 24 May
 2023 17:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230518013414.3053254-1-joshdon@google.com> <20230518013414.3053254-2-joshdon@google.com>
 <ZG0z1enh3TNbsxQh@slm.duckdns.org>
In-Reply-To: <ZG0z1enh3TNbsxQh@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 24 May 2023 17:06:08 -0700
Message-ID: <CABk29Nvh6jxv3cWampfjiz57=vvQVX8ThtaJPXF=vc3aqme6YQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: add throttled time stat for throttled children
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tejun,

On Tue, May 23, 2023 at 2:44=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> (cc'ing Johannes)
>
> On Wed, May 17, 2023 at 06:34:14PM -0700, Josh Don wrote:
> > We currently export the total throttled time for cgroups that are given
> > a bandwidth limit. This patch extends this accounting to also account
> > the total time that each children cgroup has been throttled.
> >
> > This is useful to understand the degree to which children have been
> > affected by the throttling control. Children which are not runnable
> > during the entire throttled period, for example, will not show any
> > self-throttling time during this period.
> ...
> > @@ -11204,20 +11217,24 @@ static int cpu_extra_stat_show(struct seq_fil=
e *sf,
> >       {
> >               struct task_group *tg =3D css_tg(css);
> >               struct cfs_bandwidth *cfs_b =3D &tg->cfs_bandwidth;
> > -             u64 throttled_usec, burst_usec;
> > +             u64 throttled_usec, burst_usec, throttled_self_usec;
> >
> >               throttled_usec =3D cfs_b->throttled_time;
> >               do_div(throttled_usec, NSEC_PER_USEC);
> > +             throttled_self_usec =3D throttled_time_self(tg);
> > +             do_div(throttled_self_usec, NSEC_PER_USEC);
> >               burst_usec =3D cfs_b->burst_time;
> >               do_div(burst_usec, NSEC_PER_USEC);
> >
> >               seq_printf(sf, "nr_periods %d\n"
> >                          "nr_throttled %d\n"
> >                          "throttled_usec %llu\n"
> > +                        "throttled_self_usec %llu\n"
>
> This is fine in principle but I think it'd be better to keep it consisten=
t
> with how non-hierarchical events are in memory.events.local. ie. Can we
> please add cpu.stat.local instead of adding the _self key to cpu.stat?

It seemed unfortunate to split it out into a separate interface, since
there wouldn't be much to put there, but I don't have a strong
objection to this. I'll go ahead and make that change for v2.

Best,
Josh
