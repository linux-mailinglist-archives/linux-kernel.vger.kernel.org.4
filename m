Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47263CDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiK3DKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3DKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:10:04 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01A51333
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:10:03 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-142306beb9aso19492821fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiBfGy/D50+OJo68XURRrTVFMzHCGYAlCy+F0thcAJI=;
        b=cFztHSyj4cEkRpf5XW0Y8jH62ueQCuY8rfd4oepOLSUPBSzLptI9niAG9KfrlEaCIf
         2IxR+A6w/abzd/5wNkC10VTvrJvJ4vXfxbhNqQOQx8vygP09Wh2FC672RPePfsep0r4j
         YaHnrBlJhN8B10hphOYxoCAoODlOtlMlViLJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiBfGy/D50+OJo68XURRrTVFMzHCGYAlCy+F0thcAJI=;
        b=BI8wucHGmFl6emxiLPead85EokQ4PH6PHGIbxWbJLlSSS/SoCCpSeJrxJLEeuYRetQ
         hpjxFiXNlUw6aVH24FkbLiQ/DlZ/2uOcdpRdu/8adb2QRwYiDnSA5sleEDuy5z3wJSFU
         NUlHIc4BpHphhNivTJLrQdeuJE7aPz1pdzoFCOOCM0PtKMncTRIIew0jWuViCEA9rpUE
         NECQdqDK1EMdoPDNxVwkiWOT/8Ux8IwFMMIjHI68Pt5wryGkXIu3l4mmVHrvY27wfmCi
         9+tQG/KJYtwEWNR0JoutB88ye1CHId/v7eCtAKUavl5/eXgSuYzQ+Z7/y6ND8Aeo48l1
         9W/A==
X-Gm-Message-State: ANoB5pnOtIWfWmKyi9m1FfjjW5mrK77jv8BrQWLlE0HkLrv/CdDzNEK0
        hz05IJy+6scupUg79f7/IL/iwlRzd+RGssHmDInXaA==
X-Google-Smtp-Source: AA0mqf7kdWYMlkb5NOwv/nEEEM4hHk1y1g7QlwmpEkE9Ryu9nNRVzFEi3lALO6X38I/EVpzmJR3PEjQ2szl83cWX1Bw=
X-Received: by 2002:a05:6870:bacb:b0:13a:dd16:9b83 with SMTP id
 js11-20020a056870bacb00b0013add169b83mr35872901oab.15.1669777802465; Tue, 29
 Nov 2022 19:10:02 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtCZ5CttibZ9o18woLiQgzFeKCBMDAGrhMd3kbgX2qs29Q@mail.gmail.com>
 <E5C05A33-06E4-4627-8108-145752D72A24@joelfernandes.org> <CAKfTPtBZ8xfoP4=W1K5vaBBm5b05Ak9ojAdJeb2hvs5W=W3gmw@mail.gmail.com>
In-Reply-To: <CAKfTPtBZ8xfoP4=W1K5vaBBm5b05Ak9ojAdJeb2hvs5W=W3gmw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Nov 2022 03:09:51 +0000
Message-ID: <CAEXW_YRpYx3VC+PdM2J=QhZipcy59A46YnjyE0zpUQe3c4Ck8A@mail.gmail.com>
Subject: Re: [PATCH 5/9] sched/fair: Take into account latency priority at wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org
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

Hi Vincent,

On Tue, Nov 29, 2022 at 5:21 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
[...]
> > >>> }
> > >>>
> > >>> /*
> > >>> @@ -7544,7 +7558,7 @@ static int __sched_setscheduler(struct task_s=
truct *p,
> > >>>                if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> > >>>                        goto change;
> > >>>                if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> > >>> -                   attr->sched_latency_nice !=3D p->latency_nice)
> > >>> +                   attr->sched_latency_nice !=3D LATENCY_TO_NICE(p=
->latency_prio))
> > >>>                        goto change;
> > >>>
> > >>>                p->sched_reset_on_fork =3D reset_on_fork;
> > >>> @@ -8085,7 +8099,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, st=
ruct sched_attr __user *, uattr,
> > >>>        get_params(p, &kattr);
> > >>>        kattr.sched_flags &=3D SCHED_FLAG_ALL;
> > >>>
> > >>> -       kattr.sched_latency_nice =3D p->latency_nice;
> > >>> +       kattr.sched_latency_nice =3D LATENCY_TO_NICE(p->latency_pri=
o);
> > >>>
> > >>> #ifdef CONFIG_UCLAMP_TASK
> > >>>        /*
> > >>> @@ -11294,6 +11308,20 @@ const u32 sched_prio_to_wmult[40] =3D {
> > >>>  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
> > >>> };
> > >>>
> > >>> +/*
> > >>> + * latency weight for wakeup preemption
> > >>> + */
> > >>> +const int sched_latency_to_weight[40] =3D {
> > >>> + /* -20 */     -1024,     -973,     -922,      -870,      -819,
> > >>> + /* -15 */      -768,     -717,     -666,      -614,      -563,
> > >>> + /* -10 */      -512,     -461,     -410,      -358,      -307,
> > >>> + /*  -5 */      -256,     -205,     -154,      -102,       -51,
> > >>> + /*   0 */         0,       51,      102,       154,       205,
> > >>> + /*   5 */       256,      307,      358,       410,       461,
> > >>> + /*  10 */       512,      563,      614,       666,       717,
> > >>> + /*  15 */       768,      819,      870,       922,       973,
> > >>> +};
> > >>> +
> > >>
> > >> The table is linear. You could approximate this as: weight =3D nice =
* 51
> > >> since it is a linear scale and do the conversion in place.
> > >>
> > >> Or, since the only place you are using the latency_to_weight is in
> > >> set_latency_offset(), can we drop the sched_latency_to_weight array
> > >> and simplify as follows?
> > >
> > > It's also used in cgroup patch and keeps a coherency between
> > > nice/weight an latency_nice/offset so I prefer
> >
> > I dont think it=E2=80=99s a valid comparison as nice/weight conversion =
are non linear and over there a table makes sense: weight =3D 1024 / 1.25 ^=
 nice
> >
> > > keeping current
> > > implementation
> >
> > I could be missing something, but, since its a linear scale, why does c=
group need weight at all? Just store nice directly. Why would that not work=
?
> >
> > In the end the TG and SE has the latency offset in the struct, that is =
all you care about. All the conversion back and forth is unnecessary, as it=
 is a linear scale and just increases LOC and takes more memory to store li=
near arrays.
> >
> > Again I could be missing something and I will try to play with your ser=
ies and see if I can show you what I mean (or convince myself it=E2=80=99s =
needed).
>
> I get what you mean but I think that having an array gives latitude to
> adjust this internal offset mapping at a minimum cost of a const array

Ok that makes sense. If you feel like there might be updates in the
future to this mapping array (like changing the constants as you
mentioned), then I am Ok with us keeping it.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I am excited about your series, the CFS latency issues have been
thorny. This feels like a step forward in the right direction. Cheers,

 - Joel
