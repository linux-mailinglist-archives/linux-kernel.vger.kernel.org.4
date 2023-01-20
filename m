Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB2675ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjATUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjATUQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCB111EB1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674245713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+424KJ/4eUBc5hj2I5II2IUgeWEg8+zfHrFyPZ3+UE=;
        b=gYFfkDTKAhOM/inY1Sa2dbYkmOqBQcvHCnXssjLOe+XgM1Sknx2xrRNngtenHN13VlMe6K
        qc+fgQ1t0o6ZoEZdPxhCWaJCRsm4JjN0RXOsoBuGZAL9fDdCtmrgV99TMeUerI0mObTssu
        5g/VKA2ePy4YpJZ0DZIBcDMAoNxFRUs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-171--ilCNXp6OqKobq1OELsGPw-1; Fri, 20 Jan 2023 15:15:11 -0500
X-MC-Unique: -ilCNXp6OqKobq1OELsGPw-1
Received: by mail-pf1-f197.google.com with SMTP id c5-20020aa78805000000b0058d983c708aso2907485pfo.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+424KJ/4eUBc5hj2I5II2IUgeWEg8+zfHrFyPZ3+UE=;
        b=mPL+eH1SsqkLV3AtejOhkhLRaLRNw+722bMXqnPSGSVtocf0Ndp+e56hJdnnvYZYED
         GG28Dux7HLwp/1eZwgWLzQKIPbv+2u2TxkKuPiy1KSnRmHDyPhBdYeQiATXRyM75nGBT
         HpkY9lmh0qAotUGBXN88otQznT7p4D1PJ5gvAGhjjO7nMOTvCPtIMt/U4XqpH3BtLELL
         4yk0pWS/j/pnsCFo1dnwUHs0QF+H0O5zDOXwdXF2NZ6x7+EywK/VMfzS75ZQUCidth9j
         Ld0qMYSRvEtTn/+vr8i0P+KzKbIHbbqTNofnpeLfoT1yU8dG8oLqg4iPhvoNPbMW814M
         Xadg==
X-Gm-Message-State: AFqh2kqTq2z9y+WZ6NCS0mXJnCUPZwcEZ8LaXaTRt09putdxdIG/Pzm4
        mXiiEk1qmZdUZ533PjzJRcmhnjEX4odny/k3ISgPljDMtpbY41MwLClycoMXVkVIRPF1FKEAKj7
        r7VgoCU3usFCp80bAF6Unvgsd8o3J+I54jcH9x4Cx
X-Received: by 2002:a63:d855:0:b0:4d1:6eb1:f4fd with SMTP id k21-20020a63d855000000b004d16eb1f4fdmr948949pgj.129.1674245710437;
        Fri, 20 Jan 2023 12:15:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtsiX3juA6NTfDqDDF8w2EHftoEn3VGj2gUYhikNqd27sIEVXIyg/QLH7Kyv54F9jKtT1B7LBJjZeqy9c/zKc4=
X-Received: by 2002:a63:d855:0:b0:4d1:6eb1:f4fd with SMTP id
 k21-20020a63d855000000b004d16eb1f4fdmr948947pgj.129.1674245710191; Fri, 20
 Jan 2023 12:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20230120150246.20797-1-wander@redhat.com> <xhsmhy1pxgkwy.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhy1pxgkwy.mognet@vschneid.remote.csb>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Fri, 20 Jan 2023 17:14:58 -0300
Message-ID: <CAAq0SUmt7HmyZes1ujA_TvA0gW9b7fX5moXywAtcpmzAiyfn2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix put_task_struct() calls under PREEMPT_RT
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 2:45 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 20/01/23 at 12:02, Wander Lairson Costa wrote:
> > put_task_struct() decrements a usage counter and calls
> > __put_task_struct() if the counter reaches zero.
> >
> > __put_task_struct() indirectly acquires a spinlock, which is a sleeping
> > lock under PREEMPT_RT. Therefore, we can't call put_task_struct() in an
> > atomic context in RT kernels.
> >
> > This patch series introduces put_task_struct_atomic_safe(), which defers
> > the call to __put_task_struct() to a process context when compiled with
> > PREEMPT_RT.
> >
> > It also fixes known problematic call sites.
> >
>
> Browsing around put_task_struct() callsites gives me the impression there
> are more problematic call sites lurking around, which makes me wonder:
> should we make the PREEMPT_RT put_task_struct() *always* be done via
> call_rcu()?
>

I thought about going on this route, but I was concerned about the
performance side effects this approach could bring. Another idea I had
was to check at runtime if we are in a preemptible context. Again,
this would have a (minor?) performance penalty.

> The task's stack is actually always freed that way in put_task_stack(), cf.
>
>   e540bf3162e8 ("fork: Only cache the VMAP stack in finish_task_switch()")
>
> > Changelog:
> > ==========
> >
> > v2:
> >  * Add the put_task_struct_atomic_safe() function that is responsible for
> >    handling the conditions to call put_task_struct().
> >  * Replace put_task_struct() by put_task_struct_atomic_safe() in known
> >    atomic call sites.
> >
> > Wander Lairson Costa (4):
> >   sched/task: Add the put_task_struct_atomic_safe function
> >   sched/deadline: fix inactive_task_timer splat
> >   sched/rt: use put_task_struct_atomic_safe() to avoid potential splat
> >   sched/core: use put_task_struct_atomic_safe() to avoid potential splat
> >
> >  include/linux/sched/task.h | 21 +++++++++++++++++++++
> >  kernel/fork.c              |  8 ++++++++
> >  kernel/sched/core.c        |  2 +-
> >  kernel/sched/deadline.c    |  2 +-
> >  kernel/sched/rt.c          |  4 ++--
> >  5 files changed, 33 insertions(+), 4 deletions(-)
> >
> > --
> > 2.39.0
>

