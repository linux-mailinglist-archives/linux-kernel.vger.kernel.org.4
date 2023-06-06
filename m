Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083AB724132
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbjFFLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbjFFLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CF310D0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686051560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xk3pPl9FU3/0MAbX7IJyPhqV/t7Hb9yUGLTf6w4aMVQ=;
        b=Staf4jDH7CUeoCu5FOn0VGRjgL9NmTOqrmUdTQ2JE+uA/B5QRr7AnRgwDOJmRwogKp3yBw
        Ab062sYFpt1uS52IQC8eFaRqQNf1iGvOnkOl/sDtg0a/gLoiTsAaUsXHC+LEX/cTO7H0US
        B8gc6oljWlKccTx2++ZGmoUxstcPtWA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-nL8TI2joOr2TThROmH5ekg-1; Tue, 06 Jun 2023 07:39:19 -0400
X-MC-Unique: nL8TI2joOr2TThROmH5ekg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEB0D38294AD;
        Tue,  6 Jun 2023 11:39:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4106840CFD46;
        Tue,  6 Jun 2023 11:39:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Jun 2023 13:38:55 +0200 (CEST)
Date:   Tue, 6 Jun 2023 13:38:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST 2/2] signal: Don't disable preemption in
 ptrace_stop() on PREEMPT_RT.
Message-ID: <20230606113853.GC7542@redhat.com>
References: <20230606085524.2049961-1-bigeasy@linutronix.de>
 <20230606085524.2049961-3-bigeasy@linutronix.de>
 <20230606110447.GA7542@redhat.com>
 <20230606111418.GA906324@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606111418.GA906324@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06, Peter Zijlstra wrote:
>
> On Tue, Jun 06, 2023 at 01:04:48PM +0200, Oleg Nesterov wrote:
> > The patch LGTM, but I am a bit confused by the changelog/comments,
> > I guess I missed something...
> >
> > On 06/06, Sebastian Andrzej Siewior wrote:
> > >
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -2328,11 +2328,16 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
> > >  	 * The preempt-disable section ensures that there will be no preemption
> > >  	 * between unlock and schedule() and so improving the performance since
> > >  	 * the ptracer has no reason to sleep.
> > > +	 *
> > > +	 * This optimisation is not doable on PREEMPT_RT due to the spinlock_t
> > > +	 * within the preempt-disable section.
> > >  	 */
> > > -	preempt_disable();
> > > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> > > +		preempt_disable();
> >
> > Not only we the problems with cgroup_enter_frozen(), afaics (please correct me)
> > this optimisation doesn't work on RT anyway?
> >
> > IIUC, read_lock() on RT disables migration but not preemption, so it is simply
> > too late to do preempt_disable() before unlock/schedule. The tracer can preempt
> > the tracee right after do_notify_parent_cldstop().
>
> Correct -- but I think you can disable preemption over what is
> effectivly rwsem_up_read(), but you can't over the effective
> rtmutex_lock() that cgroup_enter_frozen() will then attempt.
>
> (iow, unlock() doesn't tend to sleep, while lock() does)
>
> But you're correct to point out that the whole preempt_disable() thing
> is entirely pointless due to the whole task_lock region being
> preemptible before it.

Thanks Peter.

So I think the comment should be updated. Otherwise it looks as if it makes
sense to try to move cgroup_enter_frozen() up before preempt_disable().

Oleg.

