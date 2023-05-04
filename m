Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF08F6F71F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEDSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEDSaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3C2D5F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683224957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ahqT2qK2HP6aaU8/Xb1AjQNrt44RhqBn093YYa9pWY=;
        b=egspf4s2QR5Qj4h4UXCtntUg6D7Mfox3w7c/lzuDQp/1YbL50QVIOQ4Iox0/99gtbQfwHP
        aEX5dAhNazS/yJ9C9D0Sdp4HFDjmOj/dC95QyUE3nUu94Tqj/dmEeylIj6zMwjM6FbAigy
        BP0laOELjuoixNfkpgYutyfFOq5ElGY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-E5968vG1P7aTe2Za06Z8Ig-1; Thu, 04 May 2023 14:29:16 -0400
X-MC-Unique: E5968vG1P7aTe2Za06Z8Ig-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-64115e69e1eso9869168b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224956; x=1685816956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ahqT2qK2HP6aaU8/Xb1AjQNrt44RhqBn093YYa9pWY=;
        b=V9/PRSOvTAiGuuIq1kOfjSKtMkspiWpOkMxACVFpPLu9dw8l2bQQYN7yemF5fG69W0
         A51kajdfOOLZ217cbRYflaidTnCVZuBaiydB8gd/sJ742D9MCSopyHeyKXwZlfrQk/hO
         e1iq5833K+r4lllUHthVEkl1AmO6/ii9ccGKOq8dpqC+sJulo8/YhIDLEodG+xaE3wxb
         7aWjqfhsZ/D7BjE626u3H9CL8gZFuwS6BIfllyEq1IcwmZHh6gs2UF8GgtgpckeO9HVW
         l8EWofEKiZm5DF+3qQWffg3tkvOiYBdii3vN44KxLLMIOzSJ7r8jOCGrOTIt4jABNuA1
         h8JQ==
X-Gm-Message-State: AC+VfDxONUWPwGAT1bV9wmEwfoB/9mpAix0+O2aJFbD+45Q38TocRU8O
        LajxMM9XNPCyWEQIrelnE9+EWxTp/76pXXf00gkJ1krWindOzrUS3QV8Lkbo+lFf0DIGDfr9Sp8
        yDS3k1xx0Jh8dQ56l/S9mLXfNvaOYUnR6KdR4e6bt
X-Received: by 2002:a17:90a:ec01:b0:24e:1ca6:2206 with SMTP id l1-20020a17090aec0100b0024e1ca62206mr3556597pjy.8.1683224955640;
        Thu, 04 May 2023 11:29:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6NTF2DQuSl05rS/B5VSXJyoSPcYtNXgF8BRV0bvbHIWPgn+iaD5CZPxNSNgLD/BC85xX2iOApLFLzBsNSVfHM=
X-Received: by 2002:a17:90a:ec01:b0:24e:1ca6:2206 with SMTP id
 l1-20020a17090aec0100b0024e1ca62206mr3556573pjy.8.1683224955310; Thu, 04 May
 2023 11:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230425114307.36889-1-wander@redhat.com> <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com> <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com> <20230504152306.GA1135@redhat.com>
In-Reply-To: <20230504152306.GA1135@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 4 May 2023 15:29:04 -0300
Message-ID: <CAAq0SU=G0WQBLP77Wgm8MJRcVwUCj25WOowh_X8jiGiHTKAQEA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe() function
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Thu, May 4, 2023 at 12:23=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/04, Wander Lairson Costa wrote:
> >
> > On Thu, May 4, 2023 at 11:34=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > static inline void put_task_struct(struct task_struct *t)
> > > {
> > >         if (!refcount_dec_and_test(&t->usage))
> > >                 return;
> > >
> > >         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > >                 call_rcu(&t->rcu, __put_task_struct_rcu);
> > >
> > >         __put_task_struct(t);
> > > }
> > >
> >
> > That's what v5 [1] does.
>
> Yes, but as Sebastian explained CONFIG_PROVE_RAW_LOCK_NESTING won't like =
it.
>
>         https://lore.kernel.org/all/Y+zFNrCjBn53%2F+Q2@linutronix.de/
>

I think that was my confusion in that thread. My understanding is that
CONFIG_PROVE_RAW_LOCK_NESTING will check lock ordering but not
context. I feel my ignorance is blocking me from seeing something that
is obvious to everyone else :/

> Oleg.
>

