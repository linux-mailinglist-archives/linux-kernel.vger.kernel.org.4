Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CAE743B26
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjF3Lvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3Lvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:51:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CA2D78
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:41:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso21993085e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688125306; x=1690717306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Onl1jBKNUVAc7AFbiRXn2jzmir9C46s2tSDJirF66sQ=;
        b=ioOWWAouAXpjOik/NTPusclNVYQLH4rFtxpswd4WXXT5p1C2scSSQgQdbs3m1yCc0y
         Xq9p2X+55Fnbf5La8fH29P/aGdlPJfXrWqe5GvQDGKA8HTQCn7KoZlZmNYYQHBb/Hsv6
         3RR4r8xPAKF1lIugLTDPfILpOGtqo6DJQ7IGkrt9K+H+hhg9dL66y5wR+eax1SZf/E9z
         g5p4+WxLlpkBjyoIx5gas0YgXS9arpZqhyls0HESkxR9FR3qan9Yrp2jrcNsJnG8zj6e
         z9noqzN4yAcSdvm2szwzrueKjZ9wtrojYdhDbj+DMECZi2a0r8q50Yq+Dw/jY0E17SPM
         F2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125306; x=1690717306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onl1jBKNUVAc7AFbiRXn2jzmir9C46s2tSDJirF66sQ=;
        b=GocG3A+w2Qlmc24IgpgLayoKNfSqlbTaXTpCVqGFArC9ghmF402s0kOz3r56Tw1Xgb
         SqMUWAo4YQ7q3IFntWtLw5cmRQ9DmUCAQqb4wPC40GqvTdo71bTn0oSEqlP7Bs6h/i1t
         QR6rXgAH7D2NM8vS4eHB0r+KA5sMZ4omzugw8+K4Qq5fDL/aZLSgnAS0BrFYxzFsfiot
         rmsx1JG0SRaiyNkmeGVlyWUsIt7IGs5sa5nv4P3rHP80cDZQeiQv4zyxAv7ZINlcmkfi
         7grGP9avXwgS00PcVi+GOaSRXLnYOfcFzB2tKWxWkX85y3GmLgmvBJqai4AMdmZn0Eu1
         +fBg==
X-Gm-Message-State: ABy/qLbSw0cBtq1EKRLZjEldoUFJS4r6cQcSKe6zubc6UN2sm6KJ7/K1
        obsbnRlvtsi3vpIZNxfnhWLXaQ==
X-Google-Smtp-Source: APBJJlECaBKNfK5hgUk8o6T9LRu4ApoMc8cIRJIAlG2QQqtHn2V6V5NxQI5DHN6afSgc36cPLlFF4A==
X-Received: by 2002:adf:fcc5:0:b0:313:e98b:7de2 with SMTP id f5-20020adffcc5000000b00313e98b7de2mr2549014wrs.0.1688125305796;
        Fri, 30 Jun 2023 04:41:45 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id a7-20020adfe5c7000000b0030c6751a49dsm8666070wrn.115.2023.06.30.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:41:45 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:41:40 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230630114140.w3kiirw6lyjdvb6r@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
 <c5722699-d366-3f26-635d-a45f746a3658@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5722699-d366-3f26-635d-a45f746a3658@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/23 15:52, Hongyan Xia wrote:
> Hi Qais,
> 
> On 2023-02-11 17:50, Qais Yousef wrote:
> > [...]
> > > 
> > > So EAS keeps packing on the cheaper PD/clamped OPP.
> > 
> > Which is the desired behavior for uclamp_max?
> > 
> > The only issue I see is that we want to distribute within a pd. Which is
> > something I was going to work on and send after later - but can lump it in this
> > series if it helps.
> 
> I more or less share the same concern with Dietmar, which is packing things
> on the same small CPU when everyone has spare cpu_cap of 0.
> 
> I wonder if this could be useful: On the side of cfs_rq->avg.util_avg, we
> have a cfs_rq->avg.util_avg_uclamp_max. It is keeping track of util_avg, but
> each task on the rq is capped at its uclamp_max value, so even if there's
> two always-running tasks with uclamp_max values of 100 with no idle time,
> the cfs_rq only sees cpu_util() of 200 and still has remaining capacity of
> 1024 - 200, not 0. This also helps balancing the load when rqs have no idle
> time. Even if two CPUs both have no idle time, but one is running a single
> task clamped at 100, the other running 2 such tasks, the first sees a
> remaining capacity of 1024 - 100, while the 2nd is 1024 - 200, so we still
> prefer the first one.

If I understood correctly you're suggesting do accounting of the sum of
uclamp_max for all the enqueued tasks?

I think we discussed this in the past. Can't remember the details now, but
adding additional accounting seemed undeseriable.

And I had issue with treating uclamp_max as a bandwidth hint rather than
a performance requirements hint. Limiting a task to 200 means it can't run
faster than this, but it doesn't mean it is not allowed to consume more
bandwidth than 200. Nice value and cfs bandwidth controllers should be used for
that.

> And I wonder if this could also help calculating energy when there's no idle
> time under uclamp_max. Instead of seeing a util_avg at 1024, we actually see
> a lower value. This is also what cpu_util_next() does in Android's sum
> aggregation, but I'm thinking of maintaining it right beside util_avg so
> that we don't have to sum up everything every time.

I haven't thought about how to improve the EM calculations to be honest, I see
this as a secondary problem compared to the other issue we need to fix first.

It seems load_avg can grow unboundedly, can you look at using this signal to
distribute on a cluster and as a hint we might be better off spilling to other
if they're already running at a perf level <= uclamp_max?


Thanks

--
Qais Yousef
