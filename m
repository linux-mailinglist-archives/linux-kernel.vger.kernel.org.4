Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760965F35C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJCSoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJCSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:44:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272063FEE5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:44:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d18so4824595lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gaTwZ0wPsql/Gc+icZo70wMBuewiki/Fq6bw2w0dx4s=;
        b=Iwcry1MV7E8pEoKj3bhjKk9J5EANlKeM/38zS+GF45xB64GPwYeGqIvusEWupj0oUT
         mDIGYgAjy8vb+uMWC+9Vi7tOtKFaBTZ215IGWXGj1ampQuY3w+ii/BNfwRHxe3IKRPv0
         N6xNLkI+fUsW8zJoEsZ8TgHqNoNNT5u8dmeDmRXVcGIC0HU1NE9kIYO1EhITFys7+/P5
         R3D0a76WsQc6prvj83eyVSu4MEp8IT7NEC3EcWHgRWIMiz9x6tLbQ6mooIZk/fhANmDZ
         8duWe4tHwDGYPkjV4dbVw5tiey4DR3xV9yQJKBwrHIK9KaCMorlRZWbJUGgWV0joMcym
         yS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gaTwZ0wPsql/Gc+icZo70wMBuewiki/Fq6bw2w0dx4s=;
        b=CYiNqqaaIkse3KefpUUM7N4CalRihEfTezlP1S9JkZqJDvtqvFtAJSellCwFGJp6nT
         xnrozA+AXAn5RQYcUcTVYgIxvoZamWCqVx9rwiZM8ayXAeh1yOBhdVXhIwRxmWY9smSh
         98pf4paV4DiS4mRxznYzx7rQNFIOv0pgTGnt7O8HcdK6VgRoAcBRt8NWn7FlpoicDRae
         A692lxjKy5+3mAlFMikIliQI1vN+huSXwZLh06lLAVWuuaIhCxhr6coYn3EBE1/TK/iG
         m7gHOU1IXQAYGvPN5bzLyLB9m+f/sj+OKAXTY6+hj1HA3PvqTdVt35gkUuodyW81Cp6E
         2uxg==
X-Gm-Message-State: ACrzQf1T8XpNv0g/noKrx25Gr97jS0/hdtpHPcnTlimgQwIFskBAvuny
        BMFOGlbXzWlHcf+bDwFWhU5IVu0k5xe3K6epMpAJ
X-Google-Smtp-Source: AMsMyM7T+CVBe9qg1EPHX9NTq02q9opNJrN1clXfKflmI1/urJ0HA07uAqaRqRvh2mogceiB1pN1Yy1TtcafDpmMhoc=
X-Received: by 2002:ac2:5110:0:b0:4a2:3cf4:b693 with SMTP id
 q16-20020ac25110000000b004a23cf4b693mr2192823lfb.283.1664822642385; Mon, 03
 Oct 2022 11:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220921012550.3288570-1-jstultz@google.com> <20220921012550.3288570-4-jstultz@google.com>
 <20220928125652.zp3nviowo56ck3ne@wubuntu>
In-Reply-To: <20220928125652.zp3nviowo56ck3ne@wubuntu>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 3 Oct 2022 11:43:50 -0700
Message-ID: <CANDhNCqOCu4vERKmKoFGJ5=UPfyDdgbWJ7iEFN9dPjfXvt760g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] softirq: defer softirq processing to ksoftirqd
 if CPU is busy with RT
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
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

On Wed, Sep 28, 2022 at 5:56 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 09/21/22 01:25, John Stultz wrote:
> > From: Pavankumar Kondeti <pkondeti@codeaurora.org>
> >
> > Defer the softirq processing to ksoftirqd if a RT task is
> > running or queued on the current CPU. This complements the RT
> > task placement algorithm which tries to find a CPU that is not
> > currently busy with softirqs.
> >
> > Currently NET_TX, NET_RX, BLOCK and TASKLET softirqs are only
>
> Should we mention IRQ_POLL?

Ah, yes. Thank you for pointing that out.

> I think TASKLET is debatable as I mentioned in my other email.

Yeah, I've dropped it for now.


> > +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> > +/*
> > + * cpupri_check_rt - check if CPU has a RT task
> > + * should be called from rcu-sched read section.
> > + */
> > +bool cpupri_check_rt(void)
> > +{
> > +     int cpu = raw_smp_processor_id();
> > +
> > +     return cpu_rq(cpu)->rd->cpupri.cpu_to_pri[cpu] > CPUPRI_NORMAL;
> > +}
>
> Priorities always mess up with my brain! I always forget which direction to
> look at :D

Yeah, cpu_pri logic in particular (as it also depends on which version
you're looking at - the original version of this patch against an
older kernel had an off by one error that took awhile to find).

> Hmm I was wondering why not do rt_task(current), but if the task is not running
> (which can only indicate there's a DL or a stopper task preempting it), that
> won't work. But I think your code has a similar problem; you'll return true
> even if there's only a DL task running since we set the priority to
> CPUPRI_HIGHER which will cause your condition to return true.
>
> This makes me think if we should enable this optimization for DL tasks too.
> Hmm...
>
> That said, is there a reason why we can't remove this function and just call
> rt_task(current) directly in softirq_deferred_for_rt()?
>

I had thought similarly, but had hesitated to switch in case there was
some subtlety I wasn't seeing.
But I think you've persuaded me to simplify this.

Thanks again for the feedback and suggestions!
-john
