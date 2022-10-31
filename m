Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4C613B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiJaQql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJaQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:46:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB26DFFD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:46:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 63so10197557iov.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mz9q4FkmQXMt/CPksl2IBt8CctFgUcDRo2yJyy63HU=;
        b=muhS0Hni6Nrjsd6f/nV048meu4YXT7mjCv8vBi0EE0dUAcnBPhA5pTUBcQGs6v/g5n
         mcw8YlBn5NyKnJdiZ0cbkV00uCd2Wkuq1FCnCSdZcfR/FYY2GFf67lerfHlNxqlky/cw
         KGdIo+XguTc1LF97eQPEjuMot29aFZoRxWQG6eWAfckE7VgdVpgDKIHCpsUyjyHgd+yX
         r32wf6O4+wOp8chKq4oUmumtxJEcFCk+cTGzA32HaWmJjj5+MHKbbMK0jejipfz+Frrm
         DPPzu4m26iMyK0YeqBfHR2bGl417BMP4etHRIvGeyj6YVf2Nl7LQgxc4NbKRqZwNtI2O
         rEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Mz9q4FkmQXMt/CPksl2IBt8CctFgUcDRo2yJyy63HU=;
        b=IIUFHbk37SID89pz7SITMH0VUGGinA+JUc+mWKqV95uwRaLUwwtskgn/9QPDzh8Caw
         v7ut1MlznjluyIcpdGt6fRTYoBhyjYNN8ulHWoN0HjDfqnVL75gv52Mj3IhF2mKObtUH
         6A6K+HWpCWvDxQLkYhGoX4utexyPzUdQsXCF1+HMx2gnp5a0icpKCLY8yOlFXDry+ben
         YG48cm3DZtDpQ7vLB3KEHmacYvTCu9reaCD2sRrq2tcBi2YO99XhTSABdjBzI3qEfvM2
         j2lEumkBM7EcnuAIp9ET7kC0JQtAo92YfhfD9YkyaknTfC3x7KQPWkUIju6rcwb0iVOz
         PjCQ==
X-Gm-Message-State: ACrzQf00PfCOSVbQxqASyEdEcbjX084fyYhcVvOVoDFTyXEounVQynIX
        WZzf0ThzIRiJFJjY1o3MU3dqyAp9jFQjNjhSJgz/+A==
X-Google-Smtp-Source: AMsMyM4QQ19X6IkvLSW84e6oeFd+Vd64qT4wgGDelOXo5oCdt7YJ2uL5nDqd5m7SvidWOdB4m4izQ14dKZNfYUMPupg=
X-Received: by 2002:a05:6638:1450:b0:363:7052:9c30 with SMTP id
 l16-20020a056638145000b0036370529c30mr7884018jad.53.1667234796821; Mon, 31
 Oct 2022 09:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org> <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org> <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
 <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com>
 <Y1qSZHK/U0SpNqNa@cmpxchg.org> <CAJD7tkYt-KL=jDEy6pSOc5tDij=3SWmbhFeco39pjJuOmEAH0g@mail.gmail.com>
 <Y1vprODaLJLk0dka@cmpxchg.org> <CAJD7tkbBbh+uXe7S=a0E5=FBX4wVa7YDJDLmti370v2sVWVtWw@mail.gmail.com>
 <Y1/xBYZOyjoRrIoJ@cmpxchg.org>
In-Reply-To: <Y1/xBYZOyjoRrIoJ@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 31 Oct 2022 09:46:00 -0700
Message-ID: <CAJD7tkYTumMaromVY85Ncg_q6jK0rKkwUv2jRdW3Cdg0n3YJjg@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 9:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Oct 28, 2022 at 10:41:17AM -0700, Yosry Ahmed wrote:
> > On Fri, Oct 28, 2022 at 7:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > pgscan_user: User-requested reclaim. Could be confusing if we ever
> > > have an in-kernel proactive reclaim driver - unless that would then go
> > > to another counter (new or kswapd).
> > >
> > > pgscan_ext: Reclaim activity from extraordinary/external
> > > requests. External as in: outside the allocation context.
> >
> > I imagine if the kernel is doing proactive reclaim on its own, we
> > might want a separate counter for that anyway to monitor what the
> > kernel is doing. So maybe pgscan_user sounds nice for now, but I also
> > like that the latter explicitly says "this is external to the
> > allocation context". But we can just go with pgscan_user and document
> > it properly.
>
> Yes, I think you're right. pgscan_user sounds good to me.
>
> > How would khugepaged fit in this story? Seems like it would be part of
> > pgscan_ext but not pgscan_user. I imagine we also don't want to
> > pollute proactive reclaim counters with khugepaged reclaim (or other
> > non-direct reclaim).
> >
> > Maybe pgscan_user and pgscan_kernel/pgscan_indirect for things like khugepaged?
> > The problem with pgscan_kernel/indirect is that if we add a proactive
> > reclaim kthread in the future it would technically fit there but we
> > would want a separate counter for it.
> >
> > I am honestly not sure where to put khugepaged. The reasons I don't
> > like a dedicated counter for khugepaged are:
> > - What if other kthreads like khugepaged start doing the same, do we
> > add one counter per-thread?
>
> It's unlikely there will be more.
>
> The reason khugepaged doesn't rely on kswapd is unique to THP
> allocations: they can require an exorbitant amount of work to
> assemble, but due to fragmentation those requests may fail
> permanently. We don't want to burden a shared facility like kswapd
> with large amounts of speculative work on behalf of what are (still*)
> cornercase requests.
>
> This isn't true for other allocations. We do have __GFP_NORETRY sites
> here and there that rather fall back early than put in the full amount
> of work; but overall we expect allocations to succeed - and kswapd to
> be able to balance for them!!** - because the alternative tends to be
> OOMs, or drivers and workloads aborting on -ENOMEM.
>
> (* As we evolve the allocator and normalize huge page requests
>    (folios), kswapd may also eventually balance for THPs again. IOW,
>    it's more likely for this exception to disappear again than it is
>    that we'll see more of them.)
>
> (** This is also why it's no big deal if other kthreads that rely on
>     kswapd contribute to direct reclaim stats. First, it's highly
>     error prone to determine on a case by case basis whether userspace
>     could be waiting behind that direct reclaim - as Yang Shi's
>     writeback example demonstrates. Second, if kswapd is overwhelmed,
>     it's likely to impact userspace *anyway*! The benefit of this
>     classification work is questionable.)

Thanks for the explanation :)

>
> > - What if we deprecate khugepaged (or such threads)? Seems more likely
> > than deprecating kswapd.
>
> If that happens, we can remove the counter again. The bar isn't as
> high for vmstat as it for other ABI, and we've updated it plenty of
> times to reflect changes in the MM implementation.

Good to know! I thought we'd be stuck with it forever.

>
> > Looks like we want a stat that would group all of this reclaim coming
> > from non-direct kthreads, but would not include a future proactive
> > reclaim kthread.
>
> I think the desire to generalize overcomplicates things here in a way
> that isn't actually meaningful.
>
> Think of direct reclaim stats as a signal that either a) kswapd is
> broken or b) memory pressure is high enough to cause latencies in the
> class of requests that are of interest to userspace. This is true for
> all cases but khugepaged.

Agreed. I believe moving forward with pgscan_user and
pgscan_khugepaged style stats makes sense.

Thanks, Johannes!
