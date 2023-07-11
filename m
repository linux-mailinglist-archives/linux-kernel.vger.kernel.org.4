Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5E774F9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGKVdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKVds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:33:48 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6210DF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:33:47 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7659dc74d91so683140785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689111227; x=1691703227;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdqh8jMf7s2T+NSmfFC2ZqaBW686ZXujcKB3SS1VBpg=;
        b=H9PWnH0ym+DELvSL9rAxXl1J1FZomPZ/11sJC5NSpOg0uQDattnLwCsSXG6it+vpzY
         o0EyWAJV5vKxBhaWmQ7dfEGLylWUa/ep8rilbAuuBAztUTSuZsJjoLtlndEKMKo+Smfd
         8TDtIWpEJ6iVwVBbRKhfVQCX/jioRKB9nynplwPbD0t+iS3c/SGk8peVNhOH9Y2W5DI/
         JVJzBOdj3kHB0UN2FscDFquqt3YNw0E4VHCOs0qZBNN1c4P5t173/FLRjsnad4+voklI
         L3gc+2lo2tyIORHSz1OghrXzsAD61CptcwRhbf4fr9W1J7/iUK/6sVp97YEb8iywRkGb
         IM7A==
X-Gm-Message-State: ABy/qLbqYy/5iQqUm9LUbtvy69NoygGRouO9MivcJRJcvoKi15Y7lFqo
        Emc5Ur5Px3l/42ueRRLXlOc=
X-Google-Smtp-Source: APBJJlGuKnf8hzLtbr4sTzWWep7hEYhQQrE+2lZboMe61RTBHrf3Q1sPCK9SOrthm6t8oNjgAHQGjA==
X-Received: by 2002:a05:622a:134f:b0:403:b08c:9114 with SMTP id w15-20020a05622a134f00b00403b08c9114mr9759431qtk.61.1689111226697;
        Tue, 11 Jul 2023 14:33:46 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1d49])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87318000000b00402364e77dcsm1536842qto.7.2023.07.11.14.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 14:33:46 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:33:43 -0500
From:   David Vernet <void@manifault.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        gautham.shenoy@amd.com, kprateek.nayak@amd.com, aaron.lu@intel.com,
        clm@meta.com, tj@kernel.org, roman.gushchin@linux.dev,
        kernel-team@meta.com
Subject: Re: [PATCH v2 0/7] sched: Implement shared runqueue in CFS
Message-ID: <20230711213343.GE389526@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230711114207.GK3062772@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711114207.GK3062772@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:42:07PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 10, 2023 at 03:03:35PM -0500, David Vernet wrote:
> > Difference between shared_runq and SIS_NODE
> > ===========================================
> > 
> > In [0] Peter proposed a patch that addresses Tejun's observations that
> > when workqueues are targeted towards a specific LLC on his Zen2 machine
> > with small CCXs, that there would be significant idle time due to
> > select_idle_sibling() not considering anything outside of the current
> > LLC.
> > 
> > This patch (SIS_NODE) is essentially the complement to the proposal
> > here. SID_NODE causes waking tasks to look for idle cores in neighboring
> > LLCs on the same die, whereas shared_runq causes cores about to go idle
> > to look for enqueued tasks. That said, in its current form, the two
> > features at are a different scope as SIS_NODE searches for idle cores
> > between LLCs, while shared_runq enqueues tasks within a single LLC.
> > 
> > The patch was since removed in [1], and we compared the results to
> > shared_runq (previously called "swqueue") in [2]. SIS_NODE did not
> > outperform shared_runq on any of the benchmarks, so we elect to not
> > compare against it again for this v2 patch set.
> 
> Right, so SIS is search-idle-on-wakeup, while you do
> search-task-on-newidle, and they are indeed complentary actions.
> 
> As to SIS_NODE, I really want that to happen, but we need a little more
> work for the Epyc things, they have a few too many CCXs per node :-)
> 
> Anyway, the same thing that moticated SIS_NODE should also be relevant
> here, those Zen2 things have only 3/4 cores per LLC, would it not also
> make sense to include multiple of them into the shared runqueue thing?

It's probably worth experimenting with this, but it would be workload
dependent on whether this would help or hurt. I would imagine there are
workloads where having a single shared runq for the whole socket is
advantageous even for larger LLCs like on Milan. But for many use cases
(including e.g. HHVM), the cache-line bouncing makes it untenable.

But yes, if we deem SIS_NODE to be useful for small CCXs like Zen2, I
don't see any reason to not apply that to shared_runq as well. I don't
have a Zen2 but I'll prototype this idea and hopefully can get some help
from Tejun or someone else to run some benchmarks on it.

> (My brain is still processing the shared_runq name...)

Figured this would be the most contentious part of v2.
