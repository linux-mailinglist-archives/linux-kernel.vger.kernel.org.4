Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273172CEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbjFLSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjFLSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:52:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590A4E7B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:52:31 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f98276f89cso40521cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686595950; x=1689187950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2DMnkcXS2vXceGlFkWVH3wJNfsts8UCd4Bp7aJS6Dw=;
        b=tPqcVHKfyEcNdpaI6BpMNRKImboKR9JrqeXjVs+A07NDRoALE8OxlGRL0gjTeiYl+m
         DKcj+gbW9Fo7FBeJSty/RTJsJ5nULw2UjFksxs4ynIZ2FGjW7WXCQGPNkJlEWXunTy+J
         kqMh28TJ5DJHg+NZgnZVaMsGGcTpewQbSrRK+9eLlLlFS0UcRnYR1GqdZSrf/7Df3m4/
         2izsJrOgLXFZp/Rme8RJqb9/ENUTTl1CHwFFapTmn9xePqYmnI+/69YSQ71DXrWTNl/b
         8+HSNmerHbxnuu5VlCYjvDQBQUHS9xCyUuMtKoms4xtGds+mJQU2d2spLgYIDYROetKO
         AC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595950; x=1689187950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2DMnkcXS2vXceGlFkWVH3wJNfsts8UCd4Bp7aJS6Dw=;
        b=k8QC30LWmsdo8hMTtsBNGEJZqrDk8YS9VLXy3u0PtGAHMRg0Q+zyNIRAT5t3ShIC8h
         hVdIpLKM0W+6wqYCXAzUVLKMWW2hnGgbdtMtttxulHZT79A9mYZfdl2Zd4+9ThV+f4ST
         1b+76VgPlADAtHWcRLWinnpW4VUIA39UUafPNvHesHnhOYQWa+T1HSzOKh0Zpgai9r4r
         BLK9IQZ8OVDNlNXUEr3bF1zxV11b199keM6vqieaq5/5RO+/KETTc1Xu1ophUNUZ1PhZ
         o86kNBlqDYqOhEZvso468z5zuKPzTzYRUE1zPiHnvxpeFQs/6GAssSDPdTCMlmWGsbOa
         OWpg==
X-Gm-Message-State: AC+VfDyKZsC83N47uVigV716qz6dOLNAuTJE+KIPvSW7aRtZARid0gzn
        QlSII1qiYp+HjqCflzihdlri6XUMwoGj8Fp/7BzY
X-Google-Smtp-Source: ACHHUZ4T1bovuHAgZEW+AovebUJSV8KUW/JJtyF7abqt9gbKMS+5qovS3tCoYtFchMpeq1h0dgf46AOsxQObrSXjxks=
X-Received: by 2002:a05:622a:10b:b0:3e3:8c75:461 with SMTP id
 u11-20020a05622a010b00b003e38c750461mr32698qtw.6.1686595950166; Mon, 12 Jun
 2023 11:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com> <c12889cf-d57e-90be-54a5-0329183817fb@amd.com>
In-Reply-To: <c12889cf-d57e-90be-54a5-0329183817fb@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 12 Jun 2023 11:52:19 -0700
Message-ID: <CANDhNCo5yiHzyFaJO6Aks=sCiS2PekPscwWa-8Zbw2bQaVtTeA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Generalized Priority Inheritance via Proxy
 Execution v3
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
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

On Mon, Jun 12, 2023 at 10:21=E2=80=AFAM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
> On 6/1/2023 11:28 AM, John Stultz wrote:
> > After having to catch up on other work after OSPM[1], I've finally
> > gotten back to focusing on Proxy Execution and wanted to send out this
> > next iteration of the patch series for review, testing, and feedback.
> > (Many thanks to folks who provided feedback on the last revision!)
> >
> > As mentioned previously, this Proxy Execution series has a long history=
:
> > First described in a paper[2] by Watkins, Straub, Niehaus, then from
> > patches from Peter Zijlstra, extended with lots of work by Juri Lelli,
> > Valentin Schneider, and Connor O'Brien. (and thank you to Steven Rosted=
t
> > for providing additional details here!)
> >
> > So again, many thanks to those above, as all the credit for this series
> > really is due to them - while the mistakes are likely mine.
> >
> > Overview:
> > =E2=80=94----------
> > Proxy Execution is a generalized form of priority inheritance. Classic
> > priority inheritance works well for real-time tasks where there is a
> > straight forward priority order to how things are run. But it breaks
> > down when used between CFS or DEADLINE tasks, as there are lots
> > of parameters involved outside of just the task=E2=80=99s nice value wh=
en
> > selecting the next task to run (via pick_next_task()).  So ideally we
> > want to imbue the mutex holder with all the scheduler attributes of
> > the blocked waiting task.
> >
> > Proxy Execution does this via a few changes:
> > * Keeping tasks that are blocked on a mutex *on* the runqueue
> > * Keeping additional tracking of which mutex a task is blocked on, and
> >   which task holds a specific mutex.
> > * Special handling for when we select a blocked task to run, so that we
> >   instead run the mutex holder.
> >
> > The first of these is the most difficult to grasp (I do get the mental
> > friction here: blocked tasks on the *run*queue sounds like nonsense!
> > Personally I like to think of the runqueue in this model more like a
> > =E2=80=9Ctask-selection queue=E2=80=9D).
> >
> > By leaving blocked tasks on the runqueue, we allow pick_next_task() to
> > choose the task that should run next (even if it=E2=80=99s blocked wait=
ing on a
> > mutex). If we do select a blocked task, we look at the task=E2=80=99s b=
locked_on
> > mutex and from there look at the mutex=E2=80=99s owner task. And in the=
 simple
> > case, the task which owns the mutex is what we then choose to run,
> > allowing it to release the mutex.
> >
> > This means that instead of just tracking =E2=80=9Ccurr=E2=80=9D, the sc=
heduler needs to
> > track both the scheduler context (what was picked and all the state use=
d
> > for scheduling decisions), and the execution context (what we=E2=80=99r=
e
> > running)
> >
> > In this way, the mutex owner is run =E2=80=9Con behalf=E2=80=9D of the =
blocked task
> > that was picked to run, essentially inheriting the scheduler context of
> > the blocked task.
> >
> > As Connor outlined in a previous submission of this patch series,  this
> > raises a number of complicated situations:  The mutex owner might itsel=
f
> > be blocked on another mutex, or it could be sleeping, running on a
> > different CPU, in the process of migrating between CPUs, etc.
> >
> > But the functionality provided by Proxy Execution is useful, as in
> > Android we have a number of cases where we are seeing priority inversio=
n
> > (not unbounded, but longer than we=E2=80=99d like) between =E2=80=9Cfor=
eground=E2=80=9D and
> > =E2=80=9Cbackground=E2=80=9D SCHED_NORMAL applications, so having a gen=
eralized solution
> > would be very useful.
> >
> > New in v4:
> > =E2=80=94------
> > * Fixed deadlock that was caused by wait/wound mutexes having circular
> >   blocked_on references by clearing the blocked_on pointer on the task
> >   we are waking to wound/die.
> >
> > * Tried to resolve an issue Dietmar raised with RT balancing where the
> >   proxy migration and push_rt_task() were fighting ping-ponging tasks
> >   back and forth, caused by push_rt_task() migrating tasks even if they
> >   were in the chain that ends with the current running task. Though thi=
s
> >   likely needs more work, as this change resulted in different migratio=
n
> >   quirks (see below).
> >
> > * Fixed a number of null-pointer traversals that the changes were
> >   occasionally tripping on
> >
> > * Reworked patch that exposes __mutex_owner() to the scheduler to ensur=
e
> >   it doesn=E2=80=99t expose it any more than necessary, as suggested by=
 Peter.
> >
> > * To address some of Peter=E2=80=99s complaints, backed out the rq_curr=
()
> >   wrapper, and reworked rq_selected() to be a macro to avoid needing
> >   multiple accessors for READ_ONCE/rcu_dereference() type accesses.
> >
> > * Removed verbose legacy comments from previous developers of the serie=
s
> >   as Dietmar was finding them distracting when reviewing the diffs
> >   (Though, to ensure I heed the warnings from previous experienced
> >   travelers, I=E2=80=99ve preserved the comments/questions in a separat=
e patch
> >   in my own development tree).
> >
> > * Dropped patch that added *_task_blocked_on() wrappers to check lockin=
g
> >   correctness. Mostly as Peter didn=E2=80=99t seem happy with the wrapp=
ers in
> >   other patches, but I still think it's useful for testing (and the
> >   blocked_on locking still needs some work), so I=E2=80=99m carrying it=
 in my
> >   personal development tree.
> >
> > Issues still to address:
> > =E2=80=94----------
> > * Occasional getting null scheduler entities from pick_next_entity() in
> >   CFS. I=E2=80=99m a little stumped as to where this is going awry just=
 yet, and
> >   delayed sending this out, but figured it was worth getting it out for
> >   review on the other issues while I chase this down.
>
> I'm consistently hitting the above issue early during the boot when I was
> trying to test the series on a dual socket 3rd Generation EPYC platform
> (2 x 64C/128T). Sharing the trace below:
>
>     [   20.821808] ------------[ cut here ]------------
>     [   20.826432] kernel BUG at kernel/sched/core.c:7462!
>     [   20.831322] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>     [   20.836545] CPU: 250 PID: 0 Comm: swapper/250 Not tainted 6.4.0-rc=
4-proxy-execution-v4+ #474
>     [   20.844976] Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS =
2.7.3 03/30/2022
>     [   20.852544] RIP: 0010:__schedule+0x18b6/0x20a0
>     [   20.856998] Code: 0f 85 51 04 00 00 83 ad 50 ff ff ff 01 0f 85 05 =
e9 ff ff f3 0f 1e fa 48 8b 35 0e 0c fe 00 48 c7 c7 33 a1 c1 85 e8 ca 37 23 =
ff <0f> 0b 4c 89 ff 4c 8b 6d 98 e8 1c 82 00 00 4c 89 f7 e8 14 82 00 00
>     [   20.875744] RSP: 0018:ffffbd1e4d1d7dd0 EFLAGS: 00010082
>     [   20.880970] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000=
00000000005
>     [   20.888104] RDX: ffff9d4d0006b000 RSI: 0000000000000200 RDI: ffff9=
d4d0004d400
>     [   20.895235] RBP: ffffbd1e4d1d7e98 R08: 0000000000000024 R09: fffff=
fffff7edbd0
>     [   20.902369] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9=
d4d12e25a20
>     [   20.909501] R13: ffff9dcbffab3840 R14: ffffbd1e4d1d7e50 R15: ffff9=
dcbff2b3840
>     [   20.916632] FS:  0000000000000000(0000) GS:ffff9dcbffa80000(0000) =
knlGS:0000000000000000
>     [   20.924709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [   20.930449] CR2: 00007f92120c4800 CR3: 000000011477a002 CR4: 00000=
00000770ee0
>     [   20.937581] PKRU: 55555554
>     [   20.940292] Call Trace:
>     [   20.942741]  <TASK>
>     [   20.944845]  ? show_regs+0x6e/0x80
>     [   20.948259]  ? die+0x3c/0xa0
>     [   20.951146]  ? do_trap+0xd4/0xf0
>     [   20.954377]  ? do_error_trap+0x75/0xa0
>     [   20.958129]  ? __schedule+0x18b6/0x20a0
>     [   20.961971]  ? exc_invalid_op+0x57/0x80
>     [   20.965808]  ? __schedule+0x18b6/0x20a0
>     [   20.969648]  ? asm_exc_invalid_op+0x1f/0x30
>     [   20.973835]  ? __schedule+0x18b6/0x20a0
>     [   20.977672]  ? cpuidle_enter_state+0xde/0x710
>     [   20.982033]  schedule_idle+0x2e/0x50
>     [   20.985614]  do_idle+0x15d/0x240
>     [   20.988845]  cpu_startup_entry+0x24/0x30
>     [   20.992772]  start_secondary+0x126/0x160
>     [   20.996695]  secondary_startup_64_no_verify+0x10b/0x10b
>     [   21.001924]  </TASK>
>     [   21.004117] Modules linked in: sch_fq_codel dm_multipath scsi_dh_r=
dac scsi_dh_emc scsi_dh_alua ipmi_devintf ipmi_msghandler msr ramoops reed_=
solomon pstore_blk pstore_zone efi_pstore
>     ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async=
_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32=
c raid1 raid0 multipath linear mgag200
>     i2c_algo_bit drm_shmem_helper drm_kms_helper ghash_clmulni_intel sysc=
opyarea sysfillrect aesni_intel sysimgblt crypto_simd crc32_pclmul cryptd c=
rct10dif_pclmul sha512_ssse3 xhci_pci tg3 drm
>     xhci_pci_renesas megaraid_sas wmi
>     [   21.055707] Dumping ftrace buffer:
>     [   21.059291] ---------------------------------
>     [   21.063697]   <idle>-0       250dn.2. 21175635us : __schedule: JDB=
: BUG!!! pick next retry_count > 50
>     [   21.072915] ---------------------------------
>     [   21.077282] ---[ end trace 0000000000000000 ]---
>
>     $ sed -n 7460,7462p kernel/sched/core.c
>       if (retry_count++ > 50) {
>               trace_printk("JDB: BUG!!! pick next retry_count > 50\n");
>               BUG();
>
> Hope it helps during the debug. If you have a fix in mind that you
> would like me to test, please do let me know.

Thank you for the testing and feedback here! I really appreciate it!
And my apologies that you're hitting trouble here!

> > * Better deadlock handling in proxy(): With the ww_mutex issues
> >   resolved, we shouldn=E2=80=99t see circular blocked_on references, bu=
t a
> >   number of the bugs I=E2=80=99ve been chasing recently come from getti=
ng stuck
> >   with proxy() returning null forcing a reselection over and over. Thes=
e
> >   are still bugs to address, but my current thinking is that if we get
> >   stuck like this, we can start to remove the selected mutex blocked
> >   tasks from the rq, and let them be woken from the mutex waiters list
> >   as is done currently? Thoughts here would be appreciated.
> >
> > * More work on migration correctness (RT/DL load balancing,etc). I=E2=
=80=99m
> >   still seeing occasional trouble as cpu counts go up which seems to be
> >   due to a bunch of tasks being proxy migrated to a cpu, then having to
> >   migrate them all away at once (seeing lots of pick again iterations).
> >   This may actually be correct, due to chain migration, but it ends up
> >   looking similar to a deadlock.

So I suspect what you're seeing is a combination of the two items
above. With 128 threads, my deadlock detection BUG() at 50 is probably
far too low, as migration chains can get pretty long.
Clearly BUG'ing at a fixed count is the wrong approach (but was
helpful for quickly catching problems and debugging in my
environment).

My main priority is trying to get the null se crashes resolved (almost
have my hands around it, but took a little break from it end of last
week), and once I have something there I'll update and share my WIP
tree:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-WIP

To include some extra trace logging and I'll reach out to see if you
can capture the issue again.

Thanks so much again for your interest and help in testing!
-john
