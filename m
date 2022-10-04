Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851015F49A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJDTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJDTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:19:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88152D65
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:19:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn8so2966633ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fvWgk8o1Yyu3CLIgnzzCCwXTSFv/+lUvtPxy3V4OsJU=;
        b=qccRpoEvt0602Zse5wCsznS7Mf2Bjdcxs62QTaX13HwzliPk+fW4uveflrNKoQ+YyX
         xqsABLl1gT1yTUGD9Gj/1pY3MUmPNZlrYV+8AbpSolObhIf7KdevpIsLhiMhCd5gXDSA
         Nb9sLZJuf3q5uO7xmpaF2iuTB8CY0H41nj1Mf3wTJSswsLJ2vtCnydECHehoUuZpHQps
         0scjVKqMQJ2IS9qwfmywPUFiW+FQlape1ccFdEskoHeKJNsKtHSMzS7cwwUyQ2wR5M+B
         Vmyn/6UzGZIftwXNkm9JOoit9Kij9s2XpXShinA2UVDmRbwqm8ZEflAgMOgR+K5VBF7v
         d0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fvWgk8o1Yyu3CLIgnzzCCwXTSFv/+lUvtPxy3V4OsJU=;
        b=5slNRn5++uYK5qFRsl/dv8sHhuzVQZuav1tjMHC3NDyAwtuy2wyeFGpfsaJ11JLTs9
         Ge6jQrzWToCDn8Iu4zzctuETg4bEpLWXFDh0A4mxhXxYfFCWmGTnCEVKanpehQx2s5V7
         MaXJjFiOkcsxHXbSJYd9h+NFABoZkSQvGewOrRRp2VEpTaQI87YOwj3g/pCmZqNJVCkI
         UyEJDmZFtGTEUbTvestcq5HliAodm0NEesW/m8/gfvgNWHWFnmgAxfYASE/Xa3NPr2wr
         soQ1OEbk7zKrOTkv+tgiVs5psUltRLPgwDNYt6Lrm8yb98yOe0KjwJdFP1ZDOsjqqnvR
         X4Ug==
X-Gm-Message-State: ACrzQf1yIi6NEHjw1GvqwHkVWKlHWVnC1dcSQ8drlRR5OaErIL4FduxO
        WLmobWKNlINyiHTD/sQYZgTqrh1Q2yZzSN2CQgvs
X-Google-Smtp-Source: AMsMyM71aybwDPx0xcLFeJN1W9P6ODfQFBLfIHSdAiEueY/qGQJkwk1ZbuvZ2t/WWUhFmoAkjqHJ3PkRv2LDL3GS/mY=
X-Received: by 2002:a2e:84cc:0:b0:26d:e0c8:95d with SMTP id
 q12-20020a2e84cc000000b0026de0c8095dmr3237208ljh.388.1664911178800; Tue, 04
 Oct 2022 12:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com> <20221003232033.3404802-4-jstultz@google.com>
 <ac37c63a5039435ab775a0e983213902@AcuMS.aculab.com>
In-Reply-To: <ac37c63a5039435ab775a0e983213902@AcuMS.aculab.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 4 Oct 2022 12:19:27 -0700
Message-ID: <CANDhNCpSuRF07K_=dHgaX8SQ9JkSeN+=z5LNPofFSFv+4-zSGw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] softirq: defer softirq processing to ksoftirqd
 if CPU is busy with RT
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kernel-team@android.com" <kernel-team@android.com>,
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

On Tue, Oct 4, 2022 at 3:45 AM David Laight <David.Laight@aculab.com> wrote:
> From: John Stultz
> > Sent: 04 October 2022 00:21
> >
> > From: Pavankumar Kondeti <pkondeti@codeaurora.org>
> >
> > Defer the softirq processing to ksoftirqd if a RT task is
> > running or queued on the current CPU. This complements the RT
> > task placement algorithm which tries to find a CPU that is not
> > currently busy with softirqs.
> >
> > Currently NET_TX, NET_RX, BLOCK and IRQ_POLL softirqs are only
> > deferred as they can potentially run for long time.
>
> Deferring NET_RX to ksoftirqd stops the NET_RX code from
> running until the RT process completes.
>
> This has exactly the same problems as the softint taking
> priority of the RT task - just the other way around.
>
> Under very high traffic loads receive packets get lost.
> In many cases that is actually far worse that the wakeup
> of an RT process being delayed slightly.
>
> The is no 'one size fits all' answer to the problem.

I'm not claiming there is a one size fits all solution, just like
there are cases where PREEMPT_RT is the right choice and cases where
it is not.

I'm only proposing we add this build-time configurable option, because
the issues they address do affect Android devices and we need some
sort of solution (though I'm open to alternatives).

> Plausibly depending on the priority of the RT task
> might be useful.
> But sometimes it depends on the actual reason for the
> wakeup.
> For instance a wakeup from an ISR or a hish-res timer
> might need lower latency than one from a futex.

I mean, with the PREEMPT_RT series years ago there used to be
configuration guides on setting the rtprio for each softirq thread to
provide tuning knobs like you mention, but I'm not sure what the
current state of that is.

If you're wanting more flexibility from the proposed patch, I guess we
could have a knob to runtime set which softirqs would be deferred by
rt tasks, but I'm not sure if folks want to expose that level of
detail of the kernel's workings as a UABI, so having it be a kernel
build option avoids that.

thanks
-john
