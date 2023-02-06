Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E68D68C5DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBFSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBFSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:33:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43E12052
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675708388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wf4mPQ+7ogCB6tda5pugPm0Lua9jGDv0YLg90036BXU=;
        b=CaBT4KvSNuxmHZaDahllCY0HO01GOEQNR5qGOAaeiUNVwufRQA2RIWzH2CbD8V7C+abiDt
        CsjbeGtGs+rQ/eT2Txytguzbk+CjHdK3YGx0dMD/a8BlykFTEB0Ikdu+gFYyDQkQMaEjZI
        5D/0GbupuUmXQ3W51fBy2X5ba5eEOLc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-ucJSOGT_PxOBUHCw9QV0Wg-1; Mon, 06 Feb 2023 13:33:07 -0500
X-MC-Unique: ucJSOGT_PxOBUHCw9QV0Wg-1
Received: by mail-pj1-f70.google.com with SMTP id l22-20020a17090aaa9600b00230aa3c1350so1540355pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf4mPQ+7ogCB6tda5pugPm0Lua9jGDv0YLg90036BXU=;
        b=roIgx6NV9269sFwFVhx1GO+UiFIqsfu+wdCSsrU5AOCBYS4m1G639v9uxLHEaLpo1h
         a1VLd7UGcRAWGh+70IsYVnbbH1YVTgtEnS/+DuWGwV+jS02I37hebGtdpA4Fl7fypTru
         CSMu1R7bkChqDYN5Lm0SrCiG7jBcnbS1b44dE5DMy6JwdfKNx2yvgZnGAplvhMtfK9tL
         8H9uJr98sNHlnH/y7w+3vyQzRDl1TqGRXa8FD30a6ZwyeG2+/mj+c/hytTd8ZMTZYZ+9
         vPWDBokKb2sHXy4wsoEM28QPx7AAJ+32Gzt4HeVOX8h4qll150D9foVfGzGUWHDgnIJs
         8DLg==
X-Gm-Message-State: AO0yUKUwNHG6mT8bVLg+V3aNTXNdxWshnCnJkmZcXMhaPNyxdTtgkjqz
        0mIrYBWsQAhch+LjeG+3fGJwh6DF9b9ocbw1onkjTadi/ZTTyDfA3S7bG7hFnidf1Wavcsz6O+0
        LFh8hREY/X0E17wJKHzfz5swaJL3o4ub7En80BFwH
X-Received: by 2002:a17:902:d506:b0:196:77ef:d51f with SMTP id b6-20020a170902d50600b0019677efd51fmr4467346plg.19.1675708386144;
        Mon, 06 Feb 2023 10:33:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/xO7DR1j4cwK+bSw0urCMn9Dl1P5O10w2wxatLooWgrDRGmlESvxsflg18HCvCuRmgYeFfitz6gLZCrRihYTo=
X-Received: by 2002:a17:902:d506:b0:196:77ef:d51f with SMTP id
 b6-20020a170902d50600b0019677efd51fmr4467339plg.19.1675708385884; Mon, 06 Feb
 2023 10:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20230206130449.41360-1-wander@redhat.com> <Y+EVNz4ORkFSvTfP@linutronix.de>
In-Reply-To: <Y+EVNz4ORkFSvTfP@linutronix.de>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 6 Feb 2023 15:32:54 -0300
Message-ID: <CAAq0SUmfVO1JZ_qFg_0ANF6dPk=M8fD3jpvALvXU8-bXXOjsxA@mail.gmail.com>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling context
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:57 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-02-06 10:04:47 [-0300], Wander Lairson Costa wrote:
> > Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
> > locks. Therefore, it can't be called from an non-preemptible context.
> >
> > One practical example is splat inside inactive_task_timer(), which is
> > called in a interrupt context:
>
> Do you have more?
> The inactive_task_timer() is marked as HRTIMER_MODE_REL_HARD which means
> in runs in hardirq-context. The author of commit
>    850377a875a48 ("sched/deadline: Ensure inactive_timer runs in hardirq =
context")
>
> should have been aware of that.
> We have on workaround of that put_task() in sched-switch. I wasn't aware
> of this shortcoming. So either we have more problems or potential
> problems or this is the only finding so far.
>

Valentin spotted two other potential issues, I fixed them in v2[1].
Also there is a discussion there that led to this implementation.

> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 9f7fe3541897..532dd2ceb6a3 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -857,6 +857,29 @@ void __put_task_struct(struct task_struct *tsk)
> =E2=80=A6
> > +void __put_task_struct(struct task_struct *tsk)
> > +{
> > +     if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task(=
)))
>
> Is it safe to use the rcu member in any case? If so why not use it
> unconditionally?
>

I am unsure what would be the consequences of moving every call to
RCU, so I thought it would be better to play safe and do it only when
necessary.

> > +             /*
> > +              * under PREEMPT_RT, we can't call put_task_struct
> > +              * in atomic context because it will indirectly
> > +              * acquire sleeping locks.
> > +              *
> > +              * call_rcu() will schedule delayed_put_task_struct_rcu()
> > +              * to be called in process context.
> > +              */
> > +             call_rcu(&tsk->rcu, delayed_put_task_struct_rcu);
> > +     else
> > +             ___put_task_struct(tsk);
> > +}
> >  EXPORT_SYMBOL_GPL(__put_task_struct);
> >
> >  void __init __weak arch_task_cache_init(void) { }
>
> Sebastian
>

[1] https://lore.kernel.org/all/20230120150246.20797-1-wander@redhat.com/

