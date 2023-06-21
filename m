Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23F173794E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFUCnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:43:06 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438A10F1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:43:05 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-763a3e9f486so221991485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687315384; x=1689907384;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZXx1HCixoSMGyIxhHhO37kOxFlf3sxhJ+peXKekhTo=;
        b=NJkr1vpvm7EMcsFZ2mrqfFHwv1EWDEXlKQ1C7lHuL2/2q6WjEalqcPO2IbSZUj0oZK
         /2Ds+QwZFvAcqg+VViUMaRVDxqFEtFdNI6diOcw24UxNA2ddiJcjeyiRqqgoyP68osyc
         5z1Rgf5o5WhYgMMJsMnUrFBEj+JvNMqBpKOJME8nbXGSJI07yWtBhyqsy5qP9QRJuYG7
         w7d6JILwgNqvzXK1M0ln+w9GgRYbHtHWh1Dub58dzGA7b6sQG9liIwQLUnzfr/ot5uFM
         WAPcM1kPa0rKKSqTlXG8oz2swVQ4npHdB9CCSVu2T3snAiNbUfZUi5GYIJujBUPVRdVm
         Gu7Q==
X-Gm-Message-State: AC+VfDwFkMapOTfY6Rf25kWxLSJiPqL9arxii0jVagRAusAj0IG4n8LC
        OH22E/tJO0J2QrEFZ3NXXVSHhD2Ml35Kwdgf
X-Google-Smtp-Source: ACHHUZ4/+qoZoHswOU0AKCRlRp4J00nRSVpCoejckejUSBraxPu8TRPu6d0/1qc+3FvzIGjGa72Omw==
X-Received: by 2002:a05:620a:2145:b0:763:997e:2685 with SMTP id m5-20020a05620a214500b00763997e2685mr7929291qkm.28.1687315383829;
        Tue, 20 Jun 2023 19:43:03 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:f69b])
        by smtp.gmail.com with ESMTPSA id s19-20020ae9f713000000b00763ae8f8f55sm1470164qkg.90.2023.06.20.19.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 19:43:03 -0700 (PDT)
Date:   Tue, 20 Jun 2023 21:43:00 -0500
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
Message-ID: <20230621024300.GA15990@maniforge>
References: <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
 <20230615232605.GB2915572@maniforge>
 <20230616005338.GA115001@ziqianlu-dell>
 <20230620173626.GA3027191@maniforge>
 <20230621023534.GA236337@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621023534.GA236337@ziqianlu-dell>
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

On Wed, Jun 21, 2023 at 10:35:34AM +0800, Aaron Lu wrote:
> On Tue, Jun 20, 2023 at 12:36:26PM -0500, David Vernet wrote:
> > On Fri, Jun 16, 2023 at 08:53:38AM +0800, Aaron Lu wrote:
> > > I also tried that on the 18cores/36threads/LLC Skylake and the contention
> > > is indeed much smaller than UDP_RR:
> > > 
> > >      7.30%     7.29%  [kernel.vmlinux]      [k]      native_queued_spin_lock_slowpath
> > > 
> > > But I wouldn't say it's entirely gone. Also consider Skylake has a lot
> > > fewer cores per LLC than later Intel servers like Icelake and Sapphire
> > > Rapids and I expect things would be worse on those two machines.
> > 
> > I cannot reproduce this contention locally, even on a slightly larger
> 
> With netperf client number equal to nr_cpu?

No, that confusion was only the first time around. See below though, I'm
not sure what insights are to be gained by continuing to tinker with
netperf runs.

> > Skylake. Not really sure what to make of the difference here. Perhaps
> > it's because you're running with CONFIG_SCHED_CORE=y? What is the
> 
> Yes I had that config on but I didn't tag any tasks or groups.
> 
> > change in throughput when you run the default workload on your SKL?
> 
> The throughput dropped a little with SWQUEUE:
> 
>                  avg_throughput    native_queued_spin_lock_slowpath%
> NO_SWQUEUE:      9528.061111111108      0.09%
> SWQUEUE:         8984.369722222222      8.05%
> 
> avg_throughput: average throughput of all netperf client's throughput,
> higher is better.
> 
> I run this workload like this:
> "
> netserver
> 
> for i in `seq 72`; do
>         netperf -l 60 -n 72 -6 &
> done
> 
> sleep 30
> perf record -ag -e cycles:pp -- sleep 5 &
> 
> wait
> "
> (the '-n 72' should be redundant but I just keep it there)

At this point I'd say we've spent quite a bit of time discussing netperf
results. We understand where the contention is coming from, and yes,
we've established that there are going to be some configurations where
swqueue is not well suited. We've also established that there are
configurations where it will and does perform well, including on
netperf.

I'm not sure what we're hoping to gain by continuing to run various
netperf workloads with your specific parameters?

Thanks,
David
