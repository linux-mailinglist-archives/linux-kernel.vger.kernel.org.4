Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49AC69C85A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjBTKNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjBTKNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:13:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C941024D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FQ85y9ng85k7JzUl9Z4270lXKuOc97q4DPVSx6OmWis=; b=cO10BKLwcwkoK9hPzgDW9qQ3+Z
        5aNeciBQeeTk0+Q5NNgKeS2lWe+cYEoaLmAO2EegZdi/pWZJRzhFliGZRppW7tmBxZXAhEnxi/Iiw
        d66wENTxRewwV5pJsjKecHxWrUETwC5rdU20uSMCEVH7mjzuaYsOSRem/r/cEYOfTWPOUlZ0bkWgS
        73f2ngtKFvS3efRsmSYSg9ZNtcW+CjPVfScxuUkpFtK1TiOMb+uPYRoDF1cF0XMdC/YhkePk+TQED
        g7Clv8FxeS3p/DX44+vabVFQJzopIXAdwqv3Jcrj8wAa/rkoRZdM8lG/o2KDPTQzkYFnGFhgLgC4r
        MEcvf5Tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pU3Af-00BkSI-1H;
        Mon, 20 Feb 2023 10:13:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20ECA3003E1;
        Mon, 20 Feb 2023 11:13:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B840B2135FB74; Mon, 20 Feb 2023 11:13:18 +0100 (CET)
Date:   Mon, 20 Feb 2023 11:13:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <Y/NHvvcgOov6DoLc@hirez.programming.kicks-ass.net>
References: <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 05:16:46PM +0100, Vincent Guittot wrote:

> > The results is very similar to PELT halflife reduction. The advantage is
> > that 'util_est_faster' is only activated selectively when the runtime of
> > the current task in its current activation is long enough to create this
> > CPU util boost.
> 
> IIUC how util_est_faster works, it removes the waiting time when
> sharing cpu time with other tasks. So as long as there is no (runnable
> but not running time), the result is the same as current util_est.

Uh.. it's double the speed, no? Even if there is no contention, the
fake/in-situ pelt sum runs at double time and thus will ramp up faster
than normal.

> util_est_faster makes a difference only when the task alternates
> between runnable and running slices.

UTIL_EST was supposed to help mitigate some of that, but yes. Also note
that _FASTER sorta sucks here because it starts from 0 every time, if it
were to start from the state saved by util_est_dequeue(), it would ramp
up faster still.

Patch has a comment along those lines I think.

> Have you considered using runnable_avg metrics in the increase of cpu
> freq ? This takes into the runnable slice and not only the running
> time and increase faster than util_avg when tasks compete for the same
> CPU

Interesting! Indeed, that's boosting the DVFS for contention. And as
deggeman's reply shows, it seems to work well.

I wonder if that one place where it regresses is exactly the case
without contention.
