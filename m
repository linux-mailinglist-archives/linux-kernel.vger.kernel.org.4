Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F116114C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJ1OkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJ1Ojp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:39:45 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8030C1A39E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:39:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id j6so4153050qvn.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBCtjSxtj1jp0cjAy0wlS6C+ZFHd66+P95yTGOU8r4I=;
        b=edzmOuuY3YIwYEwDSYZfp6u2vQbVY9m85M3yA9Z6k1GH7Cx3U4Mr8YF7BYf1LQKc/c
         7aSzB5JyRLguKzMy2j7ANrS/KJULur1dH0RL4S1FrhYhwwbQD7gwZmo00JeH/r9HiCO5
         +tXdyuwfXDCiMFZrgQKRi3wXi08AV9bmbQQyv5v7Z0v4TMWfFEXKJtRzkdBm6Z7SxR3H
         XlJU9vO5k+fNcvZrfoJMIhdLuPBpF6RsrsBusRyUpAksFRQNxc3CjNZYVnubtDTGpkN2
         Wr9T/8LwvAK7uQzWErg55cOeRwA9iyOmSorh7y9KISqs6QIVQfhYmqCqhhSiRGzlUr8F
         AQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBCtjSxtj1jp0cjAy0wlS6C+ZFHd66+P95yTGOU8r4I=;
        b=4IF/WvN2CORBpCabweTyGV536zjbSMI1YRm8Dr7SbWV9lqWoPSgJHu4pUnDR0+qcCQ
         qAO7EpwMiWELypl2syOd/mo7Nt2nnrX4dR4KHxEOzNPQsXtOe8T2t5nWJCo36c+/thZd
         tnAJeNtvzcyVgH9tagHZVQSNVXACQW5cb0SJk5mwm0wSdRvDP1fL7hBhkYOvM1UG10qq
         2Yoo+1v0ijwWaW6wQ8ys/aQBcAX0ojcfBuAYQtEZvC4laKR5Q2AsJVi/AwmVo9Fe7hd1
         s5hrZ3GLoXvG+RgW+8AgqgzZ1i+8LGyIb6bjKv/HIe5W5x+YhpLkNJrd7UIdBpTBP0d9
         15Lg==
X-Gm-Message-State: ACrzQf3LlBrHyhAoGwORK1me+KEHT5KKh3G6gn1NJ3tn4B6RXRMnGpHN
        +GU6t0gUP+YOt7Ufl3iCRQMgYZDaT9MPTA==
X-Google-Smtp-Source: AMsMyM7ZMF8C2IdV3u0R8roPa1lWIi39iEVAGYABmSKIQLm0dA3mCkwgONkiC5lWSV12aiYnccmPaA==
X-Received: by 2002:ad4:574c:0:b0:4bb:7477:f13d with SMTP id q12-20020ad4574c000000b004bb7477f13dmr21410870qvx.39.1666967980492;
        Fri, 28 Oct 2022 07:39:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id f2-20020ac84702000000b003a50c9993e1sm509704qtp.16.2022.10.28.07.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:39:39 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:39:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim
 stats
Message-ID: <Y1vprODaLJLk0dka@cmpxchg.org>
References: <20221025170519.314511-1-hannes@cmpxchg.org>
 <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org>
 <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org>
 <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
 <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com>
 <Y1qSZHK/U0SpNqNa@cmpxchg.org>
 <CAJD7tkYt-KL=jDEy6pSOc5tDij=3SWmbhFeco39pjJuOmEAH0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYt-KL=jDEy6pSOc5tDij=3SWmbhFeco39pjJuOmEAH0g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:43:24PM -0700, Yosry Ahmed wrote:
> On Thu, Oct 27, 2022 at 7:15 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Wed, Oct 26, 2022 at 07:41:21PM -0700, Yosry Ahmed wrote:
> > > My 2c, if we care about direct reclaim as in reclaim that may stall
> > > user space application allocations, then there are other reclaim
> > > contexts that may pollute the direct reclaim stats. For instance,
> > > proactive reclaim, or reclaim done by writing a limit lower than the
> > > current usage to memory.max or memory.high, as they are not done in
> > > the context of the application allocating memory.
> > >
> > > At Google, we have some internal direct reclaim memcg statistics, and
> > > the way we handle this is by passing a flag from such contexts to
> > > try_to_free_mem_cgroup_pages() in the reclaim_options arg. This flag
> > > is echod into a scan_struct bit, which we then use to filter out
> > > direct reclaim operations that actually cause latencies in user space
> > > allocations.
> > >
> > > Perhaps something similar might be more generic here? I am not sure
> > > what context khugepaged reclaims memory from, but I think it's not a
> > > memcg context, so maybe we want to generalize the reclaim_options arg
> > > to try_to_free_pages() or whatever interface khugepaged uses to free
> > > memory.
> >
> > So at the /proc/vmstat level, I'm not sure it matters much because it
> > doesn't count any cgroup_reclaim() activity.
> >
> > But at the cgroup level, it sure would be nice to split out proactive
> > reclaim churn. Both in terms of not polluting direct reclaim counts,
> > but also for *knowing* how much proactive reclaim is doing.
> >
> > Do you have separate counters for this?
> 
> Not yet. Currently we only have the first part, not polluting direct
> reclaim counts.
> 
> We basically exclude reclaim coming from memory.reclaim, setting
> memory.max/memory.limit_in_bytes, memory.high (on write, not hitting
> the high limit), and memory.force_empty from direct reclaim stats.
> 
> As for having a separate counter for proactive reclaim, do you think
> it should be limited to reclaim coming from memory.reclaim (and
> potentially memory.force_empty), or should it include reclaim coming
> from limit-setting as well?

A combined counter seems reasonable to me. We *have* used the limit
knobs to drive proactive reclaim in production in the past, so it's
not a stretch. And I can't think of a scenario where you'd like them
to be separate.

I could think of two ways of describing it:

pgscan_user: User-requested reclaim. Could be confusing if we ever
have an in-kernel proactive reclaim driver - unless that would then go
to another counter (new or kswapd).

pgscan_ext: Reclaim activity from extraordinary/external
requests. External as in: outside the allocation context.
