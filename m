Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3852068C9A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBFWi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBFWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:38:24 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028030287
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:38:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mf7so38584780ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ywdiz8Y63d+k5p5OYSMUxkysdFaESJJzGDG9Fil09g=;
        b=VPzTwTkNiLkX6zaIOtI1qqgjSmixuflyQj6+2nM2aNmtWkxKQVGGwGKHNHy3wh27Mi
         P0nfHiuO+NoYeyH1A4kV9RWuttyqRDW4/eHnuNM74+uQrKS7DDrDrC0j9lfb63sNHoMo
         yJtBumuovg6F+K1rb8XMx69GPjUnngSFs4cH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ywdiz8Y63d+k5p5OYSMUxkysdFaESJJzGDG9Fil09g=;
        b=lH7pdNf6n4/Rag/q1p7dpl2FThZHdHE9PsYllbGDH1rsaY6GrReeGly0Qi6MkiP4Rb
         5+aCTdiydbC5k9t9IqWuAAjg9KjG3i5nnilpr4XGVkcIEJ436qbXoxVwGdPKF1Q1BW94
         rjlm/YOYAl5V3s1Pe/FpmNSSct7bUKnMp+g+llb/sF0Rmm9yRSZWPRL70S73XICVj7Bo
         3TB62efB2tZkcayMyjPfDnRGRVq1Gw3tZV9D8liBQetLKQN7sbd+z9TpY6QM2D4vaB9a
         PJS4TW6YYO7thli1RvrmclWMm0KxUQ6CLHF01Cp3ZibRRat7O/rWJHq9zlwuOvepkntu
         s4fw==
X-Gm-Message-State: AO0yUKWerE1Pere4ivDNo2GjAUN4cXl9C4AWv3ql5grfidJq+KNtOTOq
        3QSD7zVIkjZw/boEYIkG4XzPpkgbH9myUfs7NUxZWQ==
X-Google-Smtp-Source: AK7set8B3ImGlsGE4SMJGki/gGVorL2JK8PLiGjCPRIV3hPBifquz+u2hCg/86NIM37S8mjMTQQ4/P1I8KVpe4lgaE8=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr286415ejc.220.1675723101804; Mon, 06 Feb
 2023 14:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it>
 <20230206112342.223d2c29@rorschach.local.home> <Y+ExcOoHOzSctvue@lorien.usersys.redhat.com>
In-Reply-To: <Y+ExcOoHOzSctvue@lorien.usersys.redhat.com>
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Mon, 6 Feb 2023 23:38:09 +0100
Message-ID: <CAEih1qXHjrbMnMKa=DKVNTYbFoBKLi0ji+usRMgjLFqmvrbVeA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: pick_next_rt_entity(): checked list_entry
To:     Phil Auld <pauld@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 at 17:57, Phil Auld <pauld@redhat.com> wrote:
>
> On Mon, Feb 06, 2023 at 11:23:42AM -0500 Steven Rostedt wrote:
> > On Tue, 31 Jan 2023 13:01:16 +0000
> > Pietro Borrello <borrello@diag.uniroma1.it> wrote:
> >
> > > index ed2a47e4ddae..c024529d8416 100644
> > > --- a/kernel/sched/rt.c
> > > +++ b/kernel/sched/rt.c
> > > @@ -1777,6 +1777,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
> > >     BUG_ON(idx >= MAX_RT_PRIO);
> > >
> > >     queue = array->queue + idx;
> > > +   SCHED_WARN_ON(list_empty(queue));
> >
> > I wonder if we should make this:
> >
> >       if (SCHED_WARN_ON(list_empty(queue)))
> >               return NULL;
> >
> > >     next = list_entry(queue->next, struct sched_rt_entity, run_list);
> > >
> > >     return next;
> > > @@ -1789,7 +1790,6 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
> > >
> > >     do {
> > >             rt_se = pick_next_rt_entity(rt_rq);
> > > -           BUG_ON(!rt_se);
> >
> >               if (unlikely(!rt_se))
> >                       return NULL;
>
> I think that's better than taking a digger in one of the subsequent macros.
>

Thanks for the feedback.
Fixed in v3: https://lore.kernel.org/all/20230128-list-entry-null-check-sched-v3-1-b1a71bd1ac6b@diag.uniroma1.it/T/#u

Best regards,
Pietro
