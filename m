Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03936D9E63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbjDFRTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbjDFRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319FAF25
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:18:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e9so26095514ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680801535; x=1683393535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaGAlDLSR+aHsW2smFb3KG3pD9Eh4aLC1jMNuxnZFSY=;
        b=XTMaXZ1V8zmHc8+mIKS3SkaPRadrPm56sChFwyZuqtTsaRv8aSvY3fRFIgLC3IGW4v
         oqSmZYiMOuwej8Wi9YcEwP54lKqJ8pgG4Ir6XV4ObE6qCPAxU/tklP30zZ+oQLeIGXI/
         bG7sxNTzpI3imi03NH2SfvBWAtgeLlXLrC2dfhISCiVQvqGyckjLcyBkDtYgAVLye7bf
         YLnSmrn9FYBPzvSFH3ZQKkl81nS9aC86798UaBZWsO+UdQ3SNmij9K2rJZGCb5/2K7Rt
         PZWJCmZcmpPPnLwaTZuGJABI3BIWmPEVNKtGR2YIl5ubD2GI5iP1sMU2tm2L4csJLTDG
         223g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801535; x=1683393535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaGAlDLSR+aHsW2smFb3KG3pD9Eh4aLC1jMNuxnZFSY=;
        b=Z5Bf+0yPgBobnLX2+hsKnqc3Vu1zcJlhiZ20IpcJI8pRgoc5CBbYT16qVOuQtjmL8u
         81ZaSdjqr2PW3jnrjtyvegwz1I3I2mTgsBOc61nWodYxfvNzBOgG4lh0T8VimqH/4OfP
         qjErbMCsuJIDN4olJTwemXtCqoTDDkgi6WR9DB2Da9xbALe9qKkjdCz8RHGawzi8bV4T
         SYqSRPYlAG2sAnzE9s7bXtCeq5hUzsP93s4teN7xF/HfK6e3WHe3fOaJp282AhaoFUhA
         OpNonhbQxCtc53NHtjzwPP+GnQFj+5K3CyqNj9Gq2eZiJe464K6anIe73Yl6eQCFBsnj
         zudA==
X-Gm-Message-State: AAQBX9flSeWwk2tIfKVKaPyloVAPGIGUtQ1aQ4scfxgqsqR0KskV740w
        W1kvFRAPpevk8OpVmJFc6pUYkc3koqQ1hpoU3A7baErdjFqcs7/XZg4=
X-Google-Smtp-Source: AKy350a2Xlu3bRoxw/GVmzSe40J3Bx9kLzH7nAcK8tpZgusEHcsEawexdzXn8jxrH51E3GZvXyc95xx1CF7Zblrg1V4=
X-Received: by 2002:a2e:2e0d:0:b0:2a1:d819:f0ae with SMTP id
 u13-20020a2e2e0d000000b002a1d819f0aemr3697401lju.9.1680801534715; Thu, 06 Apr
 2023 10:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230328210754.2745989-1-posk@google.com> <20230406103841.GJ386572@hirez.programming.kicks-ass.net>
In-Reply-To: <20230406103841.GJ386572@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 6 Apr 2023 10:18:43 -0700
Message-ID: <CAPNVh5eNEBu+gcex9pAej-_YN3zMKkG+rruXhopqS6EaG-izVQ@mail.gmail.com>
Subject: Re: UMCG - how should we proceed? Should we?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bsegall@google.com,
        linux-kernel@vger.kernel.org, pjt@google.com, posk@posk.io,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 3:38=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Mar 28, 2023 at 02:07:54PM -0700, Peter Oskolkov wrote:
> > Hi Peter!
> >
> > TL;DR: which approach, if any, should a UMCG implementation in the main=
line kernel use?
> >
> > Details:
> >
> > We are rolling out internally a UMCG implementation copied below (with =
some
> > boilerplate omitted), so I would like to restart our discussion on the =
topic.
> >
> > The implementation below is different from what we had earlier
> > (https://lore.kernel.org/lkml/20220120155517.066795336@infradead.org/)
> > in that it keeps UMCG state in the kernel rather than TLS.
> >
> > While having UMCG state in TLS is _much_ better, as it makes state sync=
hronization
> > between the userspace and the kernel much simpler, the whole page pinni=
ng
> > machinery in the link above looked very scary, honestly.
> >
> > So if we are going to ever have something like UMCG in the mainline ker=
nel, we need
> > to figure out the approach to use: the TLS-based one, something similar
> > to what we have now internally (details below), or something else. Or n=
one at all...
> >
> > While I would very much prefer to have it done your way (state in TLS),=
 the page pinning
> > business was too much for me. If you can figure out a way to do it clea=
nly and reliably, great!
>
> A few quick notes without having looked at the patch...
>
> > The main differences between what you had in the TLS patchset and what =
is below:
>
> (note that in the end the per-task UMCG info thing didn't *need* to be
> TLS, although it is a logical place to put it)

Yes, of course. By "TLS" here I mean in userspace per task. Just
easier to type "TLS" than "a per-task userspace area similar to
rseq"...

>
> > - per worker/server state not in TLS but in task_struct
> > - we keep a list of idle workers and a list of idle servers in mm
>
> How much of a scalability fail is that? Mathieu and me are currently
> poking at a rseq/cid regression due to large multi thread contention on
> mm data.

Our main use case is having a small number of servers and a single
cross-server queue/scheduler in the userspace, not per-server
queues/schedulers, so doing a couple of instructions (adding tasks to
an SLL) under a spinlock does not seem to be an issue; if it becomes
an issue, we can always switch to lock-free SLLs.

>
> But yeah, I think this was one of the open issues we still had; with the
> other implementation -- I seem to have a half finished patch for an
> idle_server list.
>
> > - worker wake events are delivered not to servers which ran the workers=
 earlier,
> >   but to idle servers from the idle server list
>
> Provided there is one I take it; very easy to run out of idle things.
> Also, what if you want to explicitly manage placement, can you still
> direct the wakeup?

As I mentioned above, we don't have per-server queues/schedulers, so
we didn't need to direct wakeups to specific servers. Again, our model
is if we have M servers and N workers, and M workers are running (i.e.
no idle servers), waking a server when a blocked worker wakes means
either preempting a running worker or grabbing an additional CPU; none
of these options fit our model well.

Doing it in a more flexible and scalable way to accommodate per-server
queues/scheduling and RT scheduling would be great, of course, but I
suspect the implementation will be more complex; and we definitely
would like to stick to the principle "userspace cannot have more
running tasks/threads than there are servers" (background stuff
excluded, of course; but scheduling code is very much "foreground").

>
> > - worker preemption happens not via a syscall (umcg_kick) but by hookin=
g
> >   into sched_tick
>
> sched_tick would render it somewhat unsuitable for RT
> workloads/schedulers where you might need more immediate preemption.

Yes; on the other hand, having preemption only via a syscall
(umcg_kick) means the userspace should be tracking all running
workers, juggling timers, etc.; and the same unresolved question of
needing extra CPUs do to all this (who will kick workers from the
userspace if they occupy all allocated CPUs?); using sched_tick is
much simpler and does not require extra concurrency/cpus. Maybe we can
have it both ways: an explicit umcg_kick() for RT use cases and
"regular" tick-based preemption?

>
> > None of the differences above are deal breakers; again, if the TLS/page=
 pinning
> > approach is viable, we will gladly use it.
>
> Urgh, so yeah.. I meant to go look at the whole UMCG thing again with an
> eye specifically at inter-process support.
>
> I'm hoping inter-process UMCG can be used to implement custom libpthread
> that would allow running most of userspace under a custom UMCG scheduler
> and obviate the need for this horrible piece of shit eBPF sched thing.
>
> But I keep getting side-tracked with other stuff :/ I'll try and bump
> this stuff up the todo list.

In-process vs cross-process userspace scheduling are two
different/distinct use cases for us, and doing them separately means
they can be worked on by different people in parallel (i.e. done
faster). Can this all be done as one thing that addresses both use
cases? Probably yes; the question is how long will it take?
