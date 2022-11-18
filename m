Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C862EF14
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbiKRISv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241333AbiKRISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:18:49 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389315FD5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:18:48 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id t5so4016237vsh.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bL61u+2dqwW/EcEsaMGkXQTvRGn76w9a2Ft5PT17cKk=;
        b=YBvW9ig59iSyCg3IQ0Vh+0oOMNcO+gSIsWC26yolGTVRx2M5lShlLRMljkjUF/2A+p
         j2zIkXOJyW/L4wMWuQ8FeYJTLJeCFC0SXdAtgGZBXVGRfhw4qBMz43SBqgv6Wg/TQsF1
         +yr80WVCykvtUizp6a+pvkk3QJldMBHVbCBRXK4GonmY0U6sjNLeTXHVylZORvjlYlur
         KNviqUNg8RcQvP1GxK4ImUBIRevrWFxwtjoQbs7GymUkXMvtlKx/pyfhmK0YzUzFAp3I
         mxAFa7ZzyxEilHwMNwNV7jenaUTV2Gwdg0GSI4pCp4KcdYTa6axDGCMnsRenMmHT27Zu
         DzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bL61u+2dqwW/EcEsaMGkXQTvRGn76w9a2Ft5PT17cKk=;
        b=C/hf7xwzAfeuMPp8daimrOMMsInAEEaLDu4zJNc36L7r8XaWGMD8o2S8AbEReSwDvA
         8ngJszg3aOmSXi2CWWCI9ZNyIUUSyHitkCjxBfSVpPB3L92vHiP21ZFedWf1LLS7Ey1L
         EN47NqjHRA7r4ZZspHPHteud/nuHJ/eXTQkkv5mAVnnSBRBU38IiZYeb8VSgoRmOwyl2
         2YE2MU/DeM4gGefQii+NRAKCI8tmMpk2VH0zBwpU3UzdSQehKV51o2i8BCttvkIklG3T
         vHv63kLVdzP8KXVSYMIv1z+5livgXpG1Mjh8hQe4DlTUqe2Z/YjK2ygGlqJe7yof/nid
         iQuQ==
X-Gm-Message-State: ANoB5pkloMKOx2oHAcRj82zoM+yIdrA/43E1H067WRWHeWEfE/UHOM5S
        gE7aHQhcOrwZN2HakJVeYAOmv/62l4XXmezfR+obbbB91SwwhJ4=
X-Google-Smtp-Source: AA0mqf7QHuHROmNDgOuracQOzmP0yfhKE5ZL6eH9lxQCyQtuMcK2vHstv8UFhiYxGr5/dL7FUo0wrjY/FEZRPwx3k+A=
X-Received: by 2002:a67:f995:0:b0:3aa:4802:ac46 with SMTP id
 b21-20020a67f995000000b003aa4802ac46mr3933229vsq.49.1668759527196; Fri, 18
 Nov 2022 00:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20221116075929.453876-1-jstultz@google.com> <20221116075929.453876-4-jstultz@google.com>
 <Y3S9VH+ThqbUDV4Y@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3S9VH+ThqbUDV4Y@hirez.programming.kicks-ass.net>
From:   John Stultz <jstultz@google.com>
Date:   Fri, 18 Nov 2022 00:18:35 -0800
Message-ID: <CANDhNCrAe8jb73feYhKuiK6pS8Ma1p+W_==kHN6iybsWBkmxUg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] softirq: defer softirq processing to ksoftirqd if
 CPU is busy with RT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
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

On Wed, Nov 16, 2022 at 2:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Nov 16, 2022 at 07:59:28AM +0000, John Stultz wrote:
> > From: Pavankumar Kondeti <pkondeti@codeaurora.org>
> >
> > Defer the softirq processing to ksoftirqd if a RT task is
> > running or queued on the current CPU. This complements the RT
> > task placement algorithm which tries to find a CPU that is not
> > currently busy with softirqs.
> >
> > Currently NET_TX, NET_RX, BLOCK and IRQ_POLL softirqs are only
> > deferred as they can potentially run for long time.
> >
> > Additionally, this patch stubs out ksoftirqd_running() logic,
> > in the CONFIG_RT_SOFTIRQ_AWARE_SCHED case, as deferring
> > potentially long-running softirqs will cause the logic to not
> > process shorter-running softirqs immediately. By stubbing it out
> > the potentially long running softirqs are deferred, but the
> > shorter running ones can still run immediately.
>
> So I'm hating on the new config space, and dubious of the placement
> logic (I'm thinking much the same gain can be had when actual softirq
> processing stops quickly when we want to reschedule).

Hey Peter!
  Thanks for taking the time to look this over and provide feedback!

> However I still have these here patches (revived from the dead):
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=core/softirq
>
> That fix some of this same... I think the last time this fell on its
> face due to regressions and me not having time/energy to chase them down
> and the author of the hack-of-the-day solution walking off or something
> like that.

So I've taken a look at your patch series and backported it (as well
as extended it to use softirq_needs_break for the BLOCK softirq) to a
5.10 device kernel where I can compare the behaviors against the tuned
code that's shipping.

At first glance at your patches, I was optimistic, as it's great that
it nicely time bounds the number of softirqs run, but I fet that it
doesn't help if a single softirq takes longer than we'd like.
(And indeed, I can see single BLOCK softirqs invocations taking quite
some time - > 16ms! in my last run)

Obviously "fix that driver to not do that" would be the standard
response, but it does become a constant wack-a-mole game. Sort of like
some of the philosophy around some of the PREEMPT_RT changes, where a
broad solution is used to avoid having to fix and maintain latencies
in code across the kernel, this task placement solution helps avoid rt
latencies being dependent on the continual perfection of all drivers
used.

> I think this aspect of the whole softirq thing really needs fixing first
> and not hidden under some obscure CONFIG symbol.

Sure, and while I am happy to help with your current patch series, as
I do think it should improve things, I'm not sure if it will let us
move away from the softirq-rt placement optimization patches.
Any ideas for additional approaches that would be more agreeable to you?

We could pull most of the logic out from the CONFIG file, maybe let
userland set the long-softirq mask which rt tasks would avoid
scheduling onto? Though I know folks would probably like to avoid the
cpupri_find_fitness test logic if they could so I'll have to think how
to efficiently shortcut that if the mask is null.

Anyway, thanks so much again for the feedback!
-john
