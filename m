Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C40767B6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjAYQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAYQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:32:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4D30288
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674664305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xLugWnik0ztUqVAzoBicaI4WZWrDoKphY1QbQVR7BFA=;
        b=i9zB3GWIn3FOApDUPOZrlIda2QjBp6nNSTS+R6REfwI/tWMS0oF3Aq8fvljhbhla5JptlM
        6Ts0Gww3VGf0O0HSbpwwGB93LGdiZb2GDINZIGCiX3h/MFHltMk4GVPPSQsfJEl8o4qLeb
        rsZD72/wiXWDmng7g93a2FHngunEzzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-tHcdFkSoOt-vzigHzZiRhQ-1; Wed, 25 Jan 2023 11:31:43 -0500
X-MC-Unique: tHcdFkSoOt-vzigHzZiRhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF99210395C8;
        Wed, 25 Jan 2023 16:31:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-195-63.brq.redhat.com [10.40.195.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1011C40C945A;
        Wed, 25 Jan 2023 16:31:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Jan 2023 17:31:40 +0100 (CET)
Date:   Wed, 25 Jan 2023 17:31:37 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
Message-ID: <20230125163137.GC13746@redhat.com>
References: <20221216171807.760147-1-dvyukov@google.com>
 <20230112112411.813356-1-dvyukov@google.com>
 <20230125124304.GA13746@redhat.com>
 <20230125151717.GB13746@redhat.com>
 <CACT4Y+YKy_4mBLYomr49+fTm31Y6Q_kXhJz8O-_RTjMe=B-6eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YKy_4mBLYomr49+fTm31Y6Q_kXhJz8O-_RTjMe=B-6eg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25, Dmitry Vyukov wrote:
>
> > diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> > index 5dead89308b7..e38b53a0f814 100644
> > --- a/kernel/time/posix-timers.c
> > +++ b/kernel/time/posix-timers.c
> > @@ -336,6 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
> >  int posix_timer_event(struct k_itimer *timr, int si_private)
> >  {
> >         enum pid_type type;
> > +       struct pid *pid;
> >         int ret;
> >         /*
> >          * FIXME: if ->sigq is queued we can race with
> > @@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
> >          */
> >         timr->sigq->info.si_sys_private = si_private;
> >
> > -       type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> > -       ret = send_sigqueue(timr->sigq, timr->it_pid, type);
> > +       type = (timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_PID : PIDTYPE_TGID;
> > +       pid = (type == PIDTYPE_PID) ? timr->it_pid : task_pid(current);
> > +       ret = send_sigqueue(timr->sigq, pid, type);
> >         /* If we failed to send the signal the timer stops. */
> >         return ret > 0;
> >  }
>
> Hi Oleg,
>
> This is indeed much simpler!
>
> Do I understand correctly that:
> 1. I would need to use SIGEV_SIGNAL (without SIGEV_THREAD_ID)

Yes,

> 2. The signal is still queued into process shared_pending

Yes. But just in case, please note that if this signal is not realtime
(sigev_signo < SIGRTMIN) and it is already queued, it will be dropped.
And I do not know if this can work for you.

However this is what we already have with SIGEV_SIGNAL w/o SIGEV_THREAD_ID,
and the same is true for SIGEV_THREAD_ID if the signal is already pending in
target_task->pending.

> 3. If the current task has not blocked the signal (it shouldn't), then
> it won't kick any other task

Yes,

> 4. The current task will likely deliver the signal right on the timer
> interrupt return to userspace
> ?

Yes.

But! I just noticed send_sigqueue() does pid_task(pid, type), so the patch
above needs another change


	--- a/kernel/signal.c
	+++ b/kernel/signal.c
	@@ -1970,7 +1970,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
	 
		ret = -1;
		rcu_read_lock();
	-	t = pid_task(pid, type);
	+	// comment to explain why don't we use "type"
	+	t = pid_task(pid, PIDTYPE_PID);
		if (!t || !likely(lock_task_sighand(t, &flags)))
			goto ret;
	 


> This changes the existing behavior (the "average bear" may be surprised :))
> https://elixir.bootlin.com/linux/v6.2-rc5/source/kernel/signal.c#L1007

this comment looks a bit misleading, s/main thread/target thread/

> But currnently it's also queued into shared_pending and any thread
> could get the signal anyway. So I think this should be fine.

Yes.

> On the positive side: it should improve performance. Delivering to the
> currently running task is better on all fronts (no kicking,
> rescheduling, IPIs, better locality), right?

Well, iiuc this was the goal of your patch ? ;)

Oleg.

