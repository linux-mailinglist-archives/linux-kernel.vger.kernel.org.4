Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B30737304
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFTRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFTRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:36:32 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD011D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:36:30 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-763a3699b9aso167437385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687282589; x=1689874589;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Llu7FUuSTNxADUHCSjGaK3Rlf3j6dAJpKQ0mQsrZg5I=;
        b=FTq97vR1xPQhTLxWm5IfD8uJYEZDc7eXRMAlcDBhkpAs8mfTpPbj9WjcrmNe8yU0aw
         5bu8eq/eKvAb+UrDsc7v9MucAnyxRD/zxU7bmCzW6SnP27HXtTREIky8Gev7jYK9vAvG
         OOoL7psSs8OWGU+TEF/9lTMSfvPb+aM2b9781TIxoKQYaTZDafDIJm2nRLsChr03x0GS
         iay5l/Hj7PO2qFBer/mAl/v0HGu3C6O28vC7UKswLsYduiqPzEDw/Fn7f8Wp22Z27YAR
         py2J6HZnTtqmMDO//0xLpJkhzwHtRUYQZTWONgDoaktIYnNQTBcYfr54q3DOvlUiQUBO
         CM1g==
X-Gm-Message-State: AC+VfDzq0zN/U2cX5ZPkRRAS9Df8Mf0SvvqtLBeH9JlPAkRK5LVEJN54
        Iy8CKuHI9JNawJAVovPCRhI=
X-Google-Smtp-Source: ACHHUZ7HRyirnqN0kYX7Zk+JxBVF8Yso+pLglnHRUkXXDBmdZF9mgWuEuMQ97gfUFXcbMKXjJp67dg==
X-Received: by 2002:a05:6214:1c0b:b0:630:1732:7084 with SMTP id u11-20020a0562141c0b00b0063017327084mr9576817qvc.61.1687282588962;
        Tue, 20 Jun 2023 10:36:28 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:2cf0])
        by smtp.gmail.com with ESMTPSA id jo30-20020a056214501e00b006301819be40sm1485276qvb.49.2023.06.20.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:36:28 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:36:26 -0500
From:   David Vernet <void@manifault.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        joshdon@google.com, roman.gushchin@linux.dev, tj@kernel.org,
        kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230620173626.GA3027191@maniforge>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
 <20230615232605.GB2915572@maniforge>
 <20230616005338.GA115001@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616005338.GA115001@ziqianlu-dell>
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

On Fri, Jun 16, 2023 at 08:53:38AM +0800, Aaron Lu wrote:
> On Thu, Jun 15, 2023 at 06:26:05PM -0500, David Vernet wrote:
>  
> > Ok, it seems that the issue is that I wasn't creating enough netperf
> > clients. I assumed that -n $(nproc) was sufficient. I was able to repro
> 
> Yes that switch is confusing.
> 
> > the contention on my 26 core / 52 thread skylake client as well:
> > 
> > 
>  
> > Thanks for the help in getting the repro on my end.
> 
> You are welcome.
> 
> > So yes, there is certainly a scalability concern to bear in mind for
> > swqueue for LLCs with a lot of cores. If you have a lot of tasks quickly
> > e.g. blocking and waking on futexes in a tight loop, I expect a similar
> > issue would be observed.
> > 
> > On the other hand, the issue did not occur on my 7950X. I also wasn't
> 
> Using netperf/UDP_RR?

Correct

> > able to repro the contention on the Skylake if I ran with the default
> > netperf workload rather than UDP_RR (even with the additional clients).
> 
> I also tried that on the 18cores/36threads/LLC Skylake and the contention
> is indeed much smaller than UDP_RR:
> 
>      7.30%     7.29%  [kernel.vmlinux]      [k]      native_queued_spin_lock_slowpath
> 
> But I wouldn't say it's entirely gone. Also consider Skylake has a lot
> fewer cores per LLC than later Intel servers like Icelake and Sapphire
> Rapids and I expect things would be worse on those two machines.

I cannot reproduce this contention locally, even on a slightly larger
Skylake. Not really sure what to make of the difference here. Perhaps
it's because you're running with CONFIG_SCHED_CORE=y? What is the
change in throughput when you run the default workload on your SKL?

> > I didn't bother to take the mean of all of the throughput results
> > between NO_SWQUEUE and SWQUEUE, but they looked roughly equal.
> > 
> > So swqueue isn't ideal for every configuration, but I'll echo my
> > sentiment from [0] that this shouldn't on its own necessarily preclude
> > it from being merged given that it does help a large class of
> > configurations and workloads, and it's disabled by default.
> > 
> > [0]: https://lore.kernel.org/all/20230615000103.GC2883716@maniforge/
> 
> I was wondering: does it make sense to do some divide on machines with
> big LLCs? Like converting the per-LLC swqueue to per-group swqueue where
> the group can be made of ~8 cpus of the same LLC. This will have a
> similar effect of reducing the number of CPUs in a single LLC so the
> scalability issue can hopefully be fixed while at the same time, it
> might still help some workloads. I realized this isn't ideal in that
> wakeup happens at LLC scale so the group thing may not fit very well
> here.
> 
> Just a thought, feel free to ignore it if you don't think this is
> feasible :-)

That's certainly an idea we could explore, but my inclination would be
to keep everything at a per-LLC granularity. It makes it easier to
reason about performance; both in terms of work conservation per-LLC
(again, not every workload suffers from having large LLCs even if others
do, and halving the size of a swqueue in an LLC could harm other
workloads which benefit from the increased work conservation), and in
terms of contention. To the latter point, I think it would be difficult
to choose an LLC size that wasn't somewhat artificial and workload
specific. If someone has that requirement, I think sched_ext would be a
better alternative.

Thanks,
David
