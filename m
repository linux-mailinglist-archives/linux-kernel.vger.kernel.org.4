Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A5622F58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKIPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKIPtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:49:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B513F7C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KTmaf8B87vIIN0yxDModoNqGQTj0xX5ooslpdKUP19Q=; b=OIr0butA3iITJ8k+7dXjKRZ8hc
        tp6wfV3Ll9bJiI0H1jR0pyZBtXtc5qhOUsowRUyIV19G+CE0Uk3xffbL2pyrHnexeLOt8IlIptkby
        NzA9qr28coz2FadXnD/6HRXTu6r1j/U8qPh9F5iR4TTCmU0x4Dgl64j0oTzONTAmKl7X+JfZ+9hXS
        nYyYGFGt4c14vfSxto40NdGp1D2ZquV9cSG4DmXqlRr/4a1752UMxn37PR6AzsqFNYMiUnZovFH3B
        9TGuAinAb6YLC2dFNjwbblQ22bByUg/WWb6PAziBwQGO9QtXQ83qI+aunzODEiQGqe/1+L9++97lj
        W0HVtUJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osnKW-00BIwI-NF; Wed, 09 Nov 2022 15:49:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D803B30031B;
        Wed,  9 Nov 2022 16:49:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB11820D9067D; Wed,  9 Nov 2022 16:49:25 +0100 (CET)
Date:   Wed, 9 Nov 2022 16:49:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108194843.i4qckcu7zwqstyis@airbuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
> On 11/07/22 14:41, Peter Zijlstra wrote:
> > On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
> > 
> > > Based on all the tests we've seen, jankbench or otherwise, the
> > > improvement can mainly be attributed to the faster ramp up of frequency
> > > caused by the shorter PELT window while using schedutil.
> > 
> > Would something terrible like the below help some?
> > 
> > If not, I suppose it could be modified to take the current state as
> > history. But basically it runs a faster pelt sum along side the regular
> > signal just for ramping up the frequency.
> 
> A bit of a tangent, but this reminded me of this old patch:
> 
> 	https://lore.kernel.org/lkml/1623855954-6970-1-git-send-email-yt.chang@mediatek.com/
> 
> I think we have a bit too many moving cogs that might be creating undesired
> compound effect.
> 
> Should we consider removing margins in favour of improving util ramp up/down?
> (whether via util_est or pelt hf).

Yeah, possibly.

So one thing that was key to that hack I proposed is that it is
per-task. This means we can either set or detect the task activation
period and use that to select an appropriate PELT multiplier.

But please explain; once tasks are in a steady state (60HZ, 90HZ or god
forbit higher), the utilization should be the same between the various
PELT window sizes, provided the activation period isn't *much* larger
than the window.

Are these things running a ton of single shot tasks or something daft
like that?
