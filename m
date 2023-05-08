Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE76FB002
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjEHMaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjEHM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1383E3C3D1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683548910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lgrzGxAxmI/spviOHV2b8UBBldlWDCIioMic8trwoYg=;
        b=Bw8+57xoqvf0lgYZQLr/DQ2Rw3DUDO2q0+A546LDsHoAd7rEhypYHaFyi1C+NyEeSVpWEv
        2Bz7SlHWc//je2PC33bnEckBWpGI8pZBLRkqIWzOrub6mNyxY5OCPBLiORoEGrCCjgd/NI
        jy5eMPC6uU+i+kbcGNSrbRfylbMF2R0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-uzmTTyjHN9KczZXNMIfa3Q-1; Mon, 08 May 2023 08:28:29 -0400
X-MC-Unique: uzmTTyjHN9KczZXNMIfa3Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-643fdfb437aso8936217b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683548908; x=1686140908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgrzGxAxmI/spviOHV2b8UBBldlWDCIioMic8trwoYg=;
        b=d9TIr1EGlnSNaw7zh/HY2GmskTuSQXgmr0huytEadkqxCHLi5jkyieYIvG6LMaxWNz
         pVVHayjm3LWrGYrVSzWeRcxWI11CJM3WLo1tgoNYmaVsY2825wNJYQgBDrxddNxmo8Gm
         XOpyC+wdeY9C+9ucgSFhq9czGE+LPUxzYjl9puTQ9e2jFfF526MVwqzvHEWn+Zuv+wDL
         v+Lb6m5KIFqX9qMJze0ZHLGtdf3T7lhd8x7lFjyC+45GO33QZmOEyKTCKnAosT7wI5Rv
         uvmVmCVvzATWJj1b0jrDkfcro7o0xH/yJsUetq7QQVx1tKfhPPNR40ku3ajp+HZyw8aG
         DyWQ==
X-Gm-Message-State: AC+VfDwp3McbAQJC5DejI4dHgzFjf05KbTAw/PGZJOTtMhB90ljEwfFu
        HgH0LMvTbplImeoHApQDSYKQ3BssS3lKWa9EzHA4yc0E6v6o6mAOrKuIv641FZ3zVqGJI8nyPHG
        cYimmSUNcWNJeAfgoW95SKjDzwWNtF19E1HPcQFzV
X-Received: by 2002:a17:902:c943:b0:1a9:2a9e:30a8 with SMTP id i3-20020a170902c94300b001a92a9e30a8mr19852467pla.9.1683548907999;
        Mon, 08 May 2023 05:28:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wJMx1jBWrcarhM+oA6VC9s/ptiRs+n09mKMApsO+ZT6dRWxKFOpP7kv6qviLo30TspCsRD9iNCrTW20+sv0M=
X-Received: by 2002:a17:902:c943:b0:1a9:2a9e:30a8 with SMTP id
 i3-20020a170902c94300b001a92a9e30a8mr19852446pla.9.1683548907634; Mon, 08 May
 2023 05:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
 <20230504152424.GG1744258@hirez.programming.kicks-ass.net>
 <cjhvb72qrqggom5gxdjz6mtz3bntlmznx7r52adz72z2t2edzr@hwcog2pltfaq> <20230505133235.GG4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230505133235.GG4253@hirez.programming.kicks-ass.net>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 8 May 2023 09:28:16 -0300
Message-ID: <CAAq0SUmf_q5UFMKrBb+JtqUF3cFchSZhiiRM4YbVmYO_dyDRGg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe() function
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 10:33=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, May 04, 2023 at 03:21:11PM -0300, Wander Lairson Costa wrote:
> > On Thu, May 04, 2023 at 05:24:24PM +0200, Peter Zijlstra wrote:
> > > On Thu, May 04, 2023 at 11:55:15AM -0300, Wander Lairson Costa wrote:
> > >
> > > > > Then I'm thinking something trivial like so:
> > > > >
> > > > > static inline void put_task_struct(struct task_struct *t)
> > > > > {
> > > > >         if (!refcount_dec_and_test(&t->usage))
> > > > >                 return;
> > > > >
> > > > >         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > > > >                 call_rcu(&t->rcu, __put_task_struct_rcu);
> > > > >
> > > > >         __put_task_struct(t);
> > > > > }
> > > > >
> > > >
> > > > That's what v5 [1] does. What would be the path in this case? Shoul=
d I
> > > > resend it as v8?
> > >
> > > It's almost what v5 does. v5 also has a !in_task() thing. v5 also
> > > violates codingstyle :-)
> >
> > IIRC, the in_task() is there because preemptible() doesn't check if it
> > is running in interrupt context.
>
> #define preemptible()   (preempt_count() =3D=3D 0 && !irqs_disabled())
>
> When in interrupt context preempt_count() will have a non-zero value in
> HARDIRQ_MASK and IRQs must be disabled, so preemptible() evaluates to
> (false && false), last time I checked that ends up being false.
>

When I first tested, I started with in_irq(), then I saw some warnings
and added preemptible().
Never tested with preemptible() alone. Thanks, I will change that and test =
it.

