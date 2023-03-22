Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02D6C50F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCVQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCVQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:41:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EED018149
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:41:43 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j7so21747347ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679503302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtJBmd+NXxBUGXj2IDg5Y7Q6u275L/30nwNnLFOcU8o=;
        b=tC/uq94J6wB1MdAyl4ZFjS8jr/5mwFF84B2qWC8Xf5CVkpnWGbiMklEqCMmZgcSM0T
         OcRnuR/f7Ji53kqCyXrz3zmV9qEhWUBi55pkOyzR71q0etJCKgoM49C/wgfOdA26+o6i
         BACY66Unz6GhTPqar/YdQE4LI5nUD6SKZEJLuBZ1aAA+MiwA5XPW21QndcyotGf/Nw3G
         /FqfaDROHKlim02DfOc6Xj3R8Fn7NADTAk+hrYY1JJKsF4/TQAi9WRzOYXtstAKvH4aC
         wWIOuWQhVaDjZLKfqPu1q2g4/DuNuRqBOBz2Uy65vvXMcvOHwd0gB04cnLuXJMAVzVmF
         djLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtJBmd+NXxBUGXj2IDg5Y7Q6u275L/30nwNnLFOcU8o=;
        b=tdZZZJTrFc2DkC17Ly3toIkesppPyI93vPqXnDWff4NVSBA40TcpdkeQVNpQr/Fc6v
         3hLzc+dmtaiJTUyqaFMV3wasnbGuhaf9gecxxKg4r3hKJj0eJt34oPCVdiwOPxrh3E9W
         9MnoXxilV9XKSsnN+wKsrg3IYinjniZJRgjaR0dIGGpFxwxz1UBSqYFdZkFZliwBCyf3
         bU3moDrlDeduBzsrg49jFqHb0TCpHzxi+u3vmACrXR6niM/aJ1on7JfZGrOzP0Xq6NTb
         aR1HF0OPGVAX89KavDvFV2l/bUdraO25c8ZzM6cuoGehDCQKkrbNXXYkshDPjmS/gMTm
         HNDw==
X-Gm-Message-State: AAQBX9cLKf6OcpbkO9RHIGJXB51JbyVqXiKurzLhwZdk4sIfYlWGJnIl
        JmfNAPlOpS18qlp6BYo13UBYXYNl/KmP5AHLVHliSQ==
X-Google-Smtp-Source: AKy350budQDkrzj5rOAlW/tAJ7lpWiKVRyhHR9VyW9DE741h9TquNZLlnz+c3O0J/GXiELbLTZQZG06j3DXMUM6MdWs=
X-Received: by 2002:a25:aa32:0:b0:b30:d9c:b393 with SMTP id
 s47-20020a25aa32000000b00b300d9cb393mr238358ybi.12.1679503302069; Wed, 22 Mar
 2023 09:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
 <20230309170756.52927-4-cerasuolodomenico@gmail.com> <CAJuCfpE18RYymcpzKZDapQg35ew5BiUPepnbS7cj+z6H5--Huw@mail.gmail.com>
 <CA+CLi1g=70ot=YFL+xug3jC4OXG727NGo+NXxmC45WcwaFpo8g@mail.gmail.com>
 <CAJuCfpFMrpL16RMp5CNJUKuPM5nTUmRvSNjK+zaxhRcdArLVhg@mail.gmail.com> <CA+CLi1gjKFFgoeHQs-sNn1knqk1w9rb73kaOqP9z8TUwwiqqFQ@mail.gmail.com>
In-Reply-To: <CA+CLi1gjKFFgoeHQs-sNn1knqk1w9rb73kaOqP9z8TUwwiqqFQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 22 Mar 2023 09:41:30 -0700
Message-ID: <CAJuCfpGxGjcE20THevY3pTCTX-EdhZDGtURr8XE6+ThHfoEzHA@mail.gmail.com>
Subject: Re: [PATCH 3/4] sched/psi: extract update_triggers side effect
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 3:14=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> I'm not suggesting that update_triggers should be different, I agree that=
 they should behave the same for both types of trigger.
> The problem is that if we extract the update_total information out of upd=
ate_triggers, that information will be ignored by psi_avgs_work because avg=
_total is always updated in update_averages, only psi_poll_work would use i=
t to copy the total to polling_total.
> If this is the only alternative to having `if (update_total && aggregator=
 =3D=3D PSI_POLL)` inside update_triggers, I'll add the argument to update_=
triggers, I'm just wondering if there could be another alternative.

I suggest you post the V2 with suggested changes and this approach and
it will be easier to decide whether this can be improved further.
Also, please do not top-post (read through
https://kernelnewbies.org/mailinglistguidelines for more hints).
Thanks,
Suren.

>
> On Wed, Mar 22, 2023 at 4:41=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
>>
>> On Tue, Mar 21, 2023 at 3:18=E2=80=AFAM Domenico Cerasuolo
>> <cerasuolodomenico@gmail.com> wrote:
>> >
>> > Hi Suren, thanks for all the feedback! This makes sense, I only have o=
ne doubt, if we set update_total flag to window_update() and update_trigger=
s(), that flag would be ignored when the caller is psi_avgs_work(), this wo=
uld be happening in the next patch in the set.
>>
>> I don't see why the update_triggers part should be conceptually
>> different between RT and unprivileged triggers. Could you please
>> explain?
>>
>> > What do you think if I just remove this change from the patchset and t=
hen work on a solution after the iterations on the main change are complete=
d? This was in fact just an attempt to clean up.
>> > I'll apply your suggested changes on the other patches, wait a bit for=
 comments from someone else and then send V2.
>> >
>> > On Tue, Mar 21, 2023 at 12:00=E2=80=AFAM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
>> >>
>> >> On Thu, Mar 9, 2023 at 9:08=E2=80=AFAM Domenico Cerasuolo
>> >> <cerasuolodomenico@gmail.com> wrote:
>> >> >
>> >> > The update of rtpoll_total inside update_triggers can be moved out =
of
>> >> > the function since changed_states has the same information as the
>> >> > update_total flag used in the function. Besides the simplification =
of
>> >> > the function, with the next patch it would become an unwanted side
>> >> > effect needed only for PSI_POLL.
>> >>
>> >> (changed_states & group->rtpoll_states) and update_total flag are not
>> >> really equivalent. update_total flag depends on the difference betwee=
n
>> >> group->polling_total[state] and group->total[PSI_POLL][state] while
>> >> changed_states depends on the difference between groupc->times and
>> >> groupc->times_prev. groupc->times_prev is updated every time
>> >> collect_percpu_times() is called and there are 3 places where that
>> >> happens: from psi_avgs_work(), from psi_poll_work() and from
>> >> psi_show(). group->polling_total[state] is updated only from
>> >> psi_poll_work(). Therefore the deltas between these values might not
>> >> always be in-sync.
>> >>
>> >> Consider the following sequence as an example:
>> >>
>> >> psi_poll_work()
>> >> ...
>> >> psi_avgs_work()/psi_show()
>> >>   collect_percpu_times() // we detect a change in a monitored state
>> >> ...
>> >> psi_poll_work()
>> >>   collect_percpu_times() // this time no change in monitored states
>> >>   update_triggers() // group->polling_total[state] !=3D
>> >> group->total[PSI_POLL][state]
>> >>
>> >> In the last psi_poll_work() collect_percpu_times() recorded no change
>> >> in monitored states, so (changed_states & group->rtpoll_states) =3D=
=3D 0,
>> >> however since the last time psi_poll_work() was called there was
>> >> actually a change in monitored states recorded by the first
>> >> collect_percpu_times(), therefore (group->polling_total[t->state] !=
=3D
>> >> total[t->state]) and we should update the totals. With your change we
>> >> will miss that update.
>> >>
>> >> I think you can easily fix that by introducing update_triggers as an
>> >> output parameter in window_update() like this:
>> >>
>> >> static u64 window_update(struct psi_window *win, u64 now, u64 value,
>> >> bool *update_triggers) {
>> >>     *update_total =3D false;
>> >> ...
>> >>     if (new_stall) {
>> >>         *update_total =3D true;
>> >> ...
>> >> }
>> >>
>> >> static void psi_rtpoll_work(struct psi_group *group) {
>> >> +       bool update_triggers;
>> >> ...
>> >> -       if (now >=3D group->rtpoll_next_update)
>> >> +       if (now >=3D group->rtpoll_next_update) {
>> >>                 group->rtpoll_next_update =3D update_triggers(group,
>> >> now, &update_triggers);
>> >> +               if (update_triggers)
>> >> +                       memcpy(group->rtpoll_total, group->total[PSI_=
POLL],
>> >> +                                  sizeof(group->rtpoll_total));
>> >> +       }
>> >> }
>> >>
>> >>
>> >> >
>> >> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> >> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>> >> > ---
>> >> >  kernel/sched/psi.c | 20 +++++---------------
>> >> >  1 file changed, 5 insertions(+), 15 deletions(-)
>> >> >
>> >> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>> >> > index a3d0b5cf797a..476941c1cbea 100644
>> >> > --- a/kernel/sched/psi.c
>> >> > +++ b/kernel/sched/psi.c
>> >> > @@ -433,7 +433,6 @@ static u64 window_update(struct psi_window *win=
, u64 now, u64 value)
>> >> >  static u64 update_triggers(struct psi_group *group, u64 now)
>> >> >  {
>> >> >         struct psi_trigger *t;
>> >> > -       bool update_total =3D false;
>> >> >         u64 *total =3D group->total[PSI_POLL];
>> >> >
>> >> >         /*
>> >> > @@ -456,14 +455,6 @@ static u64 update_triggers(struct psi_group *g=
roup, u64 now)
>> >> >                  * events without dropping any).
>> >> >                  */
>> >> >                 if (new_stall) {
>> >> > -                       /*
>> >> > -                        * Multiple triggers might be looking at th=
e same state,
>> >> > -                        * remember to update group->polling_total[=
] once we've
>> >> > -                        * been through all of them. Also remember =
to extend the
>> >> > -                        * polling time if we see new stall activit=
y.
>> >> > -                        */
>> >> > -                       update_total =3D true;
>> >> > -
>> >> >                         /* Calculate growth since last update */
>> >> >                         growth =3D window_update(&t->win, now, tota=
l[t->state]);
>> >> >                         if (!t->pending_event) {
>> >> > @@ -484,11 +475,6 @@ static u64 update_triggers(struct psi_group *g=
roup, u64 now)
>> >> >                 /* Reset threshold breach flag once event got gener=
ated */
>> >> >                 t->pending_event =3D false;
>> >> >         }
>> >> > -
>> >> > -       if (update_total)
>> >> > -               memcpy(group->rtpoll_total, total,
>> >> > -                               sizeof(group->rtpoll_total));
>> >> > -
>> >> >         return now + group->rtpoll_min_period;
>> >> >  }
>> >> >
>> >> > @@ -686,8 +672,12 @@ static void psi_rtpoll_work(struct psi_group *=
group)
>> >> >                 goto out;
>> >> >         }
>> >> >
>> >> > -       if (now >=3D group->rtpoll_next_update)
>> >> > +       if (now >=3D group->rtpoll_next_update) {
>> >> >                 group->rtpoll_next_update =3D update_triggers(group=
, now);
>> >> > +               if (changed_states & group->rtpoll_states)
>> >> > +                       memcpy(group->rtpoll_total, group->total[PS=
I_POLL],
>> >> > +                                  sizeof(group->rtpoll_total));
>> >> > +       }
>> >> >
>> >> >         psi_schedule_rtpoll_work(group,
>> >> >                 nsecs_to_jiffies(group->rtpoll_next_update - now) +=
 1,
>> >> > --
>> >> > 2.34.1
>> >> >
