Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E600271A0CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjFAOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjFAOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:47:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E2E7;
        Thu,  1 Jun 2023 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZYEXK8/Tilwt+GKS21Lw8IVncikUgCMWDnG3N7IZ52A=; b=ZodfAQROT8IbcsBfMZ/WoWQPhI
        X+50z2rjZ2lSQnewrN80mLaPbZRoj/PGTWlo/iLasb0fh+zSCHxallvKNBUyMoSWYbQzTU2Uf99i9
        /upu87ASZxCujQYrqy1kKPEVb6iCVZu3nGUe+TH1ysebkcWo3aVtA2A9GWBeKKV0j+RM48aI+fXbc
        9EEqTI+AP04j5a47n3IOdWSt4K29Y0K2qWzoEzlhwgx6qo5u6OwO5Sks8tC9LyAsHWZVxszn1fbCy
        GdXwp5rGNY8yvXyUdbXDXSM1ARlb7vm3qt9POUYHg0/iExeR9+DT28Hvq0g6xYtSaFmoX2bAg+Nn4
        R5RU0YdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4ja0-008SNV-2z; Thu, 01 Jun 2023 14:47:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D30D730031F;
        Thu,  1 Jun 2023 16:47:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC362202BDCAC; Thu,  1 Jun 2023 16:47:06 +0200 (CEST)
Date:   Thu, 1 Jun 2023 16:47:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230601144706.GA559454@hirez.programming.kicks-ass.net>
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

One way to fix all this would be by having arch/x86/kernel/smpboot.c set
an AMD specific set_sched_topology() that has a CCD domain above the MC
and below the DIE domain that groups 'near' CCDs together based on some
AMD specific topology information.

Then for small systems that will probably be just a single CCD domain
and the degenerate code will make it go away, but for these large
systems it will do what is right for their respective configuration.

Then, since this new multi-llc code uses MC->parent it will end up on
the fancy new CCD domain and not scan the *entire* socket.

Hmm?
