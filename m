Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B00F703D95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244824AbjEOTSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbjEOTSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:18:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC63A2709
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:18:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96aadfb19d7so735683966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1684178312; x=1686770312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGZIWScYDCTVEAup2yYp0aMD7ScTtaXLpo5jJpzQnPs=;
        b=tGzW4m5cBWonTIGkVQC3G9+Ns4Y6+mG9dQdooE2F+7RKw35SnEJFg+siWPeTb8+Glm
         BM34Rh4vXf/bbKXH+0f5JgGcbHYh4Hszzxybcb99eFAjzTEr75mxlRmJhJv7iE/14+ug
         /BWriQeV6i2SNYxZjbFPuk8A9VV9LVwBulzKh4p6+Y4768BB/q71xfkqkx9Wodsts2MF
         F2Y3Ig+CiGntZTWAPkT6UDOIzroEnNoBNZ0fDvhyGDgNQnDYqCYGMumv53S39pInq20s
         slo8VySneq+WLyxtpUKn+4MaqqDRi4gKdqyFNGLjaOTSUZ7Dz4QH0Rir9VNzgs+x42q8
         Ih1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178312; x=1686770312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGZIWScYDCTVEAup2yYp0aMD7ScTtaXLpo5jJpzQnPs=;
        b=UggjRSjoO8zAZlFmvQnAbv3+aYkP9ULnQPTQiw5wqZx5821jvJ48+ZjdePrJPk9a0L
         TafTt9XrIJTFzQ61Pe4KJJezzb9VSh76bMaDX1bYYIjdpBH2Jmfm8EY+NhY+yOUQBNbJ
         7kNOt8X8wVaCPCDsLOstUggcYnc5eH7OcpeuDI6OVFknAtdpz2ozwvmdD7n+zRmS3yFz
         wsIKgjdfthehPa8aHKoWfBvuBfes/vYBa3MTyydy6+GfGso4Pu+o3DFOYOJ+jvDEO6Hf
         S8v9hanU+0m3BA7/mmSJ6W9AtO2/pKd4Fs15rAUgEiNAtosJYnkFbKLshhiUEGVOwEwe
         g5VA==
X-Gm-Message-State: AC+VfDwD7V8du4SSBIKuWpImOjectAPckUgvluOsWMbuR3A8ZvQhkT8i
        VUwkT9I9x4NWyibjFzDm2p6NxQ==
X-Google-Smtp-Source: ACHHUZ4XAEAX1xV90jvv9clTElQdHdEOkjGo8TqtDGpIBhJ1CZhD2noD/mOLCCJYVPkoVM8GJ2bOOA==
X-Received: by 2002:a17:906:ef0d:b0:94e:e9c1:1932 with SMTP id f13-20020a170906ef0d00b0094ee9c11932mr34834034ejs.43.1684178312350;
        Mon, 15 May 2023 12:18:32 -0700 (PDT)
Received: from airbuntu (3EC94B14.catv.pool.telekom.hu. [62.201.75.20])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906285000b0096b15e4ffcesm2615474ejc.85.2023.05.15.12.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:18:31 -0700 (PDT)
Date:   Mon, 15 May 2023 20:18:27 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Message-ID: <20230515191827.m57e5raraoqbmer3@airbuntu>
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
 <20230429145829.GB1495785@hirez.programming.kicks-ass.net>
 <4c77a01e-8ff3-f415-ffff-01c8d79a8bc7@arm.com>
 <20230504152328.twh3rqgq2o2gvd4u@airbuntu>
 <8d229f8c-ebdf-f12f-ebec-27c2d1c9e900@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d229f8c-ebdf-f12f-ebec-27c2d1c9e900@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/23 17:25, Dietmar Eggemann wrote:
> On 04/05/2023 17:23, Qais Yousef wrote:
> > On 05/03/23 19:13, Dietmar Eggemann wrote:
> >> On 29/04/2023 16:58, Peter Zijlstra wrote:
> >>> On Thu, Apr 06, 2023 at 05:50:30PM +0200, Dietmar Eggemann wrote:
> 
> [...]
> 
> >>> But why, and how does it affect? That is, isn't this Changelog a wee bit
> >>> sparse?
> >>
> >> Absolutely. 
> >>
> >> I have compelling test data based on JankbenchX on Pixel6 for 
> >> sugov_get_util() case I will share with v2.
> > 
> > I am actually still concerned this is a global win. This higher contention can
> > potentially lead to higher power usage. Not every high contention worth
> > reacting to faster. The blanket 25% headroom in map_util_perf() is already
> > problematic. And Jankbench is not a true representative of a gaming workload
> > which is what started this whole discussion. It'd be good if mediatek can
> > confirm this helps their case. Or for us to find a way to run something more
> > representative. The original ask was to be selective about being more reactive
> > for specific scenarios/workloads. 
> 
> I contacted MTK beginning of March this year and specifically asked them
> to see whether this patch helps their gaming use-cases or not.
> Unfortunately I haven't heard back from them.

Hmm I'm not sure if gfxbench would be benchmark to try to help here..

> 
> I'm actually happy to have compelling Jankbench (which _the_ UI

I'm glad you're getting these good numbers. But I am still worried this is
might not be sufficient. My worry here is how this could impact thermal and
power in all other cases. You're assuming any contention is worth a boost.

> benchmark app) numbers on a recent mobile device (Pixel6) with v5.18
> mainline based kernel including schedutil. And I'm able to remove a lot
> of extra product-oriented features, like up/down frequency transition
> rate-limits or ADPF (Android Dynamic Performance Framework) 'CPU
> performance hints' feature. Bridging product and mainline world for
> mobile isn't easy as we all know.
> 
> ---
> 
> Testcase is Jankbench (all subtests, 10 iterations) on Pixel6 (Android
> 12) with mainline v5.18 kernel and forward ported task scheduler
> patches, uclamp has been deactivated to disable ADPF's 'CPU performance
> hints'.
> 
> Max_frame_duration:
> +-----------------+------------+
> |     kernel      | value [ms] |
> +-----------------+------------+
> |      base       | 163.061513 |
> |    runnable     | 157.821346 |
> +-----------------+------------+
> 
> Mean_frame_duration:
> +-----------------+------------+----------+
> |     kernel      | value [ms] | diff [%] |
> +-----------------+------------+----------+
> |      base       |    18.0    |    0.0   |
> |    runnable     |    12.5    |  -30.64  |
> +-----------------+------------+----------+
> 
> Jank percentage (Jank deadline 16ms):
> +-----------------+------------+----------+
> |     kernel      | value [%]  | diff [%] |
> +-----------------+------------+----------+
> |      base       |     3.6    |    0.0   |
> |    runnable     |     0.8    |  -76.59  |
> +-----------------+------------+----------+
> 
> Power usage [mW] (total - all CPUs):
> +-----------------+------------+----------+
> |     kernel      | value [mW] | diff [%] |
> +-----------------+------------+----------+
> |      base       |    129.5   |    0.0   |
> |    runnable     |    129.3   |   -0.15  |
> +-----------------+------------+----------+
> 
> ---
> 
> I assume that the MTK folks will also profit from the fact that CPU
> frequency can ramp up faster with this 'runnable boosting', especially
> when activity starts from an (almost) idle little CPU. Seeing their test
> results here would be nice though.

My worry is that this is another optimization for performance first with
disregard to potential bad power and thermal impact.

> 
> If we can't make this selective we need more
> > data it won't hurt general power consumption. I plan to help with that, but my
> > focus now is on other areas first, namely getting uclamp_max usable in
> > production.
> 
> This is the stalled discussion under
> https://lkml.kernel.org/r/20230205224318.2035646-1-qyousef@layalina.io I
> assume?
> 
> IIRC, the open question was should EAS CPU selection be performed in
> case there is no CPU spare capacity (due to uclamp capping) left.
> 
> [...]
> 
> 
