Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB92607F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJUTyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJUTyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:54:50 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3A1A040
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:54:28 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j7so4524762ybb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aKDRhV6+P8y8NS31jd40v/miJa3wKTc00qffGxh0ckM=;
        b=NRP6+rr5EWQI72Hxguoy9IS+tHGZpHNCE2b1jmRLbDzSgRnTk5k+2tkuvQeeavACrS
         HhGZ9IBH6jSxzZBNyAaUm+X+5n+M3mFWLZz8EjekXMSHBjIE6OQdyfq7hLbXZzvhsMWq
         sUm+EEyjXaINqolyzHIM/2Xxgj6JHkRgvepong41lEH02f06voXMJKPUlDO1nphn8Pti
         MDe5XcQ1mHgkgVk5RrLjaJU3sWGJTTBjKvhK8UbRW1R4U9HHgOSyKaNcOECIUiVNf09Z
         c2CWuGEy4lnRJfGN6WSBly/UfJtMia2F0jBF1hLVbnjxp/GJxvJbNc36rKP+f3P94DAM
         z6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKDRhV6+P8y8NS31jd40v/miJa3wKTc00qffGxh0ckM=;
        b=Tc345urLRzuimqfqmhnPY/azPTaqOBTBoSNR+ekE7YnsTCFiFvuspzJZxIVEpp9Ee0
         wTAKptvHISpV7z0eOQuBbGu+da587t2pd5X9J32YMP1ODb86g1bpnsIjJY1WMyc/XtER
         8dC7ujKf2w0xulOQTjt3NaycZMKypeHJPxJ0DnQPG1MoUf5dyhX+D2fR6kOOlEIivIx4
         SrwzNQC1E/ZdAKjOXhSVGdAouK734zGyPFd+zNnFVqXDu1Tvdo9CstS0m6tQc6+YVgJ2
         a202tw/qkR4YE6/00UXhJuvVnJuWO4nRLo7NFNkbbJ2K03tORcqxn6tnSoOtPuL04hTN
         n9vg==
X-Gm-Message-State: ACrzQf1ydxVUriS8ulBf3i7HB+84H9ypthMiC+VY96/Dq8s81SXN1uuc
        sC6F11EqqseR2SGIcAOBRyNlWuBFajaqdflXTkGQSEY8lYmeNA==
X-Google-Smtp-Source: AMsMyM4nOLDMI0WmAfHPixBfD0bkNyKdGWcZfgFjzhjJTHir6XneEF6paAkIr+PK69rV0iOL4c4DFaEtTW075JpKdko=
X-Received: by 2002:a05:6902:1244:b0:6bd:6409:9591 with SMTP id
 t4-20020a056902124400b006bd64099591mr18372435ybu.431.1666382067315; Fri, 21
 Oct 2022 12:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221010225744.101629-1-surenb@google.com> <20221021013613.1428-1-hdanton@sina.com>
In-Reply-To: <20221021013613.1428-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Oct 2022 12:54:16 -0700
Message-ID: <CAJuCfpGMnoci2y_JiM0LR_OnY1MPKhpabhfAJZCpzzUiGMdL+w@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/1] psi: stop relying on timer_pending for
 poll_work rescheduling
To:     Hillf Danton <hdanton@sina.com>
Cc:     peterz@infradead.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 7:11 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On 10 Oct 2022 15:57:44 -0700 Suren Baghdasaryan <surenb@google.com>
> > Psi polling mechanism is trying to minimize the number of wakeups to
> > run psi_poll_work and is currently relying on timer_pending() to detect
> > when this work is already scheduled. This provides a window of opportunity
> > for psi_group_change to schedule an immediate psi_poll_work after
> > poll_timer_fn got called but before psi_poll_work could reschedule itself.
> > Below is the depiction of this entire window:
> >
> > poll_timer_fn
> >   wake_up_interruptible(&group->poll_wait);
> >
> > psi_poll_worker
> >   wait_event_interruptible(group->poll_wait, ...)
> >   psi_poll_work
> >     psi_schedule_poll_work
> >       if (timer_pending(&group->poll_timer)) return;
> >       ...
> >       mod_timer(&group->poll_timer, jiffies + delay);
>
> [...]
>
> >
> > -/* Schedule polling if it's not already scheduled. */
> > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > +/* Schedule polling if it's not already scheduled or forced. */
> > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > +                                bool force)
> >  {
> >       struct task_struct *task;
> >
> >       /*
> > -      * Do not reschedule if already scheduled.
> > -      * Possible race with a timer scheduled after this check but before
> > -      * mod_timer below can be tolerated because group->polling_next_update
> > -      * will keep updates on schedule.
> > +      * atomic_xchg should be called even when !force to provide a
> > +      * full memory barrier (see the comment inside psi_poll_work).
> >        */
> > -     if (timer_pending(&group->poll_timer))
> > +     if (atomic_xchg(&group->poll_scheduled, 1) && !force)
> >               return;
>
> If poll_scheduled works, turning poll_timer, which only wakes up poll
> worker, to a delayed work also works because schedule_delayed_work()
> takes care of pending work, with the bonus of cutting poll worker.

Thanks for the suggestion, Hillf.
psi_poll_worker runs at a low FIFO priority to prevent normal tasks
from preempting PSI signal generation (see sched_set_fifo_low() call
inside psi_poll_worker()), so schedule_delayed_work() would not be
usable as is I think, since it uses normal priority system_wq. I would
probably need to use queue_delayed_work() with a dedicated workqueue
that uses a worker with worker->task set to the same FIFO priority.
However I'm not sure it's worth creating a workqueue for only one task
that might be scheduled in it...
Thanks,
Suren.

>
> Hillf
