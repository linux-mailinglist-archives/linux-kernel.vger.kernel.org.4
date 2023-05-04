Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1046F6E67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjEDO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEDO60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B763C05
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683212130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YsQ8xdo0ytXa7ybkhxOH7pGSLqmfAjZ1BIJ079PuAc=;
        b=dMKktowU1r2zUEwi0n2zYth48nemmDF/hXdy5MrD82e76F9tt/MzMiWdOe0Q/mq6Dtr60I
        vwc/O6M08nBmfRidAgd59HaMne/cMsrkjAU8iKaUZaJr3GODd11z4ff0MHVuGve1LCke1+
        ieTAOQvKOnFYVm7/oJZNKkBRzGwwD1Y=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Ayu6cioLOuWcvz8uEFZSUQ-1; Thu, 04 May 2023 10:55:29 -0400
X-MC-Unique: Ayu6cioLOuWcvz8uEFZSUQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1aafb2766e0so2705795ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 07:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212128; x=1685804128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YsQ8xdo0ytXa7ybkhxOH7pGSLqmfAjZ1BIJ079PuAc=;
        b=XhGPI2e622shq4ztL66T0uqJK1V/UT1Fbp3ztRZSvvoRXdjThFPVjysQ3eMGFqHqrY
         AXmsjCHsl0wOQSBNFTdkLBza2+4LUmdj0j3K3fH/yYytwLsWEhWSFbpK1me0zDsdYPju
         LTAKLEPSLEubxFqCpU+I8ORSqAkJJdfRp6160k287Ji0ATU2ln70U1i1cesJVR6RPiz/
         vfMUSJ6WEP+Sl7ZSXazN8JDG8IJ3YrV+nOhA0JYru+J3gDWqUVHLobgvlOsAooBWdptD
         BbwiHGb2x5xku1FzO+Hph56ml01UWnCzFl+3hQKLvTJtIBo5bCoLvzv9vcT18ximq3MG
         jSWw==
X-Gm-Message-State: AC+VfDyvYiwxfJiwyQUCpn9lABZ3zXjSXqqZ9vd70woVKfrvJhmUdljL
        eCMHXavPF+pmhWPi/qQkGXqjMFVYoBrv4pDYvEPkfwO8VS09wh4b97zVQgmwHtbmJI5ck+afb8b
        fBv552rtItYymIVntUpNmjQpL45zIwPKifoSYSBeM
X-Received: by 2002:a17:902:9f87:b0:1a9:7e26:d72 with SMTP id g7-20020a1709029f8700b001a97e260d72mr3982905plq.9.1683212127805;
        Thu, 04 May 2023 07:55:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6a+ZmUXqeCZBEWqfB9F07VH3ROswrjPipQTUEnGnxpTdKFHOdNu+aNGSSJQ2n7wz+LO4rj5Dj540V1lyM3Hbg=
X-Received: by 2002:a17:902:9f87:b0:1a9:7e26:d72 with SMTP id
 g7-20020a1709029f8700b001a97e260d72mr3982863plq.9.1683212127419; Thu, 04 May
 2023 07:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
In-Reply-To: <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 4 May 2023 11:55:15 -0300
Message-ID: <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 11:34=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, May 04, 2023 at 02:29:45PM +0200, Oleg Nesterov wrote:
> > On 05/04, Peter Zijlstra wrote:
> > >
> > > Urgh.. that's plenty horrible. And I'm sure everybody plus kitchen si=
nk
> > > has already asked why can't we just rcu free the thing unconditionall=
y.
> > >
> > > Google only found me an earlier version of this same patch set, but I=
'm
> > > sure we've had that discussion many times over the past several years=
.
> >
> > Yes... see for example
> >
> > https://lore.kernel.org/lkml/CAHk-=3Dwhtj+aSYftniMRG4xvFE8dmmYyrqcJyPmz=
Stsfj5w9r=3Dw@mail.gmail.com/
> >
> > We already have an rcu pass before put_task_struct(zombie), see
> > put_task_struct_rcu_user(), another one look unfortunate.
>
> Ah indeed, it got mentioned there as well. And Linus seems to be arguing
> against doing an rcu free there. So humm..
>
> Then I'm thinking something trivial like so:
>
> static inline void put_task_struct(struct task_struct *t)
> {
>         if (!refcount_dec_and_test(&t->usage))
>                 return;
>
>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
>                 call_rcu(&t->rcu, __put_task_struct_rcu);
>
>         __put_task_struct(t);
> }
>

That's what v5 [1] does. What would be the path in this case? Should I
resend it as v8?

> should do, or alternatively use irq_work, which has a much lower
> latency, but meh..
>

Initially, I did that. I switched to call_rcu because the code got much sim=
pler.

[1] https://lore.kernel.org/all/20230210161323.37400-1-wander@redhat.com/

