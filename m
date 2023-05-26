Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23778711C31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 03:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjEZBMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 21:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjEZBMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 21:12:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B364ED8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:12:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so322266b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685063568; x=1687655568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5V4U0QaMu0LI5Dzr0ihiBbHDaMWHSa0QtiTwmiAtNY=;
        b=Kuj03vndz5x1tqZG9BxKW4bmWzMqRKAlWP47W0+B3S6Dv+c/GZFhVX318ZmsuQ/pHf
         JXLs3TXXy8eFe6Pl9+Rro69LZSuIDLC3/822dJ/A4H+Kn01X1eBG1I3YBlG51zxN1FkU
         JypdaOeom6ogJ5pImc4MZyhSOP/vPXAzReJfKAdIfGel7MWPOKStRoksTp6tjTHZdnvb
         tjdeWV04NDIoA9+oGWTTOJL3zpU3J2sP2OXO/xyTwr/oivEvNR9gEJIamZVrocvi0YxW
         zmgUMi/p3h9GULWRH3s5QM1Bu7uRC0pDh1ApM0DU5RYkSfjk9AOv7MSiP+zbXzNje9bY
         l8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685063568; x=1687655568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5V4U0QaMu0LI5Dzr0ihiBbHDaMWHSa0QtiTwmiAtNY=;
        b=EETxrQOIdJznguCwXxtuEmQHk2ugUoQMXX10ywVe9mUheUS6BcL9YGxOmdahydDljy
         pgrhSnCh5Fdlq3fgOfZmwMVPo7vqXCQPXnCc/lMSTpqBrV+wYkk7ql+LSDIbaVWu6Ezf
         2SnF4Xxs9zfeCa+Hz2qKs4VeGaRDk055kQQNLZgFqCQnICfOHpnVQ+yzkJsuKElnQ7Rq
         So1sOkzjo+2wyUDXUtubyjDAD3RRZnKJpRcnEqPoBXyPEsG8n790QjFWBkMwJvH4wOnk
         T1pbDEZ/c2zF6RQA1u/izJWtf/3dnEW0N4ESZ4LrrHKA7ixeAmBysQmd/4iRUv9hgBYN
         rnIw==
X-Gm-Message-State: AC+VfDyDldDLMbWo4sxhXn0ofLGdcXMDTI8Iqz6H8egnZu8xSVr8eLSW
        v9iteKQ1yFdjnvct10Q55nA=
X-Google-Smtp-Source: ACHHUZ6o9tE+oE//CO6S7S6TmoPFXVdk+VYget/FoF6zaR1LqecSaT9Xn5hSLSZGtPsTBaD9OwZQGg==
X-Received: by 2002:a05:6a00:139c:b0:64c:ae1c:33ac with SMTP id t28-20020a056a00139c00b0064cae1c33acmr1004493pfg.25.1685063567824;
        Thu, 25 May 2023 18:12:47 -0700 (PDT)
Received: from localhost ([2600:380:b551:e8fe:da52:61ec:2b97:ae7f])
        by smtp.gmail.com with ESMTPSA id s132-20020a63778a000000b00502fd70b0bdsm1725791pgc.52.2023.05.25.18.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 18:12:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 May 2023 15:12:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, gautham.shenoy@amd.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Message-ID: <ZHAHjXL1e-H1PCqQ@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230523111818.GH4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230523111818.GH4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 23, 2023 at 01:18:18PM +0200, Peter Zijlstra wrote:
> > * Ryzen 9 3900x - 12 cores / 24 threads spread across 4 L3 caches.
> >   Core-to-core latencies across L3 caches are ~2.6x worse than within each
> >   L3 cache. ie. it's worse but not hugely so. This means that the impact of
> >   L3 cache locality is noticeable in these experiments but may be subdued
> >   compared to other setups.
> 
> *blink*, 12 cores with 4 LLCs ? that's a grand total of 3 cores / 6
> threads per LLC. That's puny.
> 
> /me goes google a bit.. So these are Zen2 things which nominally have 4
> cores per CCX which has 16M of L3, but these must binned parts with only
> 3 functional cores per CCX.

Yeah.

> Zen3 then went to 8 cores per CCX with double the L3.

Yeah, they basically doubled each L3 domain.

> > 2. MED: Fewer issuers, enough work for saturation
> > 
> >                   Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
> >   ----------------------------------------------------------------------
> >   SYSTEM             1155.40  ±0.89     97.41 ±0.05                 0.00
> >   CACHE              1154.40  ±1.14     96.15 ±0.09                -0.09
> >   CACHE+STRICT       1112.00  ±4.64     93.26 ±0.35                -3.76
> >   SYSTEM+LOCAL       1066.80  ±2.17     86.70 ±0.10                -7.67
> >   CACHE+LOCAL        1034.60  ±1.52     83.00 ±0.07               -10.46
> > 
> > There are still eight issuers and plenty of work to go around. However, now,
> > depending on the configuration, we're starting to see a significant loss of
> > work-conservation where CPUs sit idle while there's work to do.
> > 
> > * CACHE is doing okay. It's just a bit slower. Further testing may be needed
> >   to definitively confirm the bandwidth gap but the CPU util difference
> >   seems real, so while minute, it did lose a bit of work-conservation.
> >   Comparing it to CACHE+STRICT, it's starting to show the benefits of
> >   non-strict scopes.
> 
> So wakeup based placement is mostly all about LLC, and given this thing
> has dinky small LLCs it will pile up on the one LLC you target and leave
> the others idle until the regular idle balancer decides to make an
> appearance and move some around.

While this processor configuration isn't the most typical, I have a
difficult time imgaining newer chiplet designs behaving much differently.
The core problem is that while there is benefit to improving locality within
each L3 domain, the distance across L3 domains isn't that far either, so
unless loads get balanced aggressively across L3 domains while staying
within L3 when immediately possible, you lose capacity.

> But if these are fairly short running tasks, I can well see that not
> going to help much.

Right, the tasks themselves aren't necessarily short-running but they do
behave that way due to discontinuation and repatriation across work item
boundaries.

> Much of this was tuned back when there was 1 L3 per Node; something
> which is still more or less true for Intel but clearly not for these
> things.

Yeah, the same for workqueue. It assumed that the distance within a NUMA
node is indistinguishiable, which no longer holds.

> The below is a bit crude and completely untested, but it might help. The
> flip side of that coin is of course that people are going to complain
> about how selecting a CPU is more expensive now and how this hurts their
> performance :/
> 
> Basically it will try and iterate all L3s in a node; wakeup will still
> refuse to cross node boundaries.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0ca13ac..ddb7f16a07a9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7027,6 +7027,33 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	return idle_cpu;
>  }
>  
> +static int
> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	struct sched_domain *sd_node = rcu_dereference(per_cpu(sd_node, target));

I had to rename the local variable because it was making the global percpu
one during initialization but after that the result looks really good. I did
the same HIGH, MED, LOW scenarios. +SN indicates that SIS_NODE is turned on.
The machine set-up was slightly different so the baseline numbers aren't
directly comparable to the original results; however, the relative bw %
comparisons should hold.

RESULTS
=======

1. HIGH: Enough issuers and work spread across the machine

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM              1162.80 ±0.45     99.29 ±0.03                 0.00
  CACHE               1169.60 ±0.55     99.35 ±0.02                +0.58
  CACHE+SN            1169.00 ±0.00     99.37 ±0.01                +0.53
  CACHE+SN+LOCAL      1165.00 ±0.71     99.48 ±0.03                +0.19

This is an over-saturation scenario and the CPUs aren't having any trouble
finding work to do no matter what. The slight gain is mostly likely from
improved L3 locality and +SN doesn't behave noticeably differently from
CACHE.


2. MED: Fewer issuers, enough work for saturation

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM              1157.20 ±0.84     97.34 ±0.07                 0.00
  CACHE               1155.60 ±1.34     96.09 ±0.10                -0.14
  CACHE+SN            1163.80 ±0.45     96.90 ±0.07                +0.57
  CACHE+SN+LOCAL      1052.00 ±1.00     85.84 ±0.11                -0.09

+LOCAL is still sad but CACHE+SN is now maintaining similar gain over SYSTEM
similar to the HIGH scenario. Compared to CACHE, CACHE_SN shows slight but
discernable increases both in bandwidth and CPU util, which is great.


3. LOW: Even fewer issuers, not enough work to saturate

                  Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%)
  ----------------------------------------------------------------------
  SYSTEM               995.00 ±4.42     75.60 ±0.27                 0.00
  CACHE                971.00 ±3.39     74.86 ±0.18                -2.41
  CACHE+SN             998.40 ±4.04     74.91 ±0.27                +0.34
  CACHE+SN+LOCAL       957.60 ±2.51     69.80 ±0.17                -3.76

+LOCAL still sucks but CACHE+SN wins over SYSTEM albeit within a single
sigma. It's clear that CACHE+SN outperforms CACHE by a significant margin
and makes up the loss compared to SYSTEM.


CONCLUSION
==========

With the SIS_NODE enabled, there's no downside to CACHE. It always
outperforms or matches SYSTEM. It's possible that the overhead of searching
further for an idle CPU is more pronounced on bigger machines but most
likely so will be the gains. This looks like a no brainer improvement to me.

Thanks.

-- 
tejun
