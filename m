Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B06D6A3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjDDRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbjDDRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:17:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E4B1997
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:17:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso22289708wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680628642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txVm5JgMwTa0GASAVxn38cvz41mLZSuRMGj6/8ZDA7c=;
        b=FloniA4MoWqYbM+5TFvqRD8Xh5RN/1Xkg6Ks5dcY4KLO8ijNV5A3p3APgiGCnV7x9s
         vC+2Ygzlfroa7epKwHbJJY3LHGbbjCM+iMDvdwHAp1gBjcMA1i+aH7hDmvxeQ2sUKbaR
         BwwS7fyCCmUeC1t85F1QqAbdWrGxV7MKZXuo/uHco/AylG4F+bQ+4AmINeVeXwkHNKfl
         1DZwjB9alBUouexQ0FKXHRT82AQKJWiv+B7qdKk9+zjVNqNJR56JknG8DvJn93tECrHw
         yqKSHxvSM7Bx0qOB4tzCHt+VU4rPbJy8ynDkvqdmf817ZAovk2MwsIKDEmhAat0TmemN
         v7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txVm5JgMwTa0GASAVxn38cvz41mLZSuRMGj6/8ZDA7c=;
        b=Q5C4bJkuhfEo4Y5SyCG1xIxcvpYbAAqGR7uyXf4nNSrUq5Xu+HaYhtJV8ZRUuiGr1B
         kiQ5XHcyk3WYDGck4S373eX+9tzrgFxFF4f3XlL0I9R0eJ2bYqS2dWyq2cmIEf/nHCPC
         wB+CNG9aNkLi3EQ8Dm383fCgtW59y1Sjwt2tVo2QNkoc46PcNLq5zXyq/rUpP1Wxqhfr
         nwnZop8F0v6isBSLBdQTagKdyKAegCvqpwrG7kQvZsAKO55KylstV9UX98jN4odp8WuF
         eWu/AqY88EpOgf9spHLYO4nF/54MUIyYx3LPDh9XRBpuqZ/cltXcxiJ7g72Wru4V5D1X
         l0gg==
X-Gm-Message-State: AAQBX9fOxjO+RCnncmqoXyf+8YymthEzcLA/kPkopd+ljlaCNaU+cvWt
        WArCvaXO3e5UtTp2JPcNXB8AUpIEl0vOqXMQlyA=
X-Google-Smtp-Source: AKy350Ze6ZhJMWKYd/qI5CGFx2CSupFNq011b07kq3gL9ejsm0Si9sT7MoSagbShMYuxxGAXSJisRg==
X-Received: by 2002:a1c:cc1a:0:b0:3f0:4e04:b8f8 with SMTP id h26-20020a1ccc1a000000b003f04e04b8f8mr2648001wmb.39.1680628642373;
        Tue, 04 Apr 2023 10:17:22 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b003ede2c4701dsm23061015wms.14.2023.04.04.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:17:21 -0700 (PDT)
Date:   Tue, 4 Apr 2023 18:17:20 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
Subject: Re: [PATCH 1/3] sched/tp: Add new tracepoint to track uclamp set
 from user-space
Message-ID: <20230404171720.ntktoqixkj5f77ag@airbuntu>
References: <20230322151843.14390-1-lukasz.luba@arm.com>
 <20230322151843.14390-2-lukasz.luba@arm.com>
 <20230403134606.amdxfmr5fb544xnv@airbuntu>
 <bdaebc90-ca39-1301-c7ba-e367f8406d09@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdaebc90-ca39-1301-c7ba-e367f8406d09@arm.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/23 17:47, Lukasz Luba wrote:
> Hi Qais,
> 
> On 4/3/23 14:46, Qais Yousef wrote:
> > Hi Lukasz!
> > 
> > On 03/22/23 15:18, Lukasz Luba wrote:
> > > The user-space can set uclamp value for a given task. It impacts task
> > > placement decisions made by the scheduler. This is very useful information
> > > and helps to understand the system behavior or track improvements in
> > > middleware and applications which start using uclamp mechanisms and report
> > > better performance in tests.
> > 
> > We do have uclamp trace events in sched_tp, why are they not sufficient?
> > 
> > 	https://github.com/qais-yousef/sched_tp/blob/main/sched_events.h#L233
> > 
> > Do you really want to know the exact time the value has changed?
> 
> Yes, that's why these new are triggered instantly after userspace wanted
> to set the new uclamp values. We are going to have a few different
> uclamp implementations: one in mainline and X in Android vendor kernels.

This is not true. As you can see everyone tries to push fixes for issues they
find, but this not happening fast enough and they get forced to carry out of
tree stuff at the end. Out of tree stuff for the broken bits that is.

> The goal is to have only one... We will have to experiment to find

This statement gives a very strong message to everyone out here. And I'd like
to stress strongly that this is NOT true. Broken bits, yes. But essential bits
that works are used the same.

We can do a better job and fix things faster upstream. I am committed to
sorting all these stuff out anyway.

> the behavior of those algorithms and understand the differences. Since
> uclamp is part of this 'control-chain' of CPU frequency and also
> task placement - it would be really tricky to figure our everything.
> The analysis on traces are crucial for this.

I think the existing uclamp trace event is enough to be honest. But up to the
maintainer if they want to add this new specific one. The two tps seem a bit of
a clutter to me. With kprobes and bpf a lot can be done on the fly if you want
to reverse engineer some stuff.

> 
> > 
> > Would it make sense to introduce a generic sched_setscheduler tracepoint
> > instead? Although this might not be necessary as I think we can use
> > register_kprobe() to register a callback and create a new event without any
> > additional tracepoint. sched_setscheduler() is not inlined so should be easy to
> > hook into and create events, no?
> 
> This looks very complex and we already have our LISA tool with the

It's not. Here's a PoC that only does a trace_printk(), it's simple. You don't
need to do it in a module even, see below.

	https://github.com/qais-yousef/sched_tp/compare/main...kprobe-poc

It did highlight that sugov_should_update_freq() ends up actually being inlined
though :(. It should work for sched_setscheduler(). You'd want to use
register_kprobe() instead for that.

> module to change the tracepoints into trace events and build them.
> I wanted to be aligned with that design, which might look a bit
> old-fashion but is simple IMO.

trace-cmd, bpf and I believe perf, all can do the same; and they support
kprobes not just tracepoints.

And they all boil down to the same underlying mechanism

	https://www.kernel.org/doc/html/v6.1/trace/kprobetrace.html

No need to re-invent a new wheel ;-)

> The 'sched_setscheduler tracepoint' might be a too big for this
> purpose.

Sorry I am usually supportive for more tracepoints, but I feel skeptical this
time. That said, I really don't mind if the maintainers are okay with it. So
while I'm not convinced, but I don't have any objection either.

> Thanks for the comments :)

Thanks!

--
Qais Yousef
