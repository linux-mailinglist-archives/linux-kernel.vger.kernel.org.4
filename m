Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE4613AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiJaQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJaQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:00:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32691EAA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:00:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id fz10so1976382qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqNXT1yvQ+HeL2IwyL8Ke4Gy8cBqHUWLrK2MKKUD7Ms=;
        b=6R1CxvJuec61nZc5iGmNYAx1CT/jr3j7yzXcibP0bT7RSVNWBDFj13wsjwTzqM6mnd
         UXroCkKUwbV+KL1WmS1RFPx0VgBRGlvf1GvlXI4T4qam9pUOicaba5DkzOEjksiO0wbu
         ckhSgiyZCUqPdndZeCg125nV6//L9HEiKkSbjcbUle7+2tDxBhyMUGLrva+r6PfZNBYq
         /Kj3FKDexk6gZ4kFYx/DQcEPpioIQV1vnARhpezCWqr7e0yygmUFQkbH8fv7yloGXaAM
         81rZgv52lEHDVeN7ODSPfDq1cD1WKB6tx+jAjODZU2mf3xKlESjvr/TCbmlod96Mm+bX
         AGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqNXT1yvQ+HeL2IwyL8Ke4Gy8cBqHUWLrK2MKKUD7Ms=;
        b=RLZ+UUrAZv3aJAI/uBI9yTN78BlcrXmOSNjhF9xhoXU9ACoTYVaqoEirkf2N9NkHUD
         GsOIO8tGds2IPk9kMeKFp7uLtFAuJbZ3TM7mZXkMk9Bd/MAivDxf1ZZWRq1YgxtqaPrX
         1Y2U8xT7LX1AEqt7Et+JLuTuvxDrdCrRrY9jfRUrCPitJSWwEnwZVpIsc63wtJYr7bpb
         vs47Z3ozGHuWv6rIAMTn6d6asUSJwEbkpR2cPOmrMcx5dI9uSako8BjwQ/IvvWJMhquP
         8+Q6Djyv8UN6zuLvnUpyPysKtoym/jfo8Jmnn4ikAf0GVFnhHVfk3vZJy8N15AnmkxXp
         pXUQ==
X-Gm-Message-State: ACrzQf0jqYe/eCFQSDAYI0WbVHWtuFcw1Fg6C5H+eNufqUEnTfiXKJQG
        YkYAn/QUKEUvo3NfefyWQRdSbA==
X-Google-Smtp-Source: AMsMyM6ROOnUhJSSHMqb/eoxOgQHmqL3NUHIvcDeLB1gfroaX0hnKpkxLMDNMgfqHkG4NsFd+bjzWQ==
X-Received: by 2002:a05:622a:4815:b0:3a5:25a0:9b7c with SMTP id fb21-20020a05622a481500b003a525a09b7cmr4897818qtb.668.1667232005015;
        Mon, 31 Oct 2022 09:00:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25f1])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a431600b006ceb933a9fesm4844384qko.81.2022.10.31.09.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:00:04 -0700 (PDT)
Date:   Mon, 31 Oct 2022 12:00:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim
 stats
Message-ID: <Y1/xBYZOyjoRrIoJ@cmpxchg.org>
References: <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org>
 <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org>
 <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
 <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com>
 <Y1qSZHK/U0SpNqNa@cmpxchg.org>
 <CAJD7tkYt-KL=jDEy6pSOc5tDij=3SWmbhFeco39pjJuOmEAH0g@mail.gmail.com>
 <Y1vprODaLJLk0dka@cmpxchg.org>
 <CAJD7tkbBbh+uXe7S=a0E5=FBX4wVa7YDJDLmti370v2sVWVtWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbBbh+uXe7S=a0E5=FBX4wVa7YDJDLmti370v2sVWVtWw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:41:17AM -0700, Yosry Ahmed wrote:
> On Fri, Oct 28, 2022 at 7:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > pgscan_user: User-requested reclaim. Could be confusing if we ever
> > have an in-kernel proactive reclaim driver - unless that would then go
> > to another counter (new or kswapd).
> >
> > pgscan_ext: Reclaim activity from extraordinary/external
> > requests. External as in: outside the allocation context.
> 
> I imagine if the kernel is doing proactive reclaim on its own, we
> might want a separate counter for that anyway to monitor what the
> kernel is doing. So maybe pgscan_user sounds nice for now, but I also
> like that the latter explicitly says "this is external to the
> allocation context". But we can just go with pgscan_user and document
> it properly.

Yes, I think you're right. pgscan_user sounds good to me.

> How would khugepaged fit in this story? Seems like it would be part of
> pgscan_ext but not pgscan_user. I imagine we also don't want to
> pollute proactive reclaim counters with khugepaged reclaim (or other
> non-direct reclaim).
> 
> Maybe pgscan_user and pgscan_kernel/pgscan_indirect for things like khugepaged?
> The problem with pgscan_kernel/indirect is that if we add a proactive
> reclaim kthread in the future it would technically fit there but we
> would want a separate counter for it.
> 
> I am honestly not sure where to put khugepaged. The reasons I don't
> like a dedicated counter for khugepaged are:
> - What if other kthreads like khugepaged start doing the same, do we
> add one counter per-thread?

It's unlikely there will be more.

The reason khugepaged doesn't rely on kswapd is unique to THP
allocations: they can require an exorbitant amount of work to
assemble, but due to fragmentation those requests may fail
permanently. We don't want to burden a shared facility like kswapd
with large amounts of speculative work on behalf of what are (still*)
cornercase requests.

This isn't true for other allocations. We do have __GFP_NORETRY sites
here and there that rather fall back early than put in the full amount
of work; but overall we expect allocations to succeed - and kswapd to
be able to balance for them!!** - because the alternative tends to be
OOMs, or drivers and workloads aborting on -ENOMEM.

(* As we evolve the allocator and normalize huge page requests
   (folios), kswapd may also eventually balance for THPs again. IOW,
   it's more likely for this exception to disappear again than it is
   that we'll see more of them.)

(** This is also why it's no big deal if other kthreads that rely on
    kswapd contribute to direct reclaim stats. First, it's highly
    error prone to determine on a case by case basis whether userspace
    could be waiting behind that direct reclaim - as Yang Shi's
    writeback example demonstrates. Second, if kswapd is overwhelmed,
    it's likely to impact userspace *anyway*! The benefit of this
    classification work is questionable.)

> - What if we deprecate khugepaged (or such threads)? Seems more likely
> than deprecating kswapd.

If that happens, we can remove the counter again. The bar isn't as
high for vmstat as it for other ABI, and we've updated it plenty of
times to reflect changes in the MM implementation.

> Looks like we want a stat that would group all of this reclaim coming
> from non-direct kthreads, but would not include a future proactive
> reclaim kthread.

I think the desire to generalize overcomplicates things here in a way
that isn't actually meaningful.

Think of direct reclaim stats as a signal that either a) kswapd is
broken or b) memory pressure is high enough to cause latencies in the
class of requests that are of interest to userspace. This is true for
all cases but khugepaged.
