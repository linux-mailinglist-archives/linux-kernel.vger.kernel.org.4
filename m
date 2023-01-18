Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04476726E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjARS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjARS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60EE23C79
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674066487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yc6aYGxEIFfDCIA/Zf5NYIcbIePQEIByP3E8Jqjy8zY=;
        b=d5ymuZBoOfhF+RXyrmq2CS6JldY0h58dyPVasodfsgnpIBBRJahDSAf6YvHqW0SQxJRfCz
        r75aoxxwpVJ+sNLc7yaWaNXwJVVhc2u9fp9zk/4yz788IX8r4NHkwAfux6vpph5SBVmssO
        yBh/QUnp/RUFIfQypEzsj/zNrX17+M4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-EMexDfx3Mi2EZ1VvlFtP_Q-1; Wed, 18 Jan 2023 13:28:05 -0500
X-MC-Unique: EMexDfx3Mi2EZ1VvlFtP_Q-1
Received: by mail-yb1-f200.google.com with SMTP id k204-20020a256fd5000000b007b8b040bc50so36341197ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc6aYGxEIFfDCIA/Zf5NYIcbIePQEIByP3E8Jqjy8zY=;
        b=BsnsKlk347YyGyYdvoKVsKEBIQQWAEPnzH+NSjGpU5NV/mmm9sS8dcUFWkdzvcs8AP
         RoohjWLq240VIVxoesBfVNkPPhasvdB6jMriF19uLXNFcX3TZ+hWCkQU9gQGsl8Aw+CR
         Yxs4mbKgprbOpE6BeYKe8A7w3oKW3BuVdfkzmM/aNX/+f/rHsMvM2yBW5LwQCf57K5cp
         rfPnQOKFkdRwIM0UzD+XEJb7saq8n0R+kVtKs/n4Z8VHWGNXgCnxQNGGJabFieRKIuWg
         arkmBbrBoxhnR/PgHLw8svbvkrn+xGqnz6yGBY+5t96OwKkA2EODSs93oSRkCr1tgsgi
         DZJw==
X-Gm-Message-State: AFqh2kodDRRitIOst2ooIuzk27//JlALWgH5kYUagH2mSNDsM/SEEGCg
        2TNaAsgSj/Kp114vagBdewa/YlW5vfW3khIYwG6V8ag7EwV34Yd6HNaNeos18iSo1JdqohqRwqW
        06h4PwAol6BpmDmKZxSxCPBQ7
X-Received: by 2002:a25:a2cf:0:b0:7b5:9a5b:74bb with SMTP id c15-20020a25a2cf000000b007b59a5b74bbmr6611940ybn.38.1674066484427;
        Wed, 18 Jan 2023 10:28:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu4nral7lgMvrs/RhImojO6xXvLZ4kNxpFDbnlDV6jH2tcgXmVSJfAkaLmhCf/fVt+EbOchmw==
X-Received: by 2002:a25:a2cf:0:b0:7b5:9a5b:74bb with SMTP id c15-20020a25a2cf000000b007b59a5b74bbmr6611920ybn.38.1674066484187;
        Wed, 18 Jan 2023 10:28:04 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a254f00b007056237b41bsm22719177qko.67.2023.01.18.10.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:28:03 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     paulmck@kernel.org
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/deadline: fix inactive_task_timer splat with
 CONFIG_PREEMPT_RT
In-Reply-To: <20230118181132.GF2948950@paulmck-ThinkPad-P17-Gen-1>
References: <20230104181701.43224-1-wander@redhat.com>
 <20230110013333.GH4028633@paulmck-ThinkPad-P17-Gen-1>
 <CAAq0SUm+VkoM38ULJE6zuajA3Tc7KYbiH51uc9oKjGE+RhDmXg@mail.gmail.com>
 <20230110222725.GT4028633@paulmck-ThinkPad-P17-Gen-1>
 <xhsmha62fj0nh.mognet@vschneid.remote.csb>
 <20230118181132.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 18 Jan 2023 18:28:00 +0000
Message-ID: <xhsmh7cxjitov.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/23 10:11, Paul E. McKenney wrote:
> On Wed, Jan 18, 2023 at 03:57:38PM +0000, Valentin Schneider wrote:
>> > Given that this problem occurred in PREEMPT_RT, I am assuming that the
>> > appropriate definition of "atomic context" is "cannot call schedule()".
>> > And you are in fact not permitted to call schedule() from a bh-disabled
>> > region.
>> >
>> > This also means that you cannot acquire a non-raw spinlock in a
>> > bh-disabled region of code in a PREEMPT_RT kernel, because doing
>> > so can invoke schedule.
>>
>> But per the PREEMPT_RT lock "replacement", non-raw spinlocks end up
>> invoking schedule_rtlock(), which should be safe vs BH disabled
>> (local_lock() + rcu_read_lock()):
>>
>>   6991436c2b5d ("sched/core: Provide a scheduling point for RT locks")
>>
>> Unless I'm missing something else?
>
> No, you miss nothing.  Apologies for my confusion!
>
> (I could have sworn that someone else corrected me on this earlier,
> but I don't see it right off hand.)
>
>                                                       Thanx, Paul

Heh, I had a smidge of doubt myself, but since we've cleared this up:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

