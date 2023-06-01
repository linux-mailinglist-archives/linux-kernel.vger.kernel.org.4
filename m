Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454F971A0F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjFAOvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjFAOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:51:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C12C0;
        Thu,  1 Jun 2023 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1JQ8H5SWLeF9hOjl0b6jkGrksawhL5bRI40mRJFX8jI=; b=AQipA1TAR5OQm4luUa3IrhuR+Q
        FgALeD2E/Nc+RT2aOlQFunr2BdKZkbGkQ7Q+nDWwOFxAJWAaWXg/8NU6mvJng/EZ1Fc+rMaF9yq3N
        dNO6Kh1F4gAbUz3hz/m/xU129pQ12UMkZbg8sAcvVmzn+P9/B7xN7QLozGANCPwRAmnweqK4Vonnd
        d1oNWX0fJDB3PbN7wHOov41U6yqHvMD/hEE78WiE0T2vIXe6rfTKY51/wUJGVaHCggdJWLyL7aavQ
        iIQmdoxx1BNYf+EoXMQ705PGwT0Hwzjg0c7j5eAX1xi0QymrQD/YJ3CfXFsmi/6MzM9RthImW4J5B
        g6i9DJtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4jdz-00HB7j-0r;
        Thu, 01 Jun 2023 14:51:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED838300269;
        Thu,  1 Jun 2023 16:51:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFD43202BDCAC; Thu,  1 Jun 2023 16:51:13 +0200 (CEST)
Date:   Thu, 1 Jun 2023 16:51:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230601145113.GA559993@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:00:01PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 01:56:43PM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 01, 2023 at 01:13:26PM +0200, Peter Zijlstra wrote:
> > > 
> > > This DeathStarBench thing seems to suggest that scanning up to 4 CCDs
> > > isn't too much of a bother; so perhaps something like so?
> > > 
> > > (on top of tip/sched/core from just a few hours ago, as I had to 'fix'
> > > this patch and force pushed the thing)
> > > 
> > > And yeah, random hacks and heuristics here :/ Does there happen to be
> > > additional topology that could aid us here? Does the CCD fabric itself
> > > have a distance metric we can use?
> > 
> >   https://www.anandtech.com/show/16529/amd-epyc-milan-review/4
> > 
> > Specifically:
> > 
> >   https://images.anandtech.com/doci/16529/Bounce-7763.png
> > 
> > That seems to suggest there are some very minor distance effects in the
> > CCD fabric. I didn't read the article too closely, but you'll note that
> > the first 4 CCDs have inter-CCD latency < 100 while the rest has > 100.
> > 
> > Could you also test on a Zen2 Epyc, does that require nr=8 instead of 4?
> > Should we perhaps write it like: 32 / llc_size ?
> > 
> > The Zen2 picture:
> > 
> >   https://images.anandtech.com/doci/16315/Bounce-7742.png
> > 
> > Shows a more pronounced CCD fabric topology, you can really see the 2
> > CCX inside the CCD but also there's two ligher green squares around the
> > CCDs themselves.
> 
> I can't seem to find pretty pictures for Zen4 Epyc; what does that want?
> That's even bigger at 96/8=12 LLCs afaict.

Going by random pictures on the interweb again, it looks like this Zen4
thing wants either 2 groups of 6 each, or 4 groups of 3.

But you have the hardware, so I'll let you figure it out.
