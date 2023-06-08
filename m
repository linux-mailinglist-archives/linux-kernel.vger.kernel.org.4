Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA347287A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFHTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFHTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:10:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB82D4F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:10:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b23f04e333so316305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686251420; x=1688843420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7JDYeCj1Au9M2F7A6TgeeUVVVrQVhgPcLMJ9f44nT4=;
        b=ObuUy7jq4yJMZeFETYqxhPRD+TYk2lfW++fICGVSpTyoFgSwzI8oSot9SuARscGqBM
         gJ6yT9AOAmg0fobeDiW3RbJxtvsciXacKfGy8xjsuGVAV1Vu/2zVzltEjAILSuqZHPgr
         OgVzmMwxwUPdnXBKHpbA/586q5uEN7fT3yjTTlTIQFUWG7jhSUslUud02q/t+isp/eur
         5lDWdH0aSaYIWHVoDyynf4GABLH58sBMhhgmD6JL1tKZRDiA4rsyBpBZ/Frvgw9DaXSY
         rgmyG3kUqW1gfqG1JXJJnjfl574QW2l0HmWxiWPg+Tpm3/Z4oOgeW0jOKhFBNwLMWcpH
         ES2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251420; x=1688843420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7JDYeCj1Au9M2F7A6TgeeUVVVrQVhgPcLMJ9f44nT4=;
        b=OGIMVTavsoZong33VlWvWYx/io/yYqDk7BzPDPDS0BWUnwBz5EZ90ozMzKEKZYKare
         eTgrGAaJIVg0hevLQke2+KDOD5AE2X7Phc7xRYIvC5WVq2z+nVdKqjT0rlgMbYbw+DDL
         ZUE7ZEtmDiK9s+0NMUNzBeA2E96vl+Q7J61zCdqUg4z+UWbfsQBC+IHwNxOLRyInHAyb
         5t8gDhmwh1yxQ28BbOXBrckSd8qhGbaMnjyJLEWylUHcnV+4AVTSz4iFQfchvUvyc//s
         PRS5CjE+aHa7bcjXhM9ie3UxfTFrqlKDu2fVIt0vD4iaVJpxhW8Ewy8bgiLzYhJdsrjK
         hsuw==
X-Gm-Message-State: AC+VfDxq+TZtWWFBj467YVND+UFWWGrIzWvAbzzPrRtMcFYr+AD3BGBj
        iJOELzuVOhkeWjJE3oaKjjI=
X-Google-Smtp-Source: ACHHUZ5nR2KP9shcCg65TNHMHwD2feED6YAnUJLCRKW0B2VcKLwF5rQZJh1D7B9Bofg0fsquoq4UIQ==
X-Received: by 2002:a17:902:7c82:b0:1a2:9ce6:6483 with SMTP id y2-20020a1709027c8200b001a29ce66483mr4006161pll.64.1686251420344;
        Thu, 08 Jun 2023 12:10:20 -0700 (PDT)
Received: from V92F7Y9K0C.corp.robot.car ([199.73.127.2])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001b03f89daffsm1781251plg.110.2023.06.08.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:10:19 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:10:15 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.cz,
        vbabka@suse.cz, regressions@lists.linux.dev,
        Yu Ma <yu.ma@intel.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Message-ID: <ZIInlxGIl8mS-iRk@V92F7Y9K0C.corp.robot.car>
References: <20221024052841.3291983-1-shakeelb@google.com>
 <20230608111408.s2minsenlcjow7q3@quack3>
 <20230608173700.wafw5tyw52gwoicu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608173700.wafw5tyw52gwoicu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel and Jan,

On Thu, Jun 08, 2023 at 05:37:00PM +0000, Shakeel Butt wrote:
> On Thu, Jun 08, 2023 at 01:14:08PM +0200, Jan Kara wrote:
> [...]
> > 
> > Somewhat late to the game but our performance testing grid has noticed this
> > commit causes a performance regression on shell-heavy workloads. For
> > example running 'make test' in git sources on our test machine with 192
> > CPUs takes about 4% longer, system time is increased by about 9%:
> > 
> >                        before (9cd6ffa6025)  after (f1a7941243c1)
> > Amean     User         471.12 *   0.30%*     481.77 *  -1.96%*
> > Amean     System       244.47 *   0.90%*     269.13 *  -9.09%*
> > Amean     Elapsed      709.22 *   0.45%*     742.27 *  -4.19%*
> > Amean     CPU          100.00 (   0.20%)     101.00 *  -0.80%*
> > 
> > Essentially this workload spawns in sequence a lot of short-lived tasks and
> > the task startup + teardown cost is what this patch increases. To
> > demonstrate this more clearly, I've written trivial (and somewhat stupid)
> > benchmark shell_bench.sh:
> > 
> > for (( i = 0; i < 20000; i++ )); do
> > 	/bin/true
> > done
> > 
> > And when run like:
> > 
> > numactl -C 1 ./shell_bench.sh
> > 
> > (I've forced physical CPU binding to avoid task migrating over the machine
> > and cpu frequency scaling interfering which makes the numbers much more
> > noisy) I get the following elapsed times:
> > 
> >          9cd6ffa6025    f1a7941243c1
> > Avg      6.807429       7.631571
> > Stddev   0.021797       0.016483
> > 
> > So some 12% regression in elapsed time. Just to be sure I've verified that
> > per-cpu allocator patch [1] does not improve these numbers in any
> > significant way.
> > 
> > Where do we go from here? I think in principle the problem could be fixed
> > by being clever and when the task has only a single thread, we don't bother
> > with allocating pcpu counter (and summing it at the end) and just account
> > directly in mm_struct. When the second thread is spawned, we bite the
> > bullet, allocate pcpu counter and start with more scalable accounting.
> > These shortlived tasks in shell workloads or similar don't spawn any
> > threads so this should fix the regression. But this is obviously easier
> > said than done...
> > 
> 
> Thanks Jan for the report. I wanted to improve the percpu allocation to
> eliminate this regression as it was reported by intel test bot as well.
> However your suggestion seems seems targetted and reasonable as well. At
> the moment I am travelling, so not sure when I will get to this. Do you
> want to take a stab at it or you want me to do it? Also how urgent and
> sensitive this regression is for you?
> 
> thanks,
> Shakeel
> 
> 

I _think_ I could probably spin you a percpu_alloc_bulk() series in a
couple days for percpu_counters. Let me try and find some time, unless
you had something different in mind.

Thanks,
Dennis
