Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D096A927A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCCIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCCIdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:33:05 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F162D4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:33:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u20so1063999pfm.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c/Oa6D/ZzVbXO2dxT7z3pi8II84IDKTdhKwi7HXYtk=;
        b=krSuK8UTgjbuaWkaF0jVHEDBv9OqFBiHRq5ggqM7AZbBYlWx/fZ/ic3aOoOzh/V8je
         M5EjD+ZM1j1iVYO0ERGVf9HsIHydQUnArvkqvktCAv1hq3G/buuRV7zmd5n2bnqFvk5+
         fvNSDWZIBs0kmsfKyo417bhpf8v8EgVaazXIpWagSndJcYSRFZvmqBX06T8zIXE1XfeJ
         QyOLNylVnb90KCisr7S+jFeaE8mJyBQCGvhWiD86Dy1yVq8nwIfbIZQvOi6GI7m1nq7M
         pBsDwOhtyxqG3d68vZVJ048tECavs3lWtX8Bv5tbsNtuFibns7Zo5csn9MTlPLerxB0A
         waCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c/Oa6D/ZzVbXO2dxT7z3pi8II84IDKTdhKwi7HXYtk=;
        b=vEskUJcokAxFxswaCVJtePaPpnZw8FPj0OORQZFUZQztjdepWZLVTB6Nv4xB4wdBdz
         llRL6Fvi6AZziMZgvqy+gjZITK/CpJxDc+cjws1ACCOOvkTm4ILMgWBj8yNlNgq7jbLv
         5JEZEnB4RyUtSpdotkNffV19WGI/D02jVHj9bVYEnQidFcwPfP44dQLa6J3g5DjYJLr6
         NYVMTsqLAAqhsPIWx7+W8cfnvLyZamnq+mcyScvXLOxICsiJbXNS5p/GIzf4kZm2BzB2
         Ek1HmIuzoV+dgI8plpIZgaDTf5P1RpO2l4K7gkGvCi66iP1c9Sl6IbBIYKkFbc8rE8o2
         jPcw==
X-Gm-Message-State: AO0yUKUhxXlqJjUKJHag7Zi6t+balsugjgx62ebOoijJtGadqHg66zeu
        C9RPcNj0QjppgM2LgfxC7zcwSOE5700Ai1802PJmwQ==
X-Google-Smtp-Source: AK7set9wsOMi9OjbPH+ymC0VUnGBJroLwNV9AHEqZclsQ0c82BX8FjpkwrHLyAGbwvs2F8GGbHCMAMduxBusMo//ocw=
X-Received: by 2002:a63:2950:0:b0:4fd:5105:eb93 with SMTP id
 bu16-20020a632950000000b004fd5105eb93mr231025pgb.3.1677832382150; Fri, 03 Mar
 2023 00:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20230209193107.1432770-1-rkagan@amazon.de> <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com> <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
 <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com> <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
 <1cd19d3f-18c4-92f9-257a-378cc18cfbc7@huawei.com> <CAKfTPtB9oYsKHLF--nVwNT5z-9tCR3bBWd8mPe4NWZ5S3y43Lg@mail.gmail.com>
 <aef87465-221b-3aff-3501-af1a516bbd98@huawei.com> <CAKfTPtC=Y-ihdiO3ctrdsLmhMNraf6c-Ft2059T=z38kwzdJ=Q@mail.gmail.com>
 <5b8bb880-de5a-dd99-4168-89d1281e8348@huawei.com>
In-Reply-To: <5b8bb880-de5a-dd99-4168-89d1281e8348@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 3 Mar 2023 09:32:50 +0100
Message-ID: <CAKfTPtCnhS-Dk27K-w9q00xbH_rrxyVPwJpae1puoifJqywh7Q@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     Roman Kagan <rkagan@amazon.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 at 07:51, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2023/3/2 22:55, Vincent Guittot =E5=86=99=E9=81=93:
> > On Thu, 2 Mar 2023 at 15:29, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2023/3/2 21:34, Vincent Guittot =E5=86=99=E9=81=93:
> >>> On Thu, 2 Mar 2023 at 10:36, Zhang Qiao <zhangqiao22@huawei.com> wrot=
e:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2023/2/27 22:37, Vincent Guittot =E5=86=99=E9=81=93:
> >>>>> On Mon, 27 Feb 2023 at 09:43, Roman Kagan <rkagan@amazon.de> wrote:
> >>>>>>
> >>>>>> On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
> >>>>>>> On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrot=
e:
> >>>>>>>> What scares me, though, is that I've got a message from the test=
 robot
> >>>>>>>> that this commit drammatically affected hackbench results, see t=
he quote
> >>>>>>>> below.  I expected the commit not to affect any benchmarks.
> >>>>>>>>
> >>>>>>>> Any idea what could have caused this change?
> >>>>>>>
> >>>>>>> Hmm, It's most probably because se->exec_start is reset after a
> >>>>>>> migration and the condition becomes true for newly migrated task
> >>>>>>> whereas its vruntime should be after min_vruntime.
> >>>>>>>
> >>>>>>> We have missed this condition
> >>>>>>
> >>>>>> Makes sense to me.
> >>>>>>
> >>>>>> But what would then be the reliable way to detect a sched_entity w=
hich
> >>>>>> has slept for long and risks overflowing in .vruntime comparison?
> >>>>>
> >>>>> For now I don't have a better idea than adding the same check in
> >>>>> migrate_task_rq_fair()
> >>>>
> >>>> Hi, Vincent=EF=BC=8C
> >>>> I fixed this condition as you said, and the test results are as foll=
ows.
> >>>>
> >>>> testcase: hackbench -g 44 -f 20 --process --pipe -l 60000 -s 100
> >>>> version1: v6.2
> >>>> version2: v6.2 + commit 829c1651e9c4
> >>>> version3: v6.2 + commit 829c1651e9c4 + this patch
> >>>>
> >>>> -------------------------------------------------
> >>>>         version1        version2        version3
> >>>> test1   81.0            118.1           82.1
> >>>> test2   82.1            116.9           80.3
> >>>> test3   83.2            103.9           83.3
> >>>> avg(s)  82.1            113.0           81.9
> >>>>
> >>>> -------------------------------------------------
> >>>> After deal with the task migration case, the hackbench result has re=
stored.
> >>>>
> >>>> The patch as follow, how does this look?
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index ff4dbbae3b10..3a88d20fd29e 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -4648,6 +4648,26 @@ static void check_spread(struct cfs_rq *cfs_r=
q, struct sched_entity *se)
> >>>>  #endif
> >>>>  }
> >>>>
> >>>> +static inline u64 sched_sleeper_credit(struct sched_entity *se)
> >>>> +{
> >>>> +
> >>>> +       unsigned long thresh;
> >>>> +
> >>>> +       if (se_is_idle(se))
> >>>> +               thresh =3D sysctl_sched_min_granularity;
> >>>> +       else
> >>>> +               thresh =3D sysctl_sched_latency;
> >>>> +
> >>>> +       /*
> >>>> +        * Halve their sleep time's effect, to allow
> >>>> +        * for a gentler effect of sleepers:
> >>>> +        */
> >>>> +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >>>> +               thresh >>=3D 1;
> >>>> +
> >>>> +       return thresh;
> >>>> +}
> >>>> +
> >>>>  static void
> >>>>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int in=
itial)
> >>>>  {
> >>>> @@ -4664,23 +4684,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se, int initial)
> >>>>                 vruntime +=3D sched_vslice(cfs_rq, se);
> >>>>
> >>>>         /* sleeps up to a single latency don't count. */
> >>>> -       if (!initial) {
> >>>> -               unsigned long thresh;
> >>>> -
> >>>> -               if (se_is_idle(se))
> >>>> -                       thresh =3D sysctl_sched_min_granularity;
> >>>> -               else
> >>>> -                       thresh =3D sysctl_sched_latency;
> >>>> -
> >>>> -               /*
> >>>> -                * Halve their sleep time's effect, to allow
> >>>> -                * for a gentler effect of sleepers:
> >>>> -                */
> >>>> -               if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >>>> -                       thresh >>=3D 1;
> >>>> -
> >>>> -               vruntime -=3D thresh;
> >>>> -       }
> >>>> +       if (!initial)
> >>>> +               vruntime -=3D sched_sleeper_credit(se);
> >>>>
> >>>>         /*
> >>>>          * Pull vruntime of the entity being placed to the base leve=
l of
> >>>> @@ -4690,7 +4695,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sch=
ed_entity *se, int initial)
> >>>>          * inversed due to s64 overflow.
> >>>>          */
> >>>>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start=
;
> >>>> -       if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>>> +       if (se->exec_start !=3D 0 && (s64)sleep_time > 60LL * NSEC_P=
ER_SEC)
> >>>>                 se->vruntime =3D vruntime;
> >>>>         else
> >>>>                 se->vruntime =3D max_vruntime(se->vruntime, vruntime=
);
> >>>> @@ -7634,8 +7639,12 @@ static void migrate_task_rq_fair(struct task_=
struct *p, int new_cpu)
> >>>>          */
> >>>>         if (READ_ONCE(p->__state) =3D=3D TASK_WAKING) {
> >>>>                 struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >>>> +               u64 sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se=
->exec_start;
> >>>>
> >>>> -               se->vruntime -=3D u64_u32_load(cfs_rq->min_vruntime)=
;
> >>>> +               if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>>
> >>> You also need to test (se->exec_start !=3D0) here because the task mi=
ght
> >>
> >> Hi,
> >>
> >> I don't understand when the another migration happend. Could you tell =
me in more detail?
> >
> > se->exec_start is update when the task becomes current.
> >
> > You can have the sequence:
> >
> > task TA runs on CPU0
> >     TA's se->exec_start =3D xxxx
> > TA is put back into the rb tree waiting for next slice while another
> > task is running
> > CPU1 pulls TA which migrates on CPU1
> >     migrate_task_rq_fair() w/ TA's se->exec_start =3D=3D xxxx
> >         TA's se->exec_start =3D 0
> > TA is put into the rb tree of CPU1 waiting to run on CPU1
> > CPU2 pulls TA which migrates on CPU2
> >     migrate_task_rq_fair() w/ TA's se->exec_start =3D=3D 0
> >         TA's se->exec_start =3D 0
> Hi, Vincent,
>
> yes, you're right, such sequence does exist. But at this point, p->__stat=
e !=3D TASK_WAKING.
>
> I have a question, Whether there is case that is "p->se.exec_start =3D=3D=
 0 && p->__state =3D=3D TASK_WAKING" ?
> I analyzed the code and concluded that this case isn't existed, is it rig=
ht?

Yes, you're right. Your proposal is enough

Thanks

>
> Thanks.
> ZhangQiao.
>
> >
> >>
> >> I think the next migration will happend after the wakee task enqueued,=
 but at this time
> >> the p->__state isn't TASK_WAKING, p->__state already be changed to TAS=
K_RUNNING at ttwu_do_wakeup().
> >>
> >> If such a migration exists, Previous code "se->vruntime -=3D u64_u32_l=
oad(cfs_rq->min_vruntime);" maybe
> >> perform multiple times=EF=BC=8Cwouldn't it go wrong in this way?
> >
> > the vruntime have been updated when enqueued but not exec_start
> >
> >>
> >>> migrate another time before being scheduled. You should create a
> >>> helper function like below and use it in both place
> >>
> >> Ok, I will update at next version.
> >>
> >>
> >> Thanks,
> >> ZhangQiao.
> >>
> >>>
> >>> static inline bool entity_long_sleep(se)
> >>> {
> >>>         struct cfs_rq *cfs_rq;
> >>>         u64 sleep_time;
> >>>
> >>>         if (se->exec_start =3D=3D 0)
> >>>                 return false;
> >>>
> >>>         cfs_rq =3D cfs_rq_of(se);
> >>>         sleep_time =3D rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> >>>         if ((s64)sleep_time > 60LL * NSEC_PER_SEC)
> >>>                 return true;
> >>>
> >>>         return false;
> >>> }
> >>>
> >>>
> >>>> +                       se->vruntime =3D -sched_sleeper_credit(se);
> >>>> +               else
> >>>> +                       se->vruntime -=3D u64_u32_load(cfs_rq->min_v=
runtime);
> >>>>         }
> >>>>
> >>>>         if (!task_on_rq_migrating(p)) {
> >>>>
> >>>>
> >>>>
> >>>> Thanks.
> >>>> Zhang Qiao.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Roman.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Amazon Development Center Germany GmbH
> >>>>>> Krausenstr. 38
> >>>>>> 10117 Berlin
> >>>>>> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> >>>>>> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> >>>>>> Sitz: Berlin
> >>>>>> Ust-ID: DE 289 237 879
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>> .
> >>>>>
> >>> .
> >>>
> > .
> >
