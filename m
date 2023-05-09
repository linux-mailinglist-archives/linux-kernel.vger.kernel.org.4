Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959CE6FD26F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjEIWPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEIWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0793A87
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683670487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydVLg8IPNtZ/Ju1d4KRWiYGNqw9BPaKTQueF/IDR2ec=;
        b=Hz4ZQF9Tk/nCvM2rsnaBMee7Uyp6R0fe2AwYh8u680VAGImdpbEJ00nJEz7gQcvTCeIXze
        jkYqpSxtw7KyXUNgmonB8LHopKN/RPyj/vqojxw6h2M3xp9xXrNIZ8QfjERXNHMytsmWAu
        ZZBs7TbzxwsJFcm2jzrGKFjeaqKS5ko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-S52LVMGYOBiaEpiZwT9FMQ-1; Tue, 09 May 2023 18:14:41 -0400
X-MC-Unique: S52LVMGYOBiaEpiZwT9FMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6743F185A79C;
        Tue,  9 May 2023 22:14:40 +0000 (UTC)
Received: from [10.22.18.234] (unknown [10.22.18.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42D2C492B00;
        Tue,  9 May 2023 22:14:39 +0000 (UTC)
Message-ID: <e17e3aa2c9ac1d6e410f66986da3c41efa9f7462.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] sched/core: Provide sched_rtmutex() and expose
 sched work helpers
From:   Crystal Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Date:   Tue, 09 May 2023 17:14:38 -0500
In-Reply-To: <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
         <20230427111937.2745231-2-bigeasy@linutronix.de>
         <20230503132051.GB1676736@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-03 at 15:20 +0200, Peter Zijlstra wrote:
> On Thu, Apr 27, 2023 at 01:19:34PM +0200, Sebastian Andrzej Siewior wrote=
:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >=20
> > schedule() invokes sched_submit_work() before scheduling and
> > sched_update_worker() afterwards to ensure that queued block requests
> > are
> > flushed and the (IO)worker machineries can instantiate new workers if
> > required. This avoids deadlocks and starvation.
> >=20
> > With rt_mutexes this can lead to subtle problem:
> >=20
> > =C2=A0 When rtmutex blocks current::pi_blocked_on points to the rtmutex=
 it
> > =C2=A0 blocks on. When one of the functions in sched_submit/resume_work=
()
> > =C2=A0 contends on a rtmutex based lock then that would corrupt
> > =C2=A0 current::pi_blocked_on.
> >=20
> > Make it possible to let rtmutex issue the calls outside of the slowpath=
,
> > i.e. when it is guaranteed that current::pi_blocked_on is NULL, by:
> >=20
> > =C2=A0 - Exposing sched_submit_work() and moving the task_running() con=
dition
> > =C2=A0=C2=A0=C2=A0 into schedule()
> >=20
> > =C2=A0 - Renamimg sched_update_worker() to sched_resume_work() and expo=
sing
> > it
> > =C2=A0=C2=A0=C2=A0 too.
> >=20
> > =C2=A0 - Providing sched_rtmutex() which just does the inner loop of
> > scheduling
> > =C2=A0=C2=A0=C2=A0 until need_resched() is not longer set. Split out th=
e loop so this
> > does
> > =C2=A0=C2=A0=C2=A0 not create yet another copy.
> >=20
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> Urgh, so I really don't like this.
>=20
> The end result is something like:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rt_mutex_lock()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_submit_work(=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // a n=
ested rt_mutex_lock() here will not clobber
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // ->p=
i_blocked_on because it's not set yet.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_blocks_on_rt_=
mutex();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tsk->p=
i_blocked_on =3D waiter;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rt_mut=
ex_enqueue(lock, waiter); <-- the real problem
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rt_mutex_slowlock_=
block();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 schedu=
le_rtmutex();
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_resume_work(=
);
>=20
> And all of this it not just because tsk->pi_blocked_on, but mostly
> because of task_blocks_on_rt_mutex() enqueueing the waiter. The whole
> enqueue thing is what makes the 'simple' solution of saving/restoring
> tsk->pi_blocked_on not work.
>=20
> Basically the pi_blocked_on curruption is a side effect, not the
> fundamental issue. One task having two waiters registered is the bigger
> issue.

Where do you see pi_blocked_on being saved/restored?  The whole point of
this patchset is to deal with sched_submit_work() before anything has
been done on the "outer" lock acquisition (not just pi_blocked_on, but
also enqueuing) other than failing the fast path.

> Now, sched_submit_work() could also use (regular) mutex -- after all
> it's a fully preemptible context. And then we're subject to the 'same'
> problem but with tsk->blocked_on (DEBUG_MUTEXES=3Dy).

It's fully preemptible but it still shouldn't be doing things that would
block on non-RT.  That'd already be broken for a number of reasons (task
state corruption, infinite recursion if current->plug isn't cleared
before doing whatever causes another standard schedule(), etc).

-Crystal

