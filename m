Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678506023CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJRFcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJRFca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:32:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AD097EE3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:32:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a6so16550176ljq.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rrSLeS7stRE/t8A98eeGX6eTQM51safURvSVGcjgGo4=;
        b=VfDIGn7/yVo/AsdPcRD1CGtURB4HYnno7Ri5dVUP9JQUMvO94y6lHIecfRH5ht/iSr
         0g7Kuiwru88sFLXcCsY62qnrOjfHsrA9L3MUuiyYHGZQygyEEw62KAEkMKpx0cPiDlZS
         xKyA1qpDZz2kypi2rpzypgXghVUu0YXK1JSSZ08YNSwAzFG16UTywpyKdJRu6vztfSDa
         WZR+P73iXbrIVZwe7ipqUD1ygoYWLZsP+lqhchy7k0Yvfo59omS1ozly0pZ6juVaqmmb
         fUhNH2nVqA73fkzRAPPz04Yi+MniP+JH7EgM5f8laT40+nARbUUgmxS3LinoqZvHKgsp
         WCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rrSLeS7stRE/t8A98eeGX6eTQM51safURvSVGcjgGo4=;
        b=Ee/mQyy851VyBCbfjjvnBvV7sAesdYGCBw1CjJSy+CgrH+MafUUB+obe/6Bk2UYz1C
         40uyE/6s9VfwgYijD7Hai/vvNaKAhepN9d0vMcvlXc3IN/9uyoijaA9xHedqEQDqJoAp
         grBxIClBduOEXlD/OuYu+SOXBhXevLPTOmY6UkwIdH6CXDo1kb51UGQdiufBdQJnAX0e
         Mtdb7qoQQFNV+TRz6sgXvd74t7AwIjzORDqAdFD0+WiAOpsWW6rJe20hcSotWwwWW2GM
         lqtcoAiSloE8rSQfRa98dLTKilTolNgZViFt9fQkO0twUgeEc7QzHpN+/CkZ81GTyLrR
         Y2Dg==
X-Gm-Message-State: ACrzQf0im+bInGgxUat7Vq/DKaJhNLt9rf4/Jqz1XtKPasQiBod3usOc
        OLXuS3R+ZJAkGLB3pQUC486aSWyvDrJk7x/WcL7v
X-Google-Smtp-Source: AMsMyM5t3DMxNPINQ06AQXnq6bMVUTqNbuNpNJZcCwvv0FSQagcyYosxxCqunlh1i2mTgPsJu2J1MS5YdSZNp8pvi5I=
X-Received: by 2002:a2e:9e50:0:b0:261:e3fd:cdc5 with SMTP id
 g16-20020a2e9e50000000b00261e3fdcdc5mr457585ljk.56.1666071148259; Mon, 17 Oct
 2022 22:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-3-jstultz@google.com>
 <Y01NPB4sa8Z98ntK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com> <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
In-Reply-To: <CANDhNCoTGNANDnOQ6touhreG_UEn1-N4T4BktWFxpLPSWVfrdA@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 17 Oct 2022 22:32:16 -0700
Message-ID: <CANDhNCrw=-p1kNAog+m6ipM1j5QMdBCibU5_p2M75oqhfHWnvw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
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

On Mon, Oct 17, 2022 at 8:42 PM John Stultz <jstultz@google.com> wrote:
>  On Mon, Oct 17, 2022 at 5:40 AM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> > On Mon, Oct 03, 2022 at 11:20:32PM +0000, John Stultz wrote:
> > > +               preempt_count() & SOFTIRQ_MASK);
> >
> > Could you please clarify this whole check in more detail?
> >
> > What is the point in checking if a remote CPU is handling
> > a "long" softirq while the local one is handling any softirq?
>
> Good question! This looks like an error from my rework of the earlier
> version of the patch.
> In v1 it was:
>    task_thread_info(curr)->preempt_count & SOFTIRQ_MASK));
> And it looks like I erroneously condensed that to preempt_count() &
> SOFTIRQ_MASK  treating curr (from the target cpu rq) as if it were
> current. :P
>
> I'll fix this. Thank you for catching it!

Ah, it's not so trivial to fix as I see part of my motivation for
condensing it was task_thread_info(curr)->preempt_count doesn't build
on x86 (which uses percpu values instead of threadinfo).

So I'll have to think a bit more about how to do this generically, and
if the conditionalization can be otherwise simplified.

Thanks again for pointing the issue out!
-john
