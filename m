Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D2F6061A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJTNat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJTNam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5B1167F43
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666272636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BUyrMnRAetKWDyqMvz4lmBgnabUoXRa1KogD0K2jzUY=;
        b=BlaPC+o6q+SMWy59Xj7M336EbYfK05hi3VxcV6Pb/rFXc+SrkPnJ1Hq/VxmctgHVk8krN9
        hx5OpzmLuCg1jadqnLggzo4BzHEmbt2jI+I0/lPjD4c66ltngchi4L+biJE+em2JNssN//
        O3gJv1zBIJLp9gbpjETQBVbEUVdD7CQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-Jndec4jAOT6hYvw9kUD_WQ-1; Thu, 20 Oct 2022 09:30:34 -0400
X-MC-Unique: Jndec4jAOT6hYvw9kUD_WQ-1
Received: by mail-qt1-f200.google.com with SMTP id bq21-20020a05622a1c1500b0039cdae506e6so12174565qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUyrMnRAetKWDyqMvz4lmBgnabUoXRa1KogD0K2jzUY=;
        b=PFfBiKfDxsw7UUkUwjnqfIWPW4jiLluPTKfxfV3Q+FP/R09XdyD9Q9bjhf35yrVuK1
         sbX18eKbUUsbh7eoC7p67UNXaAjbRZJejieAVqbZKDjnBxINjpzvwtaJBO1tjSia35EK
         Xgu0akiWAfQiV1NtM1clXBMJy7pxvbaAyrvrZeoGHTDV+0kwKwY48fCclIOcZbkEF4aT
         C47uyUKT9+WTKn0z4SpHzPSPO5FEHn0XyF/vQrC/SA+nnXq0LV+L4AFfuWEf3uaH5L9M
         qpOxM+ww2zJ5w9WOjp91V2tURjg0C62cfmPRtAHfrQfVyuiwbGUFFPtVpJ9MIQC+HG1o
         RjaA==
X-Gm-Message-State: ACrzQf0NyhVOWF+96GlriOy/0n7Rk6FxHsOxcTql+iabKvd9dZ51lEbB
        tdR5OV7mME7b0J1x5yEpfnIdEOfM56m152yMh1paTqUOdrLSJl5BcYDEGtetPhrwmfALABSEnYx
        CIIgBTNOC9F94GeMi5VLqRxWt
X-Received: by 2002:a05:6214:c6d:b0:4b1:c751:ac7 with SMTP id t13-20020a0562140c6d00b004b1c7510ac7mr11416892qvj.96.1666272633328;
        Thu, 20 Oct 2022 06:30:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5/Fv+9ImOl6uqDgax7bpb3ftqmq2BNdXPKHvwEHE15DMkWQkQYLzHLnOe8hIcF7T3D+P+MeQ==
X-Received: by 2002:a05:6214:c6d:b0:4b1:c751:ac7 with SMTP id t13-20020a0562140c6d00b004b1c7510ac7mr11416833qvj.96.1666272632981;
        Thu, 20 Oct 2022 06:30:32 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.101])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006bb366779a4sm7077880qko.6.2022.10.20.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:30:32 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:30:26 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 09/11] sched/rt: Fix proxy/current (push,pull)ability
Message-ID: <Y1FNcmLl678L/3Ah@localhost.localdomain>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-10-connoro@google.com>
 <xhsmhv8orgb59.mognet@vschneid.remote.csb>
 <CALE1s+ODz2FUJoSHcORa25kckk81qSHuZ6RSE6-k=s2gzQ+eOQ@mail.gmail.com>
 <xhsmhtu3zwxpt.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhtu3zwxpt.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 18:05, Valentin Schneider wrote:
> On 14/10/22 15:32, Connor O'Brien wrote:
> > On Mon, Oct 10, 2022 at 4:40 AM Valentin Schneider <vschneid@redhat.com> wrote:
> >> Consider:
> >>
> >>    p0 (FIFO42)
> >>     |
> >>     | blocked_on
> >>     v
> >>    p1 (FIFO41)
> >>     |
> >>     | blocked_on
> >>     v
> >>    p2 (FIFO40)
> >>
> >>   Add on top p3 an unrelated FIFO1 task, and p4 an unrelated CFS task.
> >>
> >>   CPU0
> >>   current:  p0
> >>   proxy:    p2
> >>   enqueued: p0, p1, p2, p3
> >>
> >>   CPU1
> >>   current:  p4
> >>   proxy:    p4
> >>   enqueued: p4
> >>
> >>
> >> pick_next_pushable_task() on CPU0 would pick p1 as the next highest
> >> priority task to push away to e.g. CPU1, but that would be undone as soon
> >> as proxy() happens on CPU1: we'd notice the CPU boundary and punt it back
> >> to CPU0. What we would want here is to pick p3 instead to have it run on
> >> CPU1.
> >
> > Given this point, is there any reason that blocked tasks should ever
> > be pushable, even if they are not part of the blocked chain for the
> > currently running task? If we could just check task_is_blocked()
> > rather than needing to know whether the task is in the middle of the
> > "active" chain, that would seem to simplify things greatly. I think
> > that approach might also require another dequeue/enqueue, in
> > ttwu_runnable(), to catch non-proxy blocked tasks becoming unblocked
> > (and therefore pushable), but that *seems* OK...though I could
> > certainly be missing something.
> >
> 
> So for an active chain yes we probably don't want any task in the chain to
> be visible to load-balance - proxy and curr because they both make up the
> currently-executed task (but there are active load balances in
> e.g. CFS...), and the rest of the chain because of the above issues.
> 
> As for blocked tasks in a separate chain, ideally we would want them to be
> picked up by load-balance. Consider:
> 
>       blocked_on       owner
>   p0 ------------> m0 -------> p1
> FIFO4                         FIFO3
> 
>       blocked_on       owner
>   p2 ------------> m1 -------> p3
> FIFO2                         FIFO1
> 
> 
> If all those tasks end up on a single CPU for whatever reason, we'll pick
> p0, go through proxy(), and run p1.
> 
> If p2 isn't made visible to load-balance, we'll try to move p3 away -
> unfortunately nothing will make it bring p2 with it. So if all other CPUs
> are running FIFO1 tasks, load-balance will do nothing.
> 
> If p2 is made visible to load-balance, we'll try to move it away, but
> if/when we try to pick it we'll move it back to where p3 is...
> One possible change here is to make the blocked chain migrate towards the
> proxy rather than the owner - this makes scheduling priority considerations
> a bit saner, but is bad towards the owner (migrating blocked tasks is
> "cheap", migrating running tasks isn't).

Plus we need to consider owner's affinity, maybe it can't really migrate
towards proxy's CPU.

It looks like in general we would like to perform load balancing
decisions considering potential proxies attributes? Guess it might soon
turn into a mess to implement, though.

