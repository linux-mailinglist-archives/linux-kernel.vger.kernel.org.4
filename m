Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553626141FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJaXxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJaXxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:53:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F211460
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:53:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d24so12121385pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtUKCiO+blpFTExxqgMRejbSoz4+To5x2z2lbiuVvBI=;
        b=FES1T9cH9X56AuZvW1TcBbE2nCjp//q7JaZ+B840F5gr323QVPCODh+RGenHIMC7ai
         MMAXz/iM5OPFixjXBGzFL62GZQXfSqRFLFQm10p8C4Szgr/o/bUNdcdnfHHjUurYVBgu
         bzbZ8Z6qXHT168FxINiWmzP/wnlHSpu7IccIDVQBLRSZK/GYhgQA0MyYfYCJWmjxdl4O
         296Trl3zGsN2ZLO+MOix1i6CjWs/Eq0ohSLn+KEa84pchKLVpfghAyd8u9T+GqcUA+s6
         EoAFmKWm2jnYTwCxFj9do+13Y7KZd9iPpVbGIdnV90MuVxhBHMfFEbKiqB4aHNbAvo99
         /kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtUKCiO+blpFTExxqgMRejbSoz4+To5x2z2lbiuVvBI=;
        b=qLfr9LdXBcdo3PQOiLStFK25HkS1TE5RqL6SAbFnValAxf7iKQVrj1u/PnWMATtpB5
         5AVpz+a00dv7Ox5PzbGUjjf0u4a2YL1KWerywkJ/du3m56yBCASKh/5RGpwAgJAO/os2
         oG4Q67pb+F9nuYwelNST3hIuT3ga189CyGwoUO4oFOaILDh6bvJWDxTfLhj3/4FwonyZ
         GrpP/z1Lc50NNQxLhxRlXjuZQFLnhFR78LNpeKfNr/yJvuXFWIXuo08aJsDWsNCWR32i
         ZR+2crcNu8ATgZwFfuBj362K+JDjgCqLm7wAxCma0NeiHUTKliuaASnZ1wZjr1+AUdlA
         EdKg==
X-Gm-Message-State: ACrzQf32z1sAJZsKTIymtsRPxfzz9z0mOn72pBQlUQUVFlJZAJLS6AkN
        2Rc3CMAOqulKsIT/Gx3E7hb6wxuYAmU=
X-Google-Smtp-Source: AMsMyM7563+NHdznmeqm8HGk2hmD/hkUGKCU/w/0/efB2iYdNP5NmJ3tlCEeHQQ0E5As/dT5LEFVWg==
X-Received: by 2002:a17:902:848c:b0:17a:b4c0:a02b with SMTP id c12-20020a170902848c00b0017ab4c0a02bmr16682662plo.122.1667260411087;
        Mon, 31 Oct 2022 16:53:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001769e6d4fafsm4952289plb.57.2022.10.31.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:53:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 13:53:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
References: <20221026224449.214839-1-joshdon@google.com>
 <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org>
 <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 31, 2022 at 04:15:54PM -0700, Josh Don wrote:
> On Mon, Oct 31, 2022 at 2:50 PM Tejun Heo <tj@kernel.org> wrote:
> Yes, but schemes such as shares and idle can still end up creating
> some severe inversions. For example, a SCHED_IDLE thread on a cpu with
> many other threads. Eventually the SCHED_IDLE thread will get run, but
> the round robin times can easily get pushes out to several hundred ms
> (or even into the seconds range), due to min granularity. cpusets
> combined with the load balancer's struggle to find low weight tasks
> exacerbates such situations.

Yeah, especially with narrow cpuset (or task cpu affinity) configurations,
it can get pretty bad. Outside that tho, at least I haven't seen a lot of
problematic cases as long as the low priority one isn't tightly entangled
with high priority tasks, mostly because 1. if the resource the low pri one
is holding affects large part of the system, the problem is self-solving as
the system quickly runs out of other things to do 2. if the resource isn't
affecting large part of the system, their blast radius is usually reasonably
confined to things tightly coupled with it. I'm sure there are exceptions
and we definitely wanna improve the situation where it makes sense.

> > > chatted with the folks working on the proxy execution patch series,
> > > and it seems like that could be a better generic solution to these
> > > types of issues.
> >
> > Care to elaborate?
> 
> https://lwn.net/Articles/793502/ gives some historical context, see
> also https://lwn.net/Articles/910302/.

Ah, full blown priority inheritance. They're great to pursue but I think we
wanna fix cpu bw control regardless. It's such an obvious and basic issue
and given how much problem we have with actually understanding resource and
control dependencies with all the custom synchronization contstructs in the
kernel, fixing it will be useful even in the future where we have a better
priority inheritance mechanism.

> > I don't follow. If you only throttle at predefined safe spots, the easiest
> > place being the kernel-user boundary, you cannot get system-wide stalls from
> > BW restrictions, which is something the kernel shouldn't allow userspace to
> > cause. In your example, a thread holding a kernel mutex waking back up into
> > a hierarchy that is currently throttled should keep running in the kernel
> > until it encounters such safe throttling point where it would have released
> > the kernel mutex and then throttle.
> 
> Agree except that for the task waking back up, it isn't on cpu, so
> there is no "wait to throttle it until it returns to user", since
> throttling happens in the context of the entire cfs_rq. We'd have to

Oh yeah, we'd have to be able to allow threads running in kernel regardless
of cfq_rq throttled state and then force charge the cpu cycles to be paid
later. It would definitely require quite a bit of work.

> treat threads in a bandwidth hierarchy that are also in kernel mode
> specially. Mechanically, it is more straightforward to implement the
> mechanism to wait to throttle until the cfs_rq has no more threads in
> kernel mode, than it is to exclude a woken task from the currently
> throttled period of its cfs_rq, though this is incomplete.

My hunch is that bunching them together is likely gonna create too many
escape scenarios and control artifacts and it'd be better to always push
throttling decisions to the leaves (tasks) so that each task can be
controlled separately. That'd involve architectural changes but the eventual
behavior would be a lot better.

> What you're suggesting would also require that we find a way to
> preempt the current thread to start running the thread that woke up in
> kernel (and this becomes more complex when the current thread is also
> in kernel, or if there are n other waiting threads that are also in
> kernel).

I don't think it needs that. What allows userspace to easily trigger
pathological scenarios is the ability to force the machine idle when there's
something which is ready to run in the kernel. If you take that away, most
of the problems disappear. It's not perfect but reasonable enough and not
worse than a system without cpu bw control.

Thanks.

-- 
tejun
