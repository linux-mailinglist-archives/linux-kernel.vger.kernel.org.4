Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8CF6C120F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCTMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCTMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:41:07 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332F16AC5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:41:03 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l15so4851151ilv.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679316062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtR4GRxDhN+q/NAPtY8ei8OWcAjOM8QOVYwxp3Ctntw=;
        b=aikLgFR5rA4m5KCR0VOg2iuIVZwuARiCv1WBZ0Usv0/BlOphmJynurKGsKQwKJI7GV
         QRwh8QGXOh/bhbKNPvoAPrRMM8kcT+lRldVtvEzPdXVuvIxDwfrYJHfpUxgLZU6ouHAa
         EwSkfds1FskkWokQutku8KKnz8tBvrDxnQ/fGnEyz/Jq0OWceY3JuUQKpZXfwJS4ZvCg
         xK+JIM86K8HWVB4gNpDZwD9kLX8ctPKpuitJ3VIRC9OLySpfPlDYzFh4c+GoC26xt7GO
         hQpq1YGf31A7Skpvc/OhBbl6Eyk6TFQ9U3O3oNBm/HPfp/MgtuKNbvNQ+Bk8Cb3gB3mf
         x9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679316062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtR4GRxDhN+q/NAPtY8ei8OWcAjOM8QOVYwxp3Ctntw=;
        b=n+N0Dvl+1wnOuTnpPrd5qeL6GFRExIXL/lr4C4oR7uLBKJcoHkBlhbTpNp8nwNhrWm
         8BMcN3vO5mU4gpf2qs2YJUC/QvWK4l1QugNSwVK7/yifSaBQwaf0GuuurSJv9Nk1Mffw
         7083+UqpNdDwBRg2lbFxphQuh8+kD+FXVLy2kWsdPexqpfB8a1QifmR0+RIIJwfXYJZa
         5Q29LKwsjHgzfBioCptz8/VMxjNNSaL4BCdjcI/wFS9t+MrliqnW0zbOgsN5AOxF9aL0
         58mbZmoUrjG4v2+eqB8I2csQxnnfkbqWwKebaNHI0Lb3pCf0sT+hk8rgpWT5mhUDP0J4
         w+ww==
X-Gm-Message-State: AO0yUKV5g5H0EG3MXA7xTH1KeeDVgIFcgR1qLloX5GibFz1DZps9c7xQ
        COCVtVyG4A3dTbHD0Khn8UIRVHkvW/oylKKQ4lI=
X-Google-Smtp-Source: AK7set/mhmS/ij6A7fMpYdKY7Rv+3ba8W2X3yQSO+z5YtvOaDuLa12c6FZK8HnvqNS6PvMHv7+XeJlm4wK7x+usOgyA=
X-Received: by 2002:a92:d0c7:0:b0:316:fa49:3705 with SMTP id
 y7-20020a92d0c7000000b00316fa493705mr3004572ila.1.1679316062405; Mon, 20 Mar
 2023 05:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230319075643.28312-1-wuchi.zero@gmail.com> <20230320082811.GD2194297@hirez.programming.kicks-ass.net>
In-Reply-To: <20230320082811.GD2194297@hirez.programming.kicks-ass.net>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Mon, 20 Mar 2023 20:40:51 +0800
Message-ID: <CA+tQmHBfp2ecNC1j+w0uBs5jbYwa_-JD72Rwvhxx1Q4Pv8m+XQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Reduce cost of sched_move_task when config autogroup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 16:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Mar 19, 2023 at 03:56:43PM +0800, wuchi wrote:
> > Some sched_move_task calls of autogroup is useless when the
> > task_struct->sched_task_group isn't changed because of task_group
> > of cpu_cgroup overlay task_group of autogroup. The overlay key codes
> > are as follows:
> >
> > sched_cgroup_fork->autogroup_task_group->task_wants_autogroup
> > sched_change_group->autogroup_task_group->autogroup_task_group
> >
> > sched_move_task eg:
> > task A belongs to cpu_cgroup0 and autogroup0, it will always to
> > cpu_cgroup0 when doing exit. So there is no need to do {de|en}queue.
> > The call graph is as follow.
> >
> > do_exit
> >   sched_autogroup_exit_task
> >     sched_move_task
> >       dequeue_task
> >         sched_change_group
> >         A.sched_task_group =3D sched_get_task_group
> >       enqueue_task
> >
> > So do some check before dequeue task in sched_move_task.
>
> No immediate objection; but the $subject seems to suggest you did this
> for performance reasons, yet there are no performance results in this
> Changelog. How much does this save under what load?

cpu:bogomips=3D4600.00
kernel:6.3.0-rc3
cpu cgroup: 6:cpu,cpuacct:/user.slice

run cmds:

#!/bin/bash
for i in {0..10000}; do
sleep 0 &
done
wait

bpftrace -e 'k:sched_move_task { @ts[tid] =3D nsecs; }
kr:sched_move_task /@ts[tid]/ { @ns +=3D nsecs - @ts[tid];
delete(@ts[tid]); }'

cost time(ns):
 without patch: 43528033
 with      patch: 18934496
                  diff: -24593537  -56.5%

About the change, move sched_task_group_changed before
update_rq_clock as following and add the performance results in
the Changelog?

@@ -10369,6 +10390,9 @@ void sched_move_task(struct task_struct *tsk)
        rq =3D task_rq_lock(tsk, &rf);

+       if (!sched_task_group_changed(tsk))
+               goto unlock;
+
        update_rq_clock(rq);
