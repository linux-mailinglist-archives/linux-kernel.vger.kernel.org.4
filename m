Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8FE629E58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKOQCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKOQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:02:03 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C3F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:02:02 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z17so9737742qki.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mphHOb91dA81eNm6zrgzZsbjN8Ohc/3yIAvdrTbJbYI=;
        b=pVwc/aOmwXdnDaJKer7siBqCPA2gfnv74Iphmkvg+WZQHkmbtqS854NYYYAa+U4+3e
         KHWeo4g02qOnund8YnBLeZ+H/y59pz5Kmd8vtc4CjHnP0iyTgLR1heMfpJpW35+0zywr
         IMytAPm6kkeqFJEUMVN098j/WrKCI6pCOq/Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mphHOb91dA81eNm6zrgzZsbjN8Ohc/3yIAvdrTbJbYI=;
        b=AOdbHtvPopOidtPYflovP8iRdzXbjCllE+plmy9clHWlPT9fBrIjpudPHnsxyHLlWl
         RawUibzm421svLXtbi4KnkpSB4fK4u/nJR3+q1UMLBccD44P43SpBeTanA9KjFdCQXws
         1NHnL3uQLVGpdaqYK9nUBd9m43/MCugRXUqOcpIm2gcI2jfR348/+XRxO6W/rSY5X+32
         O+HlTVmiKvQ8hQ/p88vNWoij8wP4+huy51lYMJcIb6TxqIaQy36IAB97rqbzw1re73bN
         j+J9jbsCgccvLtJifHllpcj9hmtgRdUBKEs7e/EZqqRZzbjiGNoPg+pHgkD0gSz1lmyv
         icTw==
X-Gm-Message-State: ANoB5pmRi2etbpcCvutP8ioxb9qU0BxG8sLmyKFPVXIZ2k34LOuxVbeS
        AnP2/GBk0+UmE030RQaKH/GGXA==
X-Google-Smtp-Source: AA0mqf7T5z5Bms3QZAXxIrcHzRqETWsSKrGXNLpZrjjg4bDHZKqCGtXJXOKU1dfwTc+fPMK0XlXyDw==
X-Received: by 2002:a37:a893:0:b0:6fa:a188:a4be with SMTP id r141-20020a37a893000000b006faa188a4bemr15962834qke.228.1668528121244;
        Tue, 15 Nov 2022 08:02:01 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id i20-20020ac85e54000000b0039ccbf75f92sm7413386qtx.11.2022.11.15.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:02:00 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:02:00 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 10/11] torture: support randomized shuffling for
 proxy exec testing
Message-ID: <Y3O3+NK+6/i7re3Q@google.com>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-11-connoro@google.com>
 <Y2/P3cMExRt2fUP5@google.com>
 <CALE1s+Ox_RF81kgF0YeV7sbuBN3RbBEvSK9_z6T4uWW2U_q=RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALE1s+Ox_RF81kgF0YeV7sbuBN3RbBEvSK9_z6T4uWW2U_q=RQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:44:21PM -0800, Connor O'Brien wrote:
> > Instead of doing it this way, maybe another approach is to randomize the
> > sleep interval in:
> >
> >  */
> > static int torture_shuffle(void *arg)
> > {
> >         VERBOSE_TOROUT_STRING("torture_shuffle task started");
> >         do {
> >                 schedule_timeout_interruptible(shuffle_interval);
> >                 torture_shuffle_tasks();
> >                 ...
> >         } while (...)
> >         ...
> > }
> >
> > Right now with this patch you still wakeup the shuffle thread when skipping
> > the affinity set operation.
> >
> > thanks,
> >
> >  - Joel
> >
> 
> Wouldn't the affinities of all the tasks still change in lockstep
> then? The intent with this patch is to get into situations where the
> tasks have different affinity masks, which I think requires changing
> the behavior of torture_shuffle_tasks() rather than how often it's
> called.

Correct me if I'm wrong, but you are still changing the affinities of all the
tasks at the same time (shuffle_task_list still has all the threads being set
to the same affinity). The difference is with your patch, you occasionally
skip punching a consecutive hole into shuffle_tmp_mask.

I was thinking how you could make this patch more upstreamable, you are right
calling less often is not what you are specifically looking for. However,
would a better approach be to:
	a) randomize the shuffle duration.
	b) Instead of skipping the set_cpus_allowed_ptr(), why not randomize
	the number of times you call cpumask_next() to pick a random hole.

These are just some ideas.

thanks,

 - Joel











