Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64385737AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFUFoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFUFn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:43:57 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6256E1710
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:43:56 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-762092e1fb7so483820485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687326235; x=1689918235;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHdXj9PUr7lhUAPuUtTelMceKFwaFrPXgkBrQZ0EjX8=;
        b=AzJTWVim5EVciKP2XmvPogUa540CEJzCGGnmo0b15/qimTbNPG0Sc1I+bz3I64w9VW
         oRW4dDidl0wDMrTR/H+kCyRv+o8rwR4ItU/5iTedHgaMHB0x6xeRVC2a8yoF4ee8O+KV
         GC7dUezWXMnPKMjDsTgJkAqFsK6Lc/g5XELx3W1czRhS3kIaskHyP8eIAy/II/S+IK8z
         lTNx3Y1LwDzECdi9J2kreuX87/u4NWabcnLX6nrJfzZVFkXsPIzCC+yO/+/eHaUBg6tl
         R4javbtR81G5HPX1oPYQcO89W1k/5Kw14n9Wk54oHVjsjGvfnSj2CRVYVzFHNyzSbTur
         DCzg==
X-Gm-Message-State: AC+VfDzrgQPtx87IhAvs+tOh2GiqNT94kNOtY+Jr69D4s70jUiRimrdd
        8GSrA/Nz5UyjBjuHS7EJo+I=
X-Google-Smtp-Source: ACHHUZ5X21iZZxQfq4j98F3jIjLH0HniNEgBgO5oUVRnE6KWu5vSi9MltmE9HltLkkf/qtzNPJ79CA==
X-Received: by 2002:a05:620a:6501:b0:75d:53f0:4eab with SMTP id qb1-20020a05620a650100b0075d53f04eabmr15653967qkn.42.1687326235244;
        Tue, 20 Jun 2023 22:43:55 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:d965])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a10a700b00763ba9a09a9sm919072qkk.34.2023.06.20.22.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 22:43:54 -0700 (PDT)
Date:   Wed, 21 Jun 2023 00:43:52 -0500
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
Message-ID: <20230621054352.GB15990@maniforge>
References: <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
 <20230615232605.GB2915572@maniforge>
 <20230616005338.GA115001@ziqianlu-dell>
 <20230620173626.GA3027191@maniforge>
 <20230621023534.GA236337@ziqianlu-dell>
 <20230621024300.GA15990@maniforge>
 <20230621045416.GA237582@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621045416.GA237582@ziqianlu-dell>
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

On Wed, Jun 21, 2023 at 12:54:16PM +0800, Aaron Lu wrote:
> On Tue, Jun 20, 2023 at 09:43:00PM -0500, David Vernet wrote:
> > On Wed, Jun 21, 2023 at 10:35:34AM +0800, Aaron Lu wrote:
> > > On Tue, Jun 20, 2023 at 12:36:26PM -0500, David Vernet wrote:
> > > > On Fri, Jun 16, 2023 at 08:53:38AM +0800, Aaron Lu wrote:
> > > > > I also tried that on the 18cores/36threads/LLC Skylake and the contention
> > > > > is indeed much smaller than UDP_RR:
> > > > > 
> > > > >      7.30%     7.29%  [kernel.vmlinux]      [k]      native_queued_spin_lock_slowpath
> > > > > 
> > > > > But I wouldn't say it's entirely gone. Also consider Skylake has a lot
> > > > > fewer cores per LLC than later Intel servers like Icelake and Sapphire
> > > > > Rapids and I expect things would be worse on those two machines.
> > > > 
> > > > I cannot reproduce this contention locally, even on a slightly larger
> > > 
> > > With netperf client number equal to nr_cpu?
> > 
> > No, that confusion was only the first time around. See below though, I'm
> > not sure what insights are to be gained by continuing to tinker with
> > netperf runs.
> > 
> > > > Skylake. Not really sure what to make of the difference here. Perhaps
> > > > it's because you're running with CONFIG_SCHED_CORE=y? What is the
> > > 
> > > Yes I had that config on but I didn't tag any tasks or groups.
> > > 
> > > > change in throughput when you run the default workload on your SKL?
> > > 
> > > The throughput dropped a little with SWQUEUE:
> > > 
> > >                  avg_throughput    native_queued_spin_lock_slowpath%
> > > NO_SWQUEUE:      9528.061111111108      0.09%
> > > SWQUEUE:         8984.369722222222      8.05%
> > > 
> > > avg_throughput: average throughput of all netperf client's throughput,
> > > higher is better.
> > > 
> > > I run this workload like this:
> > > "
> > > netserver
> > > 
> > > for i in `seq 72`; do
> > >         netperf -l 60 -n 72 -6 &
> > > done
> > > 
> > > sleep 30
> > > perf record -ag -e cycles:pp -- sleep 5 &
> > > 
> > > wait
> > > "
> > > (the '-n 72' should be redundant but I just keep it there)
> > 
> > At this point I'd say we've spent quite a bit of time discussing netperf
> > results. We understand where the contention is coming from, and yes,
> > we've established that there are going to be some configurations where
> > swqueue is not well suited. We've also established that there are
> > configurations where it will and does perform well, including on
> > netperf.
> > 
> > I'm not sure what we're hoping to gain by continuing to run various
> > netperf workloads with your specific parameters?
> 
> I don't quite follow you.
> 
> I thought we were in the process of figuring out why for the same
> workload(netperf/default_mode/nr_client=nr_cpu) on two similar
> machines(both are Skylake) you saw no contention while I saw some so I
> tried to be exact on how I run the workload.

I just reran the workload on a 26 core / 52 thread Cooper Lake using
your exact command below and still don't observe any contention
whatsoever on the swqueue lock:

for i in `seq 72`; do
	netperf -l 60 -n 72 -6 &
done

> If that's not the case, then yes there is no much value continuing this
> discussion.

We can iterate until we find out why we're seeing slightly different
contention (different configs, different amount of RAM, maybe you have
turbo enabled or other things running on your host, etc), but I don't
see what that would tell us that would meaningfully drive the discussion
forward for the patch set. Is there anything in particular you're trying
to determine and/or do you have reason to think that the contention
you're observing is due to something other than a lot of tasks waking up
at the same time, just as it was with UDP_RR?

Thanks,
David
