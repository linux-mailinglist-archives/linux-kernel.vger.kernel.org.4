Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C467B80D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjAYRKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjAYRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5211E1C8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674666435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wq3Q5+Num0rwyySEnsJ5ltWOQliKuH/vVqGzLOIkZiA=;
        b=ULKI600g3ng68CUygyznDuZ/LaiARZUWmABaLQwzknvfnjQ1mRHwDdrofvqfrwAU7PYfiK
        Qo5I4yq8fu83c6ZPUjycEpgsoA2DSaMltkmuSTsO0f/6ljIZDdF2gmVpIY960dAg2FVUfO
        /+QFgEXZ5eEdkvl2MPghXtRbbSoMf6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-YKypOLZXPrmEtGz0Nrurag-1; Wed, 25 Jan 2023 12:07:13 -0500
X-MC-Unique: YKypOLZXPrmEtGz0Nrurag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26097802BF5;
        Wed, 25 Jan 2023 17:07:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-195-63.brq.redhat.com [10.40.195.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7DCC714171BB;
        Wed, 25 Jan 2023 17:07:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Jan 2023 18:07:10 +0100 (CET)
Date:   Wed, 25 Jan 2023 18:07:08 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH v2] posix-timers: Support delivery of signals to the
 current thread
Message-ID: <20230125170708.GE13746@redhat.com>
References: <20221216171807.760147-1-dvyukov@google.com>
 <20230112112411.813356-1-dvyukov@google.com>
 <20230125124304.GA13746@redhat.com>
 <20230125151717.GB13746@redhat.com>
 <CACT4Y+YKy_4mBLYomr49+fTm31Y6Q_kXhJz8O-_RTjMe=B-6eg@mail.gmail.com>
 <20230125163137.GC13746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125163137.GC13746@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25, Oleg Nesterov wrote:
>
> > >  int posix_timer_event(struct k_itimer *timr, int si_private)
> > >  {
> > >         enum pid_type type;
> > > +       struct pid *pid;
> > >         int ret;
> > >         /*
> > >          * FIXME: if ->sigq is queued we can race with
> > > @@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
> > >          */
> > >         timr->sigq->info.si_sys_private = si_private;
> > >
> > > -       type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> > > -       ret = send_sigqueue(timr->sigq, timr->it_pid, type);
> > > +       type = (timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_PID : PIDTYPE_TGID;
> > > +       pid = (type == PIDTYPE_PID) ? timr->it_pid : task_pid(current);
> > > +       ret = send_sigqueue(timr->sigq, pid, type);
> > >         /* If we failed to send the signal the timer stops. */
> > >         return ret > 0;
> > >  }

...

> But! I just noticed send_sigqueue() does pid_task(pid, type), so the patch
> above needs another change
>
> 	--- a/kernel/signal.c
> 	+++ b/kernel/signal.c
> 	@@ -1970,7 +1970,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
> 	 
> 		ret = -1;
> 		rcu_read_lock();
> 	-	t = pid_task(pid, type);
> 	+	// comment to explain why don't we use "type"
> 	+	t = pid_task(pid, PIDTYPE_PID);
> 		if (!t || !likely(lock_task_sighand(t, &flags)))
> 			goto ret;

So. Unless I missed something (quite possibly) we do not even need the patch
above. The one liner change below can work just fine.

Oleg.

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1970,7 +1970,8 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 
 	ret = -1;
 	rcu_read_lock();
-	t = pid_task(pid, type);
+	/* GOOD COMMENT */
+	t = type == PIDTYPE_PID ? pid_task(pid, type) : current;
 	if (!t || !likely(lock_task_sighand(t, &flags)))
 		goto ret;
 

