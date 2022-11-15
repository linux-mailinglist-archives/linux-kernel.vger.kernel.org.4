Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B39629DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiKOPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbiKOPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:40:44 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8352C13A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:40:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id x21so18008234ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfBzaGjWfEAox7BcKqKuuoSLrouBnkbb1/SrkRonxSE=;
        b=xvtq4fYqCANTIemGSgaIUhItpbOjRKERmNTLQOFTd5RCNv/30IkrE53Xd5Kve0/0Id
         aQYxSAQ1oTTSFY546lX06TL3qe3kzwM8eSiqLXL5Tc5Htf8yRAGTxK7vdEdtD1Ub/lit
         W4G2T3Vz5Fp0ntv7q2MMZy8vvNATBqqohRv49MFvHHh+iKr2le3wh02JC2NofMsfA/as
         92MZ3z/4fi3bmmk9GNGtH0Hq7jDXevU4M5q9vmDz2CZ6xYF3xyHOlnsKNTpZ/LPXBctO
         9pL5w1X/iKDJnMXCF8VGLZoMJVHCfq1xEPflBw7TsHYS3w0eC2c+8xeJ9k7JNDq3ERtf
         MJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfBzaGjWfEAox7BcKqKuuoSLrouBnkbb1/SrkRonxSE=;
        b=DymqCiFBWCbuDj+BQpnqQRoCqDH7Mxrb5/KrVktQ67ybhxKPbiOh0QdF0CrwYt/rxm
         gFpo4DuswkDcK5aNgnPDPHM2+g8Go1bJ2CFLKZvrTHYqEzSAleW30uFFDMqaUXp9WPU+
         cuoQzSprt+Ps7quE2O3PmBCI6mZKjPzY2z9kumy4+o2/1GtUZHl7O89VQUTpscY51uz1
         03/y0H0xuwHopDvaoOsECZ4GnFXQrQtvsZ2EWQwkzl2EZJUPXfZ1gyJ/FobPJiIgHC6K
         M4/0ELavUcm8fT7qpqwNg+a0BDb2xTCxeZNb6rC/5aTPPEMSgQMCk/NtLRX1vuAc94FM
         d4CA==
X-Gm-Message-State: ANoB5pkI0PilTKAcqQ1xaNZ897khP2NNh8z8pEVjq+5ylpd2th6VSXSM
        kcJ3zQMhzHlIsnMql4314tXrE6o17QAHhEat7py2hA==
X-Google-Smtp-Source: AA0mqf5R6RqdWE1pPxNgyyqrriEb8L2e0mWWbDCXTzkEXKkKGkSv5+ZFYD8oC9q4grhVq8lxFqMbUOWswjCxxli0fT8=
X-Received: by 2002:a2e:4952:0:b0:277:792:c406 with SMTP id
 b18-20020a2e4952000000b002770792c406mr6164132ljd.126.1668526841045; Tue, 15
 Nov 2022 07:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-6-vincent.guittot@linaro.org> <Y3JqygejPxrtTFgP@google.com>
In-Reply-To: <Y3JqygejPxrtTFgP@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Nov 2022 16:40:28 +0100
Message-ID: <CAKfTPtAJrai_KYUcT=deSjxZ835Ou_RyxdNpZc0Gnb3_NA2iKA@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] sched/fair: Take into account latency priority at wakeup
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 17:20, Patrick Bellasi
<patrick.bellasi@matbug.net> wrote:
>
> Hi Vincent,
>
> On 10-Nov 18:50, Vincent Guittot wrote:
>
> [...]
>
> > diff --git a/init/init_task.c b/init/init_task.c
> > index 7dd71dd2d261..b8ddf403bc62 100644
> > --- a/init/init_task.c
> > +++ b/init/init_task.c
> > @@ -78,7 +78,7 @@ struct task_struct init_task
> >       .prio           = MAX_PRIO - 20,
> >       .static_prio    = MAX_PRIO - 20,
> >       .normal_prio    = MAX_PRIO - 20,
> > -     .latency_nice   = DEFAULT_LATENCY_NICE,
> > +     .latency_prio   = NICE_WIDTH - 20,
>                     ^^^^^^^^^^
>
> For robustness/consistency, shoudln't this be LATENCY_NICE_WIDTH?

yes, good catch

>
> [...]
>
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index b2accc9da4fe..caf54e54a74f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1284,6 +1284,16 @@ static void set_load_weight(struct task_struct *p, bool update_load)
> >       }
> >  }
> >
> > +static void set_latency_offset(struct task_struct *p)
> > +{
> > +     long weight = sched_latency_to_weight[p->latency_prio];
> > +     s64 offset;
> > +
> > +     offset = weight * get_sched_latency(false);
>                       ^^^^^^^^^^^^^^^^^^^^^^^^
> As per my comment in patch 1, we almost always (but one time) call this with
> "false" and that's not returning the sysctl_sched_latency but a possibly
> discounted value in case of feat(GENTLE_FAIR_SLEEPERS).
>
> Just to avoid confusion (this could be not the sched_latency) and to better
> document the code, what about using a accessor define something like e.g.
>
>    #define max_wakeup_latency get_wakeup_latency(false)
>
> ?
>
> [...]
>
> Best,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
